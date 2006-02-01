Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43DFFE2C.2050403@pagestation.com>
From: Jerry Geis <geisj@pagestation.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] getting error on btsco of hw:3 no such device
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
Date: Tue, 31 Jan 2006 19:17:48 -0500

I am doing the following and getting an error at btsco stage.

export MACADDRESS="00:0C:55:0A:8C:51"

modprobe -f snd-bt-sco
esdctl stop

rfcomm bind rfcomm0 $MACADDRESS
sdptool search --bdaddr $MACADDRESS 0x111E

hciconfig hci0 revision
hciconfig hci0 voice 0x0060
btsco $MACADDRESS

At this point I get an error of:
Error: control open (hw:3): No such device
Error: Can't find device. Bail

I have a USB bluetooth adapter F8T001
I have a motorola headset

What have I not done or what might be the problem.

Jerry



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
