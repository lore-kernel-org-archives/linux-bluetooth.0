Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140317094331.GA19520@localhost.P-661HNU-F1>
References: <20140313030007.557A6100A6E@puck.mtv.corp.google.com>
	<20140317094331.GA19520@localhost.P-661HNU-F1>
Date: Tue, 18 Mar 2014 17:33:58 -0700
Message-ID: <CAGXr9JE=JUSED+GPbedaZwXdrLctVDEBTpFwUj4Kw0T-GmH7XA@mail.gmail.com>
Subject: Re: [PATCH] uHIDP: HIDP in userspace
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Mar 17, 2014 at 2:43 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Petri,
>
> On Wed, Mar 12, 2014, Petri Gynther wrote:
>> Enable HID protocol handling in userspace when uHIDP=true in input.conf.
>> ---
>>  Makefile.plugins           |   3 +-
>>  profiles/input/device.c    | 804 +++++++++++++++++++++++++++++++++++++++++----
>>  profiles/input/device.h    |   1 +
>>  profiles/input/hidp_defs.h |  77 +++++
>>  profiles/input/input.conf  |   4 +
>>  profiles/input/manager.c   |  22 +-
>>  6 files changed, 837 insertions(+), 74 deletions(-)
>>  create mode 100644 profiles/input/hidp_defs.h
>
> For such a large patch you'll really need a more thorough explanation of
> the background. Also, if possible consider if there's any way the patch
> could be split into smaller pieces.

Thanks for reviewing the code. I can break this into two pieces:
1. Create the ioctl_xxx routines that talk to HIDP in kernel.
2. Introduce all new code for HIDP in userspace.

>
> Particularly, I'm curious why this feature is desirable over HIDP in the
> kernel. Aren't you essentially introducing something that would cause
> user space (bluetoothd) to be scheduled for every single packet, unlike
> the kernel solution which lets user space stay idle most of the time?

Motivation for doing this:
1. Persistent HID input pipeline: With uHID, HID + input devices in
kernel are not destroyed and recreated every time when HID device
disconnects and reconnects. In contrast, HIDP in kernel does not
retain the input pipeline on disconnect/reconnect.
2. HID vs HoG parity: HoG is already processed in userspace and uses
uHID, so this enables the same for HID.
3. It is easier to debug userspace than kernel space.

