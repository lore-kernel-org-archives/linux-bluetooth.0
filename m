Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <45129525.1060704@csr.com>
References: <freemail.20060820112703.62459@fm06.freemail.hu>
	<45118E52.8080303@csr.com> <1158779197.10356.3.camel@localhost>
	<45129525.1060704@csr.com>
Date: Mon, 25 Sep 2006 23:50:35 +0200
Message-Id: <1159221035.20997.25.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Changing BD address on CSR based USB dongle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Steven,

> > with "bccmd psread" or "bccmd pslist" you can do that. However you need
> > to pick the correct stores value to get all info.
> 
> Aha, I thought it existed.
> 
> I'd like dumps of the psram, psi and psf stores.

I don't know if you got the output that you asked for. However here are
the needed commands (all as root):

	bccmd psread --stores psram
	bccmd psread --stores psi
	bccmd psread --stores psf

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
