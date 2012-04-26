Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 13:57:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Padding should be removed from EIR data
Message-ID: <20120426105717.GA1573@x220>
References: <1335360434-28774-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335360434-28774-1-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Wed, Apr 25, 2012, Vishal Agarwal wrote:
> EIR data received from controller might contain padding zeros.
> This padding should be removed before any further processing and
> sending it over mgmt interface.
> 
> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> ---
>  include/net/bluetooth/hci_core.h |   17 +++++++++++++++++
>  net/bluetooth/hci_event.c        |    4 +++-
>  2 files changed, 20 insertions(+), 1 deletions(-)

Could you please prefix the summary line as Fix... It makes it easier to
get this to 3.4 as this really must go there. Also explain in the commit
message that the mgmt_device_found expects to receive only the
significant part of the EIR data.

> +static inline size_t eir_get_padding_offset(u8 *eir, size_t eir_len)

I'm not completely sure about this name. Would eir_significant_len()
sound better? The core spec uses the terminology "significant part" and
non-significant part" to refer to this so I thought reusing that might
make it clearer what we're dealing with.

> +	u8 field_len;
> +	size_t parsed = 0;
> +
> +	while (parsed < eir_len) {
> +		field_len = eir[0];

You should define field_len here instead of the beginning of the
function since it's not used outside of the while-loop.

> +
> +		if (field_len == 0)
> +			return parsed;
> +
> +		parsed += field_len + 1;
> +		eir += field_len + 1;
> +	}
> +	return eir_len;

Add an empty line before the return statement please.

Johan
