Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Pairing to devices with bluez and widcomm with
	same adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: Nosve <nosve@libero.it>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <AGELIJDLJNOPFNMOHHIFEECJCAAA.nosve@libero.it>
References: <AGELIJDLJNOPFNMOHHIFEECJCAAA.nosve@libero.it>
Content-Type: text/plain
Message-Id: <1074810042.3071.29.camel@pegasus>
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
Date: Thu, 22 Jan 2004 23:20:42 +0100

Hi Nosve,

> Someone has managed how to pair with both stacks, with the same pc/adapter?
> The problem seems to be the fact that when paired, the devices exchange a
> link key
> that bluez/hcid save in /etc/bluetooth/link_key.
> When widcomm try to pair, it exchange another link_key, because it didn't
> find
> a key in his database, which is returned different with the one exchanged
> from
> bluez stack.
> 
> I'm wondering of it is possible to changhe the bdaddr of the bt adapter, so
> the
> remote device saves the keys for two different devices, but I didn't find
> anything
> for this 'solution'.
> 
> Another possibility may be the synchronization of the keys between the two
> stacks,
> but I don't know how to xtract them..

it is possible to change the BD_ADDR, but only with vendor commands.

The only solution for your problem is storing the link key on your
Bluetooth chip. This was already discussed, so take a look at the
mailing list archive.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
