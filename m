Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1163677864.455c50a8bb3a3@webmail.cs.umu.se>
References: <1163677864.455c50a8bb3a3@webmail.cs.umu.se>
Date: Thu, 16 Nov 2006 13:06:49 +0100
Message-Id: <1163678809.5169.47.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bluetooth devices connection problem
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

Hi,

> We are using Linux for tranfering a file on bluetooth devices. Connection create
> function on HCI layer i.e. (hci_create_connection(----)) can't procced and give
> error message.
> 
> Connection failed !
> : operation not permitted
> 
> kindly suggest is there any problem with linux kernal or else.

simply don't use this command. There is no need to deal with low-level
HCI command at all. The L2CAP and RFCOMM sockets full abstract from this
and for everything else we have a nice D-Bus based interface.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
