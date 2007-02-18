Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4f436aae0702180425r2abd39e7q2842ef50e585e67a@mail.gmail.com>
References: <4f436aae0702180425r2abd39e7q2842ef50e585e67a@mail.gmail.com>
Date: Sun, 18 Feb 2007 13:44:06 +0100
Message-Id: <1171802646.26794.6.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] immediate unsolicited disconnect after hcitool cc
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

Hi Choi,

> after I do "hcitool cc xx:xx:xx:xx:xx:xx" I have a connection
> I can see with "hcitool con" but after one or two seconds I can
> see in hcidump that an HCI disconnect command is sent and
> the connection is disconnected.

don't use this command for piconet creation. Use higher layer like L2CAP
and RFCOMM. The kernel will create the needed ACL link for you and take
fully care of it.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
