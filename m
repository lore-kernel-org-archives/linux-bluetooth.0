Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Nov 2013 10:44:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 01/14] android: Add HAL IPC commands sanity check
Message-ID: <20131107084405.GA20548@x220.p-661hnu-f1>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
 <1383746970-25906-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383746970-25906-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Nov 06, 2013, Szymon Janc wrote:
> +#define check_no_p(opcode) \
> +	case opcode: \
> +		return len == 0;
> +
> +#define check_fix_p(opcode, msg) \
> +	case opcode: \
> +		return len == sizeof(struct msg);
> +
> +#define check_var_p(opcode, msg, mp_len_name) \
> +	case opcode: \
> +	{ \
> +		const struct msg *mp = (const struct msg *) payload; \
> +		return len == (sizeof(*mp) + mp->mp_len_name); \
> +	}
> +
> +#define check_props_p(opcode, msg) \
> +	case opcode: \
> +	{ \
> +		const struct msg *mp = (const struct msg *) payload; \
> +		const struct hal_property *hp = mp->props; \
> +		const void *p = mp->props; \
> +		int i; \
> +		for (i = 0; i < mp->num_props; i++) { \
> +			if ((void *) (p + sizeof(*hp) + hp->len) > \
> +					(void *) (payload + len)) \
> +				return false; \
> +			p += sizeof(*hp) + hp->len; \
> +			hp = p; \
> +		} \
> +		return p == payload + len; \
> +	}
> +
> +static bool check_cmd_core(uint8_t opcode, const void *payload,
> +								uint16_t len)
> +{
> +	switch (opcode) {
> +	check_fix_p(HAL_OP_REGISTER_MODULE, hal_cmd_register_module);
> +	check_fix_p(HAL_OP_UNREGISTER_MODULE, hal_cmd_unregister_module);
> +	default:
> +		return false;
> +	}
> +}

I have a feeling that this kind of approach will eventually not be very
readable/maintainable. Have you looked at how this kind of stuff is
generalized using a simple table, e.g. in btmon or the kernel mgmt
command parsing code?

Johan
