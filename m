Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Unexpected SMP Command 0x17
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <E3B98393E6037849B63EA428240A651360654F@PGSMSX103.gar.corp.intel.com>
Date: Wed, 22 Mar 2017 08:36:22 +0100
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "Wong, Mun choy" <mun.choy.wong@intel.com>,
        "Zulqarnain, Adam" <adam.zulqarnain@intel.com>,
        "avinashk@marvell.com" <avinashk@marvell.com>
Message-Id: <6C7A2FEB-859E-4161-8EED-2C90A0960F0A@holtmann.org>
References: <E3B98393E6037849B63EA428240A651360654F@PGSMSX103.gar.corp.intel.com>
To: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joshua,

> I am seeing an error during the LE pairing process which makes the pairing to fail. I have two DUTs which uses the Marvell 88W8897.
> Here are my BT settings for both master and slave:
> 
> Master:
> $ btmgmt info
> current settings: powered connectable discoverable bondable ssp br/edr le secure-conn
> 
> Slave:
> $ btmgmt info
> Current settings: powered connectable bondable le advertising secure-conn
> 
> When I initiate the pairing process from the master, I observed the message:
> "Bluetooth: hci0 unexpected SMP command 0x0a from 74:c6:3b:ab:68:ea"
> 
> Where 74:c6:3b:ab:68:ea is the address of the slave device.
> 
> In the btmon log of the master device, it is observed that after the Slave device has transmitted the keys, the Master does not transmit it. Hence, the Slave is not receiving the keys and thus disconnects the link and pairing is failed.
> 
>> ACL Data RX: Handle 128 flags 0x02 dlen 21                               [hci0] 124.801098
>      SMP: Encryption Information (0x06) len 16
>        Long term key: 9ac691e96e85e82ca68f4b6d2abec80f
>> HCI Event: Encryption Change (0x08) plen 4                               [hci0] 124.801261
>        Status: Success (0x00)
>        Handle: 128
>        Encryption: Enabled with AES-CCM (0x01)
>> ACL Data RX: Handle 128 flags 0x02 dlen 15                               [hci0] 124.812761
>      SMP: Master Identification (0x07) len 10
>        EDIV: 0xea3f
>        Rand: 0x806e542a78f55d7c
>> ACL Data RX: Handle 128 flags 0x02 dlen 21                               [hci0] 124.812782
>      SMP: Signing Information (0x0a) len 16
>        Signature key: 4451b8ae0eff90f0a47fb96be53479fb
>> HCI Event: Disconnect Complete (0x05) plen 4                             [hci0] 154.839591
>        Status: Success (0x00)
>        Handle: 128
>        Reason: Remote User Terminated Connection (0x13)
> 
> => At this point, Master should start sending LTK to slave, but Master doesn't send the LTK so Slave disconnects the link and pairing is failed.
> 
> What could possibly cause the master to not send the LTK? My kernel version is v4.1.27 and bluez stack is v5.40. I would appreciate advice on this.

if this is LE Secure Connections, then the LTK is no longer distributed. It is being calculated from ECDH. Please include the complete SMP exchanges. Only then we can see what is going on.

Also keep in mind that 4.1.x kernels are actually rather old. The latest one is 4.10.x and if there is a bug, you should verify that it also happens with the latest kernel.

Regards

Marcel

