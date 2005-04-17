Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't connect to a keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050417205450.653f7567.jesuscanonavarro@yahoo.es>
References: <20050417205450.653f7567.jesuscanonavarro@yahoo.es>
Content-Type: text/plain
Message-Id: <1113765064.16233.80.camel@pegasus>
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
Date: Sun, 17 Apr 2005 21:11:04 +0200

Hi Jesus,

> First of all, thank you very much for reading the message and spending a little of your time helping me. I'm new in this "blue field", hope i can help people with this some day.
> 
> Ok. I had an Apple Wireless Keyboard for xmas, since then, i haven't been able to use it on my GNU/Linux, a minimalistic Debian testing (in Compaq Deskpro EN series old workstation, P2 350Mhz, 256MB, 8GB; it runs so fine ;).
> 
> I read Marcel's pages about bluez and bluetooth in GNU/Linux (great job man!) to get a right dongle (a 3com USB Bluetooth adapter) and get the first contact to bluetooth in GNU/Linux. I couldn't understand that pages very well since i don't know much more about the bluetooth hw, protocol, stack... Perhaps, the answer is right in front of my nose but i cann't see it. Actually, someone seemed to have the same problem in the list archives time ago, but i can't imagine what do i have to do.
> 
> So, i installed "bluez-utils" pakage. And i've been trying things; the info i know i can give you by now, is:
> 
> -I need to restart /etc/init.d/bluez-utils, after booting to make it work.
> -I have no problem to detect the dongle on boot or with hotplug.
> -I have tried some steps to connect with the keyboard i found in the documentation i difficultly read:

run "hcidump -X -V" as root in another terminal and then call

	hidd --connect <bdaddr>

You will see that nothing happens, because your keyboard is in security
mode 3. Now push a number combination on the number pad of your keyboard
and hit return. After that a dialog should open, where you have to enter
these number combination again. Now you are paired and the keyboard is
ready for daily use.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
