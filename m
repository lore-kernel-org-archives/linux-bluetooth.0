Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: fabchevalier@free.fr
In-Reply-To: <1193595313.4724d1b17e3bf@imp.free.fr>
References: <1193591164.4724c17c545eb@imp.free.fr>
	<1193595382.5096.15.camel@aeonflux>
	<1193595313.4724d1b17e3bf@imp.free.fr>
Date: Sun, 28 Oct 2007 20:40:24 +0100
Message-Id: <1193600424.4516.1.camel@aeonflux>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH 1/3] move common exceptions to
	common/	directory
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fabien,

> > I like to have org.bluez.Error only. There is no need to get an extra
> > hierarchy level.
> >
> 
> That's basically how things are today... however if have no objection if you
> want to change that...

it is this way, because it was the easiest way. I want one
org.bluez.Error to handle all error cases.

> Btw did you have a look at the  send_message_and_unref ==>
> dbus_connection_send_and_unref patch ? Is it ok for you ? (Aven't tested but i
> think those three patches may depend on it)

Not really. I leave this to Johan, since he worked on most of common/
stuff.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
