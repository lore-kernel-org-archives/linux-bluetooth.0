Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <440BE81C.5040902@porthome.nl>
From: Pieter Poorthuis <pieter@porthome.nl>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO stuck on a Netgear WGT634U (mips)
References: <20060303011433.c498e85e.henryk@ploetzli.ch>	<4407C5CF.6060208@xmission.com>	<20060304024114.38d9b29f.henryk@ploetzli.ch> <20060304084732.1ee8b518.henryk@ploetzli.ch>
In-Reply-To: <20060304084732.1ee8b518.henryk@ploetzli.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 06 Mar 2006 08:43:24 +0100


>
> Not completely solved yet, since the sound I hear in my headset is
> anything from inaudible to heavily distorted, but at least the SCO
> packets happily go in and out, so that should be solvable for me.
>
>   
I'm using a Energic BT-001 headset (bluetooth 1.1, Motorale chipset) and 
had a terrible distortion as well. After having disabled automatic 
endianness fixup in the snd_bt_sco kernel module (line 32 btsco.c: 
#undef AUTO_FIXUP_BYTESHIFT) it works flawlessly :).

Btw, this headset costed me Euro 12.50, so is this the cheapest headset 
that works with btsco...?

Pieter


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
