Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140521131906.GB25779@t440s.P-661HNU-F1>
References: <1400676302-13626-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1400676302-13626-2-git-send-email-lukasz.rymanowski@tieto.com>
	<20140521131906.GB25779@t440s.P-661HNU-F1>
Date: Wed, 21 May 2014 16:08:48 +0200
Message-ID: <CAMudyAvO9Pm1JEAAS11Exw4nDj8cMSy7yn8=fxBxt_sD8zgNHA@mail.gmail.com>
Subject: Re: [PATCH 01/12] shared/crypto: Extend bt_crypto_sign_att with sign counter
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 21 May 2014 15:19, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lukasz,
>
> On Wed, May 21, 2014, Lukasz Rymanowski wrote:
>>  bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
>>                                       const uint8_t *m, uint16_t m_len,
>> +                                     const int32_t sign_cnt,
>
> We use const declarations to indicate that the function promises not to
> modify memory behind pointers. When passing integers you don't anyway
> have access to the original variable so the convention used throughout
> the tree is to not use const declarations for such variables.
>
Copy paste issue - will fix in v2

> Johan

Thanks
Łukasz
