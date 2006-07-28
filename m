Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <44C9DB62.1000103@kernelconcepts.de>
References: <44C8FB2F.9070403@kernelconcepts.de>
	<20060727185006.69823.qmail@web27915.mail.ukl.yahoo.com>
	<1171.216.47.50.125.1154031396.squirrel@webmail.feline-soul.net>
	<44C9DB62.1000103@kernelconcepts.de>
Date: Fri, 28 Jul 2006 11:46:28 +0200
Message-Id: <1154079988.2298.23.camel@localhost>
Mime-Version: 1.0
Cc: Bearcat@feline-soul.com
Subject: Re: [Bluez-users] can't connect EPOX Keyboard BT-KB01B
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

Hi Nils,

> > No such luck for me yet. Strangly the hcitool does not allow the auth
> > option for me. I had to do a hciconfig /dev/usb/hci0 auth to turn the auth
> > on the hub. Auth is now on but the keyboard still doesn't connect. As
> > usuall nothing is reported in the syslogs.
> > 
> > Do i need to turn on the auth for the keyboard too (is that even an option)?
> 
> No, the keyboard will require that automatically.

actually only the Apple keyboards require this and this is wrong
according to the HID specification. The host must make the decision to
authenticate and switch on encryption.

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
