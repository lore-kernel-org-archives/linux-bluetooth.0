Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] No working Bluetooth adapter found
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200503271708.10663.tmp@nitwit.de>
References: <200503271708.10663.tmp@nitwit.de>
Content-Type: text/plain
Message-Id: <1111937018.9195.224.camel@pegasus>
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
Date: Sun, 27 Mar 2005 17:23:38 +0200

Hi Timo,

> I currently run SuSE 9.2 and have a MSI PC2PC USB bluetooth dongle and it 
> doesn't work: No working bluetooth adapter found. This is the log when I plug 
> 
> Mar 27 16:47:09 tcn kernel: usb 1-4: new full speed USB device using address 7
> Mar 27 16:47:10 tcn hcid[24373]: HCI dev 0 registered
> Mar 27 16:47:13 tcn kernel: hci_cmd_task: hci0 command tx timeout
> Mar 27 16:47:18 tcn sdpd[24748]: init_server: binding L2CAP socket: Address 
> already in use
> Mar 27 16:47:18 tcn sdpd[24748]: main: Server initialization failed
> Mar 27 16:47:18 tcn opd[24752]: OBEX Push Daemon - version 0.2 started
> Mar 27 16:47:18 tcn opd[24752]: OBEX Object Push service registered with sdpd
> Mar 27 16:47:18 tcn opd[24752]: Failed to register BtOBEX server on RFCOMM 
> channel 10. (-1 / 98)
> 
> Hmm. So I switched to channel 9. 
> 
> Mar 27 17:05:43 tcn kernel: hci_cmd_task: hci0 command tx timeout
> Mar 27 17:05:49 tcn kernel: usb 1-4: USB disconnect, address 7
> Mar 27 17:05:49 tcn hcid[28768]: HCI dev 0 unregistered
> Mar 27 17:05:49 tcn /sbin/hotplug[28997]: unknown command
> Mar 27 17:05:49 tcn /sbin/hotplug[28999]: unknown command
> Mar 27 17:05:49 tcn /sbin/hotplug[28996]: unknown command
> Mar 27 17:05:49 tcn /sbin/hotplug[28998]: unknown command
> Mar 27 17:05:57 tcn kernel: ohci_hcd 0000:00:02.1: wakeup
> Mar 27 17:05:58 tcn kernel: usb 2-4: new full speed USB device using address 3
> Mar 27 17:05:58 tcn hcid[28768]: HCI dev 0 registered
> Mar 27 17:06:01 tcn kernel: hci_cmd_task: hci0 command tx timeout
> Mar 27 17:06:06 tcn sdpd[29323]: init_server: binding L2CAP socket: Address 
> already in use
> Mar 27 17:06:06 tcn sdpd[29323]: main: Server initialization failed
> Mar 27 17:06:06 tcn opd[29327]: OBEX Push Daemon - version 0.2 started
> Mar 27 17:06:06 tcn opd[29327]: OBEX Object Push service registered with sdpd
> Mar 27 17:06:06 tcn opd[29327]: Failed to register BtOBEX server on RFCOMM 
> channel 9. (-1 / 98)
> Mar 27 17:06:35 tcn kernel: hci_cmd_task: hci0 command tx timeout
> 
> Does somebody have a clue on this?

what does "/proc/bus/usb/devices" contain?

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
