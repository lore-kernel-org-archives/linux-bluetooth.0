Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Alok <develnewbie@gmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 16 Aug 2007 19:07:13 +0530
Message-Id: <1187271433.6440.18.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] Help regarding TI's Bluetooth chips.
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

Hi, 

I am working on bluetooth on OMAP 850(fsample) board.
The Bluetooth chip is BRF6150 2.12 FW 3.0.48.
The Host Control Interface used is UART.
I came across this post:
http://sourceforge.net/mailarchive/message.php?msg_id=200704301139.44842.ohad%40bencohen.org 

I need to send a .bts to the BT chip for initialization. 
I am using the following patch for it: 
 http://article.gmane.org/gmane.linux.bluez.devel/5168

I want to get a2dp up on this chip. 

I had the following queries: 

1. Is HCILL critical for TI's BT chips? 

2. Has anyone tried a2dp on the brf63xx/brf61xx ? If so what is the
minimum baud rate that is required ? 

3. I have currently selected the H4 driver. Do i need to select the bcsp
driver instead? What is the difference betweent the two?


Thanks, 
Alok.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
