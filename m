Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: what to do with brcm_patchram_plus?
To: Loic Poulain <loic.poulain@intel.com>,
        linux-bluetooth@vger.kernel.org
References: <7cef65c9-b831-b0bb-8029-38fcd99e75aa@mnementh.co.uk>
 <1f37eeff-7ce8-9242-13bc-0c718b1acefa@intel.com>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <fb50e678-a72f-d5f5-863d-23925a57d7da@mnementh.co.uk>
Date: Mon, 26 Jun 2017 13:22:15 +0100
MIME-Version: 1.0
In-Reply-To: <1f37eeff-7ce8-9242-13bc-0c718b1acefa@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 26/06/17 09:33, Loic Poulain wrote:
> Hi Ian,  > >> >> # brcm_patchram_plus --patchram 
/lib/firmware/bcm/bcm43430a1.hcd >> --no2bytes --tosleep 1000 --bd_addr 
<my_addr> /dev/ttymxc1 >> >> >> # hciattach /dev/ttymxc1 any >> >> >> As 
I understand it, brcm_patchram_plus just loads firmware into >> the 
chip, and hciattach is just hooking the hci-uart driver to the >> serial 
port as a line discipline? >> >> Is this the correct approach? is there 
a better way to get the >> firmware loaded? >> > > Actually, yes, 
bcm43xx is now "in-kernel" supported (firmware > loading, gpio 
switching, low power mode...). From user-space, you > only have to 
attach your tty with the bcm line discipline. btattach > is the 
preferred way. $ btattach -B /dev/ttyX -P bcm > > What is your platform, 
do you have ACPI or Device-tree support ? any > entry corresponding to 
your bcm controller ?
Oh, thats bloody fantastic - I did look, but must have missed it somehow.

The platform is i.MX6ul, so its device-tree based.

Thanks very much, thats a big help!

I guess I'm going to have to actually figure out how to build the bluez
userspace now, I managed to get stuck on the glib dependency, for some
reason... (my current userspace doesnt have btattach)

-Ian

