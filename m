Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hidp and hidd and MS keyboard hotkeys
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200408012330.32328.cijoml@volny.cz>
References: <200408012330.32328.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1091396840.4279.4.camel@pegasus>
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
Date: Sun, 01 Aug 2004 23:47:20 +0200

Hi Michal,

> I tested this combination and under 2.6. and 2.4 still doesn't works hotkeys. 
> Do you expect to fix it soon?

my main focus is now to get the generic HID parser for 2.6 in a good
shape so I can submit it for inclusion into the mainline kernel. The 2.4
HIDP backport is boot protocol mode only and this will stay a little bit
until the 2.6 part is mature.

Do you get the hotkeys working with 2.6.7-mh4? This patch contains a HID
parser and support for the HID report protocol mode.

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
