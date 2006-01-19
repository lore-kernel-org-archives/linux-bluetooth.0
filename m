Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43CF9800.6050005@dgreaves.com>
From: David Greaves <david@dgreaves.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] No audio with Nokia HDW-3
References: <43CF16E5.1020406@blueyonder.co.uk>
In-Reply-To: <43CF16E5.1020406@blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 19 Jan 2006 13:45:36 +0000

Sid Boyce wrote:

> I've been battling with the HDW-3 since 2.6.15 on SuSE 10.0 x86_64,
> the device is recognised. 

<snip>

> I also tried with a2play.
> Any ideas welcomed.
> Regards
> Sid.

what does:
  hciconfig hci0 revision
show?

(I had this exact problem with my dongle.
I bought a new usb dongle (CS base) and it all works fine...)

David


-- 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
