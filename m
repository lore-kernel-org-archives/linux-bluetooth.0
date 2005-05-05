Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] What endian type is supported by audio device ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050505123708.92329.qmail@web8307.mail.in.yahoo.com>
References: <20050505123708.92329.qmail@web8307.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1115298331.8496.149.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 05 May 2005 15:05:31 +0200

Hi Mayank,

> > I think that if you use ALSA it can change the
> > endian format on demand
> > inside the library, but for the a2play and a2recv
> > with OSS support we
> > can do that inside our own code. It is only byte
> > swapping. And from my
> > understand it should be done inside the SBC codec.
> > We simpy tell it what
> > input or output endian format we expect and then it
> > should obey to it.
> 
> But this means that we will have to add a flag bit to
> indicate the endian type.
> 
> This is ok between a2play and a2recv. But do you mean
> that we are gonna be limited to these two applications
> only?
> 
> For instance, I tested a2recv with BlueSoleil and it
> was working perfectly alright, i.e. if I opened the
> audio device in little-endian format, did the byte
> swapping in sbc.c file.
> 
> But we can't reprogram a third party s/w to incoporate
> a bit for endian type.

actually I have no idea what problem do you see here. We have a PCM
stream in big endian or little endian and we tell our SBC encode what
this endian format is. On the decoding side we tell it what endian
format we gonna need for the PCM stream it is creating. That's it. So
why should we worry about third party software. They can choose and if
they wanna use the SBC library they have to do it our way.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
