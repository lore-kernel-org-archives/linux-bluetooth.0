Return-Path: <stu@metanate.com>
Content-Type: multipart/signed; boundary="Apple-Mail=_6C19EBCA-9582-409B-ABCB-E55B1020C82C"; protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: Two second pending connection timeout prevents connection to devices with long advertising interval
From: Northfield Stuart <stu@metanate.com>
In-Reply-To: <9942937A-4799-4AA2-9551-8FEBF110550B@holtmann.org>
Date: Wed, 31 Aug 2016 16:08:16 +0100
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Johan Hedberg <johan.hedberg@intel.com>
Message-Id: <D938EDFC-0164-4B3D-86C6-DAC2FE269367@metanate.com>
References: <B0B1991C-FD3E-4E08-9641-DE745A6EC690@metanate.com> <9942937A-4799-4AA2-9551-8FEBF110550B@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_6C19EBCA-9582-409B-ABCB-E55B1020C82C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Marcel,

Thank you for your reply.

> the problem is that in order to send a CONNNECT_REQ, the =
HCI_LE_Create_Connection command needs to see connectable advertising =
packet one more time. So the longer time you give to =
HCI_LE_Create_Connection to find it, the longer everything else in the =
system is blocked. Since only one HCI_LE_Create_Connection can be =
running at the same time.

We understand that, but for reasons which I=E2=80=99ll explain below, I =
suspect our only realistic option is a method of controlling this from =
our applications, not by modifying system behaviour automatically based =
on the device.

> Now if the peripheral in question would actually include =
=E2=80=8B=C2=ABAdvertising Interval=C2=BB AD type in its advertising, =
then we could automatically adjust the scan window/interval and timeout =
when connection to such a device. Can you run a btmon trace and show the =
advertising data you are getting.

It=E2=80=99s a nice idea, but I can tell you now that the advertisement =
data from the device consists of purely the flags and manufacturer =
specific data fields filling the entire advertisement frame. There is no =
remaining space in the advertisement frame to add the advertising =
interval field! I can=E2=80=99t omit the flags field because the device =
is BLE only, thus some flag bits must be set.

This product is pushing at the boundaries of what is achievable. Without =
disclosing the exact nature of the product, it is a portable device =
equipped with screen, environmental sensors (temperature, =
accelerometers, etc), GPS, cellular modem, UHF transceiver and BLE (the =
Nordic BLE device acts as the system main processor as well). The =
requirement is for a (non-rechargeable, non-replaceable) battery life of =
15 years (on average), potentially out in remote field locations for =
long periods of time. Naturally, physical battery space is limited too. =
It is an extremely challenging project, and the onerous battery life =
requirements have forced us to squeeze every last bit of data in to the =
adverts to minimise the requirements for connections. It was rather an =
unpleasant surprise to discover that moving development of the =
infrastructure tools forward to a later distribution/kernel stopped them =
working completely!

I=E2=80=99m sure you can appreciate that while I agree your suggestion =
is almost certainly the =E2=80=98proper=E2=80=99 solution to this issue, =
almost any solution which requires modifying the device behaviour has a =
severe impact on the power budget. For example, I could put the =
advertising interval field in a scan response, but enabling scan =
responses guarantees more time spent transmitting and a corresponding =
reduction in battery life.

Unfortunately, we will not be in a position to build bespoke patched =
kernel images for every linux platform expected to interact with these =
devices (some, yes, but I believe the COTS linux tablets will be out of =
our control), so we were really looking for a solution which would allow =
use of a modern distribution/kernel but still allow interoperability =
with a device such as ours by configuring or tuning the central =
behaviour from our bespoke applications.

At the moment the linux platforms in use on product trials are still =
running an early enough kernel that the issue is not affecting the =
trials, but it would be unrealistic to expect this to remain the case =
going forwards.

Any other suggestions?=20

It=E2=80=99s a while since I worked on Linux kernel level stuff (I=E2=80=99=
m mostly embedded/OS X/iOS at the moment), but if it would be considered =
for inclusion then I=E2=80=99m prepared to put the effort in to a patch =
to provide some form of tunability around the timeouts (suggestions and =
guidance on preferred mechanisms welcome). We are in an environment =
where all the devices are =E2=80=98slow=E2=80=99 and we both understand =
and accept the implications of such a stack reconfiguration.

If it=E2=80=99s likely to be rejected out of hand, then that makes life =
considerably more tedious and we will have to have a serious re-think on =
how we move forward :(

Regards

Stu

--
Stuart Northfield
+44 (0) 1223 566728 (Direct), +44 (0) 1223 566727 (Fax)
Metanate Limited. Registered in England No 4046086 at:
Lincoln House, Station Court, Great Shelford, Cambridge CB22 5NE, UK
www.metanate.com (Consultancy) www.schemus.com (Data synchronisation)

This e-mail and all attachments it may contain is confidential and
intended solely for the use of the individual to whom it is addressed.
Any views or opinions presented are those of the author and do not
necessarily represent those of Metanate Ltd.  If you are not the
intended recipient, be advised that you have received this e-mail in
error and that any use, dissemination, printing, forwarding or copying
of this e-mail is strictly prohibited.  Please contact the sender if
you have received this e-mail in error.







--Apple-Mail=_6C19EBCA-9582-409B-ABCB-E55B1020C82C
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

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
--Apple-Mail=_6C19EBCA-9582-409B-ABCB-E55B1020C82C--
