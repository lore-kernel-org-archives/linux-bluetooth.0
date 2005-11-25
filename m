Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4387654D.7080800@ketil.froyn.name>
From: Ketil Froyn <lists@ketil.froyn.name>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] hidd says: Can't open HIDP control socket: No such file or directory
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
Date: Fri, 25 Nov 2005 20:26:05 +0100

Hello,

I am running a Debian 3.1 system with bluez-utils 2.15-1.1 and kernel 
2.4.27-2-686. I have a billionton bluetooth USB adapter (Vendor=0a5c 
ProdID=200a Rev= 0.01), and it seems to work fine.

However, when I run hidd, I get the following error message:

Can't open HIDP control socket: No such file or directory

I straced hidd, and it seems to be caused by this operation:

socket(PF_BLUETOOTH, SOCK_RAW, 6) = -1 ENOENT (No such file or directory)

Any suggestions on what I'm doing wrong, or how I can fix this?

Cheers,
Ketil Froyn
ketil@froyn.name
http://ketil.froyn.name/


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
