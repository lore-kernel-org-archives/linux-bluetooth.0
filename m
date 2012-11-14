Return-Path: <cyrus@holtmann.org>
Message-ID: <50A3B9FC.3070009@linux.intel.com>
Date: Wed, 14 Nov 2012 16:34:20 +0100
From: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
 <frederic.dalleau@linux.intel.com>
Reply-To: frederic.dalleau@linux.intel.com
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 11/16] sbc: Add SBC_MSBC flag to enable 15 block encoding
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>  <1351589975-22640-12-git-send-email-frederic.dalleau@linux.intel.com> <1352904577.20338.10.camel@aeonflux>
In-Reply-To: <1352904577.20338.10.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
On 11/14/2012 03:49 PM, Marcel Holtmann wrote:
> I am debating to actually call this SBC_FLAG_MSBC instead of just
> SBC_MSBC. Anyone any comments?

The use of the flag may not be the most elegant API. As an alternative,
maybe we could have a specific function for msbc initialization. Then,
instead of sbc_init(), sbc_encode() sbc_decode(), we could have
msbc_init(), sbc_encode(), sbc_decode().
The biggest advantage is that parameters like bitpool, subbands,
allocation, and other parts could be specified inside this function
instead of being given from the application.

Regards,
Frédéric
