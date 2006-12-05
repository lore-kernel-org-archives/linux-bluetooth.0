Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45750E87.5040100@xmission.com>
Date: Mon, 04 Dec 2006 23:15:35 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <8cd2fe3d0612042131l1335d831r3b3c4b85239624a9@mail.gmail.com>
In-Reply-To: <8cd2fe3d0612042131l1335d831r3b3c4b85239624a9@mail.gmail.com>
Subject: [Bluez-devel] omap1510 Re:  bluetooth
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

ravindra

> This is ravindra currently doing my MS in real time embedded systems
> in bangalore (india)...right now i m doin my project work.
> title is "To develop bluetooth communication on OMAP1510 Innovator
> development kit with the external bluetooth enabled device using linux
> ( porting linux on OMAP1510)"

on the hardware side you'd likely be able to use a uart-connected 
adapter like I did with gumstix:

http://bluetooth-alsa.sourceforge.net/embed.html

i'm not sure how your software build will look, but you should be able 
to start with the linux sdk for your dev kit. It's best if you use linux 
2.6 but 2.4 would probably work for basic bluetooth stuff.

brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
