Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <7e36c64c0611152108k62463cf5s864cce421dbf047d@mail.gmail.com>
References: <7e36c64c0611152108k62463cf5s864cce421dbf047d@mail.gmail.com>
Date: Thu, 16 Nov 2006 11:29:16 +0100
Message-Id: <1163672956.5169.23.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] server registration problem
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

>          When i am trying for server registration for obexServer
> using :
> BtOBEX_ServerRegister(handle, BDADDR_ANY, channel);
>  It shows the error "Server register error! (Bluetooth)".
>       I m using a dongle whose BD address is 11:11:11:11:11: 11.I am
> not sure whats exact problem here.Plz reply soultion on this.

this two errors are not related. However you might have happen to have
an OpenOBEX version that doesn't include Bluetooth support or the RFCOMM
kernel module is not loaded. In anycase, I would try to return that
dongle, because it has an invalid BD_ADDR.

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
