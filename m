Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Connection with a phone stays open
	afterclosingRFCOMM channel
From: Marcel Holtmann <marcel@holtmann.org>
To: Victor Shcherbatyuk <Victor.Shcherbatyuk@tomtom.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <C70061B183DE09419568AB2060C52A9518EE74@arion.intra.local>
References: <C70061B183DE09419568AB2060C52A9518EE74@arion.intra.local>
Content-Type: text/plain
Message-Id: <1109773181.8284.16.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 02 Mar 2005 15:19:41 +0100

Hi Victor,

> Don't know if I have to post it on the mailing list (with binary
> files)...

if I ask for it, it is always fine ;)

> I can not try 2.11 rc5 cause it is not an option for the current project
> and I do not have time to try it at home at the moment.

Using a 2.6.10-mh4 is also possible, but you should at least try it with
my kernel patch.

> At the moment it is not clear from the protocol (at least for me) who is
> responsible for terminating connection. It may be as well a bug in
> SE630, cause Nokia 7650 for instance takes initiative to terminate the
> connection after DISC on dlci6 (but from another side Nokias do not take
> initiative to reconnect to HF device when call is received when
> bluetooth connection is broken, as SE phones do...)

You won't find any written words or hints inside the specification who
is responsible for terminating a connection. I discussed this problem
with a lot of people so far and there is no solution besides accepting
bad implementations.

Actually I asked you for the contents of

	/proc/bluetooth/rfcomm/{dlc|sock}

after you ran into the stalled connection. They are really needed,
because it might be a bug with our code that we don't cleanup the mess
of the SE 630.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
