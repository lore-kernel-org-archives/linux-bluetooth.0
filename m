Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43D4BDDF.5060907@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Inconsistencies in hcitool inq output
References: <20060122205013.dvksy2wkrzk04s08@optimist.hostomega.com>
In-Reply-To: <20060122205013.dvksy2wkrzk04s08@optimist.hostomega.com>
Content-Type: text/plain; charset=us-ascii
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
Date: Mon, 23 Jan 2006 11:28:31 +0000

jwright@hasborg.com wrote:
> antimony:~ $ hcitool inq
> Inquiring ...
>         11:11:11:11:11:12       clock offset: 0x2caf    class: 0x3e0100
>         00:02:72:47:38:FC       clock offset: 0x60c3    class: 0x020300
>         00:60:57:AD:D0:6B       clock offset: 0x691c    class: 0x500204
>         00:02:EE:6E:72:D3       clock offset: 0x1a0e    class: 0x500204
> antimony:~ $ hcitool inq --flush
> Inquiring ...
>         00:02:EE:6E:72:D3       clock offset: 0x1a0f    class: 0x500204
>         11:11:11:11:11:12       clock offset: 0x2caf    class: 0x3e0100
>         00:02:72:47:38:FC       clock offset: 0x60c3    class: 0x020300
>         00:60:57:AD:D0:6B       clock offset: 0x691d    class: 0x500204
> antimony:~ $
> 
> In the 1st scan, the device at 00:02:72:47:38:fc is identified with the same
> class information as the device at 00:60:57:ad:d0:6b.  In the 2nd scan a few
> seconds later, the device is is correctly identified with a class of 0x020300.

Huh. I'm confused. Your description doesn't match your log. If we gather
the results together by device address using:

sort | awk '/clock offset/ {if (a != $1) {printf "\n%s", $1}; a = $1; \
  printf " %s %s", $4, $6} END {printf "\n";}'

we get (if I label the columns):

Address           offset class    offset class
00:02:72:47:38:FC 0x60c3 0x020300 0x60c3 0x020300
00:02:EE:6E:72:D3 0x1a0e 0x500204 0x1a0f 0x500204
00:60:57:AD:D0:6B 0x691c 0x500204 0x691d 0x500204
11:11:11:11:11:12 0x2caf 0x3e0100 0x2caf 0x3e0100

The device 00:02:72:47:38:fc is identified with class 0x020300 in both
scans.

The order in which the devices are reported for the two scans is
different, but that's to be expected, as is the slight change in some
of the clock offsets.

Have I missed something? Did you accidentally post the wrong log?

	- Steven
-- 


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.html


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
