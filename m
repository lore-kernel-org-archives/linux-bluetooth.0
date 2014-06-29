Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E8C350F2-6B3C-4ECD-A281-DDC25C339489@holtmann.org>
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
Date: Sun, 29 Jun 2014 12:03:06 -0700
Message-ID: <CAHZ1yCniScfX+Cvoyv0B3GaYWL41qPJD4V+Le+3HENYS5kUdYw@mail.gmail.com>
Subject: Re: LE mouse reconnect problem
From: Scott James Remnant <keybuk@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Ryan Press <ryan@presslab.us>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jun 29, 2014 at 2:43 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:

> The biggest problem here is that even if you are trying to be private and=
 doing everything right, the mouse will broadcast your public address every=
 time it tries to reconnect. So thank you Microsoft for forcing us to be tr=
ackable.
>

\o/

(I'd had an open bug to investigate why this mouse wasn't
reconnecting, y'all beat me to it)

> Now the biggest problem is that with 3.15 and 3.16-rcX kernels we would n=
eed to go back to using our identity address for discovery. This means acti=
ve scanning and it means we are broadcasting our identity address to everyb=
ody when trying to find this mouse. I rather not do that.
>

I think we would rather just document that this mouse isn't going to
reconnect, since you can at least use the UI to reconnect by hand.
Switching back to active scanning on the identity address would make
our devices trackable, which is very definitely not on our wish list.

Scott
--=20
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
