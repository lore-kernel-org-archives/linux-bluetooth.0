Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Anybody using Socket CF Bluetooth version F on
	Zaurus
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041222161314.65249.qmail@web11610.mail.yahoo.com>
References: <20041222161314.65249.qmail@web11610.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1103802134.20258.69.camel@pegasus>
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
Date: Thu, 23 Dec 2004 12:42:14 +0100

Hi Bashkar,

> Has anyone gotten this card (Socket CF Bluetooth, version F) to work on
> a Zaurus. If so, please post what ROM, kernel version, and Bluez or
> Affix  packages you are using. My card is detected by PCMCIA, but the
> dtl1_cs modules doesn't see it. So I can see it in "cardctl ident", but
> no driver is loaded, and hciconfig doesn't see it.

check /etc/pcmcia/bluetooth.conf for the correct entry. Post the output
of dump_cis of your card.

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
