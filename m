Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Max M." <bluez-ml@maxim.comm2000.it>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] tx submit failed urb c4c6b014 type 3 err -19
In-Reply-To: <1109702721.17256.178.camel@pegasus>
Message-ID: <Pine.LNX.4.21.0503031418590.28800-100000@blomma.comm2000.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 3 Mar 2005 15:24:30 +0100 (MET)

On Tue, 1 Mar 2005, Marcel Holtmann wrote:
> this is weird. The first one is related to sysfs and actually these
> should all be fixed by now. The others are also not quite clear.
> 
> How many dongles are you using at the same time? I saw hci2 and hci1 in
> the logs. What does "hciconfig -a" say about them?

Yes, I'm using three dongles. See:

 http://cassandra.comm2000.it/~maxim/pub/bluez-oops/hciconfig.txt

The reason I'm using multiple dongles is that I need to control more than
one phone, and apparently I'm unable to open concurrent SCO links to
different phones through the same dongle. 

Theoretically, this should be possible, shouldn't it? Nevertheless, if I
connect through different dongles (by bind'ing each socket to the
appropriate dongle address), everything works more or less as expected
(except for occasional oops, and some infrequent errors during SCO
connect's). If I try to use a single dongle, either not binding the
sockets, or binding them to BDADDR_ANY, I always get "Too many links" on
the second SCO connection I try to open. Am I possibly doing something
wrong?

Besides, warnings very often get logged mentioning SCO handle numbers
which look bogus to me:

  hci_scodata_packet: hci0 SCO packet for unknown connection handle 65023
  hci_scodata_packet: hci0 SCO packet for unknown connection handle 63231
  hci_scodata_packet: hci0 SCO packet for unknown connection handle 65535
  hci_scodata_packet: hci0 SCO packet for unknown connection handle 65280

See here for more messages like the above:

 http://cassandra.comm2000.it/~maxim/pub/bluez-oops/log-0.txt

Max





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
