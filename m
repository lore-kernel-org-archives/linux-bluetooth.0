Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Question to using sdptool
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1119621425.3878.216.camel@baroque.rococosoft.com>
References: 
	 <OFB3085819.655FE670-ONC125702A.0040152A-C125702A.00445A7F@dcx.dcx>
	 <1119621425.3878.216.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1119627972.7129.10.camel@notepaq>
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
Date: Fri, 24 Jun 2005 17:46:12 +0200

Hi Steve,

> > I am trying to generate some testcases for testing the BT-solution in our
> > products. Therefore some small questions.
> > 
> > I am using two BT-dongles on one host.
> > At moment when I'm execute "sdptool add <service>" or "sdptool  -i hci1 add
> > <service>" both hcix gets the service.
> > Question:
> > Does provide bluez more then one sdp-daemon - especially to each local
> > BT-address one dedicated daemon?
> > Or is it possible to have two separated sdp-data bases - one for each local
> > address?
> 
> It doesn't really make sense to have one sdpd per device. Services
> aren't really bound to a device, rather the machine to which the device
> is attached.

this depends on it. You can bound a service to a specific and device and
in this case also the SDP records should bound to a specific address.
However I don't have really time to look into it at the moment.

> > If the option -i for using with sdptool is correct : when I execute
> > "sdptool -i hci1 browse" then bluez is doing on hci0 an inquiring and with
> > the results on hci1 the sdp-requests. Is this process as expected?
> 
> Hmmm. It seems there is no way to pass the interface to
> sdp_general_inquiry(). Perhaps it is best to add a new function,
> sdp_directed_general_inquiry()? Marcel what do you think?

If only sdptool uses these function, we can change it or fix sdptool to
use hci_inquiry and sdp_* explicitly.

> > One wish to the bluez developer:
> > The old link-key file (etc/bluetooth/link_key) contained also the time
> > (+date) of generating the corresponding key. In the new one
> > (/var/lib/bluetooth/.../linkkeys) the time (+date)is missing.
> > It was a helpful feature for testing. It is possible to implement this
> > again?

I left it out, because I don't saw any reason for that. However I have
plans for a "last seen" file.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
