Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 14 Aug 2007 23:16:33 +0200
From: Michael Mauch <michael.mauch@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070814211632.GC14110@elmicha>
References: <mailman.223268.1187020437.21973.bluez-users@lists.sourceforge.net>
	<811023.94565.qm@web58008.mail.re3.yahoo.com>
MIME-Version: 1.0
In-Reply-To: <811023.94565.qm@web58008.mail.re3.yahoo.com>
Subject: Re: [Bluez-users] error for bluez-utils -3.11 configure
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

hong zhang wrote:

> I am building bluez-libs-3.11 and bluez-utils-3.11 on
> my fedora 5.
> Configure and make on bluez-libs-3.11 successfully.
> And "make install"  goes through.
> 
> But when I do configure for bluez-utils-3.11. Error
> occurs.
> 
> checking for pkg-config... /usr/bin/pkg-config
> checking pkg-config is at least version 0.9.0... yes
> checking for BLUEZ... no
> configure: error: Bluetooth library is required
> 
> bluez-libs-3.11 is installed why Bluetooth library
> cannot be found?

Perhaps you forgot to add /usr/local/lib to /etc/ld.so.conf (if it's not
already there) or you forgot to run ldconfig.

Regards...
		Michael

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
