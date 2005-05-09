Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Some doubts about dund
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050509115206.7c304470@casa.milicia.net>
References: <20050509115206.7c304470@casa.milicia.net>
Content-Type: text/plain
Message-Id: <1115633044.8949.160.camel@pegasus>
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
Date: Mon, 09 May 2005 12:04:04 +0200

Hi Guillermo,

> I'm trying to get internet on a sony ericsson k700 through bluetooth
> using dund (has anybody done it? There are a lot of tutorials on the
> net about doing it with the P800 and P900, but those phones seem to
> initiate the conection to the pc by themselves), and I have some doubts
> about dund. I hope you could help me.
> 
> 1. Is pppd started just after dund starts or when dund receives an
> incoming connection?.

only when it receives an incoming connection.

> 2. Should I start pppd by hand using /dev/rfcomm0 (it's the one I'm
> using) then?

What about using dund --connect instead. However you might have to fight
with the mRouter crap. Check the mailing list archive and with Google
for details.

> 3. Do I have to connect previosly rfcomm0? I currently have it binded
> to my phone bluetooth address, this way:

No.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
