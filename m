Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Andreas <andreas.knuth@daimlerchrysler.com>
Message-ID: <loom.20050322T130908-476@post.gmane.org>
References: <20050319123711.14688.qmail@web60901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: adding sdp service record attributes
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
Date: Tue, 22 Mar 2005 12:16:24 +0000 (UTC)

Ka Kin Cheung <michaelhku2002 <at> yahoo.com.hk> writes:

> 
> Hi Marcel!
>     I've set the SDP service profile and the
> attributes for headset and set the class of my
> computer to headset. Then my T610 can search my Linux
> PC as headset. However, when I pressed "connect" item,
> the phone tried to connect to the PC, but then the
> phone showed "Bluetooth connection failed". Is there
> any thing that I need to set in my PC, or how to
> modify my sdp program so that the phone can connect to
> PC?
>     My steps are as follows:
> 1.run my sdp program to add service and set the
> attributes.
> 2.change the class of my PC to be the one of headset.
> 3.let T610 to search my PC and then connect to PC.
>     Is there anything wrong here?
>     Thank you very much.
> Michael
> 
Hi,
After initialising the rfcomm connection (phone to PC; phone gets the setup 
data via sdp from pc) the phone tries to initialize the "HS/HF-connection" via 
AT-commands - as I know.

You should have a look to the following pages regarding HF and HS 
support over BT too:

http://bluetooth-alsa.sourceforge.net/
http://www.crazygreek.co.uk/content/chan_bluetooth
http://www.soft.uni-linz.ac.at/_wiki/tiki-index.php?page=ProjectBluezHandsfree

Regards
Andreas





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
