Return-Path: <trexx@pobox.com>
Subject: Re: [Bluez-users] Logitech Bluetooth  Mx900+keyboard support.
From: Terence Rudkin <trexx@pobox.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1074458664.6070.73.camel@pegasus>
References: <1074457244.3254.17.camel@localhost.localdomain>
	 <1074458664.6070.73.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074480891.2817.10.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Sun, 18 Jan 2004 19:54:52 -0700
List-ID: <bluez-users.lists.sourceforge.net>

Marcel,

Thank you for pointing me to hid2hci  

I have downloaded and compiled hid2hci.  (gcc -Wall hid2hci.c -o hid2hci
) 
Running it I get:
 
 trudkin Last rc=1  07:43:17 /space/Bluez
 $> ./hid2hci -0
Switching device 046d:c703 to HCI mode was successful
 trudkin Last rc=0  07:43:20 /space/Bluez
 $> ./hid2hci -0
Switching device 046d:c703 to HCI mode was successful
 trudkin Last rc=0  07:43:22 /space/Bluez
 $> ./hid2hci -1
No devices in HID mode found
 trudkin Last rc=1  07:43:26 /space/Bluez
 $>
I can set to HCI twice and cannot reset to HID.  Leads me to believe
that it did not take.  I think all the right mods are loaded and hcid is
running.

#> lsmod |grep hci
usb-uhci               26380   0  (unused)
hci_usb                 9752   0  (unused)
bluez                  40324   1  (autoclean) [sco rfcomm l2cap hci_usb]
usbcore                79168   1  [usb-uhci hci_usb hid]
ohci1394               29128   0  (unused)
ieee1394              204612   0  [sbp2 ohci1394]


What am I missing? 

On Sun, 2004-01-18 at 13:44, Marcel Holtmann wrote:
> Hi Terence,
> 
> > Based on the archives, about a month ago, support for this did not
> > exist.  That is because of not being able to switch from HID to HCI
> > mode.   I am using the keyboard an mouse but would like to use the 
> > Bluetooth hub to connect my Palm T3.  
> > 
> > 
> > Has there been any progress on getting this to work?
> > Is there something I can do to help progress this?
> 
> read the archives again. The hid2hci program from CVS supports the
> Logitech Bluetooth hub.
> 
> Regards
> 
> Marcel
> 
-- 
