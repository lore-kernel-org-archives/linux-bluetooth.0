Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43E2F126.9040605@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: btsco occasional loud bursts of static
References: <43E2BD4E.7060905@purdue.edu>
In-Reply-To: <43E2BD4E.7060905@purdue.edu>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 02 Feb 2006 22:59:02 -0700

Chase

> I'd love to hlp in any way I can. I'm not sure where this code is that you
> wrote of. Could you point me in the right direction? Also, I am going to
> need
> some kind of documentation on the sco protocol. Do you know where I
> could find
> these?

This is currently all in the kernel.

In the btsco project, you'll see in kernel/btsco.c where sock_recvmsg()
gets data from the set and is followed immediately by some
AUTO_FIXUP_BYTESHIFT code. This is the workaround for the problem.

The sco generic transport is implemented in the kernel source in
drivers/net/bluetooth/sco.c.

The hardware interaction is in net/bluetooth/hci_{conn,core,event}.c and
I suspect this is where things may need work. This is also where hacks
for broadcom sco would probably end up.

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
