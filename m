Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7E8125.4030908@codeaurora.org>
Date: Mon, 14 Mar 2011 13:57:09 -0700
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
CC: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v3 1/5] Add new UUID utility functions
References: <1300128839-6293-1-git-send-email-epx@signove.com> <1300128839-6293-2-git-send-email-epx@signove.com>
In-Reply-To: <1300128839-6293-2-git-send-email-epx@signove.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On 3/14/2011 11:53 AM, Elvis Pfützenreuter wrote:
> From: Claudio Takahasi<claudio.takahasi@openbossa.org>
>
> New UUID functions will store the UUIDs values on host order. Added
> functions to create, compare and convert UUIDs.

[...]

> +
> +void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst)
> +{
> +	switch (src->type) {
> +	case BT_UUID128:
> +		memcpy(dst, src, sizeof(bt_uuid_t));
> +		dst->type = BT_UUID128;

Line not needed. It will get copied with the rest of the structure 
during memcpy.

> +		break;
> +	case BT_UUID32:
> +		bt_uuid32_to_uuid128(src, dst);
> +		break;
> +	case BT_UUID16:
> +		bt_uuid16_to_uuid128(src, dst);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +

Regards,


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
