Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC packer done, kind of
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20041123014732.3a03b10e.henryk@ploetzli.ch>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1101191260.26578.43.camel@pegasus>
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
Date: Tue, 23 Nov 2004 07:27:40 +0100

Hi Henryk,

> Ok, I'm now basically finished with sbc_pack_frame (joint stereo is not
> handled yet). Though I tested it only with mono and two simple test
> signals (one impulse and a sawtooth) because I can't load audio data
> from files. (Marcel?)

these are good news. So I really must code the sbcenc tool now. In what
fields do I have to put the PCM stream and what other things must I set?

> Next thing (after joint stereo) would be some cleanup of sbc.c and
> finally convertion to kernel indentation. I tried the Lindent script but
> don't like what it does to the code, because most of it is nested in
> some kind of for(blk ..) { for(ch ..) { for(sb ..) { ... } } } structure
> and wasting a full 8 columns (out of the precious 80) for each of those
> loops doesn't feel right to me.

Actually that is the main point behind using tabs with the size of 8
spaces. Code that uses too much nested structures become unreadable and
you start thinking of how you can make this easier and make it looking a
little bit nicer. In most cases the answer is inline functions.

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
