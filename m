Return-Path: <philipl@mail.utexas.edu>
Message-ID: <4498AC55.2020700@mail.utexas.edu>
Date: Tue, 20 Jun 2006 19:17:57 -0700
From: Philip Langdale <philipl@mail.utexas.edu>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: Observations from mx-5000 bluetooth keyboard + mouse combo
References: <448D88EE.3030902@mail.utexas.edu> <1150540883.17539.38.camel@aeonflux.holtmann.net>
In-Reply-To: <1150540883.17539.38.camel@aeonflux.holtmann.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
 >> 4) In HID report mode, the HWHEEL is mangled at some point. Instead of
>>    reporting a usage of 0x10036, it reports 0xC0238, causing it to be
>>    marked as an unknown button. I put a hack into hidp's hid.c to catch
>>    this case and rewrite the usage. The rest of the characteristics seem
>>    to be correct and the horizontal scrolling works correctly.
>>
>>    I don't know if the mouse is just reporting the wrong value or if the
>>    usage is getting mangled somewhere in the stack.
> 
> If you think the HID report descriptor is wrong, then I prefer to fix it
> instead of adding workarounds to kernel code. We did the same for the
> EPoX presenter. Please check if a modified HID report descriptor can
> solve your problem.

Heh. I looked at the USB HID code and they handle Consumer 0x238 by
mapping it to HWHEEL. So this is more common than just this mouse.

So, that's one argument in favour of resync'ing.

>> 5) The keyboard also sees modified usages, but this is definitely in the
>>    hidp driver:
>>
>>    This step is in hidinput_configure_usage:
>>
>>    while (usage->code <= max && test_and_set_bit(usage->code, bit)) {
>>        usage->code = find_next_zero_bit(bit, max + 1, usage->code);
>>    }
>>
>>    eg: It mangles KEY_UNDO (131) into KEY_SENDFILE (145) which doesn't
>>    seem very useful.
>>
>>    It's not the end of the world if the desktop environment/application
>>    supports configurable keybindings, but it's still not correct.
> 
> Can't tell you the reason for it. Maybe it is a bug or maybe this has
> been done on purpose. Please check with the USB HID driver.

This sequence is the same in the usb hid driver. It's also worth
pointing out that it does useful stuff for other types of events, but
for these consumer keys, it does that mangling. Maybe resync'ing will
fix it by another change in some other part of the code.

>> 6) The keyboard has HID consumer reports that hidp doesn't know about.
>>    So, I added entries for them in hidinput_configure_usage and now they
>>    work fine.
> 
> Please check with the USB HID driver from latest vanilla kernel. Maybe
> we need to sync these two drivers again.

Some of the new codes are now covered, but others are not. I guess I
should talk to the USB HID maintainer about that.

Thanks,

--phil
