Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <cc1649d10708311345w6cc50a72w41bc43d43db9e683@mail.gmail.com>
References: <cc1649d10708301947o7fbb805dsfb2a7df83d39ec@mail.gmail.com>
	<1188569227.13373.94.camel@violet>
	<cc1649d10708310723h5eff2001sd95a186888e8dc03@mail.gmail.com>
	<1188582998.13373.102.camel@violet>
	<cc1649d10708311345w6cc50a72w41bc43d43db9e683@mail.gmail.com>
Date: Fri, 31 Aug 2007 23:01:25 +0200
Message-Id: <1188594085.10148.8.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] JSR-82 using D-Bus
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Vlad,

> So basically I'm coming to this conclusion:
>   To make BlueZ support for BlueCove I need to create GPL jar and .so
> for BlueZ that would accompany main BlueCove.jar (LGPL).
>   I will try to use discovery and management using D-Bus....
>   So BlueCove-Bluez.jar will link with BlueCove.jar not the other way around.

not sure that this will make you GPL compliant. Once you link it
together the whole software becomes GPL. Ask a lawyer or contact the
Free Software Foundation. I am serious about it. My word is worth
nothing in this regard.

> BWT regarding lawyers
>  How come You have this page: http://www.bluez.org/jsr82.html
>   "Impronto Developer Kit" and  "Avetana JSR-82"  are not GPL but they
> need to include l2cap.h and rfcomm.h to the native code.

No idea. Never checked their source code. While I am open for
suggestion's to support JSR-82 the best, I don't care that much because
I am not a big Java fan.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
