Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC packer done, kind of
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041124042114.5e1fee94.henryk@ploetzli.ch>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
	 <1101191260.26578.43.camel@pegasus>
	 <20041123074829.7f978ce7.henryk@ploetzli.ch>
	 <1101201897.26578.54.camel@pegasus>
	 <20041123204901.776fe240.henryk@ploetzli.ch>
	 <1101243809.27351.18.camel@pegasus>
	 <20041124042114.5e1fee94.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1101272477.27351.67.camel@pegasus>
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
Date: Wed, 24 Nov 2004 06:01:17 +0100

Hi Henryk,

> > this actually reminds me again that I am not an audio expert. Can you
> > fix it easily?
> 
> Yupp, I think I did.

wow, good work. I can now do things like this:

	sbcenc <au-file> | sbcinfo -
	sbcenc <au-file> | rcplay <bdaddr> -

> > The choose for libao was, because mpg321 uses it and its API is very
> > easy. The possibility for writing to a file and playing on a soundcard
> > with the same set of functions was also a plus. However I don't know
> > what's the best audio library nowadays. So any comments about that are
> > welcome.
> 
> Neither do I. I just put "audio file library" into the search at
> freshmeat and it came up with that audio file library. The main reason
> why I'd like to use that is that it supports reading of audio files.

I will check what kind of library other projects prefer and what library
is actually best maintained. So if anyone has any pointers ...

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
