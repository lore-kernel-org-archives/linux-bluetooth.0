Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 24 Jul 2007 19:39:14 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070724193914.60620170@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Bluetooth pairing problems with Zeevo chipsets
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

I cannot pair my ipaq 2210 (with Zeevo TC2100P chip attached via hciattach and familiar 0.8.4 distro, kernel 2.6.15-hh2)
and my cellular phone nokia 6230i. Doing some research
I found out that my phone does not like unit keys and the ipaq
uses them. On pocketpc these problems also exist. But there is
a bluetooth security update which somehow enables the use of
combination keys until the next hard reset.
But... how to fix that on linux?


Here are some logs:

When paring the two devices:
> HCI Event: PIN Code Request (0x16) plen 6  
    bdaddr xx:xx:xx:xx:xx:xx
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr xx:xx:xx:xx:xx:xx len 4 pin '0000'
> HCI Event: Command Complete (0x0e) plen 10  
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr xx:xx:xx:xx:xx:xx
> HCI Event: Link Key Notification (0x18) plen 23  
    bdaddr xx:xx:xx:xx:xx:xx key xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx type 1
> HCI Event: Disconn Complete (0x05) plen 4  
    status 0x00 handle 0 reason 0x29
    Reason: Pairing with Unit Key Not Supported

Version query:

< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 1.1 (0x1) HCI Revision: 0x8d
    LMP Version: 1.1 (0x1) LMP Subversion: 0x8d
    Manufacturer: Zeevo, Inc. (18)

hcitool cmd 3 0xd:

< HCI Command: Read Stored Link Key (0x03|0x000d) plen 0
    bdaddr 00:00:00:00:00:00 all 0
> HCI Event: Command Status (0x0f) plen 4
    Read Stored Link Key (0x03|0x000d) status 0x01 ncmd 1
    Error: Unknown HCI Command


some citations about the problem on pocketpc:

Some citations:

from: http://www.ppc-welt.info/community/archive/index.php/t-45005.html
"This is a Hardware issue and not a software issue related to the
WIDCOMM BTW-CE Product. The reason for this problem is as follows:

There are two types of keys that can be used for pairing:
- Combination keys
- Unit keys

The key type that is used is pre-set in the Bluetooth Radio Firmware. The WIDCOMM BTW-CE Bluetooth software does not control this setting. The radio on the iPaq 1940 uses unit keys by default. The Nokia 6820 phone rejects the use of unit keys in pairing because it is not as secure as combination keys.

This issue has been reported with Nokia 6820 and 6230 phones when
attempting to pair with the iPaq 1940 or 2210 PDA."


On:
http://h20000.www2.hp.com/bizsupport/TechSupport/SoftwareDescription.jsp?lang=en&cc=us&prodTypeId=0&prodSeriesId=322898&swItem=PSG_I21093-105126&prodNameId=296099&swLang=8&taskId=135&mode=4&idx=0

"Adds support for Combination Key. Some Bluetooth devices require
Combination Key support in orde to pair with the handheld device."

So what can be done to achive the same on linux?
Thank you in advance for your answers.

Greetings
Andreas Kemnade

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
