Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 7610 file transfer to computer
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1102381335.13235.8.camel@nephlim.homenet>
References: <1102381335.13235.8.camel@nephlim.homenet>
Content-Type: text/plain
Message-Id: <1102406104.8447.15.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 07 Dec 2004 08:55:04 +0100

Hi Stefan,

> I've tried to send files to my computer from my Nokia 7610.
> This works once but then I have to turn off/on the phone to
> transfer files again.
> 
> It's not a phone related problem 'cause on a windows machine
> it works fine.
> 
> Also pairing doesn't work because the pin_helper tool reacts
> too slow.
> 
> Here's my config:
> Gentoo 2004.3
> Kernel 2.6.7
> bluez-utils 2.10-r1
> bluez-libs 2.10
> bluez-kernel 2.3

use a 2.6.10-rc3 or 2.6.9-mh5 kernel and DON'T install any bluez-kernel
package. Update the libs and utils to 2.12 and run hcidump as root to
see what is going.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
