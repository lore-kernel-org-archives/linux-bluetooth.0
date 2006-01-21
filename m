Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS] remote name patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0601201037y4d6eccdem6a9cbca135196520@mail.gmail.com>
References: <e1effdeb0601201037y4d6eccdem6a9cbca135196520@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1137808123.20856.122.camel@localhost>
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
Date: Sat, 21 Jan 2006 02:48:43 +0100

Hi Claudio,

> The attached patch improves the remote name request. It's the same
> approach of "hcitool name", I am using the textfile library. Maybe we
> should move the function "get_device_name" to a common place, like
> "libtextfile.a" or create a new utility library(ie: "libbluezutil.a").

before I pick up this patch, we might wanna discuss the three different
kinds of device names we will have in the future. The full remote name
of a device, the local cached name and then the name (shorted or full)
from the extended inquiry. How do we deal with them? Do we wanna give
the user of the D-Bus API any chance to distinguish between them?

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
