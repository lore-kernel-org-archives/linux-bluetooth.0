Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Problems with anycom usb dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41B6E98F.8030603@csr.com>
References: <20041206225609.GA1177@zeus.galaxy.org.uk>
	 <cp3mkk$m7t$1@sea.gmane.org> <1102407664.8447.20.camel@pegasus>
	 <cp3rr7$1vv$1@sea.gmane.org> <1102411047.8447.28.camel@pegasus>
	 <cp4a8v$959$1@sea.gmane.org> <1102425729.8447.41.camel@pegasus>
	 <cp4df4$i6l$1@sea.gmane.org> <1102439143.8447.47.camel@pegasus>
	 <cp6fpq$167$1@sea.gmane.org> <1102496771.9988.35.camel@pegasus>
	 <41B6E98F.8030603@csr.com>
Content-Type: text/plain
Message-Id: <1102507219.9988.55.camel@pegasus>
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
Date: Wed, 08 Dec 2004 13:00:19 +0100

Hi Steven,

> >                                        As far as I know, the connection
> > handle from the link manager must not be the same connection handle used
> 
> I think you mean 'need not' not 'must not'.

oh yes, right. Germans (especially I) tend to translate this wrong :)

> > on the HCI. Feel free to correct me, because I never really looked under
> > the HCI layer in that detail.
> 
> Correct. The LMP SCO handle is an 8 bit number in the range 1 to 255.
> The HCI SCO handle is a 12 bit number in the range 0 to 0x0eff.
> 
> LMP SCO handles are unique per piconet and are assigned by the master.
> If a device is a participant in multiple piconets then it may see the
> same LMP handle on different networks. The LM must distinguish SCO
> links using the (piconet, handle) pair.
> 
> HCI SCO handles are unique per host<->controller link. However, the
> same HCI SCO handle may be being used by different devices in a
> piconet to refer to different SCO links.
> 
> The LMP SCO handle is shared between the two devices in a SCO link
> (this allows the devices to distinguish multiple SCO links so that they
> agree on which link is to disconnect, for example).
> 
> The HCI SCO handles are not shared between the two devices. The two
> hosts may see different handles.

And there can't be a SCO and an ACL link with the same handle, right?

However the problems is that we see a SCO data packet with HCI handle 0
and zero data len, which should not be send up to the HCI. Basically I
think we must drop this directly in hci_usb driver and not even send it
up to BlueZ HCI core. Actually I tend to simply mark the SCO support of
this dongle broken.

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
