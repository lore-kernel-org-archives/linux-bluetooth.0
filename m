Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Galibert <galibert@pobox.com>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>, maxk@qualcomm.com,
        bluez-devel@lists.sf.net
In-Reply-To: <20060314111248.GA75477@dspnet.fr.eu.org>
References: <20060314111248.GA75477@dspnet.fr.eu.org>
Content-Type: text/plain
Message-Id: <1142344144.4448.3.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [PATCH] Fix SCO on Broadcom Bluetooth adapters
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
Date: Tue, 14 Mar 2006 14:49:03 +0100

Hi Olivier,

> Broadcom USB Bluetooth adapters report a maximum of zero SCO packets
> in-flight, killing SCO.  Use a reasonable count instead in that case.
> 
> Signed-off-by: Olivier Galibert <galibert@pobox.com>
> 
> ---
> 
> I don't think that could be reasonably done as a quirk.  Simple
> examination of the .inf coming with the windows driver shows that 100+
> different models may be having this problem.  Also, it can't break
> already working adapters, so why bother.

your patch might break devices where this value is chosen on purpose, so
it is not acceptable and must be done with a quirk. Another reason is
that I don't allow any stupid vendor specific workarounds inside the
Bluetooth core unless they are implemented as quirks. The core has no
vendor information at all.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
