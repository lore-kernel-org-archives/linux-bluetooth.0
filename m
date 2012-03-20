Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Device Information Service and Battery Service bluez plugins
Date: Tue, 20 Mar 2012 15:57:24 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B452C7D@DNCE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

In the next few days I'll be sending patches for Device Information Service, and Battery Service implemented as bluez plugins.

Device Information Service
--------------------------
The Device Information Service will provide the first required functionality - read the remote device PNPID over GATT. This data will be saved in the brd_device current DID data (vendor, version, product and the newly added vendor_src). The data will be read from the peer GATT Server once, and will be saved for the device.

Battery Service
-----------------
The Battery service allows a host to gather battery status from the peer devices over GATT. The Battery Service will add a new API :

BlueZ D-Bus Battery API description
****************************************

	Texas Instruments, Inc. <chen.ganir@ti.com>

Battery Service hierarchy
=====================================

Service		org.bluez
Interface	org.bluez.Battery
Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/BATTYYYY


Methods	dict GetProperties()

			Returns all properties for the interface. See the
			Properties section for the available properties.

Signals		PropertyChanged(string name, variant value)

			This signal indicates a changed value of the given
			property.

Signals		PropertyChanged(string name, variant value)

			This signal indicates a changed value of the given
			property.

Properties	byte Namespace [readonly]

			Namespace value from the battery format characteristic
			descriptor.Combined with Description provides a unique
			battery identifyer if multiple batteries are supported.

		uint16 Description [readonly]

			Description value from the battery format characteristic
			descriptor. Combined with Namespace provides a unique
			battery identifyer if multiple batteries are supported.

		byte Level [readonly]

			Battery level (0-100).

The batteries will be published as a collection of object ID's for a device, and will look like this when executing GetProperties on a device :
dict entry(
         string "Batteries"
         variant             array [
               object path "/org/bluez/15515/hci0/dev_3C_2D_B7_85_EC_C2/BATT0000"
               object path "/org/bluez/15515/hci0/dev_3C_2D_B7_85_EC_C2/BATT0001"
            ]
      )

A new interface, called org.bluez.Battery will be registered for each new battery object path, and the GetProperties function will look like this:
method return sender=:1.625 -> dest=:1.632 reply_serial=2
   array [
      dict entry(
         string "Namespace"
         variant             byte 0
      )
      dict entry(
         string "Description"
         variant             uint16 0
      )
      dict entry(
         string "Level"
         variant             byte 91
      )
   ]

Patches will be sent as soon as the previous patches are applied.

BR,

Chen Ganir
Texas Instruments
