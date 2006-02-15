Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Unsafe handling of -e option in pand
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43F2F577.6090804@ubuntu.com>
References: <43F2E0C4.4040204@ubuntu.com>
	 <1139991875.26072.14.camel@localhost>  <43F2F577.6090804@ubuntu.com>
Content-Type: text/plain
Message-Id: <1139997734.26072.32.camel@localhost>
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
Date: Wed, 15 Feb 2006 11:02:14 +0100

Hi Charles,

> While we at that, there is another possible vuln...
> 
> http://www.securityfocus.com/archive/1/archive/1/424133/100/0/threaded
> 
> Tested in Ubuntu bluez-utils-2.24 and 2.20
> 
> Any fix ideas?

it is already fixed in the CVS, but don't get me started on this one
again. However to remind people. The hcidump tool is a development tool
and not for daily use in any production system. Non of the parsers are
bullet proof and actually never will be. The Bluetooth code inside the
Linux kernel however is robust against these kind of attacks.

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
