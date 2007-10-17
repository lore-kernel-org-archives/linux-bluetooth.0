Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200710170839.22891.thilo@riessner.de>
References: <200710170839.22891.thilo@riessner.de>
Date: Wed, 17 Oct 2007 16:21:34 +0200
Message-Id: <1192630894.6184.20.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] HP Bluetooth PC Card Mouse doesn't work
	after	upgrade to openSuSE 10.3
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

Hi Thilo,

> my HP Bluetooth PC Card Moue, worked fine under openSuSE 10.2 after I 
> added --connect 00:02:76:00:D0:3E to the hidd option (in the 
> file /etc/sysconfig/bluetooth). But after upgrade to 10.3 this trick doesn't 
> work any more. I tryed to to remove the pionting device and create it new. 
> But than I have to switch the mouse in discorvery more. Is there any hint how 
> to solve the problem?

the openSuSE 10.3 should use the input service. Check the wiki.bluez.org
for details on how to configure devices. You only need to do that once
btw. and then the mouse will re-connect.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
