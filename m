Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jan 2010 11:26:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Zotov <whitequark@whitequark.ru>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Handset voice dial signalling patch
Message-ID: <20100113092620.GA20024@jh-x301>
References: <4B4D780F.1080405@whitequark.ru>
 <20100113083247.GA18980@jh-x301>
 <4B4D8C5A.8070006@whitequark.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B4D8C5A.8070006@whitequark.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Wed, Jan 13, 2010, Peter Zotov wrote:
> Johan Hedberg wrote:
> >It sounds to me like you're working around another problem. I suspect
> >the issue you're facing is that you don't have a telephony driver that'd
> >keep the headset up-to-date with the current call state, so when you
> >want to answer a call the headset doesn't generate the right AT command
> >(ATA) since it doesn't know that there's an incoming call (instead, the
> >only command it manages to generate is the voice recognition one since
> >that's the default behaviour when the headset thinks that there are no
> >active or pending calls).
> Not exactly. All the code I included to BlueZ is implementing voice
> dialing, perhaps partially; but the interface it exports to outside
> world is misused by VoIP answering emulator because it would be
> probably too hard to emulate all the conversation that is usually
> occuring between HS and AG when there is a real call just to make it
> reply ATA to VoIP proxy. Maybe it's the wrong approach, but it is
> good enough for task.

Fair enough. I just wanted to make sure that you realize what the core
issue is. As long as the misuse of voice dialing isn't in the BlueZ code
itself I have no objections ;)

> +	gboolean voice_dial;
> +	gboolean voice_dial_req;

I'm not so sure that it'll be useful to have this state info in
headset.c. I suspect for the most part voice recognition will be a
platform specific issue that can be taken care of by the telephony
driver. So I'd leave out these new variables for now and add them later
if it turns out that there's actually some use for them in headset.c.

After this change I think the patch could be pushed upstream.

Johan
