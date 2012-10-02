Return-Path: <cyrus@holtmann.org>
Message-ID: <506AD942.5020902@linux.intel.com>
Date: Tue, 02 Oct 2012 14:08:34 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [RFC v2] Convert storage to use per-remote device directories
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

Here is my proposal for new storage directory structure using ini-file 
format.

Each adapter directory (/var/lib/bluetooth/<adapter address>/) will contain:
  - an adapter.conf file for the local adapter
  - an attribute_db.conf file containing attributes of supported LE services
  - one directory per remote device, named by remote device address. A 
directory will contain:
     - a device.conf file
     - a key file accessible only by root
     - an attribute_db.conf file containing attributes of remote LE services

So the directory structure should be:
     /var/lib/bluetooth/<adapter address>/
         ./adapter.conf
         ./attribute_db.conf
         ./<remote device address>/
             ./device.conf
             ./keys.conf
             ./attribute_db.conf
         ./<remote device address>/
             ./device.conf
             ./keys.conf
             ./attribute_db.conf
         ...


The adapter config file just need to be converted to ini-file format 
with only 1 group called [adapter], for example:
   [Adapter]
   Name=desktop-0
   Class=0x780011
   Pairable=true
   OnMode=discoverable
   Mode=discoverable

The attribute_db.conf file should be a list of handles (group name) with 
UUID and Value as keys, for example:
   [0x0001]
   UUID=00002800-0000-1000-8000-00805f9b34fb
   Value=0018

   [0x0004]
   UUID=00002803-0000-1000-8000-00805f9b34fb
   Value=020600002A

   [0x0006]
   UUID=00002a00-0000-1000-8000-00805f9b34fb
   Value=4578616D706C6520446576696365


Remote device config file will include a [device] group with general 
device infos (name, alias, profiles or primary services list, ...), for 
example:
   [Device]
   Name=MyPhone
   Alias=Fred's phone
   Class=0x180204
   DeviceId=FFFF 0000 0000 0000
   EIR=040D040218
   Manufacturer=15
   LmpVersion=2
   LmpSubversion=777
   Features=FFFE0D0008080000
   LastSeen=2012-09-26 11:19:40 GMT
   LastUsed=2012-09-26 11:43:42 GMT
   Trusted=true
 
Profiles=00001101-0000-1000-8000-00805f9b34fb;00001103-0000-1000-8000-00805f9b34fb

For LE devices, LEAddressType entry should exist to distinguish 
LE-Public from LE-Random address.

Keys file will include informations related to link key or long term 
link key, for example:
   [LinkKey]
   Key=9EF4BDFA68C5438A176DF42ACD59816C
   Type=0
   Length=4

   [LongTermKey]
   Key=
   Authenticated=
   EncSize=
   EDiv=
   Rand=

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation



