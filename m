Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Philip Langdale <philipl@mail.utexas.edu>
In-Reply-To: <448D88EE.3030902@mail.utexas.edu>
References: <448D88EE.3030902@mail.utexas.edu>
Date: Sat, 17 Jun 2006 12:41:23 +0200
Message-Id: <1150540883.17539.38.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Observations from mx-5000 bluetooth keyboard +
	mouse combo
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Philip,

> I originally sent these observations at the end of april but
> you were busy at that time and I guess it passed by without
> you noticing.

looks like I missed that.

> 0) Everything works fine in HID mode. All the buttons on the mouse
>    and keyboard work correctly at the input level as reported by evtest.
> 
> 1) The patch to hid2hci.c that Trevor Joynson provided and which was
> incorporated is not correct - and this is consistent with the reported
> experience of other people with the di novo laser desktop combo.

I have no idea what you are talking about. If you think that something
is wrong, please provide a patch to fix it.

> 4) In HID report mode, the HWHEEL is mangled at some point. Instead of
>    reporting a usage of 0x10036, it reports 0xC0238, causing it to be
>    marked as an unknown button. I put a hack into hidp's hid.c to catch
>    this case and rewrite the usage. The rest of the characteristics seem
>    to be correct and the horizontal scrolling works correctly.
> 
>    I don't know if the mouse is just reporting the wrong value or if the
>    usage is getting mangled somewhere in the stack.

If you think the HID report descriptor is wrong, then I prefer to fix it
instead of adding workarounds to kernel code. We did the same for the
EPoX presenter. Please check if a modified HID report descriptor can
solve your problem.

> 5) The keyboard also sees modified usages, but this is definitely in the
>    hidp driver:
> 
>    This step is in hidinput_configure_usage:
> 
>    while (usage->code <= max && test_and_set_bit(usage->code, bit)) {
>        usage->code = find_next_zero_bit(bit, max + 1, usage->code);
>    }
> 
>    eg: It mangles KEY_UNDO (131) into KEY_SENDFILE (145) which doesn't
>    seem very useful.
> 
>    It's not the end of the world if the desktop environment/application
>    supports configurable keybindings, but it's still not correct.

Can't tell you the reason for it. Maybe it is a bug or maybe this has
been done on purpose. Please check with the USB HID driver.

> 6) The keyboard has HID consumer reports that hidp doesn't know about.
>    So, I added entries for them in hidinput_configure_usage and now they
>    work fine.

Please check with the USB HID driver from latest vanilla kernel. Maybe
we need to sync these two drivers again.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
