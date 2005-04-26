Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: a2play code that is working
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050426122127.57962.qmail@web8302.mail.in.yahoo.com>
References: <20050426122127.57962.qmail@web8302.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1114527365.10706.288.camel@pegasus>
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
Date: Tue, 26 Apr 2005 16:56:04 +0200

Hi Mayank,

> > There is sometimes a delay before cvs gets updated
> > by sourceforge. I had 
> > made those changes to sbc.h
> 
> Are you sure it will be ok if we change the sbc.h and
> sbc.c files ?
> Because then the other applications making use of the
> sbc encoder will also have to change accordingly...??

there is no official SBC library release yet and so there is no problem
at all. For the pcm_a2dp plugin I copied the SBC code.

However I don't agree with these changes and you should never do a
library change together with the application change. Always make it two
different change sets. This is easier for tracking and I actually missed
that you changed the SBC library.

Now commenting on the change itself. The "struct sbc_frame_header"
should not placed inside the sbc.h header file. This is the API
interface and we don't need a definition of the SBC file format there.
If you wanna modify the additional SBC parameters add them to sbc_struct
and set them there. Please fix this.

Also a library should not use printf() at all. Remove them and improve
the return values to match -ENOMEM etc.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
