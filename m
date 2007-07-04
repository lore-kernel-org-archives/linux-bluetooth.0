Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <18a15270707031238n2cfe388ay3843e6939b890a8f@mail.gmail.com>
References: <18a15270707021204o3ffc0021pc3f0d4b0ec278c39@mail.gmail.com>
	<1183433306.6351.19.camel@aeonflux.holtmann.net>
	<18a15270707031238n2cfe388ay3843e6939b890a8f@mail.gmail.com>
Date: Wed, 04 Jul 2007 03:55:13 +0200
Message-Id: <1183514113.6351.53.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: cbe-oss-dev@ozlabs.org
Subject: Re: [Bluez-devel] [PATCH] bluetooth: reset unexpected connections
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Ranulf,

> 
> > this is not a proper fix for this problem. And you only reset the
> local
> > host controller. There is no way to send a reset to the remote
> device.
> 
> 
> I'm pretty new to both bluetooth and HID in general, so I'm happy to
> take your word for it that I'm doing the wrong thing. I would dispute
> the claim that there is no way to send a reset to the remote device,
> as calling hci_reset_req causes the remote device to stop sending
> packets almost immediately (5 more packets arrive compared to 70 per
> second before). Even the lights turn off immediately. 

no. You reset the local controller and it will tear down every piconet.
That you don't see no packets on HCI doesn't mean that no packets are
sent from the remote device anymore. And there is no way to send a reset
to a remote device. Period.

> I don't know enough about the stack to know exactly what is going on,
> but certainly hci_reset_req does appear to send a reset command
> somewhere:
> 
>     hci_send_cmd(hdev, OGF_HOST_CTL, OCF_RESET, 0, NULL); 
> 
> and it takes a hdev which as far as I can make it represents a
> specific connection to a remote device rather than the entire local
> stack.

No. The hdev only represents a local device.

> > Did you ever used hcidump and try to find out, why the other side
> still 
> > things that we are connected. Especially why the local controller
> things 
> > that we are still connected.
> 
> Obviously, as these devices are already pumping out data before the
> machine boots, I've no way of tracking what if any negotiation linux
> might have attempted to make with them. There's nothing interesting in
> the syslog before that point:
> 
> Jul  3 18:41:52 ps3 kernel: eth0: no IPv6 routers present
> Jul  3 18:41:52 ps3 hcid[2291]: Bluetooth HCI daemon
> Jul  3 18:41:52 ps3 kernel: Bluetooth: L2CAP ver 2.8
> Jul  3 18:41:52 ps3 kernel: Bluetooth: L2CAP socket layer initialized
> Jul  3 18:41:52 ps3 hcid[2291]: HCI dev 0 registered
> Jul  3 18:41:52 ps3 hcid[2291]: Starting SDP server
> Jul  3 18:41:52 ps3 kernel: Bluetooth: HIDP (Human Interface
> Emulation) ver 1.2
> Jul  3 18:41:52 ps3 hcid[2291]: HCI dev 0 up
> Jul  3 18:41:52 ps3 hcid[2291]: Device hci0 has been added
> Jul  3 18:41:53 ps3 hidd[2302]: Bluetooth HID daemon
> Jul  3 18:41:53 ps3 kernel: hci_acldata_packet: hci0 ACL packet for
> unknown connection handle 43 () 
> Jul  3 18:41:53 ps3 kernel: hci_acldata_packet: hci0 ACL packet for
> unknown connection handle 47 ()
> Jul  3 18:41:53 ps3 last message repeated 3 times
> Jul  3 18:41:53 ps3 hcid[2291]: Device hci0 has been activated 
> Jul  3 18:41:53 ps3 kernel: hci_acldata_packet: hci0 ACL packet for
> unknown connection handle 43 ()
> Jul  3 18:41:53 ps3 last message repeated 3 times
> Jul  3 18:41:53 ps3 kernel: hci_acldata_packet: hci0 ACL packet for
> unknown connection handle 47 () 
> Jul  3 18:41:53 ps3 last message repeated 3 times
> 
> Certainly nothing in the data has changed, which is exactly the same
> as before the reboot (here are two devices broadcasting
> simultaneously):
> 
> > ACL data: handle 47 flags 0x02 dlen 54 
>     L2CAP(d): cid 0x0041 len 50 [psm 0] 
>       A1 01 00 00 00 00 00 8B 79 8C 78 00 00 00 00 00 00 00 00 00 
>       00 00 00 00 00 00 00 00 00 00 03 03 14 FF B5 00 12 23 FA 77 
>       01 81 02 07 01 EE 01 96 00 02 
> > ACL data: handle 43 flags 0x02 dlen 54 
>     L2CAP(d): cid 0x0041 len 50 [psm 0]
>       A1 01 00 00 00 00 00 79 7A 77 7F 00 00 00 00 00 00 00 00 00 
>       00 00 00 00 00 00 00 00 00 00 03 05 14 FF BA 00 0C 23 16 77 
>       01 81 02 07 01 EF 01 94 00 02 
> > ACL data: handle 43 flags 0x02 dlen 54
>     L2CAP(d): cid 0x0041 len 50 [psm 0]
>       A1 01 00 00 00 00 00 79 7A 77 7F 00 00 00 00 00 00 00 00 00 
>       00 00 00 00 00 00 00 00 00 00 03 05 14 FF BA 00 0C 23 16 77 
>       01 81 02 07 01 EF 01 93 00 02 
> 
> etc.
> 
> Additionally, because the linux subsystem hasn't connected with them
> at this point, there's no way of initiating a connection with them or
> stopping them: 

That makes no sense. The HID devices can re-connect. However they have
to indicate this via requesting a ACL connection. Otherwise we can't
know what to do with the data packets.

> > The PS3 remote controller (and the PS3 itself) have special hacked
> up
> > version of Bluetooth firmware to play nice with remote wakeup. So
> it 
> > might simply be an issue with them and it might be better we declare
> > them broken instead of adding nasty crap in a clean Bluetooth core.
> Your 
> > patch is nasty crap since I haven't seen any real argument why we
> should
> > reset our local controller in that case. It is wild guessing.
> 
> 
> You might be happy to declare these controllers broken, however they
> exist and people want to use them. 
> 
> Do you have any suggestions of an alternative approach to handling
> this error condition rather than just filling up the syslog? It's
> definitely a very real DOS possibility - my syslog was growing by
> about 1Mb per minute with just two regular controllers. Someone who
> deliberately constructed a device to bombard a linux box with junk
> bluetooth data could probably fill someone's /var partition in a
> matter of hours. 

It is not a DoS, because you have to connect it first. And obviously you
told your PS3 remote controller to user your system.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
