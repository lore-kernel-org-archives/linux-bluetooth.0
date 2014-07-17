Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C43AD631-D51D-46A9-98BB-99D94774CC89@holtmann.org>
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
	<CAHZ1yCniScfX+Cvoyv0B3GaYWL41qPJD4V+Le+3HENYS5kUdYw@mail.gmail.com>
	<60346ECF-9A0B-4D3B-BDD6-A617797550D9@holtmann.org>
	<CAHZ1yCnSMQqhJ_x-=5VPibThBBU12M_LvkmCpCWR1b5np0V8Hw@mail.gmail.com>
	<C43AD631-D51D-46A9-98BB-99D94774CC89@holtmann.org>
Date: Wed, 16 Jul 2014 22:42:11 -0700
Message-ID: <CAHZ1yCmh5oarHY03sJM_CxD64PK9K85+2RPW84c3-AgZBv3kug@mail.gmail.com>
Subject: Re: LE mouse reconnect problem
From: Scott James Remnant <keybuk@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Ryan Press <ryan@presslab.us>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Marcel,

On Tue, Jul 1, 2014 at 9:01 AM, Marcel Holtmann <marcel@holtmann.org> wrote:

>>> the same applies to the HP mouse btw.
>>>
>>
>> Which HP Mouse are you referring to?
>>
>> An HP Mouse I have uses general connectable advertising when it wants
>> to reconnect.
>
> might want to check HCI Remote Version Information (via hcitool cmd) for that device. So what we found out today is that the Nordic based HID devices only do direct advertising. However my CSR based one does direct advertising first and if it times out, it falls back to undirected advertising.
>

I confirm this at my end.

Our CSR-based devices are the ones falling back to undirected, while
the Nordic ones are not.

In the Z8000 case at least there's a cute blue Connect button that
resets it back to undirected advertising.

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
