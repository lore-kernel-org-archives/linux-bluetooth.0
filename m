Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20060726T090256-627@post.gmane.org>
References: <loom.20060726T090256-627@post.gmane.org>
Date: Wed, 26 Jul 2006 09:20:32 +0200
Message-Id: <1153898432.746.7.camel@localhost>
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

> Does anybody know is it possible to connect with phone (or something else) on
> the first computer and, while sending some data, can i make the phone to send
> and be conecting with another computer without loosing connection.
> This means Can i change connected bluetooth dongle to another, after sending
> some data without loosing connection.

in general this is possible as long as the computer is the master of the
piconet. If it is a slave you need a dongle that supports scatternet.
You also can either page for a new connection or run an inquiry.

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
