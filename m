Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <400D599B.3070004@web.de>
From: Burkhard Fischer <b.fi2@web.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] bluepin bash script with immediate pin response
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 20 Jan 2004 17:38:51 +0100

Hello,

I am using BlueFRITZ! USB Bluetooth dongle, the BlueFRITZ
AP-ISDN and ciptool for establishing a connection.

I want to replace the python script bluepin with a simple shell script 
to avoid interactive authentication. A simple echo should do this, 
however I found out that a connection is only established when the 
bluepin bash script doesn't answer immediately.

Here is the syslog:

Jan 20 16:59:02 magito hcid[544]: pin_code_request 
(sba=00:04:0E:82:F9:74, dba=00:04:0E:84:06:CA)
Jan 20 16:59:02 magito hcid[1088]: hci_send_cmd 6bkgLuRqDpSIYZgP
Jan 20 16:59:02 magito hcid[544]: pin_code_request 
(sba=00:04:0E:82:F9:74, dba=00:04:0E:84:06:CA)
Jan 20 16:59:02 magito hcid[1091]: hci_send_cmd 6bkgLuRqDpSIYZgP
Jan 20 16:59:34 magito kernel: hci_cmd_task: hci0 command tx timeout

and with "sleep 1" before echoing the pin everything goes well (besides 
the occasional tx timeout):

Jan 20 17:14:35 magito hcid[544]: pin_code_request 
(sba=00:04:0E:82:F9:74, dba=0
0:04:0E:84:06:CA)
Jan 20 17:14:36 magito hcid[1577]: hci_send_cmd 6bkgLuRqDpSIYZgP
Jan 20 17:14:38 magito kernel: hci_cmd_task: hci0 command tx timeout
Jan 20 17:15:10 magito hcid[544]: pin_code_request 
(sba=00:04:0E:82:F9:74, dba=0
0:04:0E:84:06:CA)
Jan 20 17:15:11 magito hcid[1596]: hci_send_cmd 6bkgLuRqDpSIYZgP
Jan 20 17:15:11 magito hcid[544]: pin_code_request 
(sba=00:04:0E:82:F9:74, dba=0
0:04:0E:84:06:CA)
Jan 20 17:15:12 magito kernel: hci_cmd_task: hci0 command tx timeout
Jan 20 17:15:12 magito hcid[1602]: hci_send_cmd 6bkgLuRqDpSIYZgP
Jan 20 17:15:12 magito hcid[544]: link_key_notify (sba=00:04:0E:82:F9:74)
Jan 20 17:15:12 magito hcid[544]: Saving link key 00:04:0E:82:F9:74 
00:04:0E:84:
06:CA
Jan 20 17:15:12 magito hcid[544]: link_key_notify (sba=00:04:0E:82:F9:74)
Jan 20 17:15:12 magito hcid[544]: Replacing link key 00:04:0E:82:F9:74 
00:04:0E:
84:06:CA
Jan 20 17:15:12 magito kernel: Found 1 CAPI controller(s) on device 
00:04:0E:84:
06:CA
Jan 20 17:15:12 magito kernel: kcapi: Controller 1: 00:04:0E:84:06:CA 
attached
Jan 20 17:15:12 magito kernel: kcapi: card 1 "00:04:0E:84:06:CA" ready.
Jan 20 17:15:12 magito kernel: kcapi: notify up contr 1
Jan 20 17:15:12 magito kernel: capi: controller 1 up

I am using 2.4.24 kernel with the mh1-Patch and the source 
bluez-libs-2.5.tar.gz
bluez-utils-2.4.tar.gz
bluez-sdp-1.5.tar.gz

Is there a reason for this behavior

thanks
Burkhard



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
