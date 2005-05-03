Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC Decoder with /dev/dsp
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4276DAB1.1020601@xmission.com>
References: <20050501124348.24307.qmail@web8310.mail.in.yahoo.com>
	 <1114952271.21785.13.camel@pegasus> <1114965624.21785.71.camel@pegasus>
	 <4275CBF6.9070300@xmission.com> <1115027766.21785.97.camel@pegasus>
	 <4276469B.5050401@xmission.com> <1115059379.21785.147.camel@pegasus>
	 <4276DAB1.1020601@xmission.com>
Content-Type: text/plain
Message-Id: <1115135192.8206.37.camel@notepaq>
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
Date: Tue, 03 May 2005 17:46:32 +0200

Hi Brad,

> > I think that we should move the complete AVDTP handling into a2dp.c and
> > make a2play and a2recv only contain the soundcard/file setup and the
> > main event loop.
> 
> agreed. The alsa-lib driver will be event-driven from the start, so I 
> will probably want to work on the alsa-lib driver next and once that's 
> done, I will have a better idea of how to implement the new model for 
> a2dp.c.

maybe I can come up with something. I will see how much free time I get
for working on A2DP.

> my headsets are "in the mail" so I'll be back on it soon. You had done 
> some avdtp alsa-lib work I think and if that's a good starting point, I 
> would like to work from that. If it's not fleshed out enough, I'll just 
> start from your rfcomm alsa-lib code.

A big thing is to get the timing (delays) right and so far I haven't
managed to find a good timing source. The gettimeofday() and RTC is not
really working inside the ALSA plugin. And the ALSA guys are a little
bit silent at the moment :(

> > First question is if we ever wanna allow a2play and a2recv to output SBC
> > files or should it always be a soundcard or a PCM file? If we skip that
> > SBC part, we can integrate the SBC processing directly into the a2dp.c
> > file and hide it. This will makes things a lot easier.
> 
> I don't think we will need the sbc streams. I don't think I'd use them 
> even for debugging. We will want a way to have the use of /dev/dsp be 
> optional (ie optionally read and write audio files) but that shouldn't 
> complicate things much.

Fine with me, too.

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
