Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Device Busy during "hcitool info" or
	"sdptoolsearch"
From: Marcel Holtmann <marcel@holtmann.org>
To: ag@new-media-artists.de
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <FJENILNPNAGPJMMDOKDCKEKBDJAA.ag@new-media-artists.de>
References: <FJENILNPNAGPJMMDOKDCKEKBDJAA.ag@new-media-artists.de>
Content-Type: text/plain
Message-Id: <1071689683.27571.108.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 Dec 2003 20:34:43 +0100

Hi Andreas,

> hciconfig revision tells me that both chips have HCI 16.4 (bc02x) so i
> checked hcidump -x , heres whats happening:
> 
> Wokring inq:
> < HCI Command: Inquiry(0x01|0x0001) plen 5
>   33 8B 9E 08 0A
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 01 04
> 
> Not wokring inq:
> < HCI Command: Inquiry(0x01|0x0001) plen 5
>   33 8B 9E 08 0A
> > HCI Event: Command Status(0x0f) plen 4
>   0C 01 01 04
> 
> Do i guess right when i think that the differing "0C" means "Command
> disallowed" like discribed in BT 1.2 Core Spec, Vol 2, Core System Package,
> Part D (Error Codes) ?

the error code is correct and this is a problem of the firmware on the
chip. For me this is working fine on any CSR chip with HCI 16.x.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
