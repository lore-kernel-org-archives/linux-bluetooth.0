Return-Path: <cyrus@holtmann.org>
From: Hendrik Sattler <post@hendrik-sattler.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH obexd 3/4] gobex: automatically use SRM when transport type is SOCK_SEQPACKET
Date: Wed, 4 Jan 2012 19:48:19 +0100
Cc: linux-bluetooth@vger.kernel.org
References: <1325598744-18855-1-git-send-email-luiz.dentz@gmail.com> <201201031658.17771.post@hendrik-sattler.de> <CABBYNZK2upSD5i37vNbV7Fcdp65dsnekVYYqmfR4q_cLVwqp_Q@mail.gmail.com>
In-Reply-To: <CABBYNZK2upSD5i37vNbV7Fcdp65dsnekVYYqmfR4q_cLVwqp_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201201041948.19890.post@hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Am Dienstag, 3. Januar 2012, 23:31:13 schrieb Luiz Augusto von Dentz:
> On Tue, Jan 3, 2012 at 5:58 PM, Hendrik Sattler <post@hendrik-sattler.de> 
wrote:
> >> So only in case of PUT or GET requests SRM is automatically configured,
> >> applications can still enable it manually for other operations by adding
> >> the headers like before but it is not recommended.
> >> 
> >> Note that it would be a good practice to indicate SRM support by using
> >> value 0x02, but since that should happens during CONNECT command it is
> >> not done automatically for requests when acting as a client, server
> >> responding to indicate requests will automatically add SRM headers
> >> though.
> > 
> > I think you misread the specs here.
> > 
> > SRM is not enabled for "requests" but for sessions and SRM is valid until
> > disabled again. This includes _all_ requests and responses, not only GET
> > and PUT but the authors of the OBEX spec have a strange way to write
> > things. The SRMP headers only affect PUT and PUT, though.

s/PUT and PUT/PUT and GET/

> That is what the OBEX spec says, but GOEP 2.0 says otherwise, actually
> PUT and GET may also be used without CONNECT and the even the OBEX
> spec state both PUT, GET and SETPATH supporting SRM headers.

Using PUT and GET without CONNECT is not very efficient as you limit yourself 
to the lowest MTU and default inbox (OPP). This was only there for some kind 
of stateless IrDA connection which does not qualify for the requirements of 
SRM, anyway

> > Additionally, the spec says:
> > "Client devices supporting SRM must issue a Single Response Mode (SRM)
> > header [...] during all CONNECT requests [...]".
> 
> That is still possible, by adding the headers manually, but

How should the application ever know better than the part that implements the 
low-level details of OBEX? That is a very unlikely case.

> automatically configuration will only be done for PUT/GET because of
> the way GOEP 2.0 is using SRM restrict that:
> >   "SRM headers shall not be sent in the Connect request or response
> >   packets (note, this is to preserve backwards compatibility). SRM shall
> >   be enabled through Put and Get operations only."
> 
> You can get GOEP 2.0 from bluetooth.org, you might find it interesting
> specially the examples are completely different from the ones OBEX
> spec has and we have to support them both.

I have read that. BTW, it should be noticed that GOEP v2.0 references OBEX 
v1.5, not v1.4. Maybe those differences come from the latest OBEX 
specification?

Also note that the first example (page 14) is _wrong_ as the "SRM disabled" in 
the last line of the table is wrong. See all following examples that do not 
have the entry. Also, this would directly contradict the OBEX specification. 
The Bluetooth spec should get an errata for this, ASAP, as this will most 
likely cause interoperability issues.

SRM is a complete mess, anyway.

HS
