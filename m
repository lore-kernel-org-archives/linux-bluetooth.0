Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43FF1F65.3010708@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sdptool fails with ppc6700
References: <C70061B183DE09419568AB2060C52A9501C19892@arion.intra.local>
In-Reply-To: <C70061B183DE09419568AB2060C52A9501C19892@arion.intra.local>
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
Date: Fri, 24 Feb 2006 07:59:49 -0700

Victor

> Try usimg sdptool browse XX:XX:XX:XX:XX:XX --l2cap (some phones do not
> implement Public Browse Group which is used for discovery by default)
> and if this does not help for some phones you have to ask for specific
> profiles to get an answer (new Motorola's): sdptool search --bdaddr
> XX:XX:XX:XX:XX:XX DUN for an example.

thanks... the l2cap scan didn't help, but searching specifically for DUN
did.

The phone still locks up whenever I try to max out the connection so
it's going back unless there's an easy fix. Maybe it's some kind of bad
interaction between bluez and pocketpc. :(

~# sdptool search --bdaddr 00:12:37:BD:9F:xx DUN
Searching for DUN on 00:12:37:BD:9F:xx ...
Service Name: Dial-up Networking
Service RecHandle: 0x10002
Service Class ID List:
  "Dialup Networking" (0x1103)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

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
