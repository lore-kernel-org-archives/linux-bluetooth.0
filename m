Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: Re:[Bluez-devel] BlueZ on CSR ?
From: David Woodhouse <dwmw2@infradead.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <ICGZCE$7DF6A31DCAD3E31E3169B51A8859A4C6@bol.com.br>
References: <ICGZCE$7DF6A31DCAD3E31E3169B51A8859A4C6@bol.com.br>
Content-Type: text/plain
Message-Id: <1109520020.27107.30.camel@localhost.localdomain>
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
Date: Sun, 27 Feb 2005 16:00:19 +0000

On Fri, 2005-02-25 at 10:41 -0300, ra002890 wrote:
>Can you configure your module(home made) or it is a shop-self module?!?
>I worked with csr modules and Bluez worked very well with them. At
>first remember that common PCs serial port works only at 115200 bps or
>less. Try "hciattach ttyS0 any 115200", or
>"hciattach ttyS0 bcsp 115200". If you can change PSKEYS, and firmware,
>recall me.

Most PC serial ports can do at least 460800 baud if you ask them nicely.
Search for 'Shsmod' which puts the port into high-speed mode.

-- 
dwmw2



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
