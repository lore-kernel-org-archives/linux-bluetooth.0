Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 4/5] HID: autoload hid-multitouch as needed
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
In-Reply-To: <alpine.LNX.2.00.1203131710120.18356@pobox.suse.cz>
Date: Tue, 13 Mar 2012 19:14:56 +0100
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Henrik Rydberg <rydberg@euromail.se>,
 "benjamin.tissoires" <benjamin.tissoires@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Gustavo F. Padovan" <padovan@profusion.mobi>,
 linux-bluetooth@vger.kernel.org
Message-Id: <620FFED4-6D6D-4F70-8674-D054C5E3B38A@enac.fr>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com> <1331053026-21272-5-git-send-email-benjamin.tissoires@gmail.com>     <alpine.LNX.2.00.1203072234550.29034@pobox.suse.cz>    <20120308105737.GA11201@polaris.bitmath.org>    <6E17845C-6F9F-4CB6-AA5D-DEEDCD2089E8@enac.fr>    <alpine.LNX.2.00.1203121650500.18356@pobox.suse.cz>   <1331574151.14217.86.camel@aeonflux>   <4B25AD62-B1C9-4C57-AE64-34EB7F47DC9B@enac.fr>  <alpine.LNX.2.00.1203122316420.18356@pobox.suse.cz>  <0EB7B0B6-EE4F-4E42-A1E6-0414D39AEAE6@enac.fr> <alpine.LNX.2.00.1203131710120.18356@pobox.suse.cz>
To: Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-bluetooth.vger.kernel.org>


Le 13 mars 2012 =E0 17:13, Jiri Kosina wrote:

> On Tue, 13 Mar 2012, St=E9phane Chatty wrote:
>>=20
>> Very useful clarification, thanks. Now, I guess I understand why =
Marcel=20
>> wants to keep hidp in bluetooth/. And, to be honest, things would =
have=20
>> been clearer to me when I explored the handling of the USB/HID class =
if=20
>> I had found a hid (or usbhid) directory in usb/ rather than a usbhid=20=

>> subdirectory in hid/: it did not make the above situation very =
obvious=20
>> to me. Don't you think we could go along with Marcel and move usbhid =
to=20
>> usb/?
>=20
> It seemed to be convenient back then, and it's still convenient for me =
in=20
> some sense, as I am maintaining both HID core and USB HID, but =
bluetooth=20
> guys are maintaining the bluetooth transport.
>=20
> But I don't have strong opinion either way, I can as well move usbhid =
to=20
> drivers/usb and maintain it there (will need to talk to Greg about it=20=

> first of course). But frankly, I don't see it making things magically=20=

> clear for everyone :)


I agree it's neither very important nor a magic bullet. But this =
confused at least one person (me) when exploring the code for the first =
time :-)

St.
