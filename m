Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem With the Inquiry and RFCOMM conexions
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <006b01c64683$e75b2c90$0300a8c0@akira>
References: <006b01c64683$e75b2c90$0300a8c0@akira>
Content-Type: text/plain; charset=utf-8
Message-Id: <1142256728.4622.1.camel@aeonflux.holtmann.net>
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
Date: Mon, 13 Mar 2006 14:32:07 +0100

Hi,

> I have a problem with make a Inquiry and RFCOMM conexions at the same
> time and don=C2=B4t understand why.....(with BlueZ).

this is a limitation of the hardware. What does "hciconfig hci0 version"
tell you?

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
