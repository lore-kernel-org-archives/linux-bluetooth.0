Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC packer done, kind of
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041123074829.7f978ce7.henryk@ploetzli.ch>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
	 <1101191260.26578.43.camel@pegasus>
	 <20041123074829.7f978ce7.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1101201897.26578.54.camel@pegasus>
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
Date: Tue, 23 Nov 2004 10:24:57 +0100

Hi Henryk,

> > these are good news. So I really must code the sbcenc tool now. In
> > what fields do I have to put the PCM stream and what other things must
> > I set?
> 
> You'll have to get yourself a shiny new struct sbc_frame, fill in the
> metadata and then put the pcm samples in the pcm_sample member. Then do
> the regular init (only once), analyze, pack (which do the reverse of
> their decoding counterparts).

the sbcenc program can now read Sun/NeXT audio S16_BE AU files and it
runs the encoder and writes the SBC frames to standard output. The tools
sbcinfo and rcplay are modified to accept the filename "-" as reading
from standard input. The sbcdec can't use standard input at the moment.

However it does not work as expected, but if you accept some noise you
will get some results. I used these commands for testing:

	sbcenc file.au > file.sbc
	sbcdec file.sbc

> > Actually that is the main point behind using tabs with the size of 8
> > spaces. Code that uses too much nested structures become unreadable
> > and you start thinking of how you can make this easier and make it
> > looking a little bit nicer. In most cases the answer is inline
> > functions.
> 
> Well yes. For most programs that's entirely true but in this special
> case of only a few ever recurring tight loops (some of them even copied
> literally from the spec) I don't see how littering the otherwise linear
> functionality all over the file would make it easier to read. I'd rather
> say the opposite was true.

Don't worry too much about it, because once we have a working decoder
and encoder we can look over your code and optimize it. Maybe some loops
will simply disappear then.

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
