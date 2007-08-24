Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Matthias Becker <matthias.becker@beyondsoft.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <8de6c3e20708231340j439ca230i487e816693149441@mail.gmail.com>
References: <2EB6297382462046A9427D7324788A480217D35A@MCLNEXVS06.resource.ds.bah.com>
	<8de6c3e20708231340j439ca230i487e816693149441@mail.gmail.com>
Date: Fri, 24 Aug 2007 16:06:33 +0200
Message-Id: <1187964393.5121.10.camel@matthias.BEYONDSOFT.local>
Mime-Version: 1.0
Subject: [Bluez-devel]  multithreaded name resolution
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

I tried to read the name of different devices parallel using multi
threading, but without success. If there is one bluetooth device I works
(as there is no real multi threading). If there are who devices, the
same name is reported for both devices. In another test with 6 devices
hci_read_remote_name returned something <0 so I did not get any name at
all.

hcitool scan --flush
Scanning ...
        00:1A:89:6F:DE:EE       Nokia 5300
        00:19:63:9D:09:16       K800i

My multithreaded tool:

00:19:63:9D:09:16       K800i
00:1A:89:6F:DE:EE       K800i


When I don't start multiple threads but do it single threaded everything
works fine, and my code should be absolutly threadsafe.

Is this a bug in BlueZ or was it never supposed to work parallel?

When I run hcidump -V  I see that the right names are recived:
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1A:89:6F:DE:EE name 'Nokia 5300'
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:19:63:9D:09:16 name 'K800i'


-- Matthias


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
