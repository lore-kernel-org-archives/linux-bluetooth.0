Return-Path: <cyrus@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>, npelly@google.com
Message-Id: <13A0D73F-E895-4291-B1DE-3589CCD24EB1@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: pavan_savoy@indiatimes.com
In-Reply-To: <1026773358.244421227304435724.JavaMail.root@mbv7.indiatimes.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Place-Holder for a driver
Date: Sun, 23 Nov 2008 02:41:55 +0100
References: <1026773358.244421227304435724.JavaMail.root@mbv7.indiatimes.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

> The OMAP Zoom2 board has a bluetooth chip which needs to be enabled  
> to be used. When running on Android, the Bluetooth service of  
> Android uses the rfkill sysfs entry to turn on bluetooth.
>
> So I linked the Bluetooth enable GPIO to the sys-fs entry, Now the  
> question is where should/does this driver fit in ?
>
> I've thought of drivers/misc, Any suggestions are welcome.

it depends a little bit. If it is purely architecture specific then it  
might fit better with the arch drivers. If it is has a more general  
use, then drivers/misc/ is fine. Drivers like thinkpad_acpi (which  
includes the Bluetooth rfkill switch) are also located there.

Regards

Marcel

