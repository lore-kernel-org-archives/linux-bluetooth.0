Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Mr Jie Liu <s4048156@student.uq.edu.au>
To: bluez-users@lists.sourceforge.net
Message-ID: <1afc401b1d89.1b1d891afc40@uq.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] hstest.c could not work
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
Date: Sat, 15 May 2004 14:00:07 +1000

I am trying to use hstest of bluez to test the sco connection. But I can't hear anything when I use "hstest play xx x:x:x:x:x x"
I can establish rfcom and sco connection and send AT command through the ACL link. but I can't hear anything in the headset. I try to record a file from the headset by "hstest record xx x:x:x:x:x x",and then try to play it by "hstest play xx x:x:x:x:x x",i still can't hear anything. Has anyone used this test program to test the headset profile? 
The voice setting in hstest is 0x0060,but in Jonathan Paisley's ALSA Bluetooth Headset Driver it says the voice setting should be set to 0x0040. I don't know if it is because of this.



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
