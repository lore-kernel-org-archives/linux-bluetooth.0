Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Tamer Higazi <tamer23@myrealbox.com>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1139079892.13219.11.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] conceptronic CBT100U with scala-500 headset pairing problem!
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
Date: Sat, 04 Feb 2006 19:04:52 +0000

Hi! 
I am trying to pair myheadset with my USB bluetooth dongle on Linux!

About my device: 
#hcitool dev
Devices:
        hci0    00:80:5A:30:BC:7D

If I run the command: 

#hcitool cc 00:0A:9B:6C:65:A0

I receive this result: 
Can't create connection: Input/output error

If I'd love to request info from the device: 

#hcitool info 00:0A:9B:6C:65:A0

I receive this result: 

Requesting information ...
Can't create connection: Input/output error

On Windows I can make easily a connection to that bluetooth device. I
want to make the same on Linux with the BTSCO package to make VoIP with
Skype. 

If there is anybody who has experiences... 

Thank you in advance



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
