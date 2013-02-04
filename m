Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1359970052.6873.23.camel@aeonflux>
References: <1359924910-27167-1-git-send-email-luiz.dentz@gmail.com>
	<20130204083030.GA1147@x220>
	<CABBYNZ+u55P_TVMUEcfwJkc9KpT2GVnYjZzG6RuFVfWhReGpsg@mail.gmail.com>
	<1359970052.6873.23.camel@aeonflux>
Date: Mon, 4 Feb 2013 03:42:57 -0600
Message-ID: <CABBYNZKnhaszq3RVQgQcz=DqsmpaNALUkGSq4MUZFf-68drENw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] AVRCP: Handler player features as a byte array
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Feb 4, 2013 at 3:27 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> >> --- a/profiles/audio/player.c
>> >> +++ b/profiles/audio/player.c
>> >> @@ -67,7 +67,7 @@ struct media_player {
>> >>       char                    *name;          /* Player name */
>> >>       char                    *type;          /* Player type */
>> >>       char                    *subtype;       /* Player subtype */
>> >> -     uint64_t                features[2];    /* Player features */
>> >> +     uint8_t                 *features;      /* Player features */
>> >
>> > Why not just have this as features[16] here as well so you don't need to
>> > do g_memdup and g_free?
>>
>> I was planning to have a NULL check if the features are valid.
>
> actually I like to decrease the number of extra memory allocations. So
> what benefit is the test for features giving you actually.

I would use it to differentiate players which can provide this
information from those who don't, for certain commands we can reject
based on the features but it has to be valid otherwise we just don't
know if it is supported and should send the command anyway.


--
Luiz Augusto von Dentz
