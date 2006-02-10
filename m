Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Motorola V620 phone and bluetooth PIN pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <loom.20060210T014446-0@post.gmane.org>
References: <loom.20060210T014446-0@post.gmane.org>
Content-Type: text/plain
Message-Id: <1139580731.17017.7.camel@localhost>
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
Date: Fri, 10 Feb 2006 15:12:11 +0100

Hi Stephane,

> I have a Motorola V620 phone which provides Bluetooth support, and a working
> Bluetooth USB dongle.
> Phone -> PC and PC -> Phone transfers work correctly, but whenever I try to
> create a rfcomm connection to the phone, I get a "Connection refused" error
> message.
> This is how I setup the RFCOMM:
> 
> $ sudo rfcomm bind 0 00:15:A8:3B:EA:F0 1
> $ sudo rfcomm
> rfcomm0: 00:15:A8:3B:EA:F0 channel 1 clean
> 
> When I try to do a simple command on /dev/rfcomm0 the command freezes, or 
> I get a "connection refused" message.
> 
> $ echo AT > /dev/rfcomm0
> (After waiting some time, I press Ctrl-C)
> bash: /dev/rfcomm0: Interrupted system call
> 
> or
> 
> $ cat /dev/rfcomm0
> cat: /dev/rfcomm0: Connection refused
> 
> I tried to do a hcidump and it stucks on the line:

run "hcidump -X -V" as root in another terminal window.

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
