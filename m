Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Question for the Mailing List
From: Marcel Holtmann <marcel@holtmann.org>
To: Monika Hubrich <monikahubrich@aol.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <001601c47a50$36024fb0$8b1cb7ac@monika>
References: <001601c47a50$36024fb0$8b1cb7ac@monika>
Content-Type: text/plain
Message-Id: <1091662770.16182.91.camel@pegasus>
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
Date: Thu, 05 Aug 2004 01:39:30 +0200

Hi Monika,

> I use suse linux 8.2 since one week.
> 
> Can anybody help me, to go online with the pcmcia-card from pico
> (sphinx) and the bluetooth-modem (sphinx-electronics).
> There are lots of questions:
> works the connection between the pcmcia-card (pico) and the
> bluetooth-modem (pico-sphinx)?
> My modem requires the pin 12345 for the first connection between the
> pcmcia-card and the modem. 
> How can I send this pin to the modem? (How can I communicate between
> the pcmcia-Card and the modem? e.a. for the internet-connection)
>   
> I've already added my pico-card to the file /etc/pcmcia/config.
> 
> But what must I do now?

check that your card works correctly. Do this with "hciconfig -a". If it
is shown, then start "hcid" and call "rfcomm connect 0 <bdaddr> 1".

For more information look at the mailing list archives and check my
articles and slides:

	http://www.holtmann.org/papers/bluetooth/uptimes2003.html
	http://www.bluez.org/talks.html

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
