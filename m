Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SuSE 9.1 Pro and Epox Barton wireless desktop
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulrich Wisser <u.wisser@publisher.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1091568946.3759.18.camel@dorette.Entenhausen>
References: <1091568946.3759.18.camel@dorette.Entenhausen>
Content-Type: text/plain
Message-Id: <1091569567.16182.36.camel@pegasus>
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
Date: Tue, 03 Aug 2004 23:46:07 +0200

Hi Ulrich,

> has anybody got that combination running?
> When I plug in my BT-DG03BF USB bluetooth dongle "hcitool dev" does not
> show any device. Please find the /var/log/messages below.
> 
> Any idea how to get the dongle working? The keyboard and mouse?

the dongle of the Barton desktop is a HID proxy dongle. You must run
hid2hci first before you will see it with hciconfig.

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
