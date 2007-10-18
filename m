Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thilo Riessner <thilo@riessner.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Thu, 18 Oct 2007 12:05:23 +0200
References: <200710170839.22891.thilo@riessner.de>
	<200710171804.10464.thilo@riessner.de>
	<1192640778.6184.37.camel@violet>
In-Reply-To: <1192640778.6184.37.camel@violet>
MIME-Version: 1.0
Message-Id: <200710181205.24046.thilo@riessner.de>
Subject: Re: [Bluez-users]
	=?iso-8859-1?q?HP_Bluetooth_PC_Card_Mouse_doesn=27t?=
	=?iso-8859-1?q?_work=09after=09upgrade_to_openSuSE_10=2E3?=
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

Am Mittwoch, 17. Oktober 2007 schrieb Marcel Holtmann:
> Hi Thilo,
>
> > > > my HP Bluetooth PC Card Moue, worked fine under openSuSE 10.2 after I
> > > > added --connect 00:02:76:00:D0:3E to the hidd option (in the
> > > > file /etc/sysconfig/bluetooth). But after upgrade to 10.3 this trick
> > > > doesn't work any more. I tryed to to remove the pionting device and
> > > > create it new. But than I have to switch the mouse in discorvery
> > > > more. Is there any hint how to solve the problem?
> > >
> > > the openSuSE 10.3 should use the input service. Check the
> > > wiki.bluez.org for details on how to configure devices. You only need
> > > to do that once btw. and then the mouse will re-connect.
> >
> > I tried that already, but it doesn't work for me, at least not
> > satisfying. The reconnect does not work. Should the hidd still run, and
> > if yes, which options should it be given? I guess "--connect
> > 00:02:76:00:D0:3E" is not needed any more? But maybe --master and/or
> > --server?
>
> no, go with the input service. It should work.
>
> Regards
>
> Marcel
Thanks for your information so far. But still the mouse doesn't work. There 
seems to be a kind of connection between the mouse and the notebook (the 
kbluetooth icon in the system tray gets blue and lists the hp-mouse as 
connected), but the LED of the mouse remains dark, and it simply does not 
work. As I said, it used to work with openSuSE 10.2 and hidd.

Thilo  

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
