Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Ben Wilson <bwilson@yooser.org>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] New Zaurus packages available
Message-ID: <20040610041900.GB21115@stag.mark-and-erika.com>
References: <1086340599.10892.807.camel@baroque.rococosoft.com> <20040607050241.GA27386@stag.mark-and-erika.com> <1086774349.7888.867.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1086774349.7888.867.camel@baroque.rococosoft.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 10 Jun 2004 00:19:01 -0400

* On Wed, Jun 09, 2004 at 10:45:49AM +0100, I received from Stephen Crane:
> On Mon, 2004-06-07 at 06:02, Ben Wilson wrote:
> > Should this work on a 6000L?
> 
> I can't promise anything. I haven't got a 6000L.

The package works fine, but it doesn't look like my card is supported.

It's the AmbiCom BT2000-CF.

# cardctl ident
Socket 0:
  product info: "AmbiCom BT2000C", "Bluetooth PC/CF Card", "",
""
  manfid: 0x022d, 0x2000
  function: 2 (serial)

dmesg shows:

ttyS03 at port 0xf60002f8 (irq = 43) is a 16C950/954
pxa_pcmcia_suspend(0)

I guess this makes it a 0x16C950 UART card, but its a BT2000C,
which is unsupported.

> 
> Steve
> -- 
> Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
> steve.crane@rococosoft.com +353-1-6601315 (ext 209)

Thanks!

-- 
Ben


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
