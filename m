Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] info about encryption in proc?
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200411011442.37852.cijoml@volny.cz>
References: <200411011341.30769.cijoml@volny.cz>
	 <1099315632.16247.96.camel@pegasus>  <200411011442.37852.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1099317714.16247.100.camel@pegasus>
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
Date: Mon, 01 Nov 2004 15:01:54 +0100

Hi Michal,

> > > is it possible to show in proc info about encryption which is used to
> > > intercommunicate between linux box and other devices?
> >
> > what do you expect to see? This is a boolean value and "hcitool con"
> > shows you the current state.
> 
> for example in /proc/bluetooth/encryption
> 
> MS Keyboard 128bit
> MS Mouse none
> ...

as I said, this is only a boolean value and "hcitool con" already shows
the current state of the encryption. How many bits are used for it, is
not retrievable with standard HCI commands.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
