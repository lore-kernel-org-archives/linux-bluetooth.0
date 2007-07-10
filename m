Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Mats Erik Andersson <mats.andersson64@comhem.se>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0707101656280.10834@terminator.picopeta.com>
References: <Pine.LNX.4.64.0707101656280.10834@terminator.picopeta.com>
Date: Tue, 10 Jul 2007 15:03:36 +0200
Message-Id: <1184072616.21280.30.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Problem making bluetooth device locatable
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

Hi Santhosh,

you should add a line to hcid.conf in the device block:

  device {
      ...
      discoverto 0;
      ...
       }

This disables the timer that normally shuts the window
allowing for external discovery. Make "man hcid.conf"
to learn more.

Regards,    Mats E A



tis 2007-07-10 klockan 17:11 +0530 skrev Santhosh N:
> Hi All,
> 
> I have a bluetooth USB dongle connected to our embedded device. I am 
> having problem in making my embedded device locatable by other devices. I 
> am able to scan the list of devices in the vicinity from my device. I have 
> made sure that PSCAN and ISCAN are enabled. Inspite of that my embedded 
> device is not locatable by other devices.
> 
> The output of "hciconfig" is:
> hci0:   Type: USB
>          BD Address: 00:02:72:01:C3:A0 ACL MTU: 192:8 SCO MTU: 64:8
>          UP RUNNING PSCAN ISCAN
>          RX bytes:151 acl:0 sco:0 events:15 errors:0
>          TX bytes:42 acl:0 sco:0 commands:10 errors:0
> 
> Please let me know, how can I proceed further in fixing this issue. I am 
> using linux kernel 2.6.20 and bluez-libs/utils 3.9.
> 
> Thanks in advance,

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
