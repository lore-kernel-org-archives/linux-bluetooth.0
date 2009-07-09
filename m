Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35c90d960907061155t7349cc90p2e58a09a310b8926@mail.gmail.com>
References: <35c90d960905191820g4e3ee434hfd0060815540a4e0@mail.gmail.com>
	<1242787757.3147.13.camel@localhost.localdomain> <35c90d960905201457i508c678fqeb696cce32ae63be@mail.gmail.com>
	<35c90d960907061155t7349cc90p2e58a09a310b8926@mail.gmail.com>
From: Nick Pelly <npelly@google.com>
Date: Thu, 9 Jul 2009 12:37:49 -0700
Message-ID: <35c90d960907091237o72228b0v57ad2556d77f4857@mail.gmail.com>
Subject: Re: bug? kernel does not send HCI Create Connection Cancel Command on
	shutdown() or close() of a connecting rfcomm socket
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=001636427084d87b6a046e4afe5a
List-ID: <linux-bluetooth.vger.kernel.org>

--001636427084d87b6a046e4afe5a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

For the RFCOMM issue.

This is the log when shutdown() is called on the rfcomm socket while
the ACL link is connecting:

[=A0 132.856414] rfcomm:rfcomm_sock_shutdown: sock c5cb3a20, sk c63fca00
[=A0 132.856933] rfcomm:__rfcomm_sock_close: sk c63fca00 state 5 socket c5c=
b3a20
[=A0 132.857788] rfcomm:__rfcomm_dlc_close: dlc c61ea240 state 7 dlci 38
err 0 session c63d4ba0
[=A0 132.858612] rfcomm:rfcomm_send_disc: c63d4ba0 dlci 38
[=A0 132.859069] rfcomm:rfcomm_send_frame: session c63d4ba0 len 4
[=A0 132.859893] l2cap:l2cap_sock_sendmsg: sock c5cb38c0, sk c63fc800
[=A0 132.860351] rfcomm:rfcomm_dlc_set_timer: dlc c61ea240 state 8 timeout =
2000
[  133.863739] rfcomm:rfcomm_sock_release: sock c5cb3a20, sk c63fca00
[  133.864257] rfcomm:rfcomm_sock_shutdown: sock c5cb3a20, sk c63fca00
[  133.865081] rfcomm:rfcomm_sock_kill: sk c63fca00 state 5 refcnt 2
[  133.865539] rfcomm:rfcomm_sock_destruct: sk c63fca00 dlc c61ea240



I'm surprised to see d->state for the rfcomm_dlc is BT_CONFIG at
__rfcomm_dlc_close(), but looking at __rfcomm_dlc_open() this appears
to be intentional.

We do not hit __l2cap_sock_close()

We attempt a graceful rfcomm disconnected by sending the dlci
disconnected frame - but this does not make sense - since there is no
rfcomm connection yet.


Assuming that d->state =3D=3D BT_CONFIG during this phase is correct, then
the attached patch will fix this issue.

However - I don't know the rfcomm state machine - so this patch may
having side effects. Requesting comments.

Nick

--001636427084d87b6a046e4afe5a
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Bluetooth-Do-not-attempt-to-send-dlci-disconnect-whe.patch"
Content-Disposition: attachment;
	filename="0001-Bluetooth-Do-not-attempt-to-send-dlci-disconnect-whe.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwxveqc20

RnJvbSBkOTBhMGNkN2EwMjE5ODA4ZTgxODNlYjc0Zjc2YTYxZDA0M2FiNGMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWNrIFBlbGx5IDxucGVsbHlAZ29vZ2xlLmNvbT4KRGF0ZTog
VGh1LCA5IEp1bCAyMDA5IDEyOjIzOjQ0IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gQmx1ZXRvb3Ro
OiBEbyBub3QgYXR0ZW1wdCB0byBzZW5kIGRsY2kgZGlzY29ubmVjdCB3aGVuIGluIEJUX0NPTkZJ
Ry4KClRoaXMgZml4ZXMgYSBidWcgd2hlcmUgc2h1dGRvd24oKSBhbmQgY2xvc2UoKSBvbiBhIHJm
Y29tbSBzb2NrZXQgZHVyaW5nIEFDTApjb25uZWN0aW9uIHdvdWxkIG5vdCBjYXVzZSBIQ0kgQ3Jl
YXRlIENvbm5lY3Rpb24gQ2FuY2VsLgoKU2lnbmVkLW9mZi1ieTogTmljayBQZWxseSA8bnBlbGx5
QGdvb2dsZS5jb20+Ci0tLQogbmV0L2JsdWV0b290aC9yZmNvbW0vY29yZS5jIHwgICAgMSAtCiAx
IGZpbGVzIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9uZXQvYmx1ZXRvb3RoL3JmY29tbS9jb3JlLmMgYi9uZXQvYmx1ZXRvb3RoL3JmY29tbS9j
b3JlLmMKaW5kZXggMWQwZmIwZi4uYzEwOWEzYSAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9y
ZmNvbW0vY29yZS5jCisrKyBiL25ldC9ibHVldG9vdGgvcmZjb21tL2NvcmUuYwpAQCAtNDI4LDcg
KzQyOCw2IEBAIHN0YXRpYyBpbnQgX19yZmNvbW1fZGxjX2Nsb3NlKHN0cnVjdCByZmNvbW1fZGxj
ICpkLCBpbnQgZXJyKQogCiAJc3dpdGNoIChkLT5zdGF0ZSkgewogCWNhc2UgQlRfQ09OTkVDVDoK
LQljYXNlIEJUX0NPTkZJRzoKIAkJaWYgKHRlc3RfYW5kX2NsZWFyX2JpdChSRkNPTU1fREVGRVJf
U0VUVVAsICZkLT5mbGFncykpIHsKIAkJCXNldF9iaXQoUkZDT01NX0FVVEhfUkVKRUNULCAmZC0+
ZmxhZ3MpOwogCQkJcmZjb21tX3NjaGVkdWxlKFJGQ09NTV9TQ0hFRF9BVVRIKTsKLS0gCjEuNi4z
LjEKCg==
--001636427084d87b6a046e4afe5a--
