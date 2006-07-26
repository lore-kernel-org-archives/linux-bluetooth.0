Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44C73308.3010903@gmail.com>
References: <44C73308.3010903@gmail.com>
Date: Wed, 26 Jul 2006 17:42:11 +0200
Message-Id: <1153928531.5075.0.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Unable to get on on the D-Bus
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

> I have moved to the debian "sid" branch as it has 3.1 bluez included.
> 
> When I first apt-get'd the necessary packages everything seemed to work OK.
> After REBOOT I am getting the following messages about HCID:
> 
> Jul 27 03:41:37  hcid[1460]: Bluetooth HCI daemon
> Jul 27 03:41:37 sdpd[1462]: Bluetooth SDP daemon
> Jul 27 03:41:37 hcid[1460]: Service could not become the primary owner.
> Jul 27 03:41:37 hcid[1460]: Unable to get on D-Bus
> Jul 27 03:41:38 dund[1481]: Bluetooth DUN daemon version 3.1

do you have a correct installed bluez-hcid.conf for the D-Bus service?

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
