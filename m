Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111130211600.GA9230@fusion.localdomain>
References: <1322670976-9517-1-git-send-email-sancane@gmail.com>
	<CACLukzJWL5=w59ARvwKvz+_Q81=ZJ+4qj_tU0+AxmT4g6847Sw@mail.gmail.com>
	<20111130211600.GA9230@fusion.localdomain>
Date: Thu, 1 Dec 2011 20:31:58 +0100
Message-ID: <CACLukzJExFe0cYZBwAcU70ajDODJ5_RxVYx4pDxRq9DQCj2z7g@mail.gmail.com>
Subject: Re: [PATCH] Fix byte order problems getting PSM through btio API
From: Santiago Carot <sancane@gmail.com>
To: Santiago Carot <sancane@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

2011/11/30 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Santiago,
>
> On Wed, Nov 30, 2011, Santiago Carot wrote:
>> 2011/11/30 Santiago Carot-Nemesio <sancane@gmail.com>:
>> > ---
>> >  btio/btio.c |    2 +-
>> >  1 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/btio/btio.c b/btio/btio.c
>> > index a129bf9..f8c5cc7 100644
>> > --- a/btio/btio.c
>> > +++ b/btio/btio.c
>> > @@ -882,7 +882,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
>> >                        break;
>> >                case BT_IO_OPT_PSM:
>> >                        *(va_arg(args, uint16_t *)) = src.l2_psm ?
>> > -                                               src.l2_psm : dst.l2_psm;
>> > +                                       btohs(src.l2_psm) : btohs(dst.l2_psm);
>> >                        break;
>> >                case BT_IO_OPT_CID:
>> >                        *(va_arg(args, uint16_t *)) = src.l2_cid ?
>> > --
>> > 1.7.7.4
>> >
>>
>> At a first sight, It seems there may be the same problems retrieving
>> CID, OMTU and IMTU on big endian architectures. I preffer waiting for
>> a more experienced comments before sending any patch fixing that.
>
> To my understanding the L2CAP PSM is the only parameter that uses
> protocol endianess in the socket interface, so we should be safe with
> the other values.
>

As far as I see, CID uses little endian as well, There are some parts
in the code where the byte conversion is done when BT_IO_OPT_CID is
provided, for example in l2cap_connect, Conversely, this attribute is
being provided in bt_io_get without host endian conversion.

Diving in the code I can see that the gatt-server is getting it in
./src/attrib-server.c:1039 so I guess that there is the same problem
that we had in big endian architectures.

Regards

Santiago
