Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403071625.01627.wim.delvaux@adaptiveplanet.com>
References: <200403071625.01627.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1078705651.15279.20.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: bnep and refcnt
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
Date: Mon, 08 Mar 2004 01:27:31 +0100

Hi Wim,

> after browsing the Linux 2.6 code there is a remark in net/core/dev.c that 
> state what the problem with the following message that I get is 
> 
> unregister_netdevice: waiting for bnep0 to become free. Usage count = 6
> 
> The comment with the function in dev.c states that this error is caused by 
> buggy protocols that should unregister after receiving notification that the 
> devices they are using has been unregistered.  They should call 
> unregister_netdev which decreases the refcnt.

looks like we need a more detailed audit for the BNEP module and some of
the 2.6 changes in the network device layer.

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
