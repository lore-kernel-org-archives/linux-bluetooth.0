Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110808140213.GA23380@dell>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1312568132-21112-10-git-send-email-lucas.demarchi@profusion.mobi>
 <CABBYNZLGOc3a1N4+j3sR+Qa46frL2Ajm2drzXwmbHfEHsY_JKw@mail.gmail.com>
 <CAMOw1v7xvyYO6VA33kZ_VYM=yYzZ+e703xOEDaE7nWmHmkLyig@mail.gmail.com> <20110808140213.GA23380@dell>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 8 Aug 2011 11:07:18 -0300
Message-ID: <CAMOw1v6VUyvNO+TwVNjgPHr-GaHe5e8d8qctSzfo23KjC0ZxPA@mail.gmail.com>
Subject: Re: [PATCH 10/23] avrcp: handle GetCurrentPlayerAplicationSettingValue
 pdu
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 8, 2011 at 11:02 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lucas,
>
> On Mon, Aug 08, 2011, Lucas De Marchi wrote:
>> >> +static int avrcp_handle_get_current_player_value(struct control *control,
>> >> +                                               struct avrcp_spec_avc_pdu *pdu)
>> >> +{
>> >> +       uint16_t len = ntohs(pdu->params_len);
>> >> +       struct media_player *mp = control->mp;
>> >> +
>> >> +       if (!mp)
>> >> +               goto done;
>> >> +
>> >> +       if (len > 1 && pdu->params[0] == len - 1) {
>> >
>> > This if statement is quite long, perhaps you could do check the
>> > opposite e.g. if (len <=1 || pdu->params[0] != len - 1) goto done;
>>
>> In all other parts of the code I do like you said because it's much
>> cleaner. Here however I can't because of the following declaration:
>>
>> >> +               uint8_t settings[pdu->params[0]];
>>
>> It depends on the value of pdu->params[0]
>
> Actually Luiz should have objected to that even more than to the coding
> style. I don't think we use anywhere else array size initializers which
> are not determinable upon compile time (I suppose this is also a very
> recent C feature?). Furthermore, since these values are coming from the

This is VLA and it's part of C99.

> remote side you're effectively allowing them to to "explode" our stack

Well, it's a uint8_t. I considered this when using this approach.

> here. So, dynamically allocating memory from the heap would be a (much)
> better idea in this case (and then you can easily use the coding style
> fix suggested by Luiz).

But this is ok for me. I'll do like you're saying.


Lucas De Marchi
