Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40300408.4070604@handgranat.org>
From: Sunnan <sunnan@handgranat.org>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] apple wireless mouse on apple ibook (g4, builtin
 usb)
References: <402D07B8.8030504@handgranat.org>	 <1076694675.2671.191.camel@pegasus>  <402D1E8C.6020301@handgranat.org>	 <1076702197.18588.11.camel@pegasus>  <402D381D.1000306@handgranat.org>	 <1076709007.18588.39.camel@pegasus>  <402D4959.10704@handgranat.org>	 <1076711341.18588.57.camel@pegasus>  <402D5592.3060907@handgranat.org>	 <1076714464.18588.95.camel@pegasus>  <402D5EB0.3090601@handgranat.org> <1076720052.18588.147.camel@pegasus> <402E014C.807@handgranat.org>
In-Reply-To: <402E014C.807@handgranat.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 16 Feb 2004 00:43:04 +0100

Hello again,
I still haven't gotten my mouse to work (I know! sorry).
One of the herrings I'm chasing is the name, is the problem the weird
characters in the devices name? if so, can it be renamed?

Or is this completely silly of me and there's something altogether
different that's wrong?

I've been able to find it more often with hcitool by clicking/moving it
while hcitool is searching.

Still no success with bthid, it has never given me anything else than

Feb 15 23:30:04 slowstorm bthid[1035]: Bluetooth HID service started
Feb 15 23:30:30 slowstorm bthid[1035]: Connection failed: Host is down (112)

when I try to connect to my mouse with sudo bthid -c 00:0A:95:01:5F:57

and bthid loves to just exit all the time.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
