Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Microsoft keyboad/mouse problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41B8A67C.3060608@paytec.com>
References: <41B8A67C.3060608@paytec.com>
Content-Type: text/plain
Message-Id: <1102627652.7962.4.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 09 Dec 2004 22:27:32 +0100

Hi Dave,

> My mouse and keyboard sometimes loose their connection. I'm running 
> 2.6.10_rc2 and hidd --server on boot. I also run a script I found around 
> the net that runs hidd --search and/or hidd --connect with retries and 
> delays to try to connect to the keyboard & mouse. When the connection is 
> lost, I typically run "hidd --show" to see that it is indeed not 
> connected then  "hidd --search" to reconnect and it USUALLY works 
> especially since I upgraded the kernel from 2.6.8. Thankfully it is 
> usually the mouse that is a problem, so I can do this from the same box. 
> When "hidd --search" fails I remove and replace the batteries. I've 
> noticed the mouse lights blinking at me, which I'm not sure is telling 
> me the batteries are low. I checked and they weren't really that low. It 
> sometimes seems as though the mouse desires batteries really well 
> charged. The few times the keyboard was a problem, I ssh from another 
> box and "hidd --search" and it works.

first questions is if this is the old Microsoft desktop or new 2.0
version of it?

> 1) when the devices sleep should "hidd --show" show the device? (And the 
> hidd server is waiting for a wakeup from the device?) I guess I should 
> check "hidd --show" sometime when they've been inactive.

When the device sniff then the connection should still be shown, but
after a while it disconnects and then it will not be shown anymore.
However this doesn't matter, because it will reconnect on the next touch
to your running "hidd --server" instance.

> 2) what does the blinking mouse mean (I don't have any docs with these 
> devices).

How should I know? I don't work for Microsoft ;)

> 3) Should I have to push the mouse and keyboard buttoms on every reboot 
> or just one time for the device? (should I need that second script I'm 
> running?)

You need to push the connect button only for the initial setup and there
is no need for another script. Only "hidd --server" must run. However
you need to push a keyboard or mouse button to initiate the reconnect.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
