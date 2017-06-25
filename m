Return-Path: <ian@mnementh.co.uk>
Subject: Re: what to do with brcm_patchram_plus?
From: Ian Molton <ian@mnementh.co.uk>
To: linux-bluetooth@vger.kernel.org
References: <7cef65c9-b831-b0bb-8029-38fcd99e75aa@mnementh.co.uk>
Cc: marcel@holtmann.org, johannes@sipsolutions.net
Message-ID: <f1cdd0ec-e0b2-010b-7d40-3b2e42392bab@mnementh.co.uk>
Date: Sun, 25 Jun 2017 20:49:34 +0100
MIME-Version: 1.0
In-Reply-To: <7cef65c9-b831-b0bb-8029-38fcd99e75aa@mnementh.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Replying to myself here...

It seems to me that my system would be considered to have a "soft"
rfkill line, in that the state can be changed from userspace (effectively
turning the hardware on and off).

One approach would be to implement rfkill code that picks up the gpio
state change, and notifies userspace - at which point userspace can
push the firmware up to the device, and call hciattach to re-attach the
interface to the UART.

Is that "correct usage" ?

It seems to me that we only *really* want to power up the bluetooth
device if someone attempts to hciattach it to a UART, so perhaps a better
solution would be to modify the hci_uart code such that it will enable the
GPIO when it is attached, and push the firmware for itself.

I favour the latter approach, as it should work perfectly across sus/res and
wont leave the BT device powered if its not attached to a UART.

Thoughts?

-Ian


On 25/06/17 17:26, Ian Molton wrote:
> Hi,  > > > I've been attempting to get bluetooth working on a broadcom 
43430 > chip, on 4.12-rc6. > > I've got it to work, at least somewhat. > 
 > I'm using: > > # brcm_patchram_plus --patchram 
/lib/firmware/bcm/bcm43430a1.hcd > --no2bytes --tosleep 1000 --bd_addr 
<my_addr> /dev/ttymxc1 > > > # hciattach /dev/ttymxc1 any > > > As I 
understand it, brcm_patchram_plus just loads firmware into the > chip, 
and hciattach is just hooking the hci-uart driver to the serial > port 
as a line discipline? > > Is this the correct approach? is there a 
better way to get the > firmware loaded? > > I've also read that 
btattach should be used instead of hciattach? is > this the case? > > > 
 > -Ian -- To unsubscribe from this list: send the line "unsubscribe > 
linux-bluetooth" in the body of a message to > majordomo@vger.kernel.org 
More majordomo info at > http://vger.kernel.org/majordomo-info.html
