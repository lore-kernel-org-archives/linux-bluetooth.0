Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Al <ojravadilla@yahoo.com>
Message-ID: <loom.20051129T022104-305@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Can't print with D600 phone
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
Date: Tue, 29 Nov 2005 01:31:13 +0000 (UTC)

Can somebody help me with this... I have a samsung D600 phone. It works with 
opp, but will not work with bpp. It is okay with get printer attributes and 
then when I try to print the image it says processing error. When I try to 
capture the transaction done The phone tries to connect to the printer again 
and then the printer will ok response, and the phone will send sdp to the 
printer and the printer will send the sdp response and then The phone will 
issue the disconnect request in the L2CAP and the printer will response 
disconnect in the L2CAP and then the LMP transaction starts to appear. And the 
phone will not connect again to send the create job. I have notice that the 
LMP version of the phone is version1.2 while the printer has LMP verison1.1. 
The printer is using bluez-lib-2.22 and bluez-util-2.22. Can somebody tell me 
whats the problem? 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
