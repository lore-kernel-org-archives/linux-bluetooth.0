Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH] scan mode
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602130950x5834aa71lb6eeeec3fc5bb4cd@mail.gmail.com>
References: <e1effdeb0602130950x5834aa71lb6eeeec3fc5bb4cd@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1139902844.21873.2.camel@localhost>
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
Date: Tue, 14 Feb 2006 08:40:44 +0100

Hi Claudio,

> This patch add/fix the following services:
> 1. Changed GetMode/SetMode arguments to string, instead of use byte
> 2. Added IsConnectable
> 3. Added IsDiscoverable

I applied the patch to keep it going, but we need to rework the data
object associated with the device path. Using it like this

	const uint8_t hci_mode = dbus_data->path_data;

won't work forever and actually it is bad coding.

> Next action:
> - Discoverable timout functions.

Go ahead. I really like to see this in action.

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
