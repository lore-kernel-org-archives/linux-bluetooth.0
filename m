Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2850259.ILDlU5AmMy@athlon>
References: <20140219201545.4D13D1007E0@puck.mtv.corp.google.com>
	<3638568.rUrzPLdPh8@athlon>
	<CAGXr9JGz-B6yLHsDMKZrp3iuWP4Uaj78kqiGtNUytnku+wczAA@mail.gmail.com>
	<2850259.ILDlU5AmMy@athlon>
Date: Wed, 19 Feb 2014 13:47:52 -0800
Message-ID: <CAGXr9JHrc5dgS5twNmPqa97XEHJxdn-hV+Rs+sH-VMVn8Hsrfg@mail.gmail.com>
Subject: Re: [PATCH] hog: Fill ev.u.create.{phys,uniq} for UHID_CREATE
From: Petri Gynther <pgynther@google.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Feb 19, 2014 at 1:24 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> Hi Petri,
>
> On Wednesday 19 February 2014 13:15:32 Petri Gynther wrote:
>> I used hogdev->device directly in:
>> http://marc.info/?l=linux-bluetooth&m=139105411019568&w=2
>>
>> But Johan commented on that:
>> http://marc.info/?l=linux-bluetooth&m=139228316405777&w=2
>>
>> So that's why I went this route and added name, src, dst.
>
> I suppose it was about using local adapter variable to avoid those nested
> calls as this is indeed quite hard to read.
>

I think I misunderstood the comment. I ended up adding name, src, dst
to hog_device to mimic input_device, which has those fields. However,
I just realized that input_device also has a pointer to btd_device.

I'll rework the HoG code. And, I'll see if it is easy to do the same
for input_device.

>>
>> -- Petri
>>
>> On Wed, Feb 19, 2014 at 12:30 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
>> > Hi Petri,
>> >
>> > On Wednesday 19 February 2014 12:15:45 Petri Gynther wrote:
>> >> Fill ev.u.create.{phys,uniq} fields when uHID device is created.
>> >> These values are copied to kernel hid_device structure.
>> >>
>> >> linux/include/linux/hid.h:
>> >> struct hid_device {
>> >>
>> >>   ...
>> >>   char name[128];  /* Device name */
>> >>   char phys[64];   /* Device physical location */
>> >>   char uniq[64];   /* Device unique identifier (serial #) */
>> >>
>> >> ---
>> >>
>> >>  profiles/input/hog.c | 7 +++++++
>> >>  1 file changed, 7 insertions(+)
>> >>
>> >> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
>> >> index b9a14b9..35b973b 100644
>> >> --- a/profiles/input/hog.c
>> >> +++ b/profiles/input/hog.c
>> >> @@ -92,6 +92,8 @@ struct hog_device {
>> >>
>> >>       uint16_t                ctrlpt_handle;
>> >>       uint8_t                 flags;
>> >>       char                    *name;
>> >>
>> >> +     bdaddr_t                src;
>> >> +     bdaddr_t                dst;
>> >>
>> >>  };
>> >
>> > struct hog_device already holds reference to btd_device and both src and
>> > dst can be taken from it where needed. No need to extend struct
>> > hog_device.
>> >
>> > BTW same goes with name member which could be removed.
>> >
>> >>  struct report {
>> >>
>> >> @@ -396,6 +398,8 @@ static void report_map_read_cb(guint8 status, const
>> >> guint8 *pdu, guint16 plen, strncpy((char *) ev.u.create.name,
>> >> hogdev->name
>> >> ?
>> >>
>> >>                                       hogdev->name : "bluez-hog-device",
>> >>                                       sizeof(ev.u.create.name) - 1);
>> >>
>> >> +     ba2str(&hogdev->src, (char *) ev.u.create.phys);
>> >> +     ba2str(&hogdev->dst, (char *) ev.u.create.uniq);
>> >>
>> >>       ev.u.create.vendor = vendor;
>> >>       ev.u.create.product = product;
>> >>       ev.u.create.version = version;
>> >>
>> >> @@ -724,6 +728,7 @@ static void attio_disconnected_cb(gpointer user_data)
>> >>
>> >>  static struct hog_device *hog_new_device(struct btd_device *device,
>> >>
>> >>                                                               uint16_t
>> >>                                                               id)
>> >>
>> >>  {
>> >>
>> >> +     struct btd_adapter *adapter = device_get_adapter(device);
>> >>
>> >>       struct hog_device *hogdev;
>> >>       char name[HCI_MAX_NAME_LENGTH + 1];
>> >>
>> >> @@ -736,6 +741,8 @@ static struct hog_device *hog_new_device(struct
>> >> btd_device *device, device_get_name(device, name, sizeof(name));
>> >>
>> >>       if (strlen(name) > 0)
>> >>
>> >>               hogdev->name = g_strdup(name);
>> >>
>> >> +     bacpy(&hogdev->src, btd_adapter_get_address(adapter));
>> >> +     bacpy(&hogdev->dst, device_get_address(device));
>> >>
>> >>       return hogdev;
>> >>
>> >>  }
>> >
>> > --
>> > Szymon K. Janc
>> > szymon.janc@gmail.com
>
> --
> Szymon K. Janc
> szymon.janc@gmail.com
