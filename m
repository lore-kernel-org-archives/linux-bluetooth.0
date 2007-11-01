Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <47297E1C.6090903@gmail.com>
Date: Thu, 01 Nov 2007 12:49:56 +0530
From: Mohan Sundaram <mohan.tux@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <47293E85.1050708@vsnl.com>
	<1193893377.32459.111.camel@violet>	<472971D8.60704@gmail.com>
	<1193898729.32459.144.camel@violet>
In-Reply-To: <1193898729.32459.144.camel@violet>
Subject: Re: [Bluez-users] Headset problem
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

Marcel Holtmann wrote:
> that is a strange issue. What does 'hciconfig hci0 version' tells you
> about your dongle?
> 
> Are you sure you are using standard code, because this double name
> resolving is not meant to happen.
> 
> Regards
> 
> Marcel
> 
I'm using std Gutsy and have not installed anything specifically.

root@smohan-laptop:/home/smohan# hciconfig hci0 version
hci0:   Type: USB
         BD Address: 00:16:CF:FB:19:D3 ACL MTU: 1017:8 SCO MTU: 64:8
         HCI Ver: 2.0 (0x3) HCI Rev: 0x20da LMP Ver: 2.0 (0x3) LMP 
Subver: 0x4182
         Manufacturer: Broadcom Corporation (15)
root@smohan-laptop:/home/smohan#

BT dongle is internal USB std with the DELL Inspiron 640M laptop.

Mohan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
