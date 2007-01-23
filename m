Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <D8CE9CFA707C894180BAC8CDD154F8460B033014@msiexch01.marvell.com>
References: <D8CE9CFA707C894180BAC8CDD154F8460B033014@msiexch01.marvell.com>
Date: Tue, 23 Jan 2007 07:23:29 +0100
Message-Id: <1169533409.11260.14.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcidump EDR packet type
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

> Wondering someone can help to enlighten me on where hci packet type
> bit is reversed for  change connection packet type command (issued by
> hcitool) for EDR mode, based on the below hcidump, seems 0x2000 is
> passed down (which should be 0x1306), however, return message ptype
> 0x1306 is correct even decoding is not right.

what does "hciconfig hci0 features version" tell you about your chip
version and manufacturer.

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
