Return-Path: <cyrus@holtmann.org>
Message-ID: <50A36BAC.4090604@linux.intel.com>
Date: Wed, 14 Nov 2012 11:00:12 +0100
From: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
	<frederic.dalleau@linux.intel.com>
Reply-To: frederic.dalleau@linux.intel.com
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 00/16] mSBC tests
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi folks, Siarhei,

On 10/30/2012 10:39 AM, Frédéric Dalleau wrote:
> Hi,
>
> v4 integrate latest comments from Siarhei:
>   - remove state->pending field from sbc_encoder_state
>   - add armv6 and iwmmxt primitives
>   - use simd primitive instead of neon
>   - reorder patches so that the SBC_MSBC flag is exposed to users only when
> implementation is complete.

Any feedback ?

Thanks,
Frédéric
