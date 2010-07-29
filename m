Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikRQfhAKm-UW+on+ZeEp709z_ku_NDjeVD_US1b@mail.gmail.com>
References: <4C46324D.5070800@aircable.net>
	<20100721101934.GA12188@jh-x301>
	<4C470E2D.7000607@aircable.net>
	<AANLkTi=8=BUThjVdc4EN_8uupGKmdgHQzGOe560Cv+pm@mail.gmail.com>
	<AANLkTi=jzZScnCK6rFpKjBJesnw=71y5hNG3kDBhxv1u@mail.gmail.com>
	<4C505806.3040508@aircable.net>
	<AANLkTikRQfhAKm-UW+on+ZeEp709z_ku_NDjeVD_US1b@mail.gmail.com>
Date: Thu, 29 Jul 2010 11:53:25 +0300
Message-ID: <AANLkTi=9Top+9kRwtZj-nZw8szQU4ff9CTSNSGuexmEL@mail.gmail.com>
Subject: Re: [PATCH][RFC] Fix SDP resolving segfault
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Manuel Naranjo <manuel@aircable.net>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001636833698082004048c82deb8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--001636833698082004048c82deb8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Manuel,

On Wed, Jul 28, 2010 at 9:46 PM, Manuel Naranjo <manuel@aircable.net> wrote=
:
> Luiz,
>
> Bad news it doesn't work, it keeps doing the same. This is the output
> of bluetoothd -n -d:
> bluetoothd[3572]: audio/manager.c:handle_uuid() server not enabled for
> 0000110a-0000-1000-8000-00805f9b34fb (0x110a)
> bluetoothd[3572]: audio/manager.c:handle_uuid() Found AV Target
> bluetoothd[3572]: audio/control.c:control_init() Registered interface
> org.bluez.Control on path /org/bluez/3572/hci0/dev_00_24_91_E4_E9_05
> bluetoothd[3572]: audio/manager.c:handle_uuid() Found AV Target
> bluetoothd[3572]: src/device.c:btd_device_unref() 0x90f9e08: ref=3D2
> bluetoothd[3572]: src/device.c:btd_device_ref() 0x90f9e08: ref=3D3
> bluetoothd[3572]: src/device.c:search_cb()
> /org/bluez/3572/hci0/dev_00_24_91_E4_E9_05: No service update
> bluetoothd[3572]: src/device.c:btd_device_unref() 0x90f9e08: ref=3D2
> bluetoothd[3572]: src/adapter.c:session_unref() 0x90b2790: ref=3D0
> bluetoothd[3572]: src/adapter.c:session_remove() Discovery session
> 0x90b2790 with :1.81 deactivated
> bluetoothd[3572]: src/adapter.c:session_remove() Stopping discovery
> bluetoothd[3572]: Stopping discovery
> bluetoothd[3572]: src/device.c:btd_device_ref() 0x90adfd0: ref=3D2
> bluetoothd[3572]: Discovery session 0x90fe178 with :1.81 activated
> bluetoothd[3572]: src/adapter.c:session_ref() 0x90fe178: ref=3D1
> bluetoothd[3572]: src/adapter.c:adapter_remove_connection() Removing
> temporary device /org/bluez/3572/hci0/dev_C8_7E_75_DC_1E_86
> bluetoothd[3572]: src/device.c:device_remove() Removing device
> /org/bluez/3572/hci0/dev_C8_7E_75_DC_1E_86
> bluetoothd[3572]: src/device.c:btd_device_unref() 0x90fc080: ref=3D1
> bluetoothd[3572]: src/device.c:btd_device_unref() 0x90fc080: ref=3D0
> bluetoothd[3572]: src/device.c:device_free() 0x90fc080
> bluetoothd[3572]: src/adapter.c:adapter_get_device() 00:05:4F:63:5A:E0
> bluetoothd[3572]: src/adapter.c:session_unref() 0x90fe178: ref=3D0
> bluetoothd[3572]: src/adapter.c:session_remove() Discovery session
> 0x90fe178 with :1.81 deactivated
> bluetoothd[3572]: src/adapter.c:session_remove() Stopping discovery
> bluetoothd[3572]: Stopping discovery
> bluetoothd[3572]: Discovery session 0x90b1e00 with :1.81 activated
> bluetoothd[3572]: src/adapter.c:session_ref() 0x90b1e00: ref=3D1
> bluetoothd[3572]: <27>Jul 28 14:26:36 bluetoothd[3572]: : error
> updating services: Host is down (112)
>
>
> And this is the call trace during the crash:
> =A0 =A0 =A0 =A0+ =A04 0x80ac636 (from 0x80a9a28) =A0 =A0 =A0device_remove=
_connection():
> /home/manuel/bluez/src/device.c:908
> =A0 =A0 =A0 =A0+ =A05 0x80ac4ca (from 0x80ac753) =A0 =A0 =A0 device_set_c=
onnected():
> /home/manuel/bluez/src/device.c:875
> =A0 =A0 =A0 =A0+ =A06 0x80b0d08 (from 0x80ac517) =A0 =A0 =A0 =A0emit_prop=
erty_changed():
> /home/manuel/bluez/src/dbus-common.c:266
> =A0 =A0 =A0 =A0+ =A07 0x80b0a31 (from 0x80b0da4) =A0 =A0 =A0 =A0 append_v=
ariant():
> /home/manuel/bluez/src/dbus-common.c:195
> =A0 =A0 =A0 =A0+ =A07 0x805005d (from 0x80b0db6) =A0 =A0 =A0 =A0 g_dbus_s=
end_message():
> /home/manuel/bluez/gdbus/object.c:615
> =A0 =A0 =A0 =A0+ =A04 0x80ae60e (from 0x80a9a55) =A0 =A0 =A0device_get_ad=
dress():
> /home/manuel/bluez/src/device.c:1654
> =A0 =A0 =A0 =A0+ =A05 0x80aa5a4 (from 0x80ae639) =A0 =A0 =A0 bacpy():
> /home/manuel/bluez/./lib/bluetooth/bluetooth.h:132
> =A0 =A0 =A0 =A0+ =A04 0x808a77f (from 0x80a9a6d) =A0 =A0 =A0hci_req_queue=
_remove():
> /home/manuel/bluez/src/security.c:169
> =A0 =A0 =A0 =A0+ =A04 0x80affea (from 0x80a9a78) =A0 =A0 =A0device_is_aut=
henticating():
> /home/manuel/bluez/src/device.c:2339
> =A0 =A0 =A0 =A0+ =A04 0x80ae749 (from 0x80a9a9a) =A0 =A0 =A0device_is_tem=
porary():
> /home/manuel/bluez/src/device.c:1683
> =A0 =A0 =A0 =A0+ =A01 0x808a82f (from 0x808cdb4) =A0 check_pending_hci_re=
q():
> /home/manuel/bluez/src/security.c:186
> =A0 =A0 =A0 =A0+ =A00 0x8094781 (from 0x2cddab) =A0connect_cb(): /home/ma=
nuel/bluez/src/btio.c:138
> =A0 =A0 =A0 =A0+ =A01 0x8094628 (from 0x80947be) =A0 check_nval():
> /home/manuel/bluez/src/btio.c:103
> =A0 =A0 =A0 =A0+ =A01 0x8097b6e (from 0x8094849) =A0 bt_io_error_quark():
> /home/manuel/bluez/src/btio.c:1296
> =A0 =A0 =A0 =A0+ =A01 0x8099523 (from 0x80948c1) =A0 connect_watch():
> /home/manuel/bluez/src/glib-helper.c:283
> =A0 =A0 =A0 =A0+ =A02 0x80ae1c5 (from 0x809966f) =A0 =A0browse_cb():
> /home/manuel/bluez/src/device.c:1540
> =A0 =A0 =A0 =A0+ =A03 0x80adf2f (from 0x80ae312) =A0 =A0 search_cb():
> /home/manuel/bluez/src/device.c:1476
> =A0 =A0 =A0 =A0+ =A04 0x8089ef6 (from 0x80adf90) =A0 =A0 =A0error(): /hom=
e/manuel/bluez/src/log.c:47
>
>
> If you go through the code it fails in the line:
> static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
> {
> =A0 =A0 =A0 =A0struct browse_req *req =3D user_data;
> =A0 =A0 =A0 =A0struct btd_device *device =3D req->device;
>
> =A0 =A0 =A0 =A0if (err < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error("%s: error updating services: %s (%d=
)",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device->pa=
th, strerror(-err), -err);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto send_reply;
> =A0 =A0 =A0 =A0}
>
>
> It fails because device->path is not valid.
>
> My patch even though than ugly it worked. I know this is not the best
> for upstream, but at least is something to start with. For some reason
> either user_data or device is invalid when that callback gets.

