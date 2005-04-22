Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] fixing hidp keycodes
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050422105609.GA16313@externe.net>
References: <20050422105609.GA16313@externe.net>
Content-Type: text/plain
Message-Id: <1114168206.32265.62.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 22 Apr 2005 13:10:06 +0200

Hi Guylhem,

> Yes I did apply mh patches. I can put a copy of the kernel online if
> you want to see it.
> 
> I'm not sure I understand the "report mode". Pressing on a keyboard
> key after hidd --connect make the key work in applications. It's not
> simply reporting.

a HID device can work in two modes, boot mode and report mode. The boot
mode is a limited mode with a predefined descriptor and thus it needs a
keycode mapping table. In report mode the HID parser decodes the HID
report according to his descriptor and then generates the keycode. In
the latter case the hidp_keycodes[] table is not used, but it is a boot
mode only thing.

> hidp_keycode is declared locally in core.c and never used elsewhere.
> input_report_key seems to send hidp_keycode[keys[i]] to the input
> layer. If I printk this, I only see 0. 
> 
> What I want to do on my strange keyboard is :
> swap tab and capslock
> swap capslock and esc
> 
> So I swapped 15 and 58, then 58 and 1 in the hidp_keycodes, but this
> only gets me multiple esc. However, replacing keycodes 65 and 66 by 0
> which where incorrectly send when pressing on a special keyboard
> modifier key worked, as did swapping keycode 30 and 125 (some library
> has keycode 30=modfier hardcoded in, so I had to do a workaround and
> remap the a key to 125 and change the keyboard map accordingly)
> 
> This suggest that my approach should work. I don't understand why it's
> not working with tab/capslock/esc.

To make this working in report mode, you must replace the HID descriptor
or tell hidd to use the boot mode only. Speaking of which, I just saw
that I never added support for pushing a device into boot mode. However
the --nosdp option should do the trick.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
