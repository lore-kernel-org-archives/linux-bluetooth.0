Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F2336E43-F4C9-411A-A3A3-1D0BF659C1F7@holtmann.org>
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
	<CABx3TkVt3t_dyRmY6rjrwzw9BoTRaZinHOQEEbyVND+_NjLSVQ@mail.gmail.com>
	<F2336E43-F4C9-411A-A3A3-1D0BF659C1F7@holtmann.org>
Date: Wed, 2 Jul 2014 20:01:25 -0700
Message-ID: <CABx3TkXFUnV_awEQUL8oicyEWXd-d5qPWjC8q-qRJL0VHQCvXA@mail.gmail.com>
Subject: Re: LE mouse reconnect problem
From: Ryan Press <ryan@presslab.us>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jul 1, 2014 at 2:49 AM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Ryan,
>
>>>> I have one other question with it.  When it first reconnects the mouse
>>>> pointer is really jerky, like it's updating really slow.  Then after a
>>>> few seconds it is normal; in fact it is very responsive compared to my
>>>> old Bluetooth mouse.  With Windows 8.1 it reconnects lightning fast
>>>> when I turn it on, and it is not jerky at first.
>>>>
>>> this is a kernel issue with not remembering the previous connection par=
ameters. What you see is that we start connecting with the default values a=
nd then the slave (the mouse) will correct us and tell us what connection p=
arameters it needs. We accept them and actually change the LE link to use t=
hese parameters. However we end up forgetting them. So every time you conne=
ct this procedure keeps repeating itself.
>>>
>>> I fixed this as well, but for that you will need a bluetooth-next kerne=
l where I enabled the management API for passive scanning and a modified bl=
uetoothd that will then allow you a smooth experience. If the slave updates=
 the connection parameters we remember them for devices using auto-connecti=
on. So once the connection is triggered via passive scanning the values wil=
l be remembered.
>>>
>>> At the moment, I have one minor issue with the re-connection within blu=
etoothd and once that is fixed this should be pretty instant.
>>
>>
>> Okay, great, glad to hear that you're already on it.  I'm really
>> looking forward to the seamless Bluetooth experience on Linux!  When
>> everything is ready and in the master branch let me know and I will
>> try them out.
>
> the current bluetooth-next tree and bluez.git should now make this work s=
moothly. The first connection after starting bluetoothd will still use the =
wrong connection parameters, but all future ones will be snappy.
>
> Regards
>
> Marcel

I have installed bluetooth-next and bluez git.  I had to merge with
rc3 because rc1 wouldn't boot on my machine for some other reason.  At
first I had rfkill soft blocked when resuming from standby but then I
pulled again and it fixed it.  I saw Johan made a commit about blocked
devices maybe that was it.

So it works really well!  Connections are instant and the mouse
reconnects every time.  The only time that connection is slow is the
first time after a reboot, like you mention above; that's not really a
problem.

Thanks,
Ryan
