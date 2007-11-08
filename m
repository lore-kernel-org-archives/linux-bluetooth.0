Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <194c6ea30711072228t74e00705ub785d74a8de77c29@mail.gmail.com>
Date: Thu, 8 Nov 2007 14:28:16 +0800
From: "dong yan" <semiydsemiyd@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Does BlueZ 3.22 support SPP profile?
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

Hi All:
    im about to use bluez3.22 to connect my development-board with a
GPS module that supports SPP.
   Does BlueZ3.22 support the SPP profile? I read on the wiki of
bluez.org that the protocol stack supports serial service(RFCOMM).
Also,after i cross-compiled bluez-utils-3.22,there's a program named
"bluetoothd-service-serial" which seems like a demon handles all the
serial service.This programme is initiated by hcid when the system
starts.     But the SPP profile is based on the RFCOMM service.(maybe
im wrong?) So supporting serial service/rfcomm doesn't necessarily
means it supports SPP?

If bluez do supports SPP,how can i use it ?


Thanks for any help!


semiyd

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
