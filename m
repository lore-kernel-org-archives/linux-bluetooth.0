Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <D8CE9CFA707C894180BAC8CDD154F8460B248D91@msiexch01.marvell.com>
References: <D8CE9CFA707C894180BAC8CDD154F8460B248D91@msiexch01.marvell.com>
Date: Mon, 29 Jan 2007 19:06:20 +0100
Message-Id: <1170093980.15389.214.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bluez-devel Digest, Vol 9, Issue 99
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

Hi Quinton,

> Sorry for the confusion, I would like to confirm that
> 
> 1. First display is right from hcidump, 
> 	HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> 	handle 1 ptype 0x2000
> 	Packet type: 3-DH5
> 
> 	However, the problem for this is we just disabled the 3-DH5
> packet type, instead of enabling it, whose function is reversed among
> BDR and EDR
> 
> 2. Second display is wrong which is caused firmware

the hcidump can have bugs, but in general it is a stupid program that
only decodes the binary HCI packets into human readable format. Feel
free to disable the verbose decoding (-V switch) and decode the binary
hex data by yourself to confirm it.

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
