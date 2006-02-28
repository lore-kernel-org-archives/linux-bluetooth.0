Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm socket connect timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060228155006.GR6529@beta.private.mielke.cc>
References: <1141132514.18703.6.camel@localhost.localdomain>
	 <20060228145922.GQ6529@beta.private.mielke.cc>
	 <1141139992.29228.0.camel@localhost>
	 <20060228155006.GR6529@beta.private.mielke.cc>
Content-Type: text/plain
Message-Id: <1141142881.29228.10.camel@localhost>
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
Date: Tue, 28 Feb 2006 17:08:01 +0100

Hi Dave,

> >you are looking for the page timeout (hciconfig hci0 pageto).
> 
> Thanks. I guess I'm not up on Bluetooth terminology. Is there a way to set it
> via something like setsockopt()? I can't find a constant that looks like it'll
> do it under "HCI socket options" in hci.h.

no, because it is global (ACL) option and not RFCOMM specific.

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