I guess I finally figure out what could be the source of your
problems, we are not removing the watches when caching the session and
since the context is already freed bt_cancel_discovery doesn't work.

The attached patch should fix this problem, Im also reseting the
internal data of the session by doing sdp_set_notify so if we are not
closing the session it will then reset the callback and data to NULL.

--=20
Luiz Augusto von Dentz
Computer Engineer

--001636833698082004048c82deb8
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-core-fix-not-removing-watches-when-caching-sdp-sessi.patch"
Content-Disposition: attachment;
	filename="0001-core-fix-not-removing-watches-when-caching-sdp-sessi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gc7cyrpu0

RnJvbSAyMDQyNDdlN2FkNWRhZDUwZWEyNTE4ODAyMmM3MjVlMzZjYmQ2ZWY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6LXZv
bkBub2tpYS5jb20+CkRhdGU6IFRodSwgMjkgSnVsIDIwMTAgMTE6Mjg6MTggKzAzMDAKU3ViamVj
dDogW1BBVENIXSBjb3JlOiBmaXggbm90IHJlbW92aW5nIHdhdGNoZXMgd2hlbiBjYWNoaW5nIHNk
cCBzZXNzaW9uCgotLS0KIHNyYy9nbGliLWhlbHBlci5jIHwgICAxOSArKysrKysrKysrLS0tLS0t
LS0tCiAxIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvc3JjL2dsaWItaGVscGVyLmMgYi9zcmMvZ2xpYi1oZWxwZXIuYwppbmRleCA0
MWY1ZTNjLi5lNzVlMjcwIDEwMDY0NAotLS0gYS9zcmMvZ2xpYi1oZWxwZXIuYworKysgYi9zcmMv
Z2xpYi1oZWxwZXIuYwpAQCAtMTU2LDYgKzE1NiwxMiBAQCBzdGF0aWMgdm9pZCBzZWFyY2hfY29u
dGV4dF9jbGVhbnVwKHN0cnVjdCBzZWFyY2hfY29udGV4dCAqY3R4dCkKIHsKIAljb250ZXh0X2xp
c3QgPSBnX3NsaXN0X3JlbW92ZShjb250ZXh0X2xpc3QsIGN0eHQpOwogCisJaWYgKGN0eHQtPmlv
X2lkKQorCQlnX3NvdXJjZV9yZW1vdmUoY3R4dC0+aW9faWQpOworCisJaWYgKGN0eHQtPnNlc3Np
b24pCisJCXNkcF9jbG9zZShjdHh0LT5zZXNzaW9uKTsKKwogCWlmIChjdHh0LT5kZXN0cm95KQog
CQljdHh0LT5kZXN0cm95KGN0eHQtPnVzZXJfZGF0YSk7CiAKQEAgLTIwNCw3ICsyMTAsMTAgQEAg
c3RhdGljIHZvaWQgc2VhcmNoX2NvbXBsZXRlZF9jYih1aW50OF90IHR5cGUsIHVpbnQxNl90IHN0
YXR1cywKIAl9IHdoaWxlIChzY2FubmVkIDwgKHNzaXplX3QpIHNpemUgJiYgYnl0ZXNsZWZ0ID4g
MCk7CiAKIGRvbmU6Ci0JY2FjaGVfc2RwX3Nlc3Npb24oJmN0eHQtPnNyYywgJmN0eHQtPmRzdCwg
Y3R4dC0+c2Vzc2lvbik7CisJaWYgKHNkcF9zZXRfbm90aWZ5KGN0eHQtPnNlc3Npb24sIE5VTEws
IE5VTEwpID09IDApIHsKKwkJY2FjaGVfc2RwX3Nlc3Npb24oJmN0eHQtPnNyYywgJmN0eHQtPmRz
dCwgY3R4dC0+c2Vzc2lvbik7CisJCWN0eHQtPnNlc3Npb24gPSBOVUxMOworCX0KIAogCWlmIChj
dHh0LT5jYikKIAkJY3R4dC0+Y2IocmVjcywgZXJyLCBjdHh0LT51c2VyX2RhdGEpOwpAQCAtMzkx
LDE0ICs0MDAsNiBAQCBpbnQgYnRfY2FuY2VsX2Rpc2NvdmVyeShjb25zdCBiZGFkZHJfdCAqc3Jj
LCBjb25zdCBiZGFkZHJfdCAqZHN0KQogCQlyZXR1cm4gLUVOT0RBVEE7CiAKIAljdHh0ID0gbWF0
Y2gtPmRhdGE7Ci0JaWYgKCFjdHh0LT5zZXNzaW9uKQotCQlyZXR1cm4gLUVOT1RDT05OOwotCi0J
aWYgKGN0eHQtPmlvX2lkKQotCQlnX3NvdXJjZV9yZW1vdmUoY3R4dC0+aW9faWQpOwotCi0JaWYg
KGN0eHQtPnNlc3Npb24pCi0JCXNkcF9jbG9zZShjdHh0LT5zZXNzaW9uKTsKIAogCXNlYXJjaF9j
b250ZXh0X2NsZWFudXAoY3R4dCk7CiAJcmV0dXJuIDA7Ci0tIAoxLjcuMC40Cgo=
--001636833698082004048c82deb8--
