Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <443FB179.5030509@pagestation.com>
From: Jerry Geis <geisj@pagestation.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] cant create connection
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
Date: Fri, 14 Apr 2006 10:28:09 -0400

I downloaded 2.6.16.4 and recomiled, installed etc...
I am no longer using alsa 1.0.11rc5 from the web site. just 2.6.16.4
I compile btsco and install and btsco/kernel and install
I can successfully modprobe snd-bt-sco. It loads with no errors now. 
GREAT I THOUGHT.

however now when I am using "sdptool search --bdaddr MACADDR 0x111E"
it says "failed to connect to SDP server on MACADDR: host is down"

I am using an H500 motorola headset and a DLINK DBT-120 dongle.

If I do an "l2ping MACADDR" it says "cant connect host is down".

My headset is ON I see it blinking blue, I hear it turn on. My dbt-120
is on and responds to hciconfig
hci0:   Type: USB
        BD Address: 00:13:46:4C:10:32 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:2123 acl:0 sco:0 events:94 errors:0
        TX bytes:506 acl:0 sco:0 commands:51 errors:0

What am I missing at this stage? THanks,

Jerry


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
