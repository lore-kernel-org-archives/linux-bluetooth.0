Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403070334.32315.wim.delvaux@adaptiveplanet.com>
References: <200403070334.32315.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1078627214.2807.31.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: bnep module use count ...
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
Date: Sun, 07 Mar 2004 03:40:14 +0100

Hi Wim,

> I have a theory about this module use count.
> 
> What is my setup.
> 
> When I insert the usb dongle, hci/sdp and pand --listen is started wating for 
> a connection.
> 
> Then I activate the connection on my Ipaq and notice in syslog that the 
> connection is request.
> 
> Pand will then create a bnep module in the kernel.  This will trigger a 
> hotplug event causing ifup to be executed on bnep0.
> 
> So far so good.
> 
> Now I disconnect my Ipaq. (either by pand -k and kill or whatever).  
> This event does not get detected by anybody.
> 
> The Ipaq when it comes back will request a new session and a new handle to 
> bnep0 is created in the kernel (causing refcount to increase beyond the real 
> use count).
> 
> Once this occurs the module is no longer unloadable and actually causes the 
> system to hang when the usb dongle is removed !!!! A reboot is then 
> needed ;-((((((
> 
> WHat you think of this scenario ?

this can be possible, but I can't tell you anything without more
information. Last time I check the reference counting it was working
perfect for all upper L2CAP modules. Maybe there is a problem in the
BNEP module or in the network layer.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
