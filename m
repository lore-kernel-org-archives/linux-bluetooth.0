Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20070828T143052-133@post.gmane.org>
References: <c669a7c70708240036j38c8f42bhdcdb5ee15a8ae4be@mail.gmail.com>
	<1187943850.15402.129.camel@violet>
	<000001c7e74d$e4e21bb0$aea65310$@com>
	<loom.20070828T143052-133@post.gmane.org>
Date: Tue, 28 Aug 2007 14:44:51 +0200
Message-Id: <1188305091.19382.1.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problem in parking device. bluez-libs	3.14,
	bluez-utils-3.14
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

Hi Mahin,

> I want to use park mode to connect more than seven devices.
> Can I use sniff mode in the same way?

no you can't, but you might also not be able to park more than seven
devices. Ask your chip manufacturer if they support it. While the
specification allows it, most chip manufacturer limit the number of
device within a piconet (active or not) to seven. This mainly to due
memory restrictions.

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
