Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41B6FAE8.7030003@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Problems with anycom usb dongle
References: <20041206225609.GA1177@zeus.galaxy.org.uk>
    <cp3mkk$m7t$1@sea.gmane.org> <1102407664.8447.20.camel@pegasus>
    <cp3rr7$1vv$1@sea.gmane.org> <1102411047.8447.28.camel@pegasus>
    <cp4a8v$959$1@sea.gmane.org> <1102425729.8447.41.camel@pegasus>
    <cp4df4$i6l$1@sea.gmane.org> <1102439143.8447.47.camel@pegasus>
    <cp6fpq$167$1@sea.gmane.org> <1102496771.9988.35.camel@pegasus>
    <41B6E98F.8030603@csr.com> <1102507219.9988.55.camel@pegasus>
In-Reply-To: <1102507219.9988.55.camel@pegasus>
Content-Type: text/plain; charset="us-ascii"
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
Date: Wed, 08 Dec 2004 13:00:24 +0000

Marcel Holtmann wrote:
>> >                                        As far as I know, the connection
>> > handle from the link manager must not be the same connection handle used
>> 
>> I think you mean 'need not' not 'must not'.
> 
> oh yes, right. Germans (especially I) tend to translate this wrong :)

I can see why this could be a problem. If "must" means "is required to
be" then it has two opposites "is required not to be" and "is not required
to be". That is, does the negation bind to "required" or to "to be".

You can't easily get to "is not required to be" using must. You end up
writing something horribly long like "it is not the case that A must be
B".

You could have said "doesn't need to be", but "need not be" is
idiomatic.

Anyway, back to the matter at hand:

> And there can't be a SCO and an ACL link with the same handle, right?

Correct. I don't know if the HCI spec explicitly states this, but it is
implicit. For example, the Disconnect command takes a connection handle
as an argument. If SCO and ACL links were able to have the same handle
then it would be ambiguous which was to be disconnected.

> However the problems is that we see a SCO data packet with HCI handle 0
> and zero data len, which should not be send up to the HCI. Basically I
> think we must drop this directly in hci_usb driver and not even send it
> up to BlueZ HCI core.

It would be valid for the dongle to create a link with HCI SCO handle 0,
but, if I read the traces correctly, it hasn't done this. So the problem
is that it's sending SCO packets for a non-existent handle.

It may just be a feature of this dongle that if the isochronous endpoint
is started up and there's no SCO data to send (or if it hasn't quite
finished setting up the SCO link internally) then it sends a dummy HCI
SCO header.

If the zero length packets are ignored then does the rest of the data
make sense. If so, silently dropping zero length packets might be
useful.

>                       Actually I tend to simply mark the SCO support of
> this dongle broken.

I think you mean "intend" not "tend". :-)

	- Steven



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
