Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Rob Raper" <djrobx@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F23luevz176Rb00048253@hotmail.com>
Subject: [Bluez-users] What's the best way to go about device detection?
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
Date: Sat, 15 May 2004 10:36:41 -0700

Sorry for the newbie questions or if I'm missing some obvious concepts, but 
I can't find any documentation for bluez, I've been primarily hacking 
samples and learning by experimentation.  My RFCOMM implementation from a 
single server to a single phone works perfectly, my problem has to do with 
detection of a bluetooth device and signal strengths.

I'm writing an application that involves having cell phones that 
automatically attach to servers when they come into range; like a 'roaming' 
application.    When the phone gets closer to another server (when going 
from room to room), the previous server should detach from it and the next 
server will attach.  These servers are connected in their own way over 
ethernet and coordinate the hand-off.

So, the server needs to look for available phones and report their signal 
strengths, even if they're connected to another server.   When one 
connection becomes significantly stronger, it will perform a coordinated 
hand off (coordated by ethernet, not bluetooth).

My first stab was to take the hcitool sources and use a modified version 
"scan" function.   For each MAC it would then do a (hci_send_cmd) 
OCF_CREATE_CONN and just wait until  OCF_GET_LINK_QUALITY succeeded.    It 
worked fine on the one to many relationship (it would detect, then worked 
fine to connect to several phones.   But as soon we launched the app on 
another server, all hell broke loose.   The hci inquiry failed frequently, 
most of the time it couldn't even read the bluetooth name off the phone.  It 
seems I can't even really do a hcitool scan on multiple machines at the same 
time.

I don't really need to scan, I know the bluetooth addresses of the phones 
that could be in range.

I found sources to a utlity called btp (Bluetooth Presence) which is used 
with Digium's Asterisk PBX to detect the presence of your phone, which had 
much more detailed implementation of using hci_send_cmd and how to read its 
responses asynchronously by reading the bluetooth device descriptor, but I'm 
not going about something properly.    I iterate through my list trying to 
connect to phones.   When I send a connect to a phone that's nonexistent, 
about 5 second later, I stilll get a EVT_CONN_COMPLETE with the status of 0. 
   How do I know when the connection has failed?   Link level requests come 
back with Busy for phones that don't exist.    Is there a faster way to 
determine the non-presence of a phone so I can move onto the next one?  
Looking through btp's sources it looks like it looks at phones sequentially 
rather than issuing a bunch of connect requests all at the same time.   I 
guess I just don't have a good understanding of what things can and can't be 
done simultaneously over bluetooth.

If I ONLY try to connect to a phone that IS there, then my routine does go 
through and get its level and all is OK.   It's when the phone is not there 
that everything breaks down.  I can't even proceed onto the next phone 
correctly.

Any help is appreciated!

_________________________________________________________________
Check out the coupons and bargains on MSN Offers! http://youroffers.msn.com



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
