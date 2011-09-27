Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:58:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: [PATCH] Fix parser of AVRCP continuing messages
Message-ID: <20110927095857.GC6190@dell>
References: <1315923685-30574-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315923685-30574-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Sep 13, 2011, Lucas De Marchi wrote:
> If packet_type is not START or SINGLE, we have to continue where we
> stopped from previous packet. Therefore we must store where we left on
> previous packet due to packet size limit. We store both the number of
> attributes missing and the lenght of the last attribute that is missing.
> 
> An example interaction for this implementation, obtained with PTS test
> TC_TG_MDI_BV_04_C (I reduced the MTU in order to reproduce it here and
> values between brackets I added now):
> 
> > AVCTP: Command : pt 0x00 transaction 2 pid 0x110e
>     AV/C: Status: address 0x48 opcode 0x00
>       Subunit: Panel
>       Opcode: Vendor Dependent
>       Company ID: 0x001958
>       AVRCP: GetElementAttributes: pt Single len 0x0009
>         Identifier: 0x0 (PLAYING)
>         AttributeCount: 0x00
> < AVCTP: Response : pt 0x00 transaction 2 pid 0x110e
>     AV/C: Stable: address 0x48 opcode 0x00
>       Subunit: Panel
>       Opcode: Vendor Dependent
>       Company ID: 0x001958
>       AVRCP: GetElementAttributes: pt Start len 0x0118
>         AttributeCount: 0x04
>         Attribute: 0x00000001 (Title)
>         CharsetID: 0x006a (UTF-8)
>         AttributeValueLength: 0x001b
>         AttributeValue: isso eh um titulo mei longo
>         Attribute: 0x00000003 (Album)
>         CharsetID: 0x006a (UTF-8)
>         AttributeValueLength: 0x00fe
> 	AttributeValue: super-long-album-name super-long-album-name
> 	super-long-album-name super-long-album-name super-long-album
> 	super-long-album-name [... snip... ] super-long-album-name-1234
> > AVCTP: Command : pt 0x00 transaction 2 pid 0x110e
>     AV/C: Control: address 0x48 opcode 0x00
>       Subunit: Panel
>       Opcode: Vendor Dependent
>       Company ID: 0x001958
>       AVRCP: RequestContinuingResponse: pt Single len 0x0001
> < AVCTP: Response : pt 0x00 transaction 2 pid 0x110e
>     AV/C: Stable: address 0x48 opcode 0x00
>       Subunit: Panel
>       Opcode: Vendor Dependent
>       Company ID: 0x001958
>       AVRCP: GetElementAttributes: pt End len 0x002a
>         ContinuingAttributeValue: 678900000000000000
>         Attribute: 0x00000005 (Track Total)
>         CharsetID: 0x006a (UTF-8)
>         AttributeValueLength: 0x0002
>         AttributeValue: 30
>         Attribute: 0x00000006 (Genre)
>         CharsetID: 0x006a (UTF-8)
>         AttributeValueLength: 0x0006
>         AttributeValue: Gospel
> ---
>  parser/avrcp.c |   94 +++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 files changed, 79 insertions(+), 15 deletions(-)

Applied. Thanks.

Johan
