Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <440C8918.7050304@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO stuck on a Netgear WGT634U (mips)
References: <20060303011433.c498e85e.henryk@ploetzli.ch>	<4407C5CF.6060208@xmission.com>	<20060304024114.38d9b29f.henryk@ploetzli.ch>	<20060304084732.1ee8b518.henryk@ploetzli.ch>	<440BE81C.5040902@porthome.nl> <20060306090140.e1e882d5.henryk@ploetzli.ch>
In-Reply-To: <20060306090140.e1e882d5.henryk@ploetzli.ch>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Mon, 06 Mar 2006 12:10:16 -0700

Henryk

>>I'm using a Energic BT-001 headset (bluetooth 1.1, Motorale chipset)
>>and had a terrible distortion as well. After having disabled
>>automatic endianness fixup in the snd_bt_sco kernel module (line 32
>>btsco.c: 
>>#undef AUTO_FIXUP_BYTESHIFT) it works flawlessly :).
> 
> Yeah, I found that part of the code suspicious too.

I was hoping to take it out when we fixed the underlying problem, but I
can do it sooner if it causes new problems.

For some reason, it appears that damaged sco frames are not tossed out.
They are still accepted and processed. A missing byte in the middle
mixes up byte order and turns the stream into static.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
