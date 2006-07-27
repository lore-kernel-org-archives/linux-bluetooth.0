Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20060727T124321-180@post.gmane.org>
References: <loom.20060726T090256-627@post.gmane.org>
	<1153898432.746.7.camel@localhost>
	<loom.20060727T124321-180@post.gmane.org>
Date: Thu, 27 Jul 2006 13:05:12 +0200
Message-Id: <1153998312.9543.10.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Connecting on the first computer with
	bluetooth	and interacting on another computer
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

Hi Yuriy,

> I have a situation
> Man is walking at one computer and at this moment bluetooth adapter
> is begining to send a file (my own code). While it sending, he goes out 
> and comes to another computer, where the link is bad with the 
> first computer and is good with another. The file is sending.
> 
> Is it possible to continue sending this file from another computer without
> breaking transmitting and to stop the first computer sending. And for man 
> it would be like just file sending without reconnecting

no. Bluetooth doesn't support this kind of roaming or handover

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
