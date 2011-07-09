Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Gottfried Haider <gottfried.haider@gmail.com>
Date: Sat, 9 Jul 2011 18:38:51 +0200
Message-ID: <CAPoCmYLDnpi-=zdfPiTUad_AuYRcOtasapFSp-uSF_E8oy4Cew@mail.gmail.com>
Subject: PS3 Sixaxis status (input/sixaxis.c)
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net, marcel@holtmann.org
Content-Type: multipart/mixed; boundary=002215b02ed6f7a18e04a7a59623
List-ID: <linux-bluetooth.vger.kernel.org>

--002215b02ed6f7a18e04a7a59623
Content-Type: text/plain; charset=ISO-8859-1

Hello all,

can anyone share some light on the current situation regarding Sixaxis
support on Linux? What is the recommended way of doing things?

I had high expectations when I found sixaxis.c in the bluez git tree -
but even after getting it to compile against the bluez version (4.91)
that comes with my xubuntu version, it still does not seem to work:
Setting the bluetooth master works nicely, and running "--store-info"
does seem to at least change the files trust, sdp, profiles and did
inside my /var/lib/bluetooth. But when I then press the PS button on
the controller, I see an active connection in Blueman, the controller
appears in the list of devices (this time with the trusted flag, but
not as paired), but disappears again after some seconds and comes back
with the trusted flag missing. If, in the mean time, I select to
connect to the "Input service" via the context menu, I receive a
"Connection refused (111)" error message. Similarly, if I choose to
pair the device via the context menu I am prompted with a dialog to
enter a PIN (but no joy when entering 1234 or similar).

Any suggestions? (or command line fun I am missing?)

I am attaching my hack'ish patch against the git input/sixaxis.c -
only compile-tested this against version 4.91, but some parts are
probably valid for upstream as well.

regards,
gohai

PS: Please CC me as I am not subscribed to the list.

--002215b02ed6f7a18e04a7a59623
Content-Type: text/x-patch; charset=US-ASCII; name="sixpair-bluez-4.91.patch"
Content-Disposition: attachment; filename="sixpair-bluez-4.91.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpwst78w0

LS0tIHNpeHBhaXIuYy5vcmlnCTIwMTEtMDctMDkgMTc6NDA6MzguMzk4NDUxNzY3ICswMjAwCisr
KyBzaXhwYWlyLmMJMjAxMS0wNy0wOSAxNzo0OToxMS4zNTg0Mzg0ODMgKzAyMDAKQEAgLTEsNSAr
MSw1IEBACiAvKiBUbyBjb21waWxlCi0gKiBnY2MgLWcgLVdhbGwgLUkuLi9zcmMgLUkuLi9saWIv
IC1JLi4vaW5jbHVkZSAtRFNUT1JBR0VESVI9XCIvdmFyL2xpYi9ibHVldG9vdGhcIiAtbyBzaXhw
YWlyIHNpeHBhaXIuYyAuLi9zcmMvc3RvcmFnZS5jIC4uL2NvbW1vbi9saWJoZWxwZXIuYSAtSS4u
L2NvbW1vbiBgcGtnLWNvbmZpZyAtLWxpYnMgLS1jZmxhZ3MgZ2xpYi0yLjAgbGlidXNiLTEuMGAg
LWxibHVldG9vdGgKKyAqIGdjYyAtZyAtV2FsbCAtSS4uL3NyYyAtSS4uL2xpYiAtSS4uL2J0aW8g
LURTVE9SQUdFRElSPVwiL3Zhci9saWIvYmx1ZXRvb3RoXCIgLW8gc2l4cGFpciBzaXhwYWlyLmMg
Li4vc3JjL3N0b3JhZ2UuYyAuLi9zcmMvdGV4dGZpbGUuYyAuLi9zcmMvZ2xpYi1oZWxwZXIuYyAt
SS4uL2NvbW1vbiBgcGtnLWNvbmZpZyAtLWxpYnMgLS1jZmxhZ3MgZ2xpYi0yLjAgbGlidXNiLTEu
MCBkYnVzLTFgIC1sYmx1ZXRvb3RoCiAgKi8KIAogI2luY2x1ZGUgPHVuaXN0ZC5oPgpAQCAtMTIs
NiArMTIsOCBAQAogI2luY2x1ZGUgPGdsaWIuaD4KICNpbmNsdWRlIDxsaWJ1c2IuaD4KIAorI2lu
Y2x1ZGUgPGRidXMvZGJ1cy5oPgorI2luY2x1ZGUgPGRldmljZS5oPgogI2luY2x1ZGUgInN0b3Jh
Z2UuaCIKIAogLyogVmVuZG9yIGFuZCBwcm9kdWN0IElEIGZvciB0aGUgU2l4YXhpcyBQUzMgY29u
dHJvbGxlciAqLwo=
--002215b02ed6f7a18e04a7a59623--
