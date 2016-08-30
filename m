Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Northfield Stuart <stu@metanate.com>
Content-Type: multipart/signed; boundary="Apple-Mail=_AB957ADE-2E35-4081-A10A-F7368F488FAD"; protocol="application/pkcs7-signature"; micalg=sha1
Subject: Two second pending connection timeout prevents connection to devices with long advertising interval
Date: Tue, 30 Aug 2016 13:13:42 +0100
Message-Id: <B0B1991C-FD3E-4E08-9641-DE745A6EC690@metanate.com>
Cc: johan.hedberg@intel.com
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_AB957ADE-2E35-4081-A10A-F7368F488FAD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

We are currently working with a BLE device which (for power consumption =
reasons) uses an unusually large advertisement period of ten seconds =
(unusual, but allowed within the BLE specification). We don=E2=80=99t =
have the option of reducing the advertising interval for this product.

This works with older kernels (e.g. 4.2.6 in RH F23), but on later =
kernels it appears that the kernel times out the connection attempt =
after only two seconds.

I believe I have tracked down the change responsible to a patch from =
Johan Hedberg <johan.hedberg@intel.com> on 2014-07-06, which appears to =
split the BLE connection timeout in to two variants, HCI_LE_CONN_TIMEOUT =
which remains at 20 seconds, and the newly added one, =
HCI_LE_AUTOCONN_TIMEOUT, which has been reduced down to two seconds.=20

I understand, from other threads touching on this subject (see links =
below - I am at least not the only person to have hit this problem) that =
this 2s timeout is chosen to avoid blocking other connections, and agree =
that the average user probably doesn=E2=80=99t need to be able to handle =
such slow devices. However, is there any reason why this timeout is =
hardcoded in the source rather than a tuneable parameter, which would at =
least allow those of us who do need to interact with such devices to be =
able to configure the linux bluetooth stack suitably.

Personally, I would regard a change which prevents interoperability with =
a conformant device as a regression, but I can see why it was done, and =
why it isn=E2=80=99t an issue for the vast majority of users and =
devices.

This is my third attempt to raise this issue on the list - I would =
appreciate if someone could please explain what more I need to do to =
actually get a response (or even some progress) on this issue?

Thread discussing identical issue with slow advertising device (no =
apparent solution though):

<http://marc.info/?l=3Dlinux-bluetooth&m=3D146361213623520&w=3D2>

Thread referenced from above which states why the 2s timeout is expected =
behaviour:

<http://marc.info/?l=3Dlinux-bluetooth&m=3D144830298701744&w=3D2>

Regards

Stu


--Apple-Mail=_AB957ADE-2E35-4081-A10A-F7368F488FAD
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

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
--Apple-Mail=_AB957ADE-2E35-4081-A10A-F7368F488FAD--
