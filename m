Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140522102858.GA7869@t440s.lan>
References: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1400746062-24766-2-git-send-email-lukasz.rymanowski@tieto.com>
	<20140522102858.GA7869@t440s.lan>
Date: Thu, 22 May 2014 12:59:41 +0200
Message-ID: <CAMudyAu-3SKfkAqG3A3ZTLdyEPYLJ7tOdPnDZzaHX0ExUtAsfw@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] shared/crypto: Extend bt_crypto_sign_att with
 sign counter
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 22 May 2014 12:28, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lukasz,
>
> On Thu, May 22, 2014, Lukasz Rymanowski wrote:
>> Note: For testing purpose it is possible to provide sign counter
>> less then 0.
> <snip>
>>  bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
>>                                       const uint8_t *m, uint16_t m_len,
>> -                                     uint8_t signature[12])
>> +                                     int32_t sign_cnt, uint8_t signature[12])
> <snip>
>> +     /* Add sign_counter to the message */
>> +     if (sign_cnt >= 0)
>> +             put_le32(sign_cnt, msg + msg_len);
>> +     else
>> +             msg_len = m_len;
> <snip>
>>       /*
>> +      *  If there is sign counter available it should be placed in the
>> +      *  signature as specified in BT spec. 4.1 Vol[3], Part C,
>> +      *  chapter 10.4.1
>> +      */
>> +     if (sign_cnt >= 0)
>> +             put_le32(sign_cnt, out + 8);
>
> Could you elaborate a bit on what exactly this "testing purpose" is and
> why it really needs to be part of the API? I don't see anywhere in the
> spec where it'd give us a choice of not having a counter available (I
> might have missed it though).
>

I'm using test vectors from the spec in the test-crypto and those does
not use sign counter.
Maybe solution is that I generate own test vectors for those unit tests?

> Even if this is part of the API you're now restricting the range of
> possible counter values to half of what the specification would allow,
> i.e. the type should be int64_t with an added check that you don't allow
> values beyond UINT32_MAX (however I'm unconvinced that this API should
> have a signed parameter to begin with).
>
> Johan

BR
Lukasz
