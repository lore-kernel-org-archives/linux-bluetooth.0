Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC code cleanup
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041128053245.4608f749.henryk@ploetzli.ch>
References: <1101592165.27074.31.camel@pegasus>
	 <20041128053245.4608f749.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1101620847.18467.19.camel@pegasus>
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
Date: Sun, 28 Nov 2004 06:47:27 +0100

Hi Henryk,

> > I started with some cleaning up of the SBC code to better fit into
> > current coding conventions. My focus was on the sbc_synthesize_audio()
> > and sbc_analyze_audio() functions. 
> 
> I saw that and you're doing a good job there.

I hope that we get no performance problems with this cleanups. This all
now depends on how good the compiler optimizes and predict stuff. I
think that we need some regression tests.

>  I also saw that you
> registered sf.net/projects/sbc.

Yes, it is true. I registered the SBC library as a standalone project at
Sourceforge. Right now this is still in the setup phase, but I hope that
we can move the code over very soon. Actually this was the reason why I
tried to cleanup some things.

> > -       for (i = 0; i < 7; i++)
> > +       for (i = 0; i < 8; i++)
> 
> > Am I right, or do I miss something?
> 
> No, you're absolutely right. Actually the decoder is broken currently
> (I swear it worked when I checked in rev 1.8 of sbclib.c). I'm
> investigating...

The decoder is working for me. I tried it before I checked in my
changes.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
