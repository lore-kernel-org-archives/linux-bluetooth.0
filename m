Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC packer done, kind of
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041123204901.776fe240.henryk@ploetzli.ch>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
	 <1101191260.26578.43.camel@pegasus>
	 <20041123074829.7f978ce7.henryk@ploetzli.ch>
	 <1101201897.26578.54.camel@pegasus>
	 <20041123204901.776fe240.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1101243809.27351.18.camel@pegasus>
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
Date: Tue, 23 Nov 2004 22:03:29 +0100

Hi Henryk,

> > However it does not work as expected, but if you accept some noise you
> > will get some results. I used these commands for testing:
> 
> Yes, the values sbclib.c puts into frame.pcm_sample don't look right.

this actually reminds me again that I am not an audio expert. Can you
fix it easily?

> If you don't have any objections I'll rename sbcdec as sbcplay (that's
> more descriptive of what it does) and try to come up with an sbcenc and
> sbcdec based on the audio file library
> http://freshmeat.net/projects/audiofilelibrary

I like to keep them as sbcenc and sbcdec, because this is what they are
doing. The output to a soundcard is a nice extra feature of sbcdec and
if sbcenc can capture from a soundcard this will be also great. To have
some nice and handy names I think sbcplay and maybe sbcrec should be
symlinks to sbcdec and sbcenc. This is how this is normally done and if
we share most of the code it is also no problem to be sbcenc and sbcdec
the same program.

The choose for libao was, because mpg321 uses it and its API is very
easy. The possibility for writing to a file and playing on a soundcard
with the same set of functions was also a plus. However I don't know
what's the best audio library nowadays. So any comments about that are
welcome.

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
