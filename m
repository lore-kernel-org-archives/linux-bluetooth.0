Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Creating LE device nodes in BlueZ
Date: Wed, 18 Jan 2012 07:47:45 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B41DE35@DNCE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All,

I've encountered some usage problems with the current connection and device node creation schemes, which I believe need to be changed for LE devices.

In today's implementation, in order to connect to an LE device, we first need to create it's node (using adapter function CreateDevice or CreatePairedDevice). This causes the bluez stack to create the node, browse for SDP in BR/EDR devices, or do primary services search on an LE device. This requires connecting to a device. This causes the first usability issue - what happens to the device after we are done searching for primary services ? What if the device requires user interaction for getting into discoverable/connectable mode ? In that case, the user will have to push a button on the device again, so we can connect to it for GATT profiles. This is a serious flaw in the user experience, and is caused by trying to mimic the BR/EDR experience, where you have the full list of services once device node is created.

Another problematic user experience issue is caused due to the fact that we try to do "Dedicated bonding" with an LE device, although we do not have such an operation method in the LE specs.

We need to think of a better way to manage and handle LE devices.

For example, device nodes will be created upon device found events, in the bluetoothd. Whenever a device found, a node will be created, without browsing for primary services at all. To manage the list properly, whenever a device search is initiated, the list is cleaned from unbounded devices, which do not have any primary services discovered for it. This way we can keep the persistant list short, containing only relevant devices (Ones that we've already connected to, or bonded devices.

Another example is to eliminate the possibility to CreatePairedDevice with LE devices. There is no such procedure, and there is not point in creating such a method when it is not defined by the specs or user scenarios.

We should always search for primary services on connection, if needed. This is actually how the spec defines this. When a GATT client connects to a remote GATT server, it may search for primary services (profile specs actually describe this as part of the profile behavior). If the device is bonded, and the service list is already populated, it is not needed to go through this procedure, since the GATT client supports the Service Changed notification (Mandatory on clients) and the GATT server must support Service Changed notification if it supports dynamic services. So the basic procedure should be connect->check if not bonded or list empty->search for services. This can be handled internally by the bluetoothd. For this to work properly we need to change the way connection is established with a remote LE device as well, since you cannot register a service watcher on a service, which was not yet discovered. On the other hand, a profile always knows the remote service which it needs to register for, so you can always register for a service, and never get notified if the remote service does not exist, or get an error, depending on the implementation we choose.

In addition, connection must be established in Mode 1 Level 1 (no security). If we try to do something that requires security, we may :
1. Change security level if we have a key.
2. Respond correctly for an incoming SMP pairing request from the slave
3. Raise the security level if we need to (GATT authentication error, profile initiated security request). This will require either encryption start request if we have a key, or pairing request if we do not have one.

We also need to allow a profile to request a specific security mode. This is the profile responsibility, and not the bluetoothd responsibility to decide which security level to use.

What do you guys think ?


Thanks,
Chen Ganir.
