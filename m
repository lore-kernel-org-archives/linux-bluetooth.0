Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] browsing non-public services?
From: Marcel Holtmann <marcel@holtmann.org>
To: "Collin R. Mulliner" <collin@betaversion.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040224132517.0434ab6d@coredump>
References: <403B1072.1020102@soft.uni-linz.ac.at>
	 <1077624474.2880.37.camel@pegasus>  <20040224132517.0434ab6d@coredump>
Content-Type: text/plain
Message-Id: <1077626176.2880.54.camel@pegasus>
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
Date: Tue, 24 Feb 2004 13:36:16 +0100

Hi Collin,

> > > can I retrieve service information on non-public services? My nokia
> > > phones show an SDP-entry for service class 0x5555 that the phones
> > > also inquire when connecting, now I'd like to see what is registered
> > > there...
> 
> I bet that 0x5555 refers to RFCOMM channel 17,18 or both ;-)

what is on RFCOMM channel 17 and 18? On channel 14 we have the Nokia PC
Suite FBUS protocol for Bluetooth.

My Nokia 6310 has a UUID128 that starts with 0x5555

	Sequence
	        Attribute 0x0000 - Service record handle
	                UINT32 0x00010008
	        Attribute 0x0001 - Service class ID list
	                Sequence
	                        UUID128 00005555-0000-1000-8000-0002ee000001
	        Attribute 0x0300
	                UINT16 0x005f

Maybe this is only checked to activate some Nokia<->Nokia special
features. For example remote PIN code or name change.

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
