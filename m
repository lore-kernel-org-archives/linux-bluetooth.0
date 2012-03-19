Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Battery Service exposing device battery properties
Date: Mon, 19 Mar 2012 12:51:46 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B45215B@DNCE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

Adding the battery service into the bluez, requires exposing the battery array (may be more than one) to the users. The internal implementation can be fairly easy, adding a GSList of btd_battery_info structures to the btd_device. This btd_battery_info may look like this :

struct btd_battery_info {
	uint8_t		namespace;
	uint16_t	description;
	uint8_t		level;
};

The batteries information should also be exposed using D-BUS interface. As this is a device property, which needs to be read when using the GetProperties D-BUS method, as well as be notified using the PropertyChanged signal from a device.

One logic way to display this information, is to add an array of object paths to the GetProperties dictionary, which will look like this :

    dict entry(
        string "Batteries"
        variant             array [
              object path "/org/bluez/14503/hci0/dev_3C_2D_B7_85_EC_C2/BATT01"
              object path "/org/bluez/14503/hci0/dev_3C_2D_B7_85_EC_C2/BATT02"
              object path "/org/bluez/14503/hci0/dev_3C_2D_B7_85_EC_C2/BATT03"
           ]
     )

This array represents the batteries in the system. A org.bluez.Battery interface will be added, including the function GetProperties. When you execute the GetProperties on a battery object path, you will get this :

   array [
      dict entry(
         string "NameSpace"
         variant             byte 1
      dict entry(
         string "Description"
         variant             uint16 44
      )
      dict entry(
         string "Level"
         variant             byte 94
      )
   ]

This will represent a single battery information element.

The problem here is with the PropertyChanged, which needs to include a String and a value. For that, we can do something like this :

signal sender=:1.558 -> dest=(null destination) serial=200 path=/org/bluez/14503/hci0/dev_3C_2D_B7_85_EC_C2/BATT02; interface=org.bluez.Battery; member=PropertyChanged
   array [
      dict entry(
         string "Level"
         variant byte 93
      )
   ]

However, having interfaces for each battery makes things complex, since you need to parse events on a new interface (org.bluez.Battery) and parse new object paths, and will need to figure out how to translate BATT01 into Battery with namespace/description. In addition, the PropertyChanged needs to be sent over org.bluez.Battery interface or org.bluez.Device interface.

What do you think ? How can I try and simplify this ?

Thanks,


Chen Ganir
Texas Instruments
