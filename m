Return-Path: <oscarp@acay.com.au>
Message-ID: <415C8B5B.3060400@acay.com.au>
Date: Fri, 01 Oct 2004 08:40:27 +1000
From: O Plameras <oscarp@acay.com.au>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: pand freezes upon disconnect
References: <E1CA5Ze-0006Iu-R6@paris.servershost.net>	 <cjad82$qji$1@sea.gmane.org> <1096371695.4950.2.camel@notepaq>	 <cje512$kj5$1@sea.gmane.org> <1096494023.6380.0.camel@pegasus>
In-Reply-To: <1096494023.6380.0.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:

> 
> go ahead and test it, because everything is working prefect on mine
> machines.
> 

I made more tests. I put the results here hoping it
might assist point to the problem.

I found the ff:

1. Installed bluez NAP server on another Linux-2.6.8.1-mm4-mh2
with nobridge-router-nofirewall-bluez. Result: When client
disconnects the server does NOT FREEZE.

2. Installed bluez NAP server on various versions of
Linux-2.6.8.1-mm4-mh1 && mh2; Linux-2.6.8.1-mh1 && mh2 on
bridge-router-firewall-bluez.

When client disconnects the server FREEZES in any combination.

3. Using any setup in item 2, I can disconnect a client without
freezing the server if I disable bluetooth by "rmmod" up till
uhci_hcd at the server first. Then, I reloaded the modules
to restart pand server so I get the client reconnected
successfully.

With these processes, I got the following logs on the server:

br0: port 3(bnep0) entering disabled state
Debug: sleeping function called from invalid context at 
include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():0
  [<c011a45f>] __might_sleep+0x9f/0xb0
  [<c01841cb>] sysfs_hash_and_remove+0x2b/0x108
  [<ccaff5b8>] br_sysfs_removeif+0x18/0x20 [bridge]
  [<ccafc671>] br_del_if+0x31/0x56 [bridge]
  [<ccafd51a>] br_device_event+0xba/0xe0 [bridge]
  [<c01273a8>] notifier_call_chain+0x18/0x40
  [<c02c723e>] unregister_netdevice+0x13e/0x236
  [<c025a82f>] unregister_netdev+0xf/0x20
  [<cc974c00>] bnep_session+0x6f0/0x790 [bnep]
  [<c0105d32>] ret_from_fork+0x6/0x14
  [<c01197c0>] default_wake_function+0x0/0x10
  [<cc974510>] bnep_session+0x0/0x790 [bnep]
  [<c010429d>] kernel_thread_helper+0x5/0x18

device bnep0 left promiscuous mode
br0: port 3(bnep0) entering disabled state
uhci_hcd 0000:00:14.2: remove, state 1
usb usb1: USB disconnect, address 1
usb 1-2: USB disconnect, address 2
uhci_hcd 0000:00:14.2: USB bus 1 deregistered
usbcore: deregistering driver hci_usb
NET: Unregistered protocol family 31
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.7
usbcore: registered new driver hci_usb
Bluetooth: L2CAP ver 2.4
Bluetooth: L2CAP socket layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:14.2
PCI: Sharing IRQ 11 with 0000:00:0a.0
uhci_hcd 0000:00:14.2: UHCI Host Controller
uhci_hcd 0000:00:14.2: irq 11, io base 00002020
uhci_hcd 0000:00:14.2: new USB bus registered, assigned bus number 1
 
