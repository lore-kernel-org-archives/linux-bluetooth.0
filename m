Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re:BCM2035
From: Marcel Holtmann <marcel@holtmann.org>
To: kidd <affix_kidd@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY22-DAV10ew8k69RK00007d15@hotmail.com>
References: <BAY22-DAV10ew8k69RK00007d15@hotmail.com>
Content-Type: text/plain
Message-Id: <1091877842.20839.152.camel@pegasus>
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
Date: Sat, 07 Aug 2004 13:24:02 +0200

Hi,

>   There are the really message :
>  h4_recv:Unknown HCI packet type 00.
>  Dose anything need to change ,please guide me.

as I said that was not an error message of hciattach. What you see is an
error message of the hci_uart kernel module. Looks like the hciattach
parameters are wrong. Ask Broadcom for the correct ones for their serial
interface to the chip.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
