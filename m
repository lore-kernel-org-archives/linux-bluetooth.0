Return-Path: <cyrus@holtmann.org>
From: Hendrik Sattler <post@hendrik-sattler.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH obexd 3/4] gobex: automatically use SRM when transport type is SOCK_SEQPACKET
Date: Thu, 5 Jan 2012 23:40:54 +0100
Cc: linux-bluetooth@vger.kernel.org
References: <1325598744-18855-1-git-send-email-luiz.dentz@gmail.com> <201201041948.19890.post@hendrik-sattler.de> <CABBYNZJZ1yaswJsrO4G4gdaNENAoJSb85TvdgMQFbUA6vQyiRA@mail.gmail.com>
In-Reply-To: <CABBYNZJZ1yaswJsrO4G4gdaNENAoJSb85TvdgMQFbUA6vQyiRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201201052340.55020.post@hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Donnerstag, 5. Januar 2012, 13:11:01 schrieb Luiz Augusto von Dentz:
> Hi Hendrik,
> 
> On Wed, Jan 4, 2012 at 8:48 PM, Hendrik Sattler <post@hendrik-sattler.de> 
wrote:
> >> That is what the OBEX spec says, but GOEP 2.0 says otherwise, actually
> >> PUT and GET may also be used without CONNECT and the even the OBEX
> >> spec state both PUT, GET and SETPATH supporting SRM headers.
> > 
> > Using PUT and GET without CONNECT is not very efficient as you limit
> > yourself to the lowest MTU and default inbox (OPP). This was only there
> > for some kind of stateless IrDA connection which does not qualify for
> > the requirements of SRM, anyway
> 
> Efficiency was no much of the point here, but what operation do
> support as stated in 2.2.23 Single Response Mode (SRM):
> 
>   "This header shall be used during CONNECT, DISCONNECT, SETPATH, PUT
> and GET operations only (see the table below)."
> 
> This is also restated in 3. Session Protocol:
>   " 2) Single Response Mode (SRM) can be negotiated during CONNECT,
> PUT, GET, or SETPATH, which will remain enabled until a DISCONNECT or
> OBEX transport disconnect occur."
> 
> And it continues stating that SRM can be enable outside of connection
> scope: "If this mode is enabled outside the scope of an OBEX connection,
> SRM is automatically disabled when the operation that enabled this mode
> completes."

I guess this is only specified if there is ever a transport that actually 
specifies this. GOEP v2.0 does not do that.

> So I can only interpret this statements as PUT and GET can be used to
> enable SRM at any point like GOEP 2.0 is doing.

Yes.

> Now after that comes an interesting part, and that one I think makes
> GOEP 2.0 to not adopt SRM headers on CONNECT is the following:
> "This mode will allow multiple outstanding request or response packets
> during the context of an OBEX connection (or OBEX operation). Since
> SRM allows multiple outstanding packets, this mode also makes
> available the ability for multiple outstanding OBEX operations to
> exist at a time."
> 
> Now look at the example 7.14 PUT and GET during Single Response Mode (SRM):

This example is the core of the SRM mess.

> "Start GET operation without waiting for the Server to respond to the
> outstanding PUT operation. Since only one response occurs per
> operation, it is known that the first Server response packet will
> pertain to the PUT operation."
> 
> I believe this is why GOEP 2.0 want to avoid using SRM per connection,
> because multiple outstanding operations are not very easy to be
> handled without an id/serial to identify them which OBEX doesn't have,
> for instance there could be SRMP headers in responses which alters SRM
> and breaks the assumption that only one response occurs per operation.

No. Unless the server does not correctly handle SRM, this assumption is not 
broken. The main problem is actually when sending an ABORT after the GET that 
comes too late. Then you get responses: one SUCCESS for GET and one SUCCESS 
for ABORT instead of one SUCCESS for GET. This can break the synchronisation 
of client and server and the writers of the OBEX spec did not consider this.

> IMO what the OBEX spec writer suggests is that the operations are
> queued by the server, so it only starts responding once the previous
> operation is finished, but this doesn't have any benefit over enabling
> SRM per operation as GOEP 2.0 suggests.

And there is the problem: "SRM per operation" is not specified by OBEX v1.4. 
There, it is always "SRM per connection", so this must be something new from 
OBEX v1.5.

> >> > Additionally, the spec says:
> >> > "Client devices supporting SRM must issue a Single Response Mode (SRM)
> >> > header [...] during all CONNECT requests [...]".
> >> 
> >> That is still possible, by adding the headers manually, but
> > 
> > How should the application ever know better than the part that implements
> > the low-level details of OBEX? That is a very unlikely case.
> 
> I mean we have an API to add headers to a packet which the application
> can use to modify the behavior in e.g. CONNECT, but we won't be adding
> this headers automatically because there are not always recommended by
> specification using OBEX as GOEP 2.0. The impact is minimal since we
> still enable SRM per operation.
> 
> >> automatically configuration will only be done for PUT/GET because of
> >> 
> >> the way GOEP 2.0 is using SRM restrict that:
> >> >   "SRM headers shall not be sent in the Connect request or response
> >> >   packets (note, this is to preserve backwards compatibility). SRM
> >> > shall be enabled through Put and Get operations only."
> >> 
> >> You can get GOEP 2.0 from bluetooth.org, you might find it interesting
> >> specially the examples are completely different from the ones OBEX
> >> spec has and we have to support them both.
> > 
> > I have read that. BTW, it should be noticed that GOEP v2.0 references
> > OBEX v1.5, not v1.4. Maybe those differences come from the latest OBEX
> > specification?
> 
> Good point, I don't have 1.5 yet, hope to get some clarification about
> it during the next UPF.
> 
> > Also note that the first example (page 14) is _wrong_ as the "SRM
> > disabled" in the last line of the table is wrong. See all following
> > examples that do not have the entry. Also, this would directly
> > contradict the OBEX specification. The Bluetooth spec should get an
> > errata for this, ASAP, as this will most likely cause interoperability
> > issues.
> 
> The way the author appears to interpret is that if SRM was enable in
> PUT/GET it will remain active only during that operation:
> 
> GOEP 2.0 Page 1.4 - 4.6 Using Single Response Mode:
> 
> "SRM will remain in effect for the duration of the operation that
> enabled it (PUT or GET), at which time it will automatically be
> disabled and revert back to the normal GOEP request/response model."
> 
> OBEX spec says that if SRM is enabled during the connection context it
> is valid to all subsequent operations, I guess GOEP 2.0 interpret
> context as just within CONNECT request/response. Again I think this is
> to avoid having to support multiple outstanding operations, but it is
> not stated anywhere so it is just my guess.

This must be from OBEX v1.5. Good guess, then :-)
Strange enough they chose to support SRM but only a less efficient setup (you 
still have twice as much RTTs for each PUT and GET than with SRM enabled with 
CONNECT.

Unrelated to this new information about SRM, I saw this in GOEP v2.0:
"The non-Body headers such as Name or Description that may exceed the allowed
OBEX packet size may be issued multiple times in consecutive packets within a 
single PUT/GET operation."

Does this mean that the value of a second NAME header gets appended to the 
value of the first NAME header? Ouch.

HS



