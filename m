Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43FB7A01.1020702@cs.bgu.ac.il>
From: Niv <nivv@cs.bgu.ac.il>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-users] cant use headset
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
Date: Tue, 21 Feb 2006 22:37:21 +0200

I am getting this wierd probelm the last couple of days.

I had it before switching to the new ebuild of bluetooth-kernel.

I am running gentoo on 2.6.15-ck3-r1

I modprobe snd-bt-sco fine and see it in alsamixer -c 3

I can l2ping the headset.

I removed the linkkeys file and did:

hcitool scan - and discovered the headset

then l2ping it succsefully

then hcitool cc <addr>

then hcitool dc <addr>

then: btsco -v 00:0D:44:33:E1:63

btsco v0.41
Error: control open (hw:4): No such device
Error: Can't find device. Bail


I ran hcidump -X -V, but there is no output during the btsco

Help me pls,

NIv



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
