Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC packer done, kind of
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1101278049.27351.98.camel@pegasus>
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>
	 <1101191260.26578.43.camel@pegasus>
	 <20041123074829.7f978ce7.henryk@ploetzli.ch>
	 <1101201897.26578.54.camel@pegasus>
	 <20041123204901.776fe240.henryk@ploetzli.ch>
	 <1101243809.27351.18.camel@pegasus>
	 <20041124042114.5e1fee94.henryk@ploetzli.ch>
	 <1101272477.27351.67.camel@pegasus>  <1101278049.27351.98.camel@pegasus>
Content-Type: text/plain
Message-Id: <1101356529.7538.29.camel@pegasus>
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
Date: Thu, 25 Nov 2004 05:22:09 +0100

Hi Henryk,

> > 	sbcenc <au-file> | sbcinfo -
> > 	sbcenc <au-file> | rcplay <bdaddr> -
> 
> when using sbcenc in a pipe with rcplay I get a delay for the first bits
> of music that should be played. This is only on the first call of the
> program or after the kernel removed it from its cache. Do you have any
> idea what might causes this?

forget about that, because it was a sbcenc problem. I fixed it now.

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
