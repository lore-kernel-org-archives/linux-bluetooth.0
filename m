Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <e96e9eeb0706040544v2410d8e8t25a3708cfb345130@mail.gmail.com>
References: <e96e9eeb0706040544v2410d8e8t25a3708cfb345130@mail.gmail.com>
Date: Mon, 04 Jun 2007 17:19:56 +0200
Message-Id: <1180970396.13429.47.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] minimal bluez setup
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

Hi Voni,

> i managed to cross compile bluez 3.11 to my platform.
> 
> i want to ask what is the minimum commands i need to run bluez ?
> i thought of :
> 
> /usr/bin/dbus-daemon
> /usr/sbin/hcid
> /usr/sbin/sdpd
> 
> is it ok ? or do i need more processes (dbus have a lot.. but i want only
> what bluez needs) ?
> 
> do i need some special command line arguments to bluez or dbus ?

the sdpd is obsoleted. Start hcid with -s to have the included SDP
server.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
