Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH] msg_func_device: wrong request
	handling for unknow methods
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602220912k39f3f9d0g627bca665e0c4dad@mail.gmail.com>
References: <e1effdeb0602220912k39f3f9d0g627bca665e0c4dad@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140630269.4519.29.camel@localhost>
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
Date: Wed, 22 Feb 2006 18:44:29 +0100

Hi Claudio,

> Here is a patch to fix the function msg_func_device.
> 
> While Eduardo was fixing the dbus-test script he noticed a strange
> reply value. The daemon was returning two consecutives error
> messages(unknow method and unknow path) for services   not implemented
> in the path.
> 
> This bug happens due the registered fallback path associated with the
> wrong return value. The "/org/bluez/Device/hciX" was returning unknow
> method and the root path "/org/bluez/Device" was returning unknow
> path.

patch has been applied. Thanks.

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
