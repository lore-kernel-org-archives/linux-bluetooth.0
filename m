Return-Path: <cyrus@holtmann.org>
Subject: Re: HCIConfig - BD Address not updated automatically
From: Marcel Holtmann <marcel@holtmann.org>
To: "Cayetanot, Sebastien" <sebastien.cayetanot@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <79C392C3A040A44895195AED5DB296F7AC3F2A46@irsmsx502.ger.corp.intel.com>
References: <79C392C3A040A44895195AED5DB296F7AC3F2A46@irsmsx502.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 21 Aug 2010 10:36:20 +0200
Message-ID: <1282379780.23399.222.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastien,

> I'm currently facing an issue regarding the command hciconfig.
> 
> On my device :
> 
> I have run hciconfig hci0 in order to check if the hci interface is up and to get the BD_Addr.
> 
> I sent an hcitool cmd to change the BD_Addr. The command is accepted.
> 
> Just after I run the Ifconfig command but the BD_Addr is not changed it still the old one.
> 
> If I use a linux laptop to scan BT device, the device is seen with changed BD_Addr.
> 
> I have sent the hci command manually to read th BD_Addr on my device and the BD_Addr return is the one modified.
> 
> Just after by running Ifconfig, the BD_Addr is updated.
> 
> Is it normal that hciconfig never read the BD_Addr automatically ? even if I do a HIC reset.
> 
> My feeling is that the BD_Addr is read one time at the beginning and never updated until we manually read the BD_Addr using the hci command.
> 
> Any idea? 

this pretty simple, only because you change the BD_ADDR with its vendor
command, it is not magically being used. Neither in software nor in the
firmware of the device. You need to do a soft reset to make this address
active. And then ensure that the kernel HCI layer knows that the reset
has happened.

Which hardware manufacture is this and what type of transport are you
using?

Regards

Marcel


