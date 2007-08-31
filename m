Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <cc1649d10708310723h5eff2001sd95a186888e8dc03@mail.gmail.com>
References: <cc1649d10708301947o7fbb805dsfb2a7df83d39ec@mail.gmail.com>
	<1188569227.13373.94.camel@violet>
	<cc1649d10708310723h5eff2001sd95a186888e8dc03@mail.gmail.com>
Date: Fri, 31 Aug 2007 19:56:38 +0200
Message-Id: <1188582998.13373.102.camel@violet>
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

>   I was talking about native code libraries....
> Anyway:
>   The question is is it possible to open and accept RFCOMM and L2CAP
> connections just using D-Bus?

that is a question for your lawyers actually. I tend to say that once
you incluce l2cap.h or rfcomm.h you include GPL code thus your code
becomes GPL, too.

The serial port service however allows you to create RFCOMM connections
and then map them to a serial port on your system. That can be used from
D-Bus. For L2CAP such thing makes no sense.

For OBEX connection at some point the obex-data-server will provide a
D-Bus interface for it.

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
