Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Limitation of emulator ?
From: Marcel Holtmann <marcel@holtmann.org>
To: Varat Chaikasetsin <varat_c@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20040212T074333-984@post.gmane.org>
References: <loom.20040210T083307-660@post.gmane.org>
	 <1076401392.32750.9.camel@pegasus>
	 <loom.20040212T074333-984@post.gmane.org>
Content-Type: text/plain
Message-Id: <1076573478.3041.51.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 12 Feb 2004 09:11:18 +0100

Hi Varat,

>      I've tried to change the HCI_MAX_DEV parameter in " bluez-libs-
> 2.4/include/hci.h " before reinstalling it as your suggestion.After that, I 
> intalled these utilities
> 
> bluez-utils-2.3
> bluez-pan-1.1
> bluez-sdp-1.5
> bluez-bluefw-1.0
> bluez-hcidump-1.5
> bluez-hciemu-1.0  
> 
>      first time that I changed it's max number to 8 it worked. I can simulate 
> only 8 device but later, when I try to change it to other value and reintall 
> all of libraries and uitilities the way I did before ,it doesn't work !.
>      What am I doing wrong ? or Do I have to install libraries and utilities in 
> order ?

maybe you have to recompile everything. The install order is bluez-libs,
bluez-utils and then the rest.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
