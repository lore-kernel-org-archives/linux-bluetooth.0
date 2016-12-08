Return-Path: <stu@metanate.com>
Content-Type: multipart/signed; boundary="Apple-Mail=_9366F302-5647-4F4D-855D-892D18A2A6CC"; protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC 0/3] core/adapter: Add disabling duplicate device filtering from d-bus
From: Northfield Stuart <stu@metanate.com>
In-Reply-To: <0551C6BD-7C6C-4929-AC5A-79A9ADB5176C@holtmann.org>
Date: Thu, 8 Dec 2016 12:29:18 +0000
Cc: Don Zickus <dzickus@redhat.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 Brennan Ashton <brn@deako.com>
Message-Id: <DB5F4EC2-F527-46C0-BC39-0FD2EE2BB8C1@metanate.com>
References: <1481060400-7088-1-git-send-email-dzickus@redhat.com> <CABBYNZLdm5TsxZeCzS0S_7Xf0sfqYPNy8YrOMTpOsL3pNUO0jA@mail.gmail.com> <20161207201642.GF35881@redhat.com> <0551C6BD-7C6C-4929-AC5A-79A9ADB5176C@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_9366F302-5647-4F4D-855D-892D18A2A6CC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 8 Dec 2016, at 06:18, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Don,
>=20
>>>> Recent discussions on the bluez mailing list revealed it was not =
easy
>>>> to disable duplicate device filtering from the d-bus interface.
>>>>=20
>>>> As a result, if I wanted to monitor LE devices entering and leaving =
the
>>>> adapters range (using RSSI data), it was difficult.
>>>>=20
>>>> This patchset is a dirty hack to make this work. The first patch =
enables
>>>> it on the kernel side, while the other two patches enable it from =
the bluez
>>>> side.
>>>>=20
>>>> I understand there are concerns about flooding the d-bus interface =
when
>>>> enabling this.  I tried to write a throttling mechanism using the =
mainloop
>>>> as my timer, but soon realized you can only have 1 device RSSI =
event
>>>> per loop, so that wasn't going to work.  Open to suggestions if =
still a
>>>> concern.
>>>>=20
>>>> Posted as an RFC just to generate discussion.  I expect I missed a =
lot of
>>>> little details here, but wanted to post my proof of concept to see =
if this
>>>> is something to work with.
>>>>=20
>>>> This patchset includes both the kernel and bluez patches.  I =
understand this is
>>>> not recommended for normal practice.  But I thought for an RFC, it =
is nice to
>>>> keep things together for now.
>>>=20
>>> I would avoid adding a new MGMT command and instead disabled
>>> duplicated filtering if RSSI filtering is set since anyway RSSI
>>> filtering needs to disable duplicates in order to do any RSSI
>>> filtering reliable. So this would mean that if the user wants to see
>>> to get duplicate filtering it needs to set a RSSI which should rate
>>> limit as we would use a threshold.
>>=20
>> Hi Luiz,
>>=20
>> Ok, fair enough.  I then simplified it down to a small kernel patch =
that
>> seems to work if I set an RSSI threshold with SetDiscoveryFilter.
>>=20
>> I only do this on an active_scan.  Not sure if I should do it for the
>> passive scans too?
>>=20
>> If this looks ok, I will resubmit properly.
>=20
> I am not sure this is the best idea. So right now the kernel restarts =
scanning to get new RSSI values when we have a quirk set that strict =
scan filtering is performed by the controller (strict means address =
only).
>=20
> That is for discovery. Something started by the user and something =
that does not last over long times. Discovery is using active scanning =
which takes way more TX/RX time on air than passive scanning. It is also =
known to be causing more problems then it solves when run constantly. =
The reason is that it will interrupt CONNECT_REQ since SCAN_REQ are more =
likely to win based on their shorter packet size.
>=20
> So the main question is if you are after a certain set of devices =
(based on their address) and want to monitor their RSSI or are you after =
any device and want to match based on advertising data?
>=20
> The first one could be dealt with by using the whitelist, the second =
one is nasty from a power consumption point of view. Any long term =
operation there would be causing major headaches.
>=20
> Keep in mind that besides the kernel waking up (and USB transport), =
you also end up waking userspace all the time to process the information =
and send out over D-Bus. Which means you might going to wakeup even more =
processes.

Can I just leap in here, as this is extremely relevant to the project I =
am working on. Sometimes you need to step back from what the =E2=80=98aver=
age user=E2=80=99 needs, and consider whether should allow certain =
behaviours to be enabled, even if they are not the default. What is =
=E2=80=98nasty=E2=80=99 to you in the big picture, is perfectly normal =
for me in a dedicated use case.

Our application transfers data between devices (and there could be well =
over a thousand within range at a single time) and the central system =
using purely the MSD in the advertisements. Our linux =E2=80=98gateway=E2=80=
=99 boxes need to have continuous reception of advertisements, and we =
don=E2=80=99t care about the power consumption or processing =
implications - that is their dedicated job. We are currently unable to =
migrate our code from some older gatttool derived code to the modern =
APIs because it simply isn=E2=80=99t possible to work in the manner we =
need. (Note that our gateways use multiple BLE dongles, with at least =
one dedicated to receiving beacons while the others are used to connect =
to devices for archived data retrieval.)

Please give some consideration to the fact that not everybody is using =
bluetooth for simple end-user devices, and whilst these are clearly the =
dominant use case, being able to engage esoteric modes of operation =
allows those of us who need to to consciously engage them as necessary =
for bespoke scenarios/applications. BLE is not just a desktop/peripheral =
technology :)

Hope you don=E2=80=99t mind the interjection=E2=80=A6

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







--Apple-Mail=_9366F302-5647-4F4D-855D-892D18A2A6CC
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

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
--Apple-Mail=_9366F302-5647-4F4D-855D-892D18A2A6CC--
