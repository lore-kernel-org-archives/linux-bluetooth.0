Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Andi Kleen <ak@suse.de>
Cc: bluez-devel@lists.sf.net, netdev@oss.sgi.com,
   viro@parcelfarce.linux.org.uk
In-Reply-To: <20040206050042.20a2b3b0.ak@suse.de>
References: <20040206050042.20a2b3b0.ak@suse.de>
Content-Type: text/plain
Message-Id: <1076110207.14418.53.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: some bluetooth fixes
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 07 Feb 2004 00:30:08 +0100

Hi Andi,

> diff -u linux-2.6.2-work32/net/bluetooth/rfcomm/tty.c-o linux-2.6.2-work32/net/bluetooth/rfcomm/tty.c
> --- linux-2.6.2-work32/net/bluetooth/rfcomm/tty.c-o	2003-09-28 10:53:25.000000000 +0200
> +++ linux-2.6.2-work32/net/bluetooth/rfcomm/tty.c	2004-02-06 04:58:28.000000000 +0100
> @@ -549,8 +549,10 @@
>  
>  	BT_DBG("dev %p dst %s channel %d opened %d", dev, batostr(&dev->dst), dev->channel, dev->opened);
>  
> -	if (dev->opened++ != 0)
> +	if (dev->opened++ != 0) {
> +		rfcomm_dev_put(dev);
>  		return 0;
> +	}
>  
>  	dlc = dev->dlc;

this part is wrong, because it is not an error case. It is success and
the refcount must stay increased.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
