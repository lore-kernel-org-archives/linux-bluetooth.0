Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6CFDB7FC-673C-468F-A901-157746778F43@holtmann.org>
References: <20140408011009.55000101498@puck.mtv.corp.google.com>
	<83DDEFEF-702B-4A41-BBC2-A9CD8F37ECCD@holtmann.org>
	<CAGXr9JH1FguUQPWXcLJXGwf25TGh5-b7uCsM1x-SYhE5oJ-3+A@mail.gmail.com>
	<6CFDB7FC-673C-468F-A901-157746778F43@holtmann.org>
Date: Mon, 5 May 2014 17:26:11 -0700
Message-ID: <CAGXr9JH1UeCBZ_hV2wmNm3Tb_zQYn+j=26iAtUJkq=rcfToPNw@mail.gmail.com>
Subject: Re: [PATCH v2] input: uHIDP: HIDP in userspace
From: Petri Gynther <pgynther@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, May 1, 2014 at 10:38 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Petri,
>
>>>> Enable HID protocol handling in userspace when uHIDP=true in input.conf.
>>>> ---
>>>> Makefile.plugins           |   3 +-
>>>> profiles/input/device.c    | 677 +++++++++++++++++++++++++++++++++++++++++++--
>>>> profiles/input/device.h    |   1 +
>>>> profiles/input/hidp_defs.h |  77 ++++++
>>>> profiles/input/input.conf  |   4 +
>>>> profiles/input/manager.c   |   9 +
>>>> 6 files changed, 754 insertions(+), 17 deletions(-)
>>>> create mode 100644 profiles/input/hidp_defs.h
>>>>
>>>> diff --git a/Makefile.plugins b/Makefile.plugins
>>>> index 6a1ddbf..f0eada9 100644
>>>> --- a/Makefile.plugins
>>>> +++ b/Makefile.plugins
>>>> @@ -55,7 +55,8 @@ builtin_sources += profiles/network/manager.c \
>>>> builtin_modules += input
>>>> builtin_sources += profiles/input/manager.c \
>>>>                      profiles/input/server.h profiles/input/server.c \
>>>> -                     profiles/input/device.h profiles/input/device.c
>>>> +                     profiles/input/device.h profiles/input/device.c \
>>>> +                     profiles/input/uhid_copy.h profiles/input/hidp_defs.h
>>>>
>>>> builtin_modules += hog
>>>> builtin_sources += profiles/input/hog.c profiles/input/uhid_copy.h \
>>>> diff --git a/profiles/input/device.c b/profiles/input/device.c
>>>> index f1fa716..01891f4 100644
>>>> --- a/profiles/input/device.c
>>>> +++ b/profiles/input/device.c
>>>> @@ -53,9 +53,13 @@
>>>> #include "src/sdp-client.h"
>>>>
>>>> #include "device.h"
>>>> +#include "hidp_defs.h"
>>>> +#include "uhid_copy.h"
>>>>
>>>> #define INPUT_INTERFACE "org.bluez.Input1"
>>>>
>>>> +#define UHID_DEVICE_FILE "/dev/uhid"
>>>> +
>>>> enum reconnect_mode_t {
>>>>      RECONNECT_NONE = 0,
>>>>      RECONNECT_DEVICE,
>>>> @@ -81,16 +85,30 @@ struct input_device {
>>>>      enum reconnect_mode_t   reconnect_mode;
>>>>      guint                   reconnect_timer;
>>>>      uint32_t                reconnect_attempt;
>>>> +     bool                    uhidp_enabled;
>>>> +     int                     uhid_fd;
>>>> +     guint                   uhid_watch;
>>>> +     bool                    uhid_created;
>>>> +     uint8_t                 report_req_pending;
>>>> +     guint                   report_req_timer;
>>>> +     uint32_t                report_rsp_id;
>>>> };
>>>>
>>>> static int idle_timeout = 0;
>>>> +static bool uhidp_enabled = false;
>>>
>>> I am not really in favor of naming this uhidp. I realize how you get to this, but I am not sure this is a good naming. Maybe we should just stick with hidp for this.
>>
>> I picked this name following typical kernel approach to naming
>> something that happens in userspace -- uhid, uinput, udev, etc.
>> I don't know how to name this better. Do you feel "hidp" is better?
>> input.conf would then have an item "hidp=<true|false>" as well.
>
> internally we might just call this uhid_enabled. Since that is what we are doing here. We are using uHID. For HoG it just happens to be the only possible option.
>
> For the input.conf file, I would propose using UserspaceDriver or maybe UserspaceHID. I am open for better names. I have not come up with a really good one yet.
>

Done. s/uhidp_enabled/uhid_enabled/ everywhere. And, I like
UserspaceHID=true/false in input.conf. Sending new patch out shortly.

>>> And I am just thinking out load, but maybe creating a src/shared/hidp.[ch] as generalized implementation of the HID protocol over L2CAP might be something to think about it a bit. No requirement to do it right away, but something that should be considered.
>>>
>>
>> Sounds good. Action item after initial commit.
>>
>>>>
>>>> void input_set_idle_timeout(int timeout)
>>>> {
>>>>      idle_timeout = timeout;
>>>> }
>>>>
>>>> +void input_enable_uhidp(bool state)
>>>> +{
>>>> +     uhidp_enabled = state;
>>>> +}
>>>> +
>>>> static void input_device_enter_reconnect_mode(struct input_device *idev);
>>>> +static int connection_disconnect(struct input_device *idev, uint32_t flags);
>>>>
>>>> static void input_device_free(struct input_device *idev)
>>>> {
>>>> @@ -124,14 +142,189 @@ static void input_device_free(struct input_device *idev)
>>>>      if (idev->reconnect_timer > 0)
>>>>              g_source_remove(idev->reconnect_timer);
>>>>
>>>> +     if (idev->report_req_timer > 0)
>>>> +             g_source_remove(idev->report_req_timer);
>>>> +
>>>>      g_free(idev);
>>>> }
>>>>
>>>> +static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
>>>> +                                     const uint8_t *data, size_t size)
>>>> +{
>>>> +     int fd;
>>>> +     ssize_t len;
>>>> +     uint8_t msg[size + 1];
>>>> +
>>>> +     if (data == NULL)
>>>> +             size = 0;
>>>> +
>>>> +     msg[0] = hdr;
>>>> +     if (size > 0)
>>>> +             memcpy(&msg[1], data, size);
>>>> +     ++size;
>>>> +
>>>> +     fd = g_io_channel_unix_get_fd(chan);
>>>> +
>>>> +     len = write(fd, msg, size);
>>>> +     if (len < 0) {
>>>> +             error("BT socket write error: %s (%d)", strerror(errno), errno);
>>>> +             return false;
>>>> +     }
>>>> +
>>>> +     if (len < size) {
>>>> +             error("BT socket write error: partial write (%zd of %zu bytes)",
>>>> +                                                             len, size);
>>>> +             return false;
>>>> +     }
>>>> +
>>>> +     return true;
>>>> +}
>>>> +
>>>> +static bool hidp_send_ctrl_message(struct input_device *idev, uint8_t hdr,
>>>> +                                     const uint8_t *data, size_t size)
>>>> +{
>>>> +     return hidp_send_message(idev->ctrl_io, hdr, data, size);
>>>> +}
>>>> +
>>>> +static bool hidp_send_intr_message(struct input_device *idev, uint8_t hdr,
>>>> +                                     const uint8_t *data, size_t size)
>>>> +{
>>>> +     return hidp_send_message(idev->intr_io, hdr, data, size);
>>>> +}
>>>> +
>>>> +static bool uhid_send_feature_answer(struct input_device *idev,
>>>> +                                     const uint8_t *data, size_t size,
>>>> +                                     uint32_t id, uint16_t err)
>>>> +{
>>>> +     struct uhid_event ev;
>>>> +     ssize_t len;
>>>> +
>>>> +     if (data == NULL)
>>>> +             size = 0;
>>>> +
>>>> +     if (size > sizeof(ev.u.feature_answer.data))
>>>> +             size = sizeof(ev.u.feature_answer.data);
>>>> +
>>>> +     if (!idev->uhid_created) {
>>>> +             DBG("HID report (%zu bytes) dropped", size);
>>>> +             return false;
>>>> +     }
>>>> +
>>>> +     memset(&ev, 0, sizeof(ev));
>>>> +     ev.type = UHID_FEATURE_ANSWER;
>>>> +     ev.u.feature_answer.id = id;
>>>> +     ev.u.feature_answer.err = err;
>>>> +     ev.u.feature_answer.size = size;
>>>> +
>>>> +     if (size > 0)
>>>> +             memcpy(ev.u.feature_answer.data, data, size);
>>>> +
>>>> +     len = write(idev->uhid_fd, &ev, sizeof(ev));
>>>
>>> Can we just use writev here and avoid the memcpy?
>>
>> I would prefer not to, initially. It gets a bit ugly calculating from
>> field offsets how much to send from ev and how much from data. I
>> modeled this based on report_value_cb() in hog.c.
>
> Fair point. No problem. We can fix that later. Just keep it in mind.
>

Noted. I'll look into this next.

>> Also, this function is not getting called that often. It would be more
>> beneficial for uhid_send_input_report() which is called for input
>> events. But, it is even uglier there:
>>
>> struct uhid_input_req {
>>        __u8 data[UHID_DATA_MAX];
>>        __u16 size;
>> } __attribute__((__packed__));
>>
>> struct uhid_event {
>>        __u32 type;
>>
>>        union {
>>                struct uhid_create_req create;
>>                struct uhid_input_req input;
>>                struct uhid_output_req output;
>>                struct uhid_output_ev_req output_ev;
>>                struct uhid_feature_req feature;
>>                struct uhid_feature_answer_req feature_answer;
>>        } u;
>> } __attribute__((__packed__));
>>
>> Because the size field is last in uhid_input_req, writev would need 4
>> different vectors: type + actual data + rest of data filled with 0s +
>> size.
>>
>> I have actually got this fixed in mainline kernel with new UHID_INPUT2
>> + UHID_CREATE2 message types:
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4522643aa9630be17238edf1b4c0b690c5dd7f5d
>>
>> Can we optimize these writes later?
>
> If we can easily detect UHID_CREATE2 is available in the kernel or not, I am more than happy to go with what you have right now and then move on to a more optimized version. Just make sure it is easy enough to detect the support so we can have a graceful fallback.
>

I'm going to propose adding UHID_VERSION command to uHID driver, so we
can easily detect UHID_INPUT2 + UHID_CREATE2 support.

>>> And strictly speaking we should use an asynchronous non-blocking write handling here. Similar to what src/shared/io.[ch] is giving us the correct helpers for. Similar to how we implement it in src/shard/hci.[ch] or src/shared/mgmt.[ch].
>>>
>>
>> I'm not familiar with those. I just modeled this based on how
>> report_value_cb() does it in hog.c.
>
> We can fix this later on as well. However have a look at how we do a POLLOUT before writing anything to a file descriptor. Long term goal is to turn into using fully asynchronous non-blocking IO for writing.

Will do. HoG will need this as well.

>
> Regards
>
> Marcel
>
