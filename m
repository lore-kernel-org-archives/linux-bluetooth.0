Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1139819179.5547.7.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Deprecating some hcid.conf options
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
Date: Mon, 13 Feb 2006 09:26:19 +0100

Hi,

while working on the D-Bus interface, I came along some unneeded complex
functionality inside hcid and its configuration options. The questions
is now what options are really used and what haven't been changed by
anyone.

Does someone uses hcid with autoinit disabled?

What about the security and pairing option? What do we really need?

The iscan and pscan will combined into a new mode option.

Changing the pkt_type is useless and will be removed no matter what.

The auth and encrypt options will also be removed, because we don't
support security mode 3 anymore.

Do we need link policy setting or should hcid calculate the best setting
from the supported features?

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
