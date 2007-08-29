Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Nitin Mahajan <nitinm76@yahoo.com>
In-Reply-To: <244253.57477.qm@web50108.mail.re2.yahoo.com>
References: <244253.57477.qm@web50108.mail.re2.yahoo.com>
Date: Wed, 29 Aug 2007 15:54:22 +0200
Message-Id: <1188395662.6109.48.camel@violet>
Mime-Version: 1.0
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] BlueZ APIs
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

Hi Nitin,

> Thanks for your inputs, is that possible I can use the BlueZ without D-BUS also?

you could use libbluetooth directly to access HCI, but you really don't
wanna do that. It is like working with plain IP packets instead of TCP
and you will do a lot of things wrong. In some cases the kernel or hcid
will not even allow you certain changes and simply go ahead and
overwrite them. The D-Bus API is the only one that makes sense, because
it takes care of a lot of things you normally don't think about. Trust
me on this one. We spent a lot of time in getting this right.

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
