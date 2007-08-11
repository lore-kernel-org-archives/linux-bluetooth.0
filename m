Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <525899.68874.qm@web58013.mail.re3.yahoo.com>
References: <525899.68874.qm@web58013.mail.re3.yahoo.com>
Date: Sat, 11 Aug 2007 20:15:12 +0200
Message-Id: <1186856112.6698.31.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] configure: error: dbus > 0.35 is requered
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

Hi,

> I am using bluez-utils-3.11 for ARM embedded linux.
> When hcid is buildt, it complains libdbus-1.so
> 
> /usr/lib/libdbus-1.so: could not read symbols: File in
> wrong format.
> 
> Because embedded linux kernel version is awalys behind
> the most recent released kernel.

the libdbus has nothing to do with the kernel version. However stop
whining about embedded kernel versions. Use the latest upstream kernel
and not some vendor crap.

> And I could not find old versions for bluez in
> www.bluez.org.
> 
> What version of libdbus needed to match
> bluez-utils-3.13 or 11?

Use the D-Bus 1.0.x release.

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
