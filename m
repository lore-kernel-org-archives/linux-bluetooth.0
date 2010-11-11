Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 23:00:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH v2 1/7] Fix invalid memory access when EIR field length
 is zero
Message-ID: <20101111210032.GA24514@jh-x301>
References: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
 <AANLkTinSrAkbcZpK9cO=xLJyH253LDuZrGZCgzEKymLG@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTinSrAkbcZpK9cO=xLJyH253LDuZrGZCgzEKymLG@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Nov 11, 2010, Luiz Augusto von Dentz wrote:
> >        while (len < EIR_DATA_LENGTH - 1) {
> > -               uint8_t type = eir_data[1];
> >                uint8_t field_len = eir_data[0];
> >
> >                /* Check for the end of EIR */
> >                if (field_len == 0)
> >                        break;
> >
> > -               switch (type) {
> > +               switch (eir_data[1]) {
> >                case EIR_UUID16_SOME:
> >                case EIR_UUID16_ALL:
> >                        uuid16_count = field_len / 2;
> 
> IMO type is easier to understand here, we just need to initialize it
> latter after the length check.

True, however I wasn't bothered enough about this and went ahead and
pushed the patch anyway upstream. If someone feels like it, feel free to
reintroduce the variable ;)

Johan
