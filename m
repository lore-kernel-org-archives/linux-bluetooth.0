Return-Path: <cyrus@holtmann.org>
Message-ID: <4C80CE3E.8020004@linux.intel.com>
Date: Fri, 03 Sep 2010 12:30:22 +0200
From: Sebastien Cayetanot <sebastien.cayetanot@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: BD address changed but pairing failed
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  All,

I'm currently facing an issue regarding the pairing of BT devices after 
having change the BD_Addr.


I use a TI chip and also use hci command or bdaddr script to modify the 
bd_addr

I'm also using the bluez-4.69

I change the BD_Addr using the bdaddr scripts provided into the bluez src.

When other devices scan me, the new address is seen but hciconfig still 
show the old BD address.

I have sent the hcitool cmd to read the bd_addr and after the hciconfig 
return the one.

I'm discoverable with the new BD address.

But When I try to pair an A2DP headset or BT Keyboard/Mouse it failed 
since BD_Addr change.

I have try to use directly the hcitool cmd using the vendor specific 
command but I got the same result.

I have tried to kill bluetooth daemon and restart it after having change 
the bd_addr. Still failing.

I have tried to kill bluetooth daemon before changing the BD adress and 
start it after the change it still fail.

I have also tried to power on/off interface. still the issue

I think that something is "broken" is bluez when the BD_Addr is changed.

Is someone already seen this issue ?

Regards

Seb
