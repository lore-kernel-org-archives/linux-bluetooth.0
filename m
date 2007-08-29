Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <003401c7ea0d$05ef6d00$0200000a@psg>
From: "psg" <psg@ki.net.pl>
To: <bluez-users@lists.sourceforge.net>
Date: Wed, 29 Aug 2007 09:20:05 +0200
MIME-Version: 1.0
Subject: [Bluez-users] PAN communication dies
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

Hello!

I am quite new to Bluetooth and BlueZ, especially under Linux. And I have
come to a problem.

My communication gets stuck when I want to send more data. That is to say
sending larger packets or just when browsing through Internet.
Everything works fine when I try regular small ping:
--------------------
...
Reply from 10.0.0.5: bytes=120 time=47ms TTL=128
Reply from 10.0.0.5: bytes=120 time=51ms TTL=128
...
--------------------
It can go with no errors forever.

But when I increase packets size for example to 1200 bytes, communication
gets jammed:
--------------------
Pinging 10.0.0.5 with 1200 bytes of data:
Request timed out.
...
--------------------
Although in hcidump I see those packets as being completed they don't get to
their destination.:
--------------------
< ACL data: handle 1 flags 0x02 dlen 1021
< ACL data: handle 1 flags 0x01 dlen 220
    L2CAP(d): cid 0x004f len 1237 [psm 0]
...
> HCI Event: Number of Completed Packets (0x13) plen 6
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 6
    handle 1 packets 1

--------------------
Moreover afterwards I can't send anything (even smaller packets). I need to
restart Bluetooth and create NAP from the beginning.

What is more important when I connected the very same two bluetooth devices
between two WindowsXP computers I was able to send packets up to 12000bytes,
with of course increase in ping times, but wth no "Request timed out" and
hanging of the device etc.

If you have any idea how to solve this issue I would appreciate this.
TIA

RGDS PSG


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
