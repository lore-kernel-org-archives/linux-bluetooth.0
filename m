Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 May 2014 13:28:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH v2 01/12] shared/crypto: Extend bt_crypto_sign_att with
 sign counter
Message-ID: <20140522102858.GA7869@t440s.lan>
References: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1400746062-24766-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400746062-24766-2-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, May 22, 2014, Lukasz Rymanowski wrote:
> Note: For testing purpose it is possible to provide sign counter
> less then 0.
<snip>
>  bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
>  					const uint8_t *m, uint16_t m_len,
> -					uint8_t signature[12])
> +					int32_t sign_cnt, uint8_t signature[12])
<snip>
> +	/* Add sign_counter to the message */
> +	if (sign_cnt >= 0)
> +		put_le32(sign_cnt, msg + msg_len);
> +	else
> +		msg_len = m_len;
<snip>
>  	/*
> +	 *  If there is sign counter available it should be placed in the
> +	 *  signature as specified in BT spec. 4.1 Vol[3], Part C,
> +	 *  chapter 10.4.1
> +	 */
> +	if (sign_cnt >= 0)
> +		put_le32(sign_cnt, out + 8);

Could you elaborate a bit on what exactly this "testing purpose" is and
why it really needs to be part of the API? I don't see anywhere in the
spec where it'd give us a choice of not having a counter available (I
might have missed it though).

Even if this is part of the API you're now restricting the range of
possible counter values to half of what the specification would allow,
i.e. the type should be int64_t with an added check that you don't allow
values beyond UINT32_MAX (however I'm unconvinced that this API should
have a signed parameter to begin with).

Johan
