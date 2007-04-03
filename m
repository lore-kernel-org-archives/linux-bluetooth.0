Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4612C15D.2080900@xmission.com>
Date: Tue, 03 Apr 2007 15:04:29 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45FE8B0B.20500@xmission.com>	<1174486267.15638.25.camel@aeonflux.holtmann.net>	<4604B9F2.5040808@xmission.com>
	<1175528198.5815.362.camel@violet>
In-Reply-To: <1175528198.5815.362.camel@violet>
Subject: Re: [Bluez-devel] new sco flowcontrol patch
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

Marcel

> And why do we have to do "c->tx_timer.function = hci_sco_tx_timer" over
> and over again. Isn't it enough if we set the timer function once after
> init of the timer.

should this happen directly inside hci_conn.c or through something like 
a notification?

To use it in hci_conn I'd want to move the definition of the function 
there too but that may not be the right fit.

Brad




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
