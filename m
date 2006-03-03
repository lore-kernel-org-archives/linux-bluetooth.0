Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] The new D-Bus API specification
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0603021302h2ffbcd80y1a9c46bf93e51278@mail.gmail.com>
References: <1140652705.4519.71.camel@localhost>
	 <1140807942.7264.44.camel@localhost>
	 <e1effdeb0603021302h2ffbcd80y1a9c46bf93e51278@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1141394159.4814.3.camel@aeonflux.holtmann.net>
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
Date: Fri, 03 Mar 2006 14:55:58 +0100

Hi Claudio,

> I tested the latest bluez-utils CVS version with the recent D-Bus
> changes and I have some comments:
> 
> * Policy
> I'm not sure, but I think some linux distributions use pam_console
> instead of at_console. We sould investigate more to avoid future
> problems. Another thing are the rules. at_console aims provide a way
> to refer to users that are not physically sitting in front of the
> computer. I tested send D-Bus messages from the local host or
> connected through ssh and I didn't noticed differences. I mean, the
> behaviour is the same. Remote users still able to send D-Bus messages.

actually the at_console should be transparent between different Linux
distributions. However we need to verify that it works on at least
Fedora, SuSE, Debian and Ubuntu.

> * Device->Adapter
> Maybe should be better if we rename the function names and constants
> too. Or remove the prefix "dev" and "DEV". These prefixes were added
> to avoid confusion when all functions were in the same file.

Remove the prefix completely, because it is all internal.

> * Error
>   I noticed that there are different handling of hci_open_dev result.
> I found bluez_new_failure_msg and error_no_such_device calls to handle
> the same error. I will send a patch to use the same approach.

Go ahead and send fixed. I am to busy to fully complete that change.

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
