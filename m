Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] browsing non-public services?
From: Marcel Holtmann <marcel@holtmann.org>
To: "Collin R. Mulliner" <collin@betaversion.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040224142400.212a912f@coredump>
References: <403B1072.1020102@soft.uni-linz.ac.at>
	 <1077624474.2880.37.camel@pegasus> <20040224132517.0434ab6d@coredump>
	 <1077626176.2880.54.camel@pegasus> <20040224134200.45dab5be@coredump>
	 <1077627172.2880.70.camel@pegasus>  <20040224142400.212a912f@coredump>
Content-Type: text/plain
Message-Id: <1077629602.2880.90.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 24 Feb 2004 14:33:22 +0100

Hi Collin,

> yes I'm sure - a friend of me test this very well (he wrote btxml.c).
> There for I thought 0x5555 would be the "key" to these two channels.

then there is a difference between 6310 and 6310i, because the Nokia
6310 have no service on RFCOMM channel 17 and 18. Phonebook reading
without pairing goes through OBEX.

The btxml.c is much too complex for this and there is no need to go
through a TTY device for it. I can be done directly through a socket.
Maybe he should look at attest.c for an example.

I need the output of "sdptest records <bdaddr-6310i>" to see if this
model has more hidden SDP records.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
