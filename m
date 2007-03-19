Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 19 Mar 2007 16:34:02 +0200
Message-ID: <F8B9B12641FB6B4FAC761BDEF9D63B040C4DA1CA@tlv-ex-01.adprod.bmc.com>
In-Reply-To: <1174316823.3690.9.camel@aeonflux.holtmann.net>
From: "Cohen, Nimrod" <Nimrod_Cohen@bmc.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Compiling bluez-utils-3.9 problem
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

Hi
Can you elaborate on.. 
Where .. how..
Where can I find that package 

Nimco 

-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Monday, March 19, 2007 5:07 PM
To: BlueZ users
Subject: Re: [Bluez-users] Compiling bluez-utils-3.9 problem

Hi Nimrod,

> My system is fedora 6 with 
> 
> bluez-libs-3.7-1
> 
> bluez-gnome-0.6-1.fc6
> 
> bluez-utils-3.7-2
> 
> bluez-bluefw-1.0-1
> 
>  
> 
> I'm trying to upgrade bluez-utils but I get error when
> running ./configure
> 
> checking for pkg-config... /usr/bin/pkg-config
> 
> checking pkg-config is at least version 0.9.0... yes
> 
> checking for BLUEZ... no
> 
> configure: error: Bluetooth library is required
> 
>  
> 
> I assume  that I'm missing some prefix  ... 

you are missing the includes files for the bluez-libs-devel package.

Regards

Marcel



------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share
your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
