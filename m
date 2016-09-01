Return-Path: <stu@metanate.com>
Content-Type: multipart/signed; boundary="Apple-Mail=_3FF797C0-EC6B-4F12-AB3A-E62D9A46E2F3"; protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Two second pending connection timeout prevents connection to devices with long advertising interval
From: Northfield Stuart <stu@metanate.com>
In-Reply-To: <2A4D0751-61E7-430F-BEE5-9254A6D8E7CC@holtmann.org>
Date: Thu, 1 Sep 2016 10:41:50 +0100
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Johan Hedberg <johan.hedberg@intel.com>
Message-Id: <29147022-D6EA-4FEA-866C-4F296879FEBC@metanate.com>
References: <B0B1991C-FD3E-4E08-9641-DE745A6EC690@metanate.com> <9942937A-4799-4AA2-9551-8FEBF110550B@holtmann.org> <D938EDFC-0164-4B3D-86C6-DAC2FE269367@metanate.com> <2A4D0751-61E7-430F-BEE5-9254A6D8E7CC@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_3FF797C0-EC6B-4F12-AB3A-E62D9A46E2F3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Marcel,

> The problem here is that we have to make this fly without harming any =
other user of the system. One peripheral should not block all the rest. =
And the problem here is really the re-connection time of for example a =
HID device where low-latency is what counts.

Understood.

> One solution would be to keep the long timeout with =
HCI_LE_Create_Connection if we have controllers that allow us to keep =
scanning. Meaning a combination of Passive Scanning State and Initiating =
State. This is something we need to find out with trial and error and =
see if it can be done.
>=20
> As a background here. Currently we stop scanning when we see a device =
we need to connect to, then connect to it. And if there are other =
devices on the "to be connected" list, we enable scanning after =
successful or failure of the connection attempt.

Presumably this is per controller rather than global across controllers? =
One thing I forgot to mention is that some of our infrastructure code is =
capable of using multiple BLE controllers and (I guess due to the above) =
we usually keep one controller scanning while using the other(s) for =
connections. (NB I personally didn=E2=80=99t write any of this linux =
application code - I was merely tasked with investigating the 2s =
connection attempt termination issue.)

> Essentially you want to change this into this:
>=20
> a) Found device we want to connect to
> b) If more devices are on the auto-connect list, keep scanning, other =
disable scanning
> c) Send connect request and wait for its completion
> d) For the first 2 seconds that connect attempt is exclusive
> e) After that cancel it if we see another auto-connect device and try =
that device
> f) Start over
>=20
> Similar things then apply to when to re-enable scanning after =
connection termination, but I doubt that will actually have to change.
>=20
> What this means in simple term, only disable background scanning when =
the auto-connect list empty. Otherwise keep it active and let the =
controller deal with the two instances of state machines by itself.
>=20
> Now we need to check if that would work or not. We have quirks like =
HCI_QUIRK_SIMULTANEOUS_DISCOVERY and this might need another one. Not =
sure if we want to go with blacklist or whitelist here. I would do =
blacklist and actually check the supported states. Since this is LE =
only, the controller should not lie to us.
>=20
> If you want to work on this, then try this simple approach:
>=20
> a) Read the supported states and extract support for passive scanning =
+ initiating
> a) Use a long timeout
> b) Only disable scanning when no other device is left on auto-connect =
list
>=20
> If this basically works, then the only other thing we have to do is be =
smart about concurrent connection. Meaning that a long running one can =
be cancelled and replaced with something we see in the 2-x second =
window. As I said above, the 0-2 second window should be exclusive to =
the first attempt. We can tune these values, it is just the 20 second =
one is killing low-latency reconnect by HID device.
>=20
> However there is one case to be made that we might only consider =
direct advertising to be able to interrupt it. Which would satisfy the =
HID requirement with low-latency. The advantage here is that they are =
high duty cycle and would show up right away. So you are not really =
losing out on your slow-connection attempt.
>=20
> But this idea really stands and falls with the passive scanning + =
initiating state support in the controller.

OK - I=E2=80=99ll investigate the controllers we have (we are using at =
least two different chipsets I believe, possibly three) and then have a =
go at this simple test - probably won=E2=80=99t be before next week at =
the moment (trying to get a new release candidate out at the moment) and =
it might take me a day or two to re-familiarise myself and get to grips =
with the code :)

Many thanks for your assistance and input so far.

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







--Apple-Mail=_3FF797C0-EC6B-4F12-AB3A-E62D9A46E2F3
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

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
--Apple-Mail=_3FF797C0-EC6B-4F12-AB3A-E62D9A46E2F3--
