Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to interpret 'link quality' value
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de4657604120421334e95d912@mail.gmail.com>
References: <200412031515.02372.wim.delvaux@adaptiveplanet.com>
	 <1102084671.8479.18.camel@pegasus>
	 <2de46576041203223817d0cc34@mail.gmail.com>
	 <1102142794.8479.38.camel@pegasus>
	 <2de4657604120421334e95d912@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1102225672.8510.20.camel@pegasus>
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
Date: Sun, 05 Dec 2004 06:47:52 +0100

Hi Manjunath,

> > > I am using anycom dongle (so SiW chipset)........can i consider the
> > > same approximation for the link quality as u have  mentioned for the
> > > CSR chipset.........
> > 
> > no. As I said it is manufacturer specific.
> 
> Is there any link for the SiW too...or should i ask the manufacturer....

if I would know of any other manufacturer information, I would have put
them on my webpage.

> > > Also, I am using usb-120 which is a class-2 device. I see the power
> > > control feature .....if i enable communication between 2 devices which
> > > are in Line of sight and short distance apart....shouldn't the
> > > transmit power level decrease??? It is not decreasing. Is this feature
> > > the same as  adpative power control feature????
> > 
> > The power control is not always mandatory. Check the specification and
> > ask the manufacturer. What do you mean by "adaptive power control"? I
> > never heard of this.
> 
> Adpative power control is, or rather i meant was the step-wise
> incrementing and decrementing of transmit power levels......

This is not controllable from the HCI. You can only check the current
value if it is supported and if the command is really implemented and
not only a fake one.

> I am planning to buy new BT 1.2 devices. Which one would be the best
> choice in terms of more features available and the ones with a
> firmware upgrade??? hope you can suggest something.

Get yourself a CSR based one or upgrade a D-Link DBT-120 Rev. B3.

As long as you don't care about the inquiry with RSSI, then you might
also be happy with a Broadcom one or a Silicon Wave. However the
Broadcom doesn't support this it all and the Silicon Wave are buggy.

Actually I am waiting for the first CSR based Bluetooth 2.0 + EDR
dongles to appear on the market.

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
