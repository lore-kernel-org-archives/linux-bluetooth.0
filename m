Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cp6fpq$167$1@sea.gmane.org>
References: <20041206225609.GA1177@zeus.galaxy.org.uk>	 <cp3mkk$m7t$1@sea.gmane.org> <1102407664.8447.20.camel@pegasus>	 <cp3rr7$1vv$1@sea.gmane.org> <1102411047.8447.28.camel@pegasus>	 <cp4a8v$959$1@sea.gmane.org> <1102425729.8447.41.camel@pegasus>	 <cp4df4$i6l$1@sea.gmane.org> <1102439143.8447.47.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <1102439143.8447.47.camel@pegasus>
Subject: [Bluez-devel] Re: Problems with anycom usb dongle
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
Date: Wed, 08 Dec 2004 09:59:37 +0100

Hi Marcel,

the point about link manager isn't really clear to me.
In the spec on page 572 about HCI - Add_SCO_Connection the description
starts with this phrase "This command will cause the link manager to
create a SCO connection ...". Does this mean LMP?
I've scaned the spec and search the internet but can't find an explicit
answer. Do LMP and L2CAP work "hand-in-hand" or are they alternative?
If they are cooperating the mentioned part (page 226) does matter I
think.

> > > Or should I simply drop SCO packets with no data on handle 0 in the
> > > HCI core? Is handle 0 a valid handle?
 > >
> > From my bluetooth spec, page 226 (bluetooth_1_1_vol1)
> > "The SCO handle zero is never used."
> 
> As far as I know this speaks about the LMP handle and this is different
> from the HCI handle.
> 

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
