Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] killing a persisted pand session
From: Marcel Holtmann <marcel@holtmann.org>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403070242.16684.wim.delvaux@adaptiveplanet.com>
References: <200403070058.50508.wim.delvaux@adaptiveplanet.com>
	 <200403070221.59578.wim.delvaux@adaptiveplanet.com>
	 <1078623235.2807.6.camel@pegasus>
	 <200403070242.16684.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1078624259.2807.14.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 07 Mar 2004 02:50:59 +0100

Hi Wim,

> 	I was wondering WHY pand is kept running after the BNEP is set up.
> 	For the persist option I can understand since i presume pand monitors the
> 	connection it had to establish and if it 'downs' it restarts it.  However if
> 	this feature is NOT requested (i.e. no --presist is given), then WHY is pand 
> still alive after the setup of the connection.

if you don't use --presist the "pand --connect" process exit after the
full BNEP connection is established. Try "--nodetach" to see it.

> 	The reason for this question is that I was trying to determine a fail safe
> 	integration into hotplug/interfaces.  Seems that if you pand -k the bnep
> 	module is deactivated and ifdown does no longer work properly (and hence
> 	the dhcp server is not stopped properly and does not RELEASE its lease)

If the BNEP connection is deleted you get a remove event from net.agent
hotplug script. If you have problems with DHCP put a bridge interface
above your bnep0 interface.

> 	I have noticed something else here.  I am testing BT between my Ipaq and
> 	a usb BT dongle.  When I suspend my Ipaq the pand on my desktop (the one that
> 	is listening) blocks on an ioctl after it receives the connection request. (I 
> checked with strace on that listening pand)
> 
> 	The iotcl that blocks is the one in bnep_connadd.  Because of this blocking 
> (for I do not know what reason) the connection is not established (no IP is 
> set up)
> 
> static int bnep_connadd(int sk, uint16_t role, char *dev)
> {
>         struct bnep_connadd_req req;
> 
>         strcpy(req.device, dev);
>         req.sock = sk;
>         req.role = role;
>         /* THIS IS THE ONE THAT BLOCKS */
>         if (ioctl(ctl, bnepconnadd, &req))
>                 return -1;
>         strcpy(dev, req.device);
>         return 0;
> }
> 	Do you know what that ioctl is supposed to do and why it blocks on something

This ioctl gives the control of your incoming connection to the kernel
BNEP module, but I don't know why it can block.

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
