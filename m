Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez freezes with 2.4.23
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles@schwieters.org
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E1AVDaW-0000z8-00@oaf.localdomain>
References: <E1AVDaW-0000z8-00@oaf.localdomain>
Content-Type: text/plain
Message-Id: <1071336859.27252.190.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 13 Dec 2003 18:34:19 +0100

HI Charles,

>   I'd like to report that I see bluetooth freezes with stock
> linux-2.4.23. The freezes will occur either upon suspend/resume, or
> immediately when one of the bluez modules is loaded (this seems to
> depend on other modules loaded).  These are hard freezes of the whole
> system. I do not have this problem with stock 2.4.22.
> 
> The modules loaded are
> hci_usb                 8120   1
> rfcomm                 32128   0 (autoclean)
> l2cap                  16816   1 (autoclean) [rfcomm]
> bluez                  32644   3 (autoclean) [hci_usb rfcomm l2cap]
> 
> The hardware is: internal Toshiba laptop (Portege M100) bluetooth-
> with usb interface.

if you have SCO support for HCI USB driver enabled, please disable it
and try again. Is this a vanilla 2.4.23 or do you have applied any
additional patches?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
