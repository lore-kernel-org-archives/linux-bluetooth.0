Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Problems with anycom usb dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <cp6fpq$167$1@sea.gmane.org>
References: <20041206225609.GA1177@zeus.galaxy.org.uk>
	 <cp3mkk$m7t$1@sea.gmane.org> <1102407664.8447.20.camel@pegasus>
	 <cp3rr7$1vv$1@sea.gmane.org> <1102411047.8447.28.camel@pegasus>
	 <cp4a8v$959$1@sea.gmane.org> <1102425729.8447.41.camel@pegasus>
	 <cp4df4$i6l$1@sea.gmane.org> <1102439143.8447.47.camel@pegasus>
	 <cp6fpq$167$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1102496771.9988.35.camel@pegasus>
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
Date: Wed, 08 Dec 2004 10:06:11 +0100

Hi Sebastian,

> the point about link manager isn't really clear to me.
> In the spec on page 572 about HCI - Add_SCO_Connection the description
> starts with this phrase "This command will cause the link manager to
> create a SCO connection ...". Does this mean LMP?
> I've scaned the spec and search the internet but can't find an explicit
> answer. Do LMP and L2CAP work "hand-in-hand" or are they alternative?
> If they are cooperating the mentioned part (page 226) does matter I
> think.

the link manager runs on the chip and L2CAP is part of the host protocol
stack. And in between we have the HCI. As far as I know, the connection
handle from the link manager must not be the same connection handle used
on the HCI. Feel free to correct me, because I never really looked under
the HCI layer in that detail.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
