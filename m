Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcitool scan question
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.60.0502110314380.12691@columbia.cs.ubc.ca>
References: <20050211111140.64497886BC@sc8-sf-spam1.sourceforge.net>
	 <Pine.GSO.4.60.0502110314380.12691@columbia.cs.ubc.ca>
Content-Type: text/plain
Message-Id: <1108123392.18099.16.camel@pegasus>
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
Date: Fri, 11 Feb 2005 13:03:12 +0100

Hi Jack,

> I am running hciemu. hciconfig shows VHCI devices up and running and I can 
> l2ping the devices, but when I do hcitool scan I get the following:
> 
> # hcitool scan
> Scanning ...
> Inquiry failed: Connection timed out
> 
> hcidump shows the following:
> 
> # hcidump -i hci0 -V
> HCI sniffer - Bluetooth packet analyzer ver 1.17
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Inquiry (0x01|0x0001) plen 5
> > HCI Event: Command Complete (0x0e) plen 4
>      Inquiry (0x01|0x0001) ncmd 1
> 
> Could you give me some ideas about what I should do to make the scan 
> working? Can I achieve that with VHCI devices? hcidump shows hci0 is doing 
> the job, but the scan doesn't show it.

the inquiry is not supported by the hciemu. Get yourself a pair of real
Bluetooth devices.

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
