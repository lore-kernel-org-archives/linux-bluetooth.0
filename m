Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40C9FD7B.6000004@gmx.net>
From: Simone Crippa <simone.crippa@gmx.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] apple wireless keyboard
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
Date: Fri, 11 Jun 2004 20:44:11 +0200

Hello list,

I bought a shiny new Apple Wireless Keyboard last week because I like to 
type on a "big" keyboard using my laptop, but I "hate" tethers!!!

Before buying it I quickly looked in the net to discover that it is 
indeed possible. After a deeper search for some information I discovered 
that it is not a very well documented task (either Google_Groups, 
Newsgroups, ...).

I found _some_ information on this list some weeks ago, but it didn't 
really help me a lot. So I thought, I might contact Marcel Holtmann 
directly, who seems to know quite a bit about it :-)

But since I don't want to bother him with my simple questions, I thought 
maybe someone very, very kind on this list might have faced my same 
problems before ... :-)

What I have:


- Apple Keyboard
- HP nx7000 laptop with built-in Bluetooth
- bluez-utils + libs 2.7 (Debian unstable)
- hidp module from mh3 patch on 2.6.6 kernel

What works so far:

- PIN authentification (othewise no info!!)

- synchronisation over Bluetooth with Palm (so, Bluetooth connection 
works!)

- hcitool info <BD-keyboard> (gives out lots of funny HW info! ... 
"Broadcom Corp."???)

- Palm finds Apple Keyboard (so, Bluetooth in keyboard works)

What does not work:

- hidd -s give out either:
	Searching ...
	Connecting to device 00:0A:95:39:67:0F
	Can't create HID control channel: Host is down
   or:
	Connecting to device 00:0A:95:39:67:0F
	Can't create HID control channel: Device or resource busy
   or:
         No devices in range or visible

not in that order, pick what you prefer ... which is kind of funny, 
since I touch nothing on the keyboard and the output changes continuosly.

I tried to look at "hcidump -x" for some info ... but I cannot find a 
clue! (btw: thanks to Marcel ... "hcidump -x" helped me for the PIN-auth 
problem!!!)


Thanks for your patience, Simone


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
