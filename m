Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060122205013.dvksy2wkrzk04s08@optimist.hostomega.com>
From: jwright@hasborg.com
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Subject: [Bluez-users] Inconsistencies in hcitool inq output
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 22 Jan 2006 20:50:13 -0500

I've noticed inconsistencies in hcitool output for various functions including
friendly name resolution and device classification:

antimony:~ $ hcitool inq
Inquiring ...
        11:11:11:11:11:12       clock offset: 0x2caf    class: 0x3e0100
        00:02:72:47:38:FC       clock offset: 0x60c3    class: 0x020300
        00:60:57:AD:D0:6B       clock offset: 0x691c    class: 0x500204
        00:02:EE:6E:72:D3       clock offset: 0x1a0e    class: 0x500204
antimony:~ $ hcitool inq --flush
Inquiring ...
        00:02:EE:6E:72:D3       clock offset: 0x1a0f    class: 0x500204
        11:11:11:11:11:12       clock offset: 0x2caf    class: 0x3e0100
        00:02:72:47:38:FC       clock offset: 0x60c3    class: 0x020300
        00:60:57:AD:D0:6B       clock offset: 0x691d    class: 0x500204
antimony:~ $

In the 1st scan, the device at 00:02:72:47:38:fc is identified with the same
class information as the device at 00:60:57:ad:d0:6b.  In the 2nd scan a few
seconds later, the device is is correctly identified with a class of 0x020300.

Any thoughts on why this happens, or recommendations for troubleshooting? 
Unfortunately, I didn't catch this with hcidump. :(

Thanks,

-Josh


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
