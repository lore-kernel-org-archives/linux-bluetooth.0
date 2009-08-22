Return-Path: <cyrus@holtmann.org>
Subject: Re: Testing bluetooth device: Virtual HCI device
From: Marcel Holtmann <marcel@holtmann.org>
To: Neeraj kushwaha <kushneeraj@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <df5e18bd0908202359m76f97dfemfc3b77afda8b516c@mail.gmail.com>
References: <df5e18bd0908202359m76f97dfemfc3b77afda8b516c@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 22 Aug 2009 13:00:42 -0700
Message-Id: <1250971243.2950.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Neeraj,

> I have started to learn BT and to see how it works. I want to test
> bluetooth from Virtual HCI device.
> 
> I did following steps but still could not get through.
> 
> # modprove hci_vhci
> Kernel: Bluetooth: Virtual HCI driver ver 1.2
> 
> # ls -l /dev/vhci
> crw-rw---- 1 root root 10,58 2009-08-21 11:22 /dev/vhci
> 
> # hciemu localhost:10
> # hciemu localhost:11
> 
> # hciconfig hci0 up
> # hciconfig hci1 up
> 
> # hciconfig -a
> hci0:   Type: VIRTUAL
>        BD Address: 7F:00:00:01:00:0A ACL MTU: 192:8 SCO MTU: 0:0
>        UP RUNNING
>        RX bytes:0 acl:0 sco:0 events:35 errors:0
>        TX bytes:681 acl:0 sco:0 commands:35 errors:0
>        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>        Link policy:
>        Link mode: SLAVE ACCEPT
>        Name: 'BlueZ (0)'
>        Class: 0x4a0100
>        Service Classes: Networking, Capturing, Telephony
>        Device Class: Computer, Uncategorized
>        HCI Ver: 2.0 (0x3) HCI Rev: 0x0 LMP Ver: 2.0 (0x3) LMP Subver: 0x0
>        Manufacturer: Qualcomm (29)
> 
> hci1:   Type: VIRTUAL
>        BD Address: 7F:00:00:01:00:0B ACL MTU: 192:8 SCO MTU: 0:0
>        UP RUNNING
>        RX bytes:0 acl:0 sco:0 events:34 errors:0
>        TX bytes:680 acl:0 sco:0 commands:34 errors:0
>        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>        Link policy:
>        Link mode: SLAVE ACCEPT
>        Name: 'BlueZ (1)'
>        Class: 0x4a0100
>        Service Classes: Networking, Capturing, Telephony
>        Device Class: Computer, Uncategorized
>        HCI Ver: 2.0 (0x3) HCI Rev: 0x0 LMP Ver: 2.0 (0x3) LMP Subver: 0x0
>        Manufacturer: Qualcomm (29)
> 
> # l2ping 7F:00:00:01:00:0B
> Can't connect: Connection refused

the hciemu was never a full Bluetooth emulation. So some things might
work and others don't. Bluetooth USB dongles are so cheap these days
that everybody tests with real hardware.

Regards

Marcel


