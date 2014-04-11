Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <83DDEFEF-702B-4A41-BBC2-A9CD8F37ECCD@holtmann.org>
References: <20140408011009.55000101498@puck.mtv.corp.google.com>
	<83DDEFEF-702B-4A41-BBC2-A9CD8F37ECCD@holtmann.org>
Date: Thu, 10 Apr 2014 17:33:36 -0700
Message-ID: <CAGXr9JH1FguUQPWXcLJXGwf25TGh5-b7uCsM1x-SYhE5oJ-3+A@mail.gmail.com>
Subject: Re: [PATCH v2] input: uHIDP: HIDP in userspace
From: Petri Gynther <pgynther@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Apr 8, 2014 at 12:26 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Petri,
>
> > Enable HID protocol handling in userspace when uHIDP=3Dtrue in input.co=
nf.
> > ---
> > Makefile.plugins           |   3 +-
> > profiles/input/device.c    | 677 ++++++++++++++++++++++++++++++++++++++=
+++++--
> > profiles/input/device.h    |   1 +
> > profiles/input/hidp_defs.h |  77 ++++++
> > profiles/input/input.conf  |   4 +
> > profiles/input/manager.c   |   9 +
> > 6 files changed, 754 insertions(+), 17 deletions(-)
> > create mode 100644 profiles/input/hidp_defs.h
> >
> > diff --git a/Makefile.plugins b/Makefile.plugins
> > index 6a1ddbf..f0eada9 100644
> > --- a/Makefile.plugins
> > +++ b/Makefile.plugins
> > @@ -55,7 +55,8 @@ builtin_sources +=3D profiles/network/manager.c \
> > builtin_modules +=3D input
> > builtin_sources +=3D profiles/input/manager.c \
> >                       profiles/input/server.h profiles/input/server.c \
> > -                     profiles/input/device.h profiles/input/device.c
> > +                     profiles/input/device.h profiles/input/device.c \
> > +                     profiles/input/uhid_copy.h profiles/input/hidp_de=
fs.h
> >
> > builtin_modules +=3D hog
> > builtin_sources +=3D profiles/input/hog.c profiles/input/uhid_copy.h \
> > diff --git a/profiles/input/device.c b/profiles/input/device.c
> > index f1fa716..01891f4 100644
> > --- a/profiles/input/device.c
> > +++ b/profiles/input/device.c
> > @@ -53,9 +53,13 @@
> > #include "src/sdp-client.h"
> >
> > #include "device.h"
> > +#include "hidp_defs.h"
> > +#include "uhid_copy.h"
> >
> > #define INPUT_INTERFACE "org.bluez.Input1"
> >
> > +#define UHID_DEVICE_FILE "/dev/uhid"
> > +
> > enum reconnect_mode_t {
> >       RECONNECT_NONE =3D 0,
> >       RECONNECT_DEVICE,
> > @@ -81,16 +85,30 @@ struct input_device {
> >       enum reconnect_mode_t   reconnect_mode;
> >       guint                   reconnect_timer;
> >       uint32_t                reconnect_attempt;
> > +     bool                    uhidp_enabled;
> > +     int                     uhid_fd;
> > +     guint                   uhid_watch;
> > +     bool                    uhid_created;
> > +     uint8_t                 report_req_pending;
> > +     guint                   report_req_timer;
> > +     uint32_t                report_rsp_id;
> > };
> >
> > static int idle_timeout =3D 0;
> > +static bool uhidp_enabled =3D false;
>
> I am not really in favor of naming this uhidp. I realize how you get to t=
his, but I am not sure this is a good naming. Maybe we should just stick wi=
th hidp for this.

I picked this name following typical kernel approach to naming
something that happens in userspace -- uhid, uinput, udev, etc.
I don't know how to name this better. Do you feel "hidp" is better?
input.conf would then have an item "hidp=3D<true|false>" as well.

>
> And I am just thinking out load, but maybe creating a src/shared/hidp.[ch=
] as generalized implementation of the HID protocol over L2CAP might be som=
ething to think about it a bit. No requirement to do it right away, but som=
ething that should be considered.
>

Sounds good. Action item after initial commit.

> >
> > void input_set_idle_timeout(int timeout)
> > {
> >       idle_timeout =3D timeout;
> > }
> >
> > +void input_enable_uhidp(bool state)
> > +{
> > +     uhidp_enabled =3D state;
> > +}
> > +
> > static void input_device_enter_reconnect_mode(struct input_device *idev=
);
> > +static int connection_disconnect(struct input_device *idev, uint32_t f=
lags);
> >
> > static void input_device_free(struct input_device *idev)
> > {
> > @@ -124,14 +142,189 @@ static void input_device_free(struct input_devic=
e *idev)
> >       if (idev->reconnect_timer > 0)
> >               g_source_remove(idev->reconnect_timer);
> >
> > +     if (idev->report_req_timer > 0)
> > +             g_source_remove(idev->report_req_timer);
> > +
> >       g_free(idev);
> > }
> >
> > +static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
> > +                                     const uint8_t *data, size_t size)
> > +{
> > +     int fd;
> > +     ssize_t len;
> > +     uint8_t msg[size + 1];
> > +
> > +     if (data =3D=3D NULL)
> > +             size =3D 0;
> > +
> > +     msg[0] =3D hdr;
> > +     if (size > 0)
> > +             memcpy(&msg[1], data, size);
> > +     ++size;
> > +
> > +     fd =3D g_io_channel_unix_get_fd(chan);
> > +
> > +     len =3D write(fd, msg, size);
> > +     if (len < 0) {
> > +             error("BT socket write error: %s (%d)", strerror(errno), =
errno);
> > +             return false;
> > +     }
> > +
> > +     if (len < size) {
> > +             error("BT socket write error: partial write (%zd of %zu b=
ytes)",
> > +                                                             len, size=
);
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static bool hidp_send_ctrl_message(struct input_device *idev, uint8_t =
hdr,
> > +                                     const uint8_t *data, size_t size)
> > +{
> > +     return hidp_send_message(idev->ctrl_io, hdr, data, size);
> > +}
> > +
> > +static bool hidp_send_intr_message(struct input_device *idev, uint8_t =
hdr,
> > +                                     const uint8_t *data, size_t size)
> > +{
> > +     return hidp_send_message(idev->intr_io, hdr, data, size);
> > +}
> > +
> > +static bool uhid_send_feature_answer(struct input_device *idev,
> > +                                     const uint8_t *data, size_t size,
> > +                                     uint32_t id, uint16_t err)
> > +{
> > +     struct uhid_event ev;
> > +     ssize_t len;
> > +
> > +     if (data =3D=3D NULL)
> > +             size =3D 0;
> > +
> > +     if (size > sizeof(ev.u.feature_answer.data))
> > +             size =3D sizeof(ev.u.feature_answer.data);
> > +
> > +     if (!idev->uhid_created) {
> > +             DBG("HID report (%zu bytes) dropped", size);
> > +             return false;
> > +     }
> > +
> > +     memset(&ev, 0, sizeof(ev));
> > +     ev.type =3D UHID_FEATURE_ANSWER;
> > +     ev.u.feature_answer.id =3D id;
> > +     ev.u.feature_answer.err =3D err;
> > +     ev.u.feature_answer.size =3D size;
> > +
> > +     if (size > 0)
> > +             memcpy(ev.u.feature_answer.data, data, size);
> > +
> > +     len =3D write(idev->uhid_fd, &ev, sizeof(ev));
>
> Can we just use writev here and avoid the memcpy?

I would prefer not to, initially. It gets a bit ugly calculating from
field offsets how much to send from ev and how much from data. I
modeled this based on report_value_cb() in hog.c.

Also, this function is not getting called that often. It would be more
beneficial for uhid_send_input_report() which is called for input
events. But, it is even uglier there:

struct uhid_input_req {
        __u8 data[UHID_DATA_MAX];
        __u16 size;
} __attribute__((__packed__));

struct uhid_event {
        __u32 type;

        union {
                struct uhid_create_req create;
                struct uhid_input_req input;
                struct uhid_output_req output;
                struct uhid_output_ev_req output_ev;
                struct uhid_feature_req feature;
                struct uhid_feature_answer_req feature_answer;
        } u;
} __attribute__((__packed__));

Because the size field is last in uhid_input_req, writev would need 4
different vectors: type + actual data + rest of data filled with 0s +
size.

I have actually got this fixed in mainline kernel with new UHID_INPUT2
+ UHID_CREATE2 message types:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=3D4522643aa9630be17238edf1b4c0b690c5dd7f5d

Can we optimize these writes later?

>
> And strictly speaking we should use an asynchronous non-blocking write ha=
ndling here. Similar to what src/shared/io.[ch] is giving us the correct he=
lpers for. Similar to how we implement it in src/shard/hci.[ch] or src/shar=
ed/mgmt.[ch].
>

I'm not familiar with those. I just modeled this based on how
report_value_cb() does it in hog.c.

> > +     if (len < 0) {
> > +             error("uHID dev write error: %s (%d)", strerror(errno), e=
rrno);
> > +             return false;
> > +     }
> > +
> > +     /* uHID kernel driver does not handle partial writes */
> > +     if (len < sizeof(ev)) {
> > +             error("uHID dev write error: partial write (%zd of %lu by=
tes)",
> > +                                                     len, sizeof(ev));
> > +             return false;
> > +     }
> > +
> > +     DBG("HID report (%zu bytes) -> uHID fd %d", size, idev->uhid_fd);
> > +
> > +     return true;
> > +}
> > +
> > +static bool uhid_send_input_report(struct input_device *idev,
> > +                                     const uint8_t *data, size_t size)
> > +{
> > +     struct uhid_event ev;
> > +     ssize_t len;
> > +
> > +     if (data =3D=3D NULL)
> > +             size =3D 0;
> > +
> > +     if (size > sizeof(ev.u.input.data))
> > +             size =3D sizeof(ev.u.input.data);
> > +
> > +     if (!idev->uhid_created) {
> > +             DBG("HID report (%zu bytes) dropped", size);
> > +             return false;
> > +     }
> > +
> > +     memset(&ev, 0, sizeof(ev));
> > +     ev.type =3D UHID_INPUT;
> > +     ev.u.input.size =3D size;
> > +
> > +     if (size > 0)
> > +             memcpy(ev.u.input.data, data, size);
> > +
> > +     len =3D write(idev->uhid_fd, &ev, sizeof(ev));
> > +     if (len < 0) {
> > +             error("uHID dev write error: %s (%d)", strerror(errno), e=
rrno);
> > +             return false;
> > +     }
> > +
> > +     /* uHID kernel driver does not handle partial writes */
> > +     if (len < sizeof(ev)) {
> > +             error("uHID dev write error: partial write (%zd of %lu by=
tes)",
> > +                                                     len, sizeof(ev));
> > +             return false;
> > +     }
> > +
> > +     DBG("HID report (%zu bytes) -> uHID fd %d", size, idev->uhid_fd);
> > +
> > +     return true;
> > +}
> > +
> > +static bool hidp_recv_intr_data(GIOChannel *chan, struct input_device =
*idev)
> > +{
> > +     int fd;
> > +     ssize_t len;
> > +     uint8_t hdr;
> > +     uint8_t data[UHID_DATA_MAX + 1];
> > +
> > +     fd =3D g_io_channel_unix_get_fd(chan);
> > +
> > +     len =3D read(fd, data, sizeof(data));
> > +     if (len < 0) {
> > +             error("BT socket read error: %s (%d)", strerror(errno), e=
rrno);
> > +             return false;
> > +     }
> > +
> > +     if (len =3D=3D 0) {
> > +             DBG("BT socket read returned 0 bytes");
> > +             return true;
> > +     }
> > +
> > +     hdr =3D data[0];
> > +     if (hdr !=3D (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
> > +             DBG("unsupported HIDP protocol header 0x%02x", hdr);
> > +             return true;
> > +     }
> > +
> > +     if (len < 2) {
> > +             DBG("received empty HID report");
> > +             return true;
> > +     }
> > +
> > +     uhid_send_input_report(idev, data + 1, len - 1);
> > +
> > +     return true;
> > +}
> > +
> > static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpoi=
nter data)
> > {
> >       struct input_device *idev =3D data;
> >       char address[18];
> >
> > +     if (cond & G_IO_IN) {
> > +             if (hidp_recv_intr_data(chan, idev) && (cond =3D=3D G_IO_=
IN))
> > +                     return TRUE;
> > +     }
> > +
> >       ba2str(&idev->dst, address);
> >
> >       DBG("Device %s disconnected", address);
> > @@ -164,11 +357,170 @@ static gboolean intr_watch_cb(GIOChannel *chan, =
GIOCondition cond, gpointer data
> >       return FALSE;
> > }
> >
> > +static void hidp_recv_ctrl_handshake(struct input_device *idev, uint8_=
t param)
> > +{
> > +     bool pending_req_complete =3D false;
> > +     uint8_t pending_req_type;
> > +
> > +     DBG("");
> > +
> > +     pending_req_type =3D idev->report_req_pending & HIDP_HEADER_TRANS=
_MASK;
> > +
> > +     switch (param) {
> > +     case HIDP_HSHK_SUCCESSFUL:
> > +             if (pending_req_type =3D=3D HIDP_TRANS_SET_REPORT) {
> > +                     DBG("SET_REPORT successful");
> > +                     pending_req_complete =3D true;
> > +             } else
> > +                     DBG("Spurious HIDP_HSHK_SUCCESSFUL");
> > +             break;
> > +
> > +     case HIDP_HSHK_NOT_READY:
> > +     case HIDP_HSHK_ERR_INVALID_REPORT_ID:
> > +     case HIDP_HSHK_ERR_UNSUPPORTED_REQUEST:
> > +     case HIDP_HSHK_ERR_INVALID_PARAMETER:
> > +     case HIDP_HSHK_ERR_UNKNOWN:
> > +     case HIDP_HSHK_ERR_FATAL:
> > +             if (pending_req_type =3D=3D HIDP_TRANS_GET_REPORT) {
> > +                     DBG("GET_REPORT failed (%u)", param);
> > +                     uhid_send_feature_answer(idev, NULL, 0,
> > +                                             idev->report_rsp_id, EIO)=
;
> > +                     pending_req_complete =3D true;
> > +             } else if (pending_req_type =3D=3D HIDP_TRANS_SET_REPORT)=
 {
> > +                     DBG("SET_REPORT failed (%u)", param);
> > +                     pending_req_complete =3D true;
> > +             } else
> > +                     DBG("Spurious HIDP_HSHK_ERR");
> > +
> > +             if (param =3D=3D HIDP_HSHK_ERR_FATAL)
> > +                     hidp_send_ctrl_message(idev, HIDP_TRANS_HID_CONTR=
OL |
> > +                                             HIDP_CTRL_SOFT_RESET, NUL=
L, 0);
> > +             break;
> > +
> > +     default:
> > +             hidp_send_ctrl_message(idev, HIDP_TRANS_HANDSHAKE |
> > +                             HIDP_HSHK_ERR_INVALID_PARAMETER, NULL, 0)=
;
> > +             break;
> > +     }
> > +
> > +     if (pending_req_complete) {
> > +             idev->report_req_pending =3D 0;
> > +             if (idev->report_req_timer > 0) {
> > +                     g_source_remove(idev->report_req_timer);
> > +                     idev->report_req_timer =3D 0;
> > +             }
> > +             idev->report_rsp_id =3D 0;
> > +     }
> > +}
> > +
> > +static void hidp_recv_ctrl_hid_control(struct input_device *idev, uint=
8_t param)
> > +{
> > +     DBG("");
> > +
> > +     if (param =3D=3D HIDP_CTRL_VIRTUAL_CABLE_UNPLUG)
> > +             connection_disconnect(idev, 0);
> > +}
> > +
> > +static void hidp_recv_ctrl_data(struct input_device *idev, uint8_t par=
am,
> > +                                     const uint8_t *data, size_t size)
> > +{
> > +     uint8_t pending_req_type;
> > +     uint8_t pending_req_param;
> > +
> > +     DBG("");
> > +
> > +     pending_req_type =3D idev->report_req_pending & HIDP_HEADER_TRANS=
_MASK;
> > +     if (pending_req_type !=3D HIDP_TRANS_GET_REPORT) {
> > +             DBG("Spurious DATA on control channel");
> > +             return;
> > +     }
> > +
> > +     pending_req_param =3D idev->report_req_pending & HIDP_HEADER_PARA=
M_MASK;
> > +     if (pending_req_param !=3D param) {
> > +             DBG("Received DATA RTYPE doesn't match pending request RT=
YPE");
> > +             return;
> > +     }
> > +
> > +     switch (param) {
> > +     case HIDP_DATA_RTYPE_FEATURE:
> > +     case HIDP_DATA_RTYPE_INPUT:
> > +     case HIDP_DATA_RTYPE_OUPUT:
> > +             uhid_send_feature_answer(idev, data + 1, size - 1,
> > +                                                     idev->report_rsp_=
id, 0);
> > +             break;
> > +
> > +     case HIDP_DATA_RTYPE_OTHER:
> > +             DBG("Received DATA_RTYPE_OTHER");
> > +             break;
> > +
> > +     default:
> > +             hidp_send_ctrl_message(idev, HIDP_TRANS_HANDSHAKE |
> > +                             HIDP_HSHK_ERR_INVALID_PARAMETER, NULL, 0)=
;
> > +             break;
> > +     }
> > +
> > +     idev->report_req_pending =3D 0;
> > +     if (idev->report_req_timer > 0) {
> > +             g_source_remove(idev->report_req_timer);
> > +             idev->report_req_timer =3D 0;
> > +     }
> > +     idev->report_rsp_id =3D 0;
> > +}
> > +
> > +static bool hidp_recv_ctrl_message(GIOChannel *chan, struct input_devi=
ce *idev)
> > +{
> > +     int fd;
> > +     ssize_t len;
> > +     uint8_t hdr, type, param;
> > +     uint8_t data[UHID_DATA_MAX + 1];
> > +
> > +     fd =3D g_io_channel_unix_get_fd(chan);
> > +
> > +     len =3D read(fd, data, sizeof(data));
> > +     if (len < 0) {
> > +             error("BT socket read error: %s (%d)", strerror(errno), e=
rrno);
> > +             return false;
> > +     }
> > +
> > +     if (len =3D=3D 0) {
> > +             DBG("BT socket read returned 0 bytes");
> > +             return true;
> > +     }
> > +
> > +     hdr =3D data[0];
> > +     type =3D hdr & HIDP_HEADER_TRANS_MASK;
> > +     param =3D hdr & HIDP_HEADER_PARAM_MASK;
> > +
> > +     switch (type) {
> > +     case HIDP_TRANS_HANDSHAKE:
> > +             hidp_recv_ctrl_handshake(idev, param);
> > +             break;
> > +     case HIDP_TRANS_HID_CONTROL:
> > +             hidp_recv_ctrl_hid_control(idev, param);
> > +             break;
> > +     case HIDP_TRANS_DATA:
> > +             hidp_recv_ctrl_data(idev, param, data, len);
> > +             break;
> > +     default:
> > +             error("unsupported HIDP control message");
> > +             hidp_send_ctrl_message(idev, HIDP_TRANS_HANDSHAKE |
> > +                             HIDP_HSHK_ERR_UNSUPPORTED_REQUEST, NULL, =
0);
> > +             break;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond, gpoi=
nter data)
> > {
> >       struct input_device *idev =3D data;
> >       char address[18];
> >
> > +     if (cond & G_IO_IN) {
> > +             if (hidp_recv_ctrl_message(chan, idev) && (cond =3D=3D G_=
IO_IN))
> > +                     return TRUE;
> > +     }
> > +
> >       ba2str(&idev->dst, address);
> >
> >       DBG("Device %s disconnected", address);
> > @@ -193,6 +545,202 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, G=
IOCondition cond, gpointer data
> >       return FALSE;
> > }
> >
> > +#define REPORT_REQ_TIMEOUT  3
> > +
> > +static gboolean hidp_report_req_timeout(gpointer data)
> > +{
> > +     struct input_device *idev =3D data;
> > +     uint8_t pending_req_type;
> > +     const char *req_type_str;
> > +     char address[18];
> > +
> > +     ba2str(&idev->dst, address);
> > +     pending_req_type =3D idev->report_req_pending & HIDP_HEADER_TRANS=
_MASK;
> > +
> > +     switch (pending_req_type) {
> > +     case HIDP_TRANS_GET_REPORT:
> > +             req_type_str =3D "GET_REPORT";
> > +             break;
> > +     case HIDP_TRANS_SET_REPORT:
> > +             req_type_str =3D "SET_REPORT";
> > +             break;
> > +     default:
> > +             /* Should never happen */
> > +             req_type_str =3D "OTHER_TRANS";
> > +             break;
> > +     }
> > +
> > +     DBG("Device %s HIDP %s request timed out", address, req_type_str)=
;
> > +
> > +     idev->report_req_pending =3D 0;
> > +     idev->report_req_timer =3D 0;
> > +     idev->report_rsp_id =3D 0;
> > +
> > +     return FALSE;
> > +}
> > +
> > +static void hidp_send_set_report(struct input_device *idev,
> > +                                                     struct uhid_event=
 *ev)
> > +{
> > +     uint8_t hdr;
> > +     bool sent;
> > +
> > +     DBG("");
> > +
> > +     switch (ev->u.output.rtype) {
> > +     case UHID_FEATURE_REPORT:
> > +             /* Send SET_REPORT on control channel */
> > +             if (idev->report_req_pending) {
> > +                     DBG("Old GET_REPORT or SET_REPORT still pending")=
;
> > +                     return;
> > +             }
> > +
> > +             hdr =3D HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE;
> > +             sent =3D hidp_send_ctrl_message(idev, hdr, ev->u.output.d=
ata,
> > +                                                     ev->u.output.size=
);
> > +             if (sent) {
> > +                     idev->report_req_pending =3D hdr;
> > +                     idev->report_req_timer =3D
> > +                             g_timeout_add_seconds(REPORT_REQ_TIMEOUT,
> > +                                             hidp_report_req_timeout, =
idev);
> > +             }
> > +             break;
> > +     case UHID_OUTPUT_REPORT:
> > +             /* Send DATA on interrupt channel */
> > +             hdr =3D HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
> > +             hidp_send_intr_message(idev, hdr, ev->u.output.data,
> > +                                                     ev->u.output.size=
);
> > +             break;
> > +     default:
> > +             DBG("Unsupported HID report type %u", ev->u.output.rtype)=
;
> > +             return;
> > +     }
> > +}
> > +
> > +static void hidp_send_get_report(struct input_device *idev,
> > +                                                     struct uhid_event=
 *ev)
> > +{
> > +     uint8_t hdr;
> > +     bool sent;
> > +
> > +     DBG("");
> > +
> > +     if (idev->report_req_pending) {
> > +             DBG("Old GET_REPORT or SET_REPORT still pending");
> > +             uhid_send_feature_answer(idev, NULL, 0, ev->u.feature.id,
> > +                                                                     E=
BUSY);
> > +             return;
> > +     }
> > +
> > +     /* Send GET_REPORT on control channel */
> > +     switch (ev->u.feature.rtype) {
> > +     case UHID_FEATURE_REPORT:
> > +             hdr =3D HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_FEATURE;
> > +             break;
> > +     case UHID_INPUT_REPORT:
> > +             hdr =3D HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_INPUT;
> > +             break;
> > +     case UHID_OUTPUT_REPORT:
> > +             hdr =3D HIDP_TRANS_GET_REPORT | HIDP_DATA_RTYPE_OUPUT;
> > +             break;
> > +     default:
> > +             DBG("Unsupported HID report type %u", ev->u.feature.rtype=
);
> > +             return;
> > +     }
> > +
> > +     sent =3D hidp_send_ctrl_message(idev, hdr, &ev->u.feature.rnum,
> > +                                             sizeof(ev->u.feature.rnum=
));
> > +     if (sent) {
> > +             idev->report_req_pending =3D hdr;
> > +             idev->report_req_timer =3D
> > +                     g_timeout_add_seconds(REPORT_REQ_TIMEOUT,
> > +                                             hidp_report_req_timeout, =
idev);
> > +             idev->report_rsp_id =3D ev->u.feature.id;
> > +     }
> > +}
> > +
> > +static gboolean uhid_watch_cb(GIOChannel *chan, GIOCondition cond,
> > +                                                     gpointer user_dat=
a)
> > +{
> > +     struct input_device *idev =3D user_data;
> > +     int fd;
> > +     ssize_t len;
> > +     struct uhid_event ev;
> > +
> > +     if (cond & (G_IO_ERR | G_IO_NVAL))
> > +             goto failed;
> > +
> > +     fd =3D g_io_channel_unix_get_fd(chan);
> > +     memset(&ev, 0, sizeof(ev));
> > +
> > +     len =3D read(fd, &ev, sizeof(ev));
> > +     if (len < 0) {
> > +             error("uHID dev read error: %s (%d)", strerror(errno), er=
rno);
> > +             goto failed;
> > +     }
> > +
> > +     if (len < sizeof(ev.type)) {
> > +             error("uHID dev read returned too few bytes");
> > +             goto failed;
> > +     }
> > +
> > +     DBG("uHID event type %u received (%zd bytes)", ev.type, len);
> > +
> > +     switch (ev.type) {
> > +     case UHID_START:
> > +     case UHID_STOP:
> > +             /* These are called to start and stop the underlying hard=
ware.
> > +              * For HID we open the channels before creating the devic=
e so
> > +              * the hardware is always ready. No need to handle these.
> > +              * Note that these are also called when the kernel switch=
es
> > +              * between device-drivers loaded on the HID device. But w=
e can
> > +              * simply keep the hardware alive during transitions and =
it
> > +              * works just fine.
> > +              * The kernel never destroys a device itself! Only an exp=
licit
> > +              * UHID_DESTROY request can remove a device. */
> > +             break;
> > +     case UHID_OPEN:
> > +     case UHID_CLOSE:
> > +             /* OPEN/CLOSE are sent whenever user-space opens any inte=
rface
> > +              * provided by the kernel HID device. Whenever the open-c=
ount
> > +              * is non-zero we must be ready for I/O. As long as it is=
 zero,
> > +              * we can decide to drop all I/O and put the device
> > +              * asleep This is optional, though. Moreover, some
> > +              * special device drivers are buggy in that regard, so
> > +              * maybe we just keep I/O always awake like HIDP in the
> > +              * kernel does. */
> > +             break;
> > +     case UHID_OUTPUT:
> > +             hidp_send_set_report(idev, &ev);
> > +             break;
> > +     case UHID_FEATURE:
> > +             hidp_send_get_report(idev, &ev);
> > +             break;
> > +     case UHID_OUTPUT_EV:
> > +             /* This is only sent by kernels prior to linux-3.11. It
> > +              * requires us to parse HID-descriptors in user-space to
> > +              * properly handle it. This is redundant as the kernel
> > +              * does it already. That's why newer kernels assemble
> > +              * the output-reports and send it to us via UHID_OUTPUT.
> > +              * We never implemented this, so we rely on users to use
> > +              * recent-enough kernels if they want this feature. No re=
ason
> > +              * to implement this for older kernels. */
> > +             DBG("Unsupported uHID output event: type %u code %u value=
 %d",
> > +                             ev.u.output_ev.type, ev.u.output_ev.code,
> > +                             ev.u.output_ev.value);
> > +             break;
> > +     default:
> > +             warn("unexpected uHID event");
> > +             break;
> > +     }
> > +
> > +     return TRUE;
> > +
> > +failed:
> > +     idev->uhid_watch =3D 0;
> > +     return FALSE;
> > +}
> > +
> > static void epox_endian_quirk(unsigned char *data, int size)
> > {
> >       /* USAGE_PAGE (Keyboard)        05 07
> > @@ -395,6 +943,39 @@ static int ioctl_disconnect(struct input_device *i=
dev, uint32_t flags)
> >       return err;
> > }
> >
> > +static int uhid_connadd(struct input_device *idev, struct hidp_connadd=
_req *req)
> > +{
> > +     int err =3D 0;
> > +     struct uhid_event ev;
> > +
> > +     if (!idev->uhid_created) {
> > +             /* create uHID device */
> > +             memset(&ev, 0, sizeof(ev));
> > +             ev.type =3D UHID_CREATE;
> > +             strncpy((char *) ev.u.create.name, req->name,
> > +                                             sizeof(ev.u.create.name) =
- 1);
> > +             ba2str(&idev->src, (char *) ev.u.create.phys);
> > +             ba2str(&idev->dst, (char *) ev.u.create.uniq);
> > +             ev.u.create.vendor =3D req->vendor;
> > +             ev.u.create.product =3D req->product;
> > +             ev.u.create.version =3D req->version;
> > +             ev.u.create.country =3D req->country;
> > +             ev.u.create.bus =3D BUS_BLUETOOTH;
> > +             ev.u.create.rd_data =3D req->rd_data;
> > +             ev.u.create.rd_size =3D req->rd_size;
> > +
> > +             if (write(idev->uhid_fd, &ev, sizeof(ev)) < 0) {
> > +                     err =3D -errno;
> > +                     error("Failed to create uHID device: %s (%d)",
> > +                                                     strerror(-err), -=
err);
> > +             } else {
> > +                     idev->uhid_created =3D true;
> > +             }
> > +     }
> > +
> > +     return err;
> > +}
> > +
> > static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
> >                                                               gpointer =
data)
> > {
> > @@ -403,7 +984,12 @@ static gboolean encrypt_notify(GIOChannel *io, GIO=
Condition condition,
> >
> >       DBG("");
> >
> > -     err =3D ioctl_connadd(idev->req);
> > +     if (idev->uhidp_enabled) {
> > +             err =3D uhid_connadd(idev, idev->req);
> > +     } else {
> > +             err =3D ioctl_connadd(idev->req);
> > +     }
> > +
> >       if (err < 0) {
> >               error("ioctl_connadd(): %s (%d)", strerror(-err), -err);
> >
> > @@ -501,7 +1087,11 @@ static int hidp_add_connection(struct input_devic=
e *idev)
> >               return 0;
> >       }
> >
> > -     err =3D ioctl_connadd(req);
> > +     if (idev->uhidp_enabled) {
> > +             err =3D uhid_connadd(idev, req);
> > +     } else {
> > +             err =3D ioctl_connadd(req);
> > +     }
> >
> > cleanup:
> >       g_free(req->rd_data);
> > @@ -512,7 +1102,11 @@ cleanup:
> >
> > static bool is_connected(struct input_device *idev)
> > {
> > -     return ioctl_is_connected(idev);
> > +     if (idev->uhidp_enabled) {
> > +             return (idev->intr_io !=3D NULL && idev->ctrl_io !=3D NUL=
L);
> > +     } else {
> > +             return ioctl_is_connected(idev);
> > +     }
> > }
> >
> > static int connection_disconnect(struct input_device *idev, uint32_t fl=
ags)
> > @@ -526,7 +1120,10 @@ static int connection_disconnect(struct input_dev=
ice *idev, uint32_t flags)
> >       if (idev->ctrl_io)
> >               g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
> >
> > -     return ioctl_disconnect(idev, flags);
> > +     if (idev->uhidp_enabled)
> > +             return 0;
> > +     else
> > +             return ioctl_disconnect(idev, flags);
> > }
> >
> > static void disconnect_cb(struct btd_device *device, gboolean removal,
> > @@ -565,6 +1162,7 @@ static void interrupt_connect_cb(GIOChannel *chan,=
 GError *conn_err,
> >                                                       gpointer user_dat=
a)
> > {
> >       struct input_device *idev =3D user_data;
> > +     GIOCondition cond =3D G_IO_HUP | G_IO_ERR | G_IO_NVAL;
> >       int err;
> >
> >       if (conn_err) {
> > @@ -576,9 +1174,11 @@ static void interrupt_connect_cb(GIOChannel *chan=
, GError *conn_err,
> >       if (err < 0)
> >               goto failed;
> >
> > -     idev->intr_watch =3D g_io_add_watch(idev->intr_io,
> > -                                     G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> > -                                     intr_watch_cb, idev);
> > +     if (idev->uhidp_enabled)
> > +             cond |=3D G_IO_IN;
> > +
> > +     idev->intr_watch =3D g_io_add_watch(idev->intr_io, cond, intr_wat=
ch_cb,
> > +                                                                     i=
dev);
> >
> >       return;
> >
> > @@ -604,6 +1204,7 @@ static void control_connect_cb(GIOChannel *chan, G=
Error *conn_err,
> >                                                       gpointer user_dat=
a)
> > {
> >       struct input_device *idev =3D user_data;
> > +     GIOCondition cond =3D G_IO_HUP | G_IO_ERR | G_IO_NVAL;
> >       GIOChannel *io;
> >       GError *err =3D NULL;
> >
> > @@ -628,9 +1229,11 @@ static void control_connect_cb(GIOChannel *chan, =
GError *conn_err,
> >
> >       idev->intr_io =3D io;
> >
> > -     idev->ctrl_watch =3D g_io_add_watch(idev->ctrl_io,
> > -                                     G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> > -                                     ctrl_watch_cb, idev);
> > +     if (idev->uhidp_enabled)
> > +             cond |=3D G_IO_IN;
> > +
> > +     idev->ctrl_watch =3D g_io_add_watch(idev->ctrl_io, cond, ctrl_wat=
ch_cb,
> > +                                                                     i=
dev);
> >
> >       return;
> >
> > @@ -829,6 +1432,7 @@ static struct input_device *input_device_new(struc=
t btd_service *service)
> >       idev->path =3D g_strdup(path);
> >       idev->handle =3D rec->handle;
> >       idev->disable_sdp =3D is_device_sdp_disable(rec);
> > +     idev->uhidp_enabled =3D uhidp_enabled;
> >
> >       /* Initialize device properties */
> >       extract_hid_props(idev, rec);
> > @@ -858,6 +1462,8 @@ int input_device_register(struct btd_service *serv=
ice)
> >       struct btd_device *device =3D btd_service_get_device(service);
> >       const char *path =3D device_get_path(device);
> >       struct input_device *idev;
> > +     int err;
> > +     GIOChannel *io;
> >
> >       DBG("%s", path);
> >
> > @@ -865,6 +1471,24 @@ int input_device_register(struct btd_service *ser=
vice)
> >       if (!idev)
> >               return -EINVAL;
> >
> > +     if (idev->uhidp_enabled) {
> > +             idev->uhid_fd =3D open(UHID_DEVICE_FILE, O_RDWR | O_CLOEX=
EC);
> > +             if (idev->uhid_fd < 0) {
> > +                     err =3D errno;
> > +                     error("Failed to open uHID device: %s (%d)",
> > +                                                     strerror(err), er=
r);
> > +                     input_device_free(idev);
> > +                     return -err;
> > +             }
> > +
> > +             io =3D g_io_channel_unix_new(idev->uhid_fd);
> > +             g_io_channel_set_encoding(io, NULL, NULL);
> > +             idev->uhid_watch =3D g_io_add_watch(io,
> > +                                             G_IO_IN | G_IO_ERR | G_IO=
_NVAL,
> > +                                             uhid_watch_cb, idev);
> > +             g_io_channel_unref(io);
> > +     }
> > +
> >       if (g_dbus_register_interface(btd_get_dbus_connection(),
> >                                       idev->path, INPUT_INTERFACE,
> >                                       NULL, NULL,
> > @@ -902,12 +1526,31 @@ void input_device_unregister(struct btd_service =
*service)
> >       struct btd_device *device =3D btd_service_get_device(service);
> >       const char *path =3D device_get_path(device);
> >       struct input_device *idev =3D btd_service_get_user_data(service);
> > +     struct uhid_event ev;
> >
> >       DBG("%s", path);
> >
> >       g_dbus_unregister_interface(btd_get_dbus_connection(),
> >                                               idev->path, INPUT_INTERFA=
CE);
> >
> > +     if (idev->uhidp_enabled) {
> > +             if (idev->uhid_watch) {
> > +                     g_source_remove(idev->uhid_watch);
> > +                     idev->uhid_watch =3D 0;
> > +             }
> > +
> > +             if (idev->uhid_created) {
> > +                     memset(&ev, 0, sizeof(ev));
> > +                     ev.type =3D UHID_DESTROY;
> > +                     if (write(idev->uhid_fd, &ev, sizeof(ev)) < 0)
> > +                             error("Failed to destroy uHID device: %s =
(%d)",
> > +                                                     strerror(errno), =
errno);
> > +             }
> > +
> > +             close(idev->uhid_fd);
> > +             idev->uhid_fd =3D -1;
> > +     }
> > +
> >       input_device_free(idev);
> > }
> >
> > @@ -948,28 +1591,30 @@ int input_device_set_channel(const bdaddr_t *src=
, const bdaddr_t *dst, int psm,
> >                                                               GIOChanne=
l *io)
> > {
> >       struct input_device *idev =3D find_device(src, dst);
> > +     GIOCondition cond =3D G_IO_HUP | G_IO_ERR | G_IO_NVAL;
> >
> >       DBG("idev %p psm %d", idev, psm);
> >
> >       if (!idev)
> >               return -ENOENT;
> >
> > +     if (idev->uhidp_enabled)
> > +             cond |=3D G_IO_IN;
> > +
> >       switch (psm) {
> >       case L2CAP_PSM_HIDP_CTRL:
> >               if (idev->ctrl_io)
> >                       return -EALREADY;
> >               idev->ctrl_io =3D g_io_channel_ref(io);
> > -             idev->ctrl_watch =3D g_io_add_watch(idev->ctrl_io,
> > -                                     G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> > -                                     ctrl_watch_cb, idev);
> > +             idev->ctrl_watch =3D g_io_add_watch(idev->ctrl_io, cond,
> > +                                                     ctrl_watch_cb, id=
ev);
> >               break;
> >       case L2CAP_PSM_HIDP_INTR:
> >               if (idev->intr_io)
> >                       return -EALREADY;
> >               idev->intr_io =3D g_io_channel_ref(io);
> > -             idev->intr_watch =3D g_io_add_watch(idev->intr_io,
> > -                                     G_IO_HUP | G_IO_ERR | G_IO_NVAL,
> > -                                     intr_watch_cb, idev);
> > +             idev->intr_watch =3D g_io_add_watch(idev->intr_io, cond,
> > +                                                     intr_watch_cb, id=
ev);
> >               break;
> >       }
> >
> > diff --git a/profiles/input/device.h b/profiles/input/device.h
> > index da2149c..3791496 100644
> > --- a/profiles/input/device.h
> > +++ b/profiles/input/device.h
> > @@ -28,6 +28,7 @@ struct input_device;
> > struct input_conn;
> >
> > void input_set_idle_timeout(int timeout);
> > +void input_enable_uhidp(bool state);
> >
> > int input_device_register(struct btd_service *service);
> > void input_device_unregister(struct btd_service *service);
> > diff --git a/profiles/input/hidp_defs.h b/profiles/input/hidp_defs.h
> > new file mode 100644
> > index 0000000..74110b5
> > --- /dev/null
> > +++ b/profiles/input/hidp_defs.h
> > @@ -0,0 +1,77 @@
> > +/*
> > + * HIDP implementation for Linux Bluetooth stack (BlueZ).
> > + * Copyright (C) 2003-2004 Marcel Holtmann <marcel@holtmann.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation;
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS
> > + * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANT=
ABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY=
 RIGHTS.
> > + * IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE F=
OR ANY
> > + * CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAM=
AGES
> > + * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN =
AN
> > + * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OU=
T OF
> > + * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> > + *
> > + * ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> > + * COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> > + * SOFTWARE IS DISCLAIMED.
> > + */
> > +
> > +#ifndef __HIDP_DEFS_H
> > +#define __HIDP_DEFS_H
>
> please create a clean one for userspace with our userspace copyright temp=
late for LGPL. No need to keep a literal copy of the kernel version since t=
hey are just defines anyway.

Done. Will be fixed in the next revision of the patch.

>
> > +
> > +/* HIDP header masks */
> > +#define HIDP_HEADER_TRANS_MASK                       0xf0
> > +#define HIDP_HEADER_PARAM_MASK                       0x0f
> > +
> > +/* HIDP transaction types */
> > +#define HIDP_TRANS_HANDSHAKE                 0x00
> > +#define HIDP_TRANS_HID_CONTROL                       0x10
> > +#define HIDP_TRANS_GET_REPORT                        0x40
> > +#define HIDP_TRANS_SET_REPORT                        0x50
> > +#define HIDP_TRANS_GET_PROTOCOL                      0x60
> > +#define HIDP_TRANS_SET_PROTOCOL                      0x70
> > +#define HIDP_TRANS_GET_IDLE                  0x80
> > +#define HIDP_TRANS_SET_IDLE                  0x90
> > +#define HIDP_TRANS_DATA                              0xa0
> > +#define HIDP_TRANS_DATC                              0xb0
> > +
> > +/* HIDP handshake results */
> > +#define HIDP_HSHK_SUCCESSFUL                 0x00
> > +#define HIDP_HSHK_NOT_READY                  0x01
> > +#define HIDP_HSHK_ERR_INVALID_REPORT_ID              0x02
> > +#define HIDP_HSHK_ERR_UNSUPPORTED_REQUEST    0x03
> > +#define HIDP_HSHK_ERR_INVALID_PARAMETER              0x04
> > +#define HIDP_HSHK_ERR_UNKNOWN                        0x0e
> > +#define HIDP_HSHK_ERR_FATAL                  0x0f
> > +
> > +/* HIDP control operation parameters */
> > +#define HIDP_CTRL_NOP                                0x00
> > +#define HIDP_CTRL_HARD_RESET                 0x01
> > +#define HIDP_CTRL_SOFT_RESET                 0x02
> > +#define HIDP_CTRL_SUSPEND                    0x03
> > +#define HIDP_CTRL_EXIT_SUSPEND                       0x04
> > +#define HIDP_CTRL_VIRTUAL_CABLE_UNPLUG               0x05
> > +
> > +/* HIDP data transaction headers */
> > +#define HIDP_DATA_RTYPE_MASK                 0x03
> > +#define HIDP_DATA_RSRVD_MASK                 0x0c
> > +#define HIDP_DATA_RTYPE_OTHER                        0x00
> > +#define HIDP_DATA_RTYPE_INPUT                        0x01
> > +#define HIDP_DATA_RTYPE_OUPUT                        0x02
> > +#define HIDP_DATA_RTYPE_FEATURE                      0x03
> > +
> > +/* HIDP protocol header parameters */
> > +#define HIDP_PROTO_BOOT                              0x00
> > +#define HIDP_PROTO_REPORT                    0x01
> > +
> > +#define HIDP_VIRTUAL_CABLE_UNPLUG            0
> > +#define HIDP_BOOT_PROTOCOL_MODE                      1
> > +#define HIDP_BLUETOOTH_VENDOR_ID             9
> > +#define HIDP_WAITING_FOR_RETURN                      10
> > +#define HIDP_WAITING_FOR_SEND_ACK            11
> > +
> > +#endif /* __HIDP_DEFS_H */
> > diff --git a/profiles/input/input.conf b/profiles/input/input.conf
> > index abfb64f..dc33e8f 100644
> > --- a/profiles/input/input.conf
> > +++ b/profiles/input/input.conf
> > @@ -7,3 +7,7 @@
> > # Set idle timeout (in minutes) before the connection will
> > # be disconnect (defaults to 0 for no timeout)
> > #IdleTimeout=3D30
> > +
> > +# Enable HID protocol handling in userspace input profile
> > +# Defaults to false (HIDP handled in HIDP kernel module)
> > +#uHIDP=3Dtrue
>
> uHIDP is not a configuration option that I actually like. We need to come=
 up with a less cryptic one that people can understand what it does.

Any suggestions? hidp=3Dtrue/false?

>
> > diff --git a/profiles/input/manager.c b/profiles/input/manager.c
> > index 23e739a..c334f4f 100644
> > --- a/profiles/input/manager.c
> > +++ b/profiles/input/manager.c
> > @@ -97,6 +97,7 @@ static int input_init(void)
> >       config =3D load_config_file(CONFIGDIR "/input.conf");
> >       if (config) {
> >               int idle_timeout;
> > +             gboolean uhidp;
> >
> >               idle_timeout =3D g_key_file_get_integer(config, "General"=
,
> >                                                       "IdleTimeout", &e=
rr);
> > @@ -105,6 +106,14 @@ static int input_init(void)
> >                       input_set_idle_timeout(idle_timeout * 60);
> >               } else
> >                       g_clear_error(&err);
> > +
> > +             uhidp =3D g_key_file_get_boolean(config, "General", "uHID=
P",
> > +                                                                     &=
err);
> > +             if (!err) {
> > +                     DBG("input.conf: uHIDP=3D%s", uhidp ? "true" : "f=
alse");
> > +                     input_enable_uhidp(uhidp);
> > +             } else
> > +                     g_clear_error(&err);
> >       }
> >
> >       btd_profile_register(&input_profile);
>
> Regards
>
> Marcel
>
