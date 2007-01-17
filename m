Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-Id: <45AE1538.5301.0014.0@novell.com>
Date: Wed, 17 Jan 2007 12:26:24 -0700
From: "Olin Atkinson" <oatkinson@novell.com>
To: <bluez-devel@lists.sourceforge.net>
Mime-Version: 1.0
Subject: [Bluez-devel] I got plugz to compile but now there is no sound on
	the	headset after connecting
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I got plugz to compile by building bluez-libs but now after I connect I cannot get any audio to the headset.

after i run headsetd I run
aplay -B 1000000 -D headset /home/oatkinson/audiobuff.wav

All I get in /var/log/messages is


Jan 17 10:37:13 oatkinson1 hcid[1955]: link_key_request (sba=00:15:E9:65:56:37, dba=00:03:89:7B:38:C6)
Jan 17 10:37:46 oatkinson1 su: (to root) oatkinson on /dev/pts/2

Jan 17 10:40:03 oatkinson1 headsetd[5508]: Bluetooth headset daemon version 0.5
Jan 17 10:40:03 oatkinson1 headsetd[5508]: Incoming RFCOMM hs connection from 00:03:89:7B:38:C6 accepted
Jan 17 10:40:03 oatkinson1 headsetd[5508]: Changing state: Idle-->Connected
Jan 17 10:41:20 oatkinson1 headsetd[5508]: Headset disconnected as RFCOMM socket died
Jan 17 10:41:20 oatkinson1 headsetd[5508]: Changing state: Connected-->Idle
Jan 17 10:41:26 oatkinson1 hcid[1955]: link_key_request (sba=00:15:E9:65:56:37, dba=00:03:89:7B:38:C6)
Jan 17 10:41:27 oatkinson1 headsetd[5508]: Incoming RFCOMM hs connection from 00:03:89:7B:38:C6 accepted
Jan 17 10:41:27 oatkinson1 headsetd[5508]: Changing state: Idle-->Connected
Jan 17 11:17:30 oatkinson1 syslog-ng[2509]: STATS: dropped 0
Jan 17 11:17:56 oatkinson1 zmd: ShutdownManager (WARN): Preparing to sleep...
Jan 17 11:17:56 oatkinson1 zmd: ShutdownManager (WARN): Going to sleep, waking up at 01/18/2007 10:07:56
Jan 17 12:17:31 oatkinson1 syslog-ng[2509]: STATS: dropped 0
 

Any ideas how best to debug the problem?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
