Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Widcomm BlueConnect and Bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: Didier Alves <dsas@mega.ist.utl.pt>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000f01c3fc6f$303ed760$318388c1@zedidas>
References: <000f01c3fc6f$303ed760$318388c1@zedidas>
Content-Type: text/plain
Message-Id: <1077804727.2754.44.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 26 Feb 2004 15:12:07 +0100

Hi Didier,

> > what kind of PDA is this? What kernel are you using? Make a binary
> > hcidump and send it to us.
> 
> It's a Handspring Visor Pro with PalmOS 3.5.2H3.0. I read somewhere that
> there is a problem with buffer overrun in that version of PalmOS.

please run "hcitool info <bdaddr-visor>" (as root).

> The Bluez kernel version is 2.3.

Don't use this. A kernel with my -mh patch is enough.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
