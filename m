Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: creating the bnep0 device
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4248625F.1060809@coloradocollege.edu>
References: <4248625F.1060809@coloradocollege.edu>
Content-Type: text/plain
Message-Id: <1112040342.9016.50.camel@pegasus>
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
Date: Mon, 28 Mar 2005 22:05:42 +0200

Hi Jonathan,

> I tried using the connect option with the same result, except that I get a few new messages in the log.
> 
> I made sure that pand was dead, restarted the bluetooth services, plugged in the adaptor, started pand with the connect and tried to bring up bnep0 with ifup and ifconfig....  
> 
> /var/log/messages:
> Mar 28 12:53:57 ma-jbredin hcid[11737]: Bluetooth HCI daemon
> Mar 28 12:53:57 ma-jbredin bluetooth: hcid startup succeeded
> Mar 28 12:53:57 ma-jbredin sdpd[11741]: Bluetooth SDP daemon
> Mar 28 12:53:57 ma-jbredin bluetooth: sdpd startup succeeded
> Mar 28 12:54:02 ma-jbredin kernel: usb 4-2: new full speed USB device using uhci_hcd and address 3
> Mar 28 12:54:03 ma-jbredin hcid[11737]: HCI dev 0 registered
> Mar 28 12:54:04 ma-jbredin hcid[11737]: HCI dev 0 up
> Mar 28 12:54:04 ma-jbredin hcid[11737]: Starting security manager 0
> Mar 28 12:54:12 ma-jbredin pand[11903]: Bluetooth PAN daemon
> Mar 28 12:54:12 ma-jbredin pand[11903]: Connecting to bnep0
> Mar 28 12:54:33 ma-jbredin pand[11903]: Connect to bnep0 failed. Host is down(112)
> 
> Any more thoughts?

run "hcidump -X -V" as root at the same time, but I am pretty sure that
"Host is down" means that your other device is not in connectable mode.

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