>
>> @@ -81,16 +85,30 @@ struct input_device {
>>       enum reconnect_mode_t   reconnect_mode;
>>       guint                   reconnect_timer;
>>       uint32_t                reconnect_attempt;
>> +     gboolean                uhidp_enabled;
>> +     int                     uhid_fd;
>> +     guint                   uhid_watch;
>> +     gboolean                uhid_created;
>> +     unsigned char           report_req_pending;
>
> To be consistent with the code base, please use uint8_t for unsigned
> 8-bit integers.
>
> In our efforts to eventually get rid of the GLib dependency, it'd be
> nice if you could try to use bool instead of gboolean whenever you're
> not directly interfacing with a GLib API (which expects gboolean).

I will address all your comments and send you the revised code in two patches:
- patch #1: Create ioctl_xxx routines
- patch #2: Introduce new uHIDP code

-- Petri

>
>> +static gboolean hidp_send_message(GIOChannel *chan, const unsigned char hdr,
>
> The extra const declaration for hdr seems unnecessary here (it's also
> not consistent with the rest of the code base. Also, use uint8_t please.
>
>> +     msg[0] = hdr;
>> +     if (size > 0)
>> +             memcpy(&msg[1], data, size);
>> +
>> +     msgptr = msg;
>> +     ++size;
>> +
>> +     fd = g_io_channel_unix_get_fd(chan);
>> +
>> +     while (size > 0) {
>> +             len = write(fd, msgptr, size);
>> +
>> +             if (len < 0) {
>> +                     error("BT socket write failed: %s (%d)",
>> +                                                     strerror(errno), errno);
>> +                     return FALSE;
>> +             }
>> +
>> +             if (len == 0) {
>> +                     error("BT socket write failed: wrote 0 bytes");
>> +                     return FALSE;
>> +             }
>> +
>> +             msgptr += len;
>> +             size -= len;
>> +     }
>
> Since this is a SEQPACKET L2CAP socket I don't think you can get this
> kind of partial writes, and hence the loop is unnecessary. Also, did
> you considered using a scatter/gather vector to avoid this extra buffer
> and memcpy in user space, i.e. use sendmsg() and keep hdr and data
> separate?
>
>> +static inline gboolean hidp_send_ctrl_message(struct input_device *idev,
>> +     const unsigned char hdr, const unsigned char *data, unsigned int size)
>> +{
>> +     return hidp_send_message(idev->ctrl_io, hdr, data, size);
>> +}
>> +
>> +static inline gboolean hidp_send_intr_message(struct input_device *idev,
>> +     const unsigned char hdr, const unsigned char *data, unsigned int size)
>> +{
>> +     return hidp_send_message(idev->intr_io, hdr, data, size);
>> +}
>
> Again, no need for const with the non-pointer variables, and please use
> uint8_t. I'd also consider renaming this to hidp_ctrl_send/hidp_intr_send
> to make it easier to follow the coding style (you should indent the
> split lines past the '(' of the first line. Also drop the inline
> declaration as the compiler will optimize this anyway. I'd also consider
> using size_t as a more appropriate type for the size, or alternatively
> something that maps better to the limitations of the protocol such as
> uint8_t or uint16_t.
>
>> +static gboolean uhid_send_feature_answer(struct input_device *idev,
>> +                             const unsigned char *data, unsigned int size,
>> +                             const unsigned int id, const unsigned int err)
>
> Same thing here with const and uint8_t.
>
>> +     len = write(idev->uhid_fd, &ev, sizeof(ev));
>> +
>> +     if (len < 0) {
>
> You can remove the empty line above to be consistent with the coding
> style.
>
>> +static gboolean uhid_send_input_report(struct input_device *idev,
>> +                             const unsigned char *data, unsigned int size)
>
> Same thing with the size variable type as mentioned earlier.
>
>> +     len = write(idev->uhid_fd, &ev, sizeof(ev));
>> +
>> +     if (len < 0) {
>
> You can remove the empty line above.
>
>> +static gboolean hidp_recv_intr_data(GIOChannel *chan,
>> +                                             struct input_device *idev)
>> +{
>> +     int fd;
>> +     ssize_t len;
>> +     unsigned char hdr;
>
> uint8_t hdr;
>
>> +     unsigned char data[UHID_DATA_MAX + 1];
>
> uint8_t data[...];
>
>> +
>> +     fd = g_io_channel_unix_get_fd(chan);
>> +     len = read(fd, data, sizeof(data));
>> +
>> +     if (len < 0) {
>
> Remove the empty line.
>
>>  static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
>>  {
>>       struct input_device *idev = data;
>>       char address[18];
>>
>> +     if ((cond & G_IO_IN) && hidp_recv_intr_data(chan, idev) &&
>> +                                                     (cond == G_IO_IN)) {
>> +             return TRUE;
>> +     }
>
> This is cramming a bit too many things into the same if-statement.
> Please split it up, e.g. something like:
>
> if ((cond & G_IO_IN) && !hidp_recv_intr_data(chan, idev))
>         goto failed;
>
> /* No exceptions just incoming data  */
> if (cond == G_IO_IN)
>         return TRUE;
>
>> +static void hidp_recv_ctrl_handshake(struct input_device *idev,
>> +                                                     unsigned char param)
>
> uint8_t param
>
>> +     unsigned char pending_req_type;
>
> uint8_t
>
>> +static void hidp_recv_ctrl_hid_control(struct input_device *idev,
>> +                                                     unsigned char param)
>> +{
>
> uint8_t param
>
>> +     DBG("");
>> +
>> +     if (param == HIDP_CTRL_VIRTUAL_CABLE_UNPLUG)
>> +             connection_disconnect(idev, 0);
>> +}
>> +
>> +static void hidp_recv_ctrl_data(struct input_device *idev, unsigned char param,
>> +                                     unsigned char *data, unsigned int len)
>
> Considering how much you made use of const in the previous functions I'm
> surprised you're not using it here. I suppose data should at least have
> it? Also, again, please use size_t or something else more appropriate
> than unsigned int for the len variable.
>
>> +{
>> +     unsigned char pending_req_type;
>> +     unsigned char pending_req_param;
>
> uint8_t
>
>> +     pending_req_type = idev->report_req_pending & HIDP_HEADER_TRANS_MASK;
>> +     pending_req_param = idev->report_req_pending & HIDP_HEADER_PARAM_MASK;
>> +
>> +     if (pending_req_type != HIDP_TRANS_GET_REPORT) {
>> +             DBG("Spurious DATA on control channel");
>> +             return;
>> +     }
>> +
>> +     if (pending_req_param != param) {
>> +             DBG("Received DATA RTYPE doesn't match pending request RTYPE");
>> +             return;
>> +     }
>
> This might look cleaner (and more consistent with coding style) if you
> do the assignments right before checking the resulting value:
>
> pending_req_type = ...
> if (panding_req_type != ...) {
>         ...
> }
>
> pending_req_param = ...
> if (pending_req_param != ...) {
>         ...
> }
>
>> +static gboolean hidp_recv_ctrl_message(GIOChannel *chan,
>> +                                             struct input_device *idev)
>> +{
>> +     int fd;
>> +     ssize_t len;
>> +     unsigned char hdr, type, param;
>> +     unsigned char data[UHID_DATA_MAX + 1];
>
> uint8_t
>
>> +
>> +     fd = g_io_channel_unix_get_fd(chan);
>> +     len = read(fd, data, sizeof(data));
>> +
>> +     if (len < 0) {
>
> You can remove the empty line above.
>
>>  static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
>>  {
>>       struct input_device *idev = data;
>>       char address[18];
>>
>> +     if ((cond & G_IO_IN) && hidp_recv_ctrl_message(chan, idev) &&
>> +                                                     (cond == G_IO_IN)) {
>> +             return TRUE;
>> +     }
>
> Same thing as earlier, please split this up a bit.
>
>
>> +static gboolean hidp_report_req_timeout(gpointer data)
>> +{
>> +     struct input_device *idev = data;
>> +     unsigned char pending_req_type;
>> +     char *req_type_str;
>
> Should be const char * considering what you're later assigning to it.
>
>> +static void hidp_send_set_report(struct input_device *idev,
>> +                                                     struct uhid_event *ev)
>> +{
>> +     unsigned char hdr;
>
> uint8_t
>
>> +     gboolean sent;
>
> bool
>
>> +static void hidp_send_get_report(struct input_device *idev,
>> +                                                     struct uhid_event *ev)
>> +{
>> +     unsigned char hdr;
>> +     gboolean sent;
>
> Same here.
>
> Johan
