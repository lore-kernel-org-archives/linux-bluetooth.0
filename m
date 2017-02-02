Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Update the connection's parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <45ee6cfc-7871-c600-0881-2ae7fa9a6955@felipetonello.com>
Date: Thu, 2 Feb 2017 11:30:21 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6B5EC9A7-4E31-4548-9F53-AFEC0163796D@holtmann.org>
References: <0770df3d-7d10-09be-5667-a652104f66bb@felipetonello.com>
 <09B30424-316E-4423-9547-660CE6F902E7@holtmann.org>
 <45ee6cfc-7871-c600-0881-2ae7fa9a6955@felipetonello.com>
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

>>> I've been working on the MIDI profile plugin for bluetoothd. This
>>> profile requires the lowest latency and connection interval possible. In
>>> order to do that we need to update the connection parameters. There are
>>> two ways of doing it, first is upon connection
>>> (HCI_LE_Create_Connection) and second is updating current connection
>>> link (HCI_LE_Connection_Update).
>>> 
>>> The first time an LE slave (MIDI controller) device is connected to
>>> BlueZ, the plugin should be able to set this parameters for current
>>> connection and save these settings for persistence purposes.
>>> 
>>> As of today, bluetoothd does support the persistence mechanist, which is
>>> triggered by a mgmt's New Connection Parameter (0x001c) command, which
>>> in turn is triggered by L2CAP Connection Parameter Update Request or a
>>> HCI LE Remote Connection Parameter Request (BT 4.1).
>>> 
>>> As mentioned before, this is not enough. Specially because in practice
>>> LE slave devices don't send a any of those two requests mentioned above.
>>> 
>>> My idea is to set the connection parameter using
>>> HCI_LE_Connection_Update if one of the host controllers, master or
>>> slave, only supports 4.0. Then update the device info file with current
>>> ConnectionParameters for persistence.
>>> 
>>> In case both controllers support 4.1 and above, we should use the
>>> Connection Parameters Request Procedure (BT 4.1 Vol 6 Part B §5.1.17) in
>>> order to negotiate what is the best parameters for the connection.
>>> 
>>> I hope this makes sense. If not, I appreciate your comments. :)
>> 
>> we need to introduce a L2CAP socket option that allows for setting some of the connection parameters. So that the kernel can consolidate these and request them.
> 
> Yes, this sounds great. What would you recommend to implement then?
> Using SOL_L2CAP or SOL_SOCKET with a new optname?

we want to use SOL_BLUETOOTH. Unless there is a common SOL_SOCKET that would map here, but I hight doubt that is the case.

>> I am not 100% we want to expose the actual values. Maybe it is better to have a latency parameter with high, default and low as values.
>> 
> 
> Yes.
> 
> What would this option trigger the controller to do? Because as I have
> seen it really depends on HCI role and BT version, but I am not an
> expert in BT, so I appreciate any comments.

It should not matter from the API point of view if you do this as slave or master. However inside the kernel, it needs to map to the right connection update procedure.

Regards

Marcel

