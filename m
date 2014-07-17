Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <993441F6-4EC2-4A4A-B9E0-18EE88F51ACB@me.com>
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
	<35F01C64-F255-433B-A07A-1AD84CA6574A@me.com>
	<9D9BAF08-F0CE-4A5A-B8E7-039DE916D93E@holtmann.org>
	<993441F6-4EC2-4A4A-B9E0-18EE88F51ACB@me.com>
Date: Wed, 16 Jul 2014 22:40:53 -0700
Message-ID: <CAHZ1yCkgN1apeGyFVNqgvW+H09RmC2gfHdb1bi26HK+7c+ibeA@mail.gmail.com>
Subject: Re: LE mouse reconnect problem
From: Scott James Remnant <keybuk@google.com>
To: d.eriksson@me.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Ryan Press <ryan@presslab.us>,
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 3, 2014 at 9:40 AM,  <d.eriksson@me.com> wrote:

> Sounds great. I really wanted the passive scan option as well.
> Would bluetooth-next work under 3.13?
>

Chrome OS is running bluetooth-next on as old a kernel as 3.8 -- we
have an unshipped backport all the way to 3.4 -- so yes, it's
definitely possible.

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
