Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Trouble pairing with new phone...
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.58.0502111016380.16262@gaia3.cc.gatech.edu>
References: <Pine.GSO.4.58.0502111016380.16262@gaia3.cc.gatech.edu>
Content-Type: text/plain
Message-Id: <1108148960.18099.47.camel@pegasus>
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
Date: Fri, 11 Feb 2005 20:09:20 +0100

Hi Jay,

> >you set yourself into security mode 3 by using auth and encrypt. Are you
> >sure that you know what you are doing?
> 
> I'm not sure of anything, but it has worked for me in the past, and I get
> the exact same results if I comment out the auth and encrypt commands in
> the hcid.conf file. I've left them commented out for the rest of my
> debugging.

The default hcid.conf is quite good and you should only change the name
or class of device.

> >The PIN helper can't provide a PIN as it seems. Fix this.
> >
> 
> I don't think the answer is quite this simple for the following reasons:
> 
> 1) my hcid.conf file has
>  security auto;
> which if I understand it correctly is supposed to use the
> /etc/bluetooth/pin file as opposed to the pin_helper application.
> 
> 1a) If I change this to "security user" the bluez-pin helper launches (but
> my Palm T times out before I can enter the PIN on the laptop!) If I try to
> pair the T610 phone with the laptop when "security user" is set, the
> bluez-pin helper program DOES NOT LAUNCH, and hcidump -X says the
> following:
> 
> HCIDump - HCI packet analyzer ver 1.12
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
>   B2 E6 1D D9 0A 00 04 02 52 01
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   B2 E6 1D D9 0A 00 00

You will only accept this connection if you become the master of the
piconet.

> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04
> > HCI Event: Connect Complete (0x03) plen 11
>   1A 29 00 B2 E6 1D D9 0A 00 01 00

This mean unsupported remote feature which may lead to that the phone
does not support the role switch. Check with "hcitool info ..." and
report.

> >Even an application with L2CAP_LM_MASTER set can force the role switch
> >at connection creation.
> 
> The only applications I'm running are hcid, sdpd and rfcomm which are
> started in my bluetooth services (rc.d) file. I even commented out the
> "rfcomm bind all" command from my /etc/rc.d/init.d/bluetooth file, but it
> didn't change anything.

And how is the sdpd started? Do you use the -m switch?

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
