Return-Path: <bluez-users-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v612)
Message-Id: <51279096-6253-11D8-9EE6-000393C5CB34@usask.ca>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: bluez-users@lists.sourceforge.net
From: Carl Norum <carl.norum@usask.ca>
Subject: [Bluez-users] Can't create socket.: No such file or directory
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
Date: Wed, 18 Feb 2004 14:44:59 -0600


I've just finished installing BlueZ on a Mandrake machine of mine, but 
I can't make l2ping work.  "hcitool scan" and "hcitool inq" both show 
me the other bluetooth machine (iBook with 3Com dongle), and "hcitool 
cc --role=m ...." appears to work too, as "hcitool con" shows the 
connection.  l2ping however, just always says "Can't create socket.: No 
such file or directory", and that's it.

Anybody have any quick ideas about what's going on here?

-- 
Carl J Norum
Academic Director, IEEE NSS Student Branch
Final Year Electrical Engineering/Computer Science Student
University of Saskatchewan
Saskatoon, Canada

http://norum.homeunix.net/~carl/



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
