Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Belkin Bluetooth USB Printer Adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: dave.givens@phaldor.co.uk
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <418601B6.2010905@phaldor.co.uk>
References: <418601B6.2010905@phaldor.co.uk>
Content-Type: text/plain
Message-Id: <1099313330.16247.91.camel@pegasus>
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
Date: Mon, 01 Nov 2004 13:48:50 +0100

Hi Dave,

>    I am writing to you as I cannot find the help I require on the net 
> and the product manufactures will not help. I have a bluetooth printer  
> adapter which I am trying to set up on Linux (Fedora Core 2, Kernel 
> 2.6.8). I have read Marcels web pages and downloaded the relevant 
> software, but even though I have copied the bluetooth file into the 
> directory as instructed and created an entry in printers.conf, the 
> printer/adapter does not appear anywhere in the gnome printer software 
> that I know of. It might be that I am looking in the wrong places, it 
> appears as an item in gnome-bluetooth-manager, but the only chooses of 
> printers in the printer configuration gui are dev/lp0 and ptal. Am I 
> looking in the correct place? Is it a Fedora Core 2 problem? Have I 
> installed the software correctly? Any help you can give me will be 
> greatfully accepted as I have spent two weeks trying to get it to work. 
> I have tried installing as a custom device, but it rejects even that.

actually the CUPS backend is included in bluez-utils-2.10 and I think
you should use this version, because the other is no longer maintained.
However the printers.conf file is gone and you have to setup your
Bluetooth printer manually by entering the URI.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
