Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <428EDFCA.5070702@gmail.com>
From: David Britton <davidpbritton@gmail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Early failures with Treo 650
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
Date: Sat, 21 May 2005 02:14:18 -0500

Hi,

Having problems even getting past the early stages with connecting my 
treo 650 to my Kensington.  I did a search through the archives, and I 
can't seem to find anyone who has been stuck this early.

Symptoms:

- I can see the PC from my plam (it shows up as a "Device").
- I have put the treo into "discoverable" mode.
- I can see the BT USB Dongle using hciconfig
- I cannot get "hcitool scan" to return any devices


Output:

red:/home/dpb# hciconfig
hci0:   Type: USB
        BD Address: 00:0C:55:F8:5A:2B ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN INQUIRY
        RX bytes:461 acl:0 sco:0 events:73 errors:0
        TX bytes:3271 acl:0 sco:0 commands:73 errors:0
red:/home/dpb# hcidump  -x -V &
HCI sniffer - Bluetooth packet analyzer ver 1.17
device: hci0 snap_len: 1028 filter: 0xffffffff
[1] 24217
red:/home/dpb# hcitool scan
Scanning ...
Inquiry failed: Connection timed out
red:/home/dpb#



Please let me know if I have not specified enough information here -- I 
just don't even know where to start.  All FAQ/HOW-TO's that I read sort 
of assume that this part will work.

TIA.

-- 
David Britton


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
