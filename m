Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP & HCI trace
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20050217111414.40743.qmail@web53202.mail.yahoo.com>
References: <20050217111414.40743.qmail@web53202.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1109027746.7626.35.camel@pegasus>
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
Date: Tue, 22 Feb 2005 00:15:46 +0100

Hi Filipa,

> > Try recompilating your kernel with the
> > CONFIG_BT_HCI_SOCK_DEBUG, CONFIG_BT_L2CAP_DEBUG,
> > etc... (All the options
> > mentionned at the beginning of the files, in a block
> > like : 
> > 
> > #ifndef CONFIG_BT_L2CAP_DEBUG
> > #undef  BT_DBG
> > #define BT_DBG(D...)
> > #endif
> > 
> > ) enabled.
> I am a newbie in Linux/BlueZ matters and I am not sure
> how to do this. Could you please explain?

add a line with "#define CONFIG_BT_L2CAP_DEBUG" before this block and
recompile the module.

> By the way, does anybody has the l2cap and hci layers
> implemented im User Space? I need to have those layers
> running without OS... 

Actually it is possible to do this, but you are on the wrong mailing
list for this question ;)

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
