Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41B8A67C.3060608@paytec.com>
From: Dave Sailer <dave.sailer@paytec.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Microsoft keyboad/mouse problem
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
Date: Thu, 09 Dec 2004 14:24:44 -0500

My mouse and keyboard sometimes loose their connection. I'm running 
2.6.10_rc2 and hidd --server on boot. I also run a script I found around 
the net that runs hidd --search and/or hidd --connect with retries and 
delays to try to connect to the keyboard & mouse. When the connection is 
lost, I typically run "hidd --show" to see that it is indeed not 
connected then  "hidd --search" to reconnect and it USUALLY works 
especially since I upgraded the kernel from 2.6.8. Thankfully it is 
usually the mouse that is a problem, so I can do this from the same box. 
When "hidd --search" fails I remove and replace the batteries. I've 
noticed the mouse lights blinking at me, which I'm not sure is telling 
me the batteries are low. I checked and they weren't really that low. It 
sometimes seems as though the mouse desires batteries really well 
charged. The few times the keyboard was a problem, I ssh from another 
box and "hidd --search" and it works.

I'm new to this and I'm a bit confused on some things:

1) when the devices sleep should "hidd --show" show the device? (And the 
hidd server is waiting for a wakeup from the device?) I guess I should 
check "hidd --show" sometime when they've been inactive.

2) what does the blinking mouse mean (I don't have any docs with these 
devices).

3) Should I have to push the mouse and keyboard buttoms on every reboot 
or just one time for the device? (should I need that second script I'm 
running?)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
