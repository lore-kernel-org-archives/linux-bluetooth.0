Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS] remote name patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602090555u507a1567tb0b3dcb8b1369f1a@mail.gmail.com>
References: <e1effdeb0601201037y4d6eccdem6a9cbca135196520@mail.gmail.com>
	 <1137808123.20856.122.camel@localhost>
	 <e1effdeb0601230833t25905a64he7ca62c7d1ab48cf@mail.gmail.com>
	 <1138036115.7327.14.camel@localhost>
	 <e1effdeb0601231054q2a3e1ec1q6f0e2c90a48c05e3@mail.gmail.com>
	 <1138047251.3750.6.camel@localhost.localdomain>
	 <e1effdeb0601260609n644c313u91d193b8f5df89bb@mail.gmail.com>
	 <1138298602.5901.78.camel@localhost>
	 <e1effdeb0602090555u507a1567tb0b3dcb8b1369f1a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1139500618.17280.30.camel@localhost>
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
Date: Thu, 09 Feb 2006 16:56:58 +0100

Hi Claudio,

> According with your request, I am sending the patch again.
> The function get_device_name should be moved to a common library.

we maybe need to create a storage plugin which can be replaced very
easily, but for now it is fine.

> Basically, this patch try retrieve the remote name from the
> cache(names file) instead of send the HCI command everytime.

The pscan_rep_mode must be 0x02 if you don't have any cached value from
an inquiry result. I fixed it and committed it to the CVS.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
