Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20070602184043.594698c5@topolino>
References: <20070602184043.594698c5@topolino>
Date: Mon, 04 Jun 2007 17:24:23 +0200
Message-Id: <1180970663.13429.56.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problems with network via bluetooth
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Aldo,

> my home lan is made up with three desktops.
> one of them (GW) has 3 eth cards the first one links to the router
> the other 2 connect PC1 and PC2 to GW.
> PC1 has 2 eth cards, the first one links it to GW and i use the second
> to connect, from time to time, my notebook (NB) to the lan.
> 
> recently i have bought 2 bluetooth/usb adapters because i wished to
> create a bluetooth net between PC1 and NB
> 
> in PC1 i have Ubuntu Gutsy (but i have the problem i'm going to tell
> also with Debian Lenny which is installed in PC1 as well) and in the
> NB i have Debian Lenny.
> 
> the two bluetooth systems see each other:
> 
> if i run in the NB:  hcitool scan
> correctly get:
> 11:11:11:11:11:11   paperino-0

this is not a valid MAC address. And PAN/Ethernet will fail with it.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
