Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] more encoder stuff
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041125071423.10e449c3.henryk@ploetzli.ch>
References: <41A56774.1000308@xmission.com>
	 <20041125071423.10e449c3.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1101365484.7538.74.camel@pegasus>
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
Date: Thu, 25 Nov 2004 07:51:24 +0100

Hi Henryk,

> > you were saying the reference encoder runs faster. Is there
> > any chance they are using vector processing like sse/sse2? Do projects
> > like xine and mplayer detect and use a vector processor through a
> > library?
> 
> Nope, that was an error on my side. My file output was awfully slow. I
> didn't test with large files since then, though. However, I_did_ profile
> it and know that most of the encoding time is spent in sbc_analyze_audio
> (no surprise there) in the matrixing, windowing and partial calculation
> stages.
> 
> I just tested it again with a -O3 compiled sbcenc:
> 
> | time wine sbc_encoder.exe -o Uninvited.sbc Uninvited.wav
> gives 
> | real    0m30.095s
> | user    0m18.766s
> | sys     0m0.686s
> 
> | time ./sbcenc Uninvited.au > Uninvited.sbc
> gives
> | real    0m36.539s
> | user    0m27.200s
> | sys     0m1.500s
> 
> That's not _too_ bad, especially since they are using dual channel while
> we are using stereo (the latter gives smaller file size in this case).

there exists a switch to sbc_encoder.exe to tell them to use stereo or
joint stereo.

> By using CC=icc CFLAGS="-O3 -tpp7 -march=pentium4" I can easily get it
> down to
> | real    0m19.122s
> | user    0m11.272s
> | sys     0m1.474s

The MAD library (www.underbit.com/products/mad/) is using fixed-point
integer computation. Do you think it is possible to do the same thing
for SBC? Will it give us some extra performance?

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
