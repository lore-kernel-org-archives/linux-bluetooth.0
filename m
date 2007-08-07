Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <72022.81167.qm@web32403.mail.mud.yahoo.com>
References: <72022.81167.qm@web32403.mail.mud.yahoo.com>
Date: Tue, 07 Aug 2007 10:04:00 +0200
Message-Id: <1186473840.20129.44.camel@violet>
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

> I'm trying to get bluetooth working om my Absolute-box. Hope I'm doing
> the right things,  to me  it's a bit confusing what to do to get
> things working properly.
> 
> Now I'm trying to install the bluez-libs and bluez-utils. Think
> bluez-libs went well, but bluez-utils gives error when configuring.
> 
> Searched into old posts, but couldn't find the solution (think due to
> my lack of knowledge).
> 
> Don't think dbus is installed on my system, but what confuses me most,
> is that it seems to me that part of the installation is installing
> dbus (isn't it in the  dir 'common'?). 

you have to install the low-level D-Bus library libdbus and its
development files. This is a hard requirement.

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
