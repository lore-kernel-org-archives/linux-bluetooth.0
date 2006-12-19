Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4587315D.10703@aon.at>
Date: Tue, 19 Dec 2006 01:25:01 +0100
From: Johannes Hoerhan <jhoe@aon.at>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4580168C.2060806@aon.at>	<1166359631.6557.37.camel@aeonflux.holtmann.net>
	<loom.20061218T215536-830@post.gmane.org>
In-Reply-To: <loom.20061218T215536-830@post.gmane.org>
Subject: Re: [Bluez-devel] rfcomm kernel 2.6.19 probs
Reply-To: jhoe@aon.at, BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi, I am also using udev 103 - I did not check the udev events. With my 
patch everything is working great now. If the information is needed I 
will monitor udev with the non working version of tty.c.

  joho

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
