Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4248625F.1060809@coloradocollege.edu>
From: Jonathan Bredin <jbredin@coloradocollege.edu>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Re: creating the bnep0 device
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
Date: Mon, 28 Mar 2005 13:00:31 -0700

Thanks, Marcel.  I tried using the connect option with the same result, except that I get a few new messages in the log.

I made sure that pand was dead, restarted the bluetooth services, plugged in the adaptor, started pand with the connect and tried to bring up bnep0 with ifup and ifconfig....  

/var/log/messages:
Mar 28 12:53:57 ma-jbredin hcid[11737]: Bluetooth HCI daemon
Mar 28 12:53:57 ma-jbredin bluetooth: hcid startup succeeded
Mar 28 12:53:57 ma-jbredin sdpd[11741]: Bluetooth SDP daemon
Mar 28 12:53:57 ma-jbredin bluetooth: sdpd startup succeeded
Mar 28 12:54:02 ma-jbredin kernel: usb 4-2: new full speed USB device using uhci_hcd and address 3
Mar 28 12:54:03 ma-jbredin hcid[11737]: HCI dev 0 registered
Mar 28 12:54:04 ma-jbredin hcid[11737]: HCI dev 0 up
Mar 28 12:54:04 ma-jbredin hcid[11737]: Starting security manager 0
Mar 28 12:54:12 ma-jbredin pand[11903]: Bluetooth PAN daemon
Mar 28 12:54:12 ma-jbredin pand[11903]: Connecting to bnep0
Mar 28 12:54:33 ma-jbredin pand[11903]: Connect to bnep0 failed. Host is down(112)

Any more thoughts?

jonathan

Marcel Holtmann wrote:
> Hi Jonathan,
> 
> what about using "pand --connect" before you try to use "ifconfig".
>
> Regards
>
> Marcel


>> I have a pretty remedial question involving setting up bluettoth in 
>> Linux, but I don't think that I've seen any answers in the documentation 
>> or mailing list. 
>> 
>> I'm using kernel 2.6.11 with a LinkSys USBBT100 adaptor.  The adaptor 
>> can scan and ping other bluetooth devices with l2ping, but I'm having 
>> problems getting bnep0 recognized as a network interface.
>> 
>> ifconfig bnep0 returns
>> bnep0: error fetching interface information: Device not found
>> 
>> The fedora utility sees bnep0, but cannot activate it and returns
>> SIOCGIFFLAGS: No such device
>> when I try to deactivate it.
>> 
>> I get the same results when I use bluez/benp compiled into the kernel or 
>> loading them as modules.  /var/log/messages has the bluetooth messages:
>> Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: L2CAP ver 2.7
>> Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: L2CAP socket layer initialized
>> Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: RFCOMM ver 1.5
>> Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: RFCOMM socket layer 
>> initialized
>> Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: RFCOMM TTY layer initialized
>> Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: BNEP (Ethernet Emulation) 
>> ver 1.2
>> Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: BNEP filters: protocol 
>> multicast
>> Mar 27 12:30:11 ma-jbredin kernel: Bluetooth: HIDP (Human Interface 
>> Emulation) ver 1.1
>> 
>> Does anyone have suggestions to get bnep0 off the ground?
>  
>




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
