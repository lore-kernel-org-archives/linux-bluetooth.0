Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC packer done, kind of
From: Marcel Holtmann <marcel@holtmann.org>
To: Brad Midgley <bmidgley@xmission.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A43E8A.8030602@xmission.com>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
	 <1101191260.26578.43.camel@pegasus>
	 <20041123074829.7f978ce7.henryk@ploetzli.ch>
	 <1101201897.26578.54.camel@pegasus>
	 <20041123204901.776fe240.henryk@ploetzli.ch>
	 <1101243809.27351.18.camel@pegasus>
	 <20041124042114.5e1fee94.henryk@ploetzli.ch>
	 <1101272477.27351.67.camel@pegasus>  <41A43E8A.8030602@xmission.com>
Content-Type: text/plain
Message-Id: <1101307146.27351.104.camel@pegasus>
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
Date: Wed, 24 Nov 2004 15:39:06 +0100

Hi Brad,

> > 	sbcenc <au-file> | rcplay <bdaddr> -
> 
> a2play will also accept '-' for stdin now. you should try it to see if 
> my latest change makes it work for your headset.

the latest CVS version of a2play is broken for me in both modes and it
makes also no difference between standard input or if the SBC frames are
read from a file.

> the mailing lists are slow lately, eh?

This happens some times. Ask the Sourceforge guys, because they may
changed hardware again and spooled all our mails. Or another virus is on
its move and overloads their severs.

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
