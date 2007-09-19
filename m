Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <000601c7faa4$0aa3b570$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>,
        "Fabien Chevalier" <fabchevalier@free.fr>
References: <06bf01c7f9e6$3008dcf0$0200a8c0@jester> <46EFB949.4090008@free.fr>
Date: Wed, 19 Sep 2007 12:01:24 +0200
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Bluetooth / WiFi USB concurrency issue
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello Fabien,

Thanks a lot for this !!

> What you experience is bluetooth/wifi coexistence issues.
> Your wifi chip must have bt coexistence support in order to work when 
> their is some bt activity.

I actually use this driver : RT73(RT2571W) Wireless Lan Linux Driver
which is built as rt73.ko kernel module.
I'm currently trying to find how/if the bt_coexist support is managed for 
this device !

Cheers,
Oli 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
