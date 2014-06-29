Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5A1EE16D-11BB-414E-B572-92FBF305B4E5@holtmann.org>
References: <CABx3TkUE_qFJggDNw8wUCcQzrdo6L5p3Ag3djpiUewwk_uJu5Q@mail.gmail.com>
	<CABBYNZLhONv81vAN8OAFX1dK5UCm44AYb2sZLyUp2gRQ4CywcA@mail.gmail.com>
	<CABx3TkVgs6J1UR8Z5Rbyd2e90p74RfggpzsvnxzgWGgN9c2Epg@mail.gmail.com>
	<CABx3TkUbD+svVpNW+0vjWS3pujZsECTOO0XxJmUQY6wOEkkZQw@mail.gmail.com>
	<CABBYNZKyd_jgSO-NpzbMhVo=Y1ZzWC29bX4q1YBQd73Mm4HWaQ@mail.gmail.com>
	<CABx3TkW-PhVeD2=Nr2pj5iL2uUm8T0B+w+WFB2EwaeW7OtChtQ@mail.gmail.com>
	<CABBYNZK2v-US-kOh6v28EKnqsLyjXrDUGpNJE6Wcfqv3YBwm9A@mail.gmail.com>
	<CABx3TkU+JvmekRYBS1iYuriJaprMznH=g6vw2MVYi+2Vqc7Y5w@mail.gmail.com>
	<CABx3TkXsRXUNG4RudXnYifyN4Tq4MssVGXZE6uQtPtxU34bw7A@mail.gmail.com>
	<20140629051442.GA31085@t440s.P-661HNU-F1>
	<20140629052949.GA32130@t440s>
	<E8C350F2-6B3C-4ECD-A281-DDC25C339489@holtmann.org>
	<CABx3TkUP3Y9nJJk=u2ghFnunQRh9x-v6PG_ncyiM+mUqaoRtWg@mail.gmail.com>
	<5A1EE16D-11BB-414E-B572-92FBF305B4E5@holtmann.org>
Date: Sun, 29 Jun 2014 12:01:49 -0700
Message-ID: <CABx3TkVt3t_dyRmY6rjrwzw9BoTRaZinHOQEEbyVND+_NjLSVQ@mail.gmail.com>
Subject: Re: LE mouse reconnect problem
From: Ryan Press <ryan@presslab.us>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 29, 2014 at 10:52 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Ryan,
>
>> I have one other question with it.  When it first reconnects the mouse
>> pointer is really jerky, like it's updating really slow.  Then after a
>> few seconds it is normal; in fact it is very responsive compared to my
>> old Bluetooth mouse.  With Windows 8.1 it reconnects lightning fast
>> when I turn it on, and it is not jerky at first.
>>
> this is a kernel issue with not remembering the previous connection param=
eters. What you see is that we start connecting with the default values and=
 then the slave (the mouse) will correct us and tell us what connection par=
ameters it needs. We accept them and actually change the LE link to use the=
se parameters. However we end up forgetting them. So every time you connect=
 this procedure keeps repeating itself.
>
> I fixed this as well, but for that you will need a bluetooth-next kernel =
where I enabled the management API for passive scanning and a modified blue=
toothd that will then allow you a smooth experience. If the slave updates t=
he connection parameters we remember them for devices using auto-connection=
. So once the connection is triggered via passive scanning the values will =
be remembered.
>
> At the moment, I have one minor issue with the re-connection within bluet=
oothd and once that is fixed this should be pretty instant.


Okay, great, glad to hear that you're already on it.  I'm really
looking forward to the seamless Bluetooth experience on Linux!  When
everything is ready and in the master branch let me know and I will
try them out.

Thanks,
Ryan
