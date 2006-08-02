Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0608011659100.2567@redbean.intranet.gw-instruments.de>
References: <Pine.LNX.4.63.0608011659100.2567@redbean.intranet.gw-instruments.de>
Date: Wed, 02 Aug 2006 05:09:11 +0200
Message-Id: <1154488151.3905.34.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Patch for rfcomm tty server ports
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Peter,

> this patch allows the use of tty server ports. If a rfcomm tty port 
> is bound to BDADDR_ANY e.g. : 
> 
> rfcomm bind /dev/rfcomm0 00:00:00:00:00:00 1 
> 
> it will start listening on the channel supplied once opened (and will 
> stop listening when the port is closed...). This allows rfcomm ttys in 
> server mode without the need for an additional user space daemon. 

the idea of using BDADDR_ANY is kinda nice, but the use of another
kernel thread for the listen RFCOMM socket within the RFCOMM module is
not good. We need to integrate all the processing for the server state
in the DLC itself.

I am not gonna working on this, but I am supporting it and happy to
review any patches.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
