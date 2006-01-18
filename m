Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] patch: custom devup script
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43CD92AE.20006@fillibach.de>
References: <43C29249.3020008@fillibach.de>
	 <1136909256.7200.6.camel@localhost.localdomain>
	 <43CD92AE.20006@fillibach.de>
Content-Type: text/plain
Message-Id: <1137590415.27515.17.camel@localhost>
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
Date: Wed, 18 Jan 2006 14:20:15 +0100

Hi Kosta,

> As my zeroconf implementation is incomplete (only generates an IP 
> address, but does not check for conflicts), I instead added an option to 
> run a custom devup script instead of /etc/bluetooth/pan/dev-up.
> 
> Why? Because the mobile phone running embedded linux has a read-only 
> /etc. This way, I can move my devup-script anywhere I want, without 
> needing to recompile if its location changes.

your email client eats all the whitespaces and tabs. Please resend it
and attach it this time or use another (working) email client.

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
