Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nosve" <nosve@libero.it>
To: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
Subject: R: [Bluez-users] Pairing to devices with bluez and widcomm withsame adapter
Message-ID: <AGELIJDLJNOPFNMOHHIFEECKCAAA.nosve@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1074810042.3071.29.camel@pegasus>
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
Date: Fri, 23 Jan 2004 10:30:21 +0100

Hi Marcel,

> -----Messaggio originale-----
> Da: Marcel Holtmann [mailto:marcel@holtmann.org]
>
> Hi Nosve,
>
> > Someone has managed how to pair with both stacks, with the same
> pc/adapter?
> > The problem seems to be the fact that when paired, the devices
> > but I don't know how to xtract them..
>

[blah blah]

> it is possible to change the BD_ADDR, but only with vendor commands.
>
> The only solution for your problem is storing the link key on your
> Bluetooth chip. This was already discussed, so take a look at the
> mailing list archive.
>
> Regards
>
> Marcel
>

Just a thing I forgot, when I have to delete the link key for the explained
things,
hcid doesn't matter about it, maybe it buffers the keys only at startup,
neither with a kill -HUP, which seems however intercepted. The only option
is to
restart hcid.

I reported this, because the pairing behaviour may be confusing for
people who uses the bt adapter in 'mixed' environment.

As for regards the other thread tha discuss the possibility of storing the
link
key in bt adapter, I understand that the possibility to do that has to be
investigated from widcomm? Or from the manufacturer of the adapter, with
hci arbitrary commands to send to the adapter?

Regards, and thanks for the good job

Nosve



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
