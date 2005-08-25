Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <430D4681.80609@gulik.org>
From: Gregory Gulik <greg@gulik.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Trouble with D-LINK adapter w/Treo 650 and FC4
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 24 Aug 2005 23:18:09 -0500


I've been trying to follow the instructions to get a D-LINK DBT-120 
Bluetooth adapter to work with Fedora Core 4 using a Treo 650 PalmOS 
phone on the Sprint network.

I've been battling it for a while and since I'll be traveling a lot very 
soon (the reason I'm trying to get this working) and I'm running out of 
time so I'm asking for help.

Basically, the instructions I'm following are these:

http://www.gurulabs.com/goodies/Using_Linux_and_Bluetooth_DUN_with_the_Treo650.php

Everything went fairly well except when I finally try to bring up the 
PPP connection I get an error:

[root@dell8100 bluetooth]# ifup treo
Failed to activate treo with error 7

/var/log/messages reports the following details:

Aug 24 23:13:16 dell8100 ifup-ppp: pppd started for treo on /dev/rfcomm0 
at 115200
Aug 24 23:13:16 dell8100 pppd[30712]: pppd 2.4.2 started by root, uid 0
Aug 24 23:13:17 dell8100 hcid[30014]: link_key_request 
(sba=00:13:46:47:64:27, dba=00:07:E0:03:D3:99)
Aug 24 23:13:18 dell8100 pppd[30712]: Failed to open /dev/rfcomm0: 
Connection reset by peer
Aug 24 23:13:18 dell8100 pppd[30712]: Exit.


FYI:
00:13:46:47:64:27 is my D-Link Bluetooth adapter
00:07:E0:03:D3:99 is my Treo 650

I tried to follow some of the other diagnostics I found on the list to 
no avail:

# l2ping 00:07:E0:03:D3:99
Ping: 00:07:E0:03:D3:99 from 00:13:46:47:64:27 (data size 20) ...
Recv failed: Connection reset by peer

During that time /var/log/messages reported the following:

Aug 24 23:14:14 dell8100 hcid[30014]: link_key_request 
(sba=00:13:46:47:64:27, dba=00:07:E0:03:D3:99)


If I try to scan for the phone it DOES appear to be found:

# hcitool scan
Scanning ...
         00:07:E0:03:D3:99       MYTREO


One thing I noticed is that when I remove the /etc/bluetooth/link_key 
and then try to start PPP the phone asks me for my PIN again.  I put it 
in and that time it seems to open the /dev/rfcomm0 port.  It then tries 
to send AT commands which don't respond so it times out and fails.


Help!



-- 
Greg Gulik                                 http://www.gulik.org/greg/
greg @ gulik.org



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
