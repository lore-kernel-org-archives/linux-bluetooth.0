Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Cleaning up the D-Bus interface
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <3013cac80512211216r3918594dv676e03480d83f5b3@mail.gmail.com>
References: <1135111693.26233.11.camel@localhost>
	 <3013cac80512211216r3918594dv676e03480d83f5b3@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1135196479.3781.10.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 21 Dec 2005 21:21:19 +0100

Hi Eduardo,

> I agree about the "mode" property. But about Up and Down we have to
> consider issues like security and power save. Will the Off mode
> (nopiscan) be equivalent to device Down in power consumption?

this is implementation specific. On some embedded devices, this might be
the same as deep-sleep. Others might disconnect the device from the bus
or simply call down. The user interface shouldn't have to care about it.

I think that we also need something like a status which shows if the
device is idle, running an inquiry or have active connections.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
