Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Aug 2011 17:44:38 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 1/3] Bluetooth: prioritizing data over HCI
Message-ID: <20110803204438.GG28119@joana>
References: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
 <1312377094-11285-2-git-send-email-luiz.dentz@gmail.com>
 <1312388716.3358.58.camel@THOR>
 <CABBYNZJ9DVr5kPE3ZrWgyWUGBayZTyY+=rfEXpckXT3xkL6X8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CABBYNZJ9DVr5kPE3ZrWgyWUGBayZTyY+=rfEXpckXT3xkL6X8w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-08-03 20:49:19 +0300]:

> Hi Peter,
> 
> On Wed, Aug 3, 2011 at 7:25 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> >
> > I believe that the existing tx scheduler is already inefficient and that
> > this approach significantly compounds that inefficiency.
> >
> > Consider the following scenarios with 4 ACL connections (keyboard,
> > mouse, phone, headset):
> >
> > For *one* scheduled ACL tx packet, the connection list will be searched
> > 35~42 times -- that's 140~168 connection list node visits to find one
> > packet! Here's the math:
> >        (7 - priority of tx packet) x 4 connections => found the packet
> >        7 pri levels x 4 connections => no more ACL tx packets
> >        7 pri levels x 4 connections => no SCO tx packets
> >        7 pri levels x 4 connections => no ESCO tx packets
> >        7 pri levels x 4 connections => no LE tx packets
> >        7 pri levels x 4 connections => recalc priority
> >
> > If the connection type doesn't match, it's not going to match at any
> > priority level.
> 
> Obviously there are a few things that we might change to not traverse
> the list of connection over and over, remember this is an RFC, besides
> it 8 priorities (0-7), but we can skip much earlier if connection
> doesn't match as you said. Also I guess for SCO/ESCO/LE e doesn't make
> much sense to have many queues/priorities, it is basically ACL only,
> that simplify a lot already.

Maybe 8 is too much, I think it could work with 4. We keep the high
priority queue 7 and more 3. A2DP and SCO could have the 6, HID the queue 5,
Obex transfers, PAN, AVRCP, etc goes queue 4. Queueing in 3, 2, 1 and 0 could
actually queue on 4.

	Gustavo
