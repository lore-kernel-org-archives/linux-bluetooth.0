Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <C3253C26-5411-4469-9623-4156F952620B@cadvium.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
From: robert <rbscott@cadvium.net>
Date: Sat, 3 Nov 2007 09:03:00 -0700
Subject: [Bluez-devel] Transmitting and Receiving SCO data
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

I am trying to write a program that just sends and receives SCO data,  
and I am running into some problems during the transmit phase.   
Whenever I try to stream out SCO data, the bluetooth dongle is  
disconnected from the system, which sometimes just closes the  
connection, but other times it crashes the whole machine.  (the  
program doing the transmitting inevitably crashes).

Is there something special that is required for sending SCO data?  I  
have looked at all of the test programs and none of them seem to do  
anything odd.  I am limiting the writes to the MTU size on the  
connection, but I am writing multiple times in a row.  (another test  
program seems to do this)

the code is a little convoluted but I can post a link to it if anyone  
is interested.

cheers,
robert


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
