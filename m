Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up
	script
From: Marcel Holtmann <marcel@holtmann.org>
To: James Cameron <james.cameron@hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040630001535.GH15948@hp.com>
References: <20040628101927.GC8871@hp.com>
	 <1088419197.3774.183.camel@pegasus> <20040628120612.GF8871@hp.com>
	 <1088427271.3774.198.camel@pegasus> <20040628224803.GA20139@hp.com>
	 <1088465177.6030.221.camel@pegasus> <20040629052317.GQ20139@hp.com>
	 <1088499480.6030.239.camel@pegasus> <20040629105508.GC2133@hp.com>
	 <1088508403.6030.265.camel@pegasus>  <20040630001535.GH15948@hp.com>
Content-Type: text/plain
Message-Id: <1088586393.22940.9.camel@pegasus>
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
Date: Wed, 30 Jun 2004 11:06:33 +0200

Hi James,

> I cross checked your patch and it looks fine.  When's the next release?
> ;-)

actually it is your patch. I only changed the check for a "non-valid"
socket descriptor. It is a little bit more general this way.

Depends on how fast I am able to implement a quirk for the EPoX HID
keyboard.

> Is the peer ba kept in bnep0 structure somewhere?  Isn't bnep0
> effectively a point to point link?  ppp0 for example, shows the peer IP
> address yet bnep0 doesn't.

It is in dst[] in the ioctl structures and we store it in eh.h_source of
the session structure.

The BNEP connections are really point-to-point, but they are still an
ethernet emulation. So they must look like an ethernet card.

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
