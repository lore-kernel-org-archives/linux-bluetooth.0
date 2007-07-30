Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <0537279F-C314-4CED-A04C-28B306778F87@pi4.informatik.uni-mannheim.de>
To: bluez-devel@lists.sourceforge.net
From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <faerber@pi4.informatik.uni-mannheim.de>
Date: Mon, 30 Jul 2007 18:49:24 +0200
Subject: [Bluez-devel] How to bypass inquiry cache?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

How can I perform non-standard inquiries without caching?

I am using an HCI socket to start my inquiry but the results somehow  
appear to be cached - i.e. the RSSI doesn't change although it  
should, but does after I re-plug the dongle.

We tried setting the two maximum cache age defines in hci_core.c to  
zero but this made the whole inquiry run forever apparently.

Where in the kernel code is such caching handled? I only found the  
cache maintenance functions and inquiry ioctl handling in hci_core.*,  
the  cache updating in hci_event.c and one other reference to the  
cache limit in hci_conn.c - neither of those appeared to override the  
value returned to userland so I must've missed something...

Thanks for any hints!

Andreas

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
