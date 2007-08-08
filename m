Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Mats Erik Andersson <mats@blue2net.com>
To: List Bluez users <bluez-users@lists.sourceforge.net>
Date: Wed, 08 Aug 2007 11:04:00 +0200
Message-Id: <1186563840.4744.52.camel@Blue2net-mats.bellman.mea>
Mime-Version: 1.0
Subject: [Bluez-users] My netdev_watchdog barked once!
Reply-To: mats.andersson@blue2net.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello all,

I had yesterday a surprising kernel message

   NETDEV WATCHDOG: bnep0: transmit timed out

It occurred exactly once and then never more.
This happened on a FOXBoard with an Etrax100LX,
i.e. cris architecture, almost exactly twenty
four hours after the bnep link was initiated.
The kernel is 2.6.19, with bluez code seemingly
identical to the code in 2.6.18-mh8, but that
is beside my present point. 

My question: Is it more probable that it is the
usb driver that has a suboptimal timer use within
the kernel, or could it be that bnep/core.c or
bnep/netdev.c somehow should take timing of a
particular usb interface into account? The regular
kernel documentation mentions that the ethernet
driver e1000.ko can have a timer issue. That is how
I come to think along these lines.

The remarkable aftermath is that after the isolated
barking of my watchdog, the bnep link transmitted
in a fragmented manner (like spikes viewed with gkrellm)
for three hours, and then magically recovered again
and is now running for an additional twenty four hours.
The only extraneous log message for bluez in these
forty eight hours, is that singular "NETDEV WATCHDOG" call.
The FOXBoard is the PANU-side, and on the NAP-side the
logging is completely silent!


Thanks for your attention and presumptive remarks.

Mats Erik Andersson, PhD

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
