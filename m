Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SuSE 9.1 Pro and Epox Barton wireless desktop
From: Ulrich Wisser <u.wisser@publisher.de>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1091569567.16182.36.camel@pegasus>
References: <1091568946.3759.18.camel@dorette.Entenhausen>
	 <1091569567.16182.36.camel@pegasus>
Content-Type: text/plain
Message-Id: <1091648489.4237.2.camel@dorette.Entenhausen>
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
Date: Wed, 04 Aug 2004 21:41:32 +0200

Hallo Marcel,

> > has anybody got that combination running?
> > When I plug in my BT-DG03BF USB bluetooth dongle "hcitool dev" does not
> > show any device. Please find the /var/log/messages below.
> > 
> > Any idea how to get the dongle working? The keyboard and mouse?
> 
> the dongle of the Barton desktop is a HID proxy dongle. You must run
> hid2hci first before you will see it with hciconfig.

which I would love to do, but it seems the SuSE 9.1 Pro does not include
the hid2hci tool.

Can I download and compile from SF or do I need to upgrade all bluez
packages in that case?

Ulrich



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
