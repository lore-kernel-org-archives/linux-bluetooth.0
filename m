Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] patch for: RFComm dynamic channel allocation
From: Marcel Holtmann <marcel@holtmann.org>
To: "Collin R. Mulliner" <collin@betaversion.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040708165219.16a1d6db@coredump>
References: <20040708165219.16a1d6db@coredump>
Content-Type: text/plain
Message-Id: <1089308231.4857.45.camel@pegasus>
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
Date: Thu, 08 Jul 2004 19:37:11 +0200

Hi Collin,

> just found and fixed the problem with dynamic rfcomm channel allocation.
> My code binds to a specific local bdaddr, the rfcomm tool binds to ANY.
> This case was not handled correctly. The fix is simple, see attachment.

I don't get the point of your fix, because bind() to a specific BD_ADDR
and to BDADDR_ANY are totally different and can result in different
dynamic channel allocations.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
