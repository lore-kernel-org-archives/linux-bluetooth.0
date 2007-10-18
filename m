Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <47179EC5.8080808@cilnu.com>
Date: Thu, 18 Oct 2007 18:58:29 +0100
From: Jon Maber <jon@cilnu.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] LED Output Reports to Keyboard
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

Right place to talk about the Bluez source code that is now in the Linux 
Kernel? Hope so.

In essence: testing with kernel 2.6.22, it seems to me that LED 
information is sent to bluetooth devices using the boot protocol 
regardless of whether the boot protocol is active and even if the device 
explicitly declares that it doesn't support boot protocol.



In detail:  I'm designing a Bluetooth keyboard device which has some 
LEDs which are for customised use.   This means that they have ID 
numbers that cannot be represented in the boot protocol keyboard output 
report.  So, the device has a customised report descriptor. The first 
byte of the output report is the same as the boot protocol but a second 
byte is added containing eight more LED flags. 

I'm testing my device on a laptop running Fedora Core 6 with kernel 
2.6.22.  Digging in the kernel source code I found that the LED output 
reports are sent from the function hidp_queue_event in the source file 
net/bluetooth/hidp/core.c.  I added an extra line for debugging;

    BT_DBG("Sending keyboard boot protocol LED output report. Session is 
in %s mode.",
        ((session->flags & (1 << 
HIDP_BOOT_PROTOCOL_MODE))?"boot":"report") );

which confirms that the HIDP module has correctly understood from my 
service record that boot protocol mode is not set.  The rest of this 
function however sends a hard wired boot protocol frame and therefore 
ignores completely any LED events that cannot be represented.  In fact 
for my customised LEDs no frame is sent at all since to this function it 
seems that no significant LED has changed state.

By the way, I also use a customised input report for key presses which 
is handled perfectly O.K.

First question: can anyone tell me that the more unusual LED events do 
get through to their Bluetooth keyboard when using Linux?  It is of 
course possible that I've messed up my Service Record and all of the 
above is a load of tosh.

Second question: actually I'll not dive into a load more questions about 
fixing the bug until I know that I've actually found one.

Jon


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
