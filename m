Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Christoph =?iso-8859-1?q?B=E4chtle?= <christophbaechtle@web.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200602100311.35870.christophbaechtle@web.de>
Subject: [Bluez-users] modprobe snd_bt_sco fails with: FATAL: Error inserting snd_bt_sco
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
Date: Fri, 10 Feb 2006 03:11:35 +0100

Hi

When I try to load the snd_bt_sco module I get the following error message:

FATAL: Error inserting snd_bt_sco 
(/lib/modules/2.6.15-jad2-default/extra/snd-bt-sco.ko): Unknown symbol in 
module, or unknown parameter (see dmesg)

and dmesg tells me:

[...]
cdrom: This disc doesn't have any tracks I recognize!
scsi: unknown opcode 0x01
snd_bt_sco: Unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
snd_bt_sco: Unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
snd_bt_sco: Unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
hci_cmd_task: hci0 command tx timeout
hci_cmd_task: hci0 command tx timeout
hci_cmd_task: hci0 command tx timeout
hci_cmd_task: hci0 command tx timeout
snd_bt_sco: Unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
hci_cmd_task: hci0 command tx timeout
snd_bt_sco: Unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores


does anybody know how to solve this?
I am using suse 10.0 with kde3.5 and kernel 2.6.15-jad2

christoph


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
