Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45FE5DA1.5010706@enteos.it>
Date: Mon, 19 Mar 2007 10:53:37 +0100
From: Livio Tenze <livio.tenze@enteos.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] headset problem...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi all,

I am starting to use bluez 3.9 and now I am testing the headset
connection. I found in bluez-utils/audio a daemon named
bluetoothd-service-headset. I thought it was similar to the old hstest.
I tested this daemon: it recognizes the headset but I am not able to use
the sco channel. Moreover the -o and -i options of the daemon seem not
to work.
When I try to call

bluetoothd-service-headset -c 1 -o pippo 00:03:89:75:36:7F
the program answers

headset[802]: Bluetooth headset service daemon
headset[802]: add_ag_record: got record id 0x10000
bluetoothd-service-headset: headset.c:1549: audio_headset_open_output:
Assertion `hs->output' failed.
Aborted

May you help me? How can I use the headset connection?
Thanks in advance!

Livius





-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
