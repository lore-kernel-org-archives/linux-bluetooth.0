Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Meena Seeballack <meena2010@gmail.com>
Date: Fri, 2 Mar 2007 10:26:12 +0000 (UTC)
Message-ID: <loom.20070302T112427-678@post.gmane.org>
References: <ddea76ce0703020147p24d01969rb76b40b856b4bfe0@mail.gmail.com>
	<24a5055d0703020204i146520bdgbabe177dfb56201f@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel]
	=?utf-8?q?HELP_configure=3A_error=3A_Bluetooth_libr?=
	=?utf-8?q?ary_is=09required?=
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

Rahul Tank <tank.rahul <at> gmail.com> writes:

> 
> 
> 
> On 3/2/07, Meenakshi Seeballack <meena2010 <at> gmail.com
> > wrote:
> I think I need to start from scratch to get the bluetooth folder in
/usr/inlcude. So I downloaded these libraries:
> 
> 
> 
> 
> bluez-libs-3.9.tar.gz
> bluez-utils-3.9.tar.gz
> bluez-firmware-1.2.tar.gz
> bluez-hcidump-1.34.tar.gz
> bluez-gnome-0.6.tar.gzand saved them onto my desktop. I have a folder called
bluez on my desktop, and I have un-packed the tarballs above.I am in the
terminal trying to install bluez-utils-3.9 by ./configure and I get this error: 
> configure: error: Bluetooth library is requiredPlease guide me in my next
steps as i am a novice to Linux?
> -------------------------------------------------------------------------Take
Surveys. Earn Cash. Influence the Future of ITJoin SourceForge.net's Techsay
panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> 
>
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV_______________________________________________Bluez-devel
mailing list
> 
> Bluez-devel <at>
lists.sourceforge.nethttps://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 
> Install bluez-libs-3.9 before installing bluez-utils-3.9 . Google is your
friend in case you have such problems :)
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> 
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel <at> lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
----------------------------------------------------
I have installed bluez-libs, bluez-firmware-1.2 and 
bluez-gnome-0.6 without any
problem.
When I then try to install bluez-utils 
or bluez-hcidump-1.34, I get the same error:
checking for BLUEZ... no
configure: error: Bluetooth library is required
Please help!!!





-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
