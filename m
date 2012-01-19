Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jan 2012 11:26:35 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/15] Bluetooth: Merge device class into the EIR data in
 mgmt_ev_device_found
Message-ID: <20120119092633.GB20598@aemeltch-MOBL1>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
 <1326912717-6347-8-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326912717-6347-8-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Jan 18, 2012 at 08:51:49PM +0200, Johan Hedberg wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> There's no need to have a separate device class field since the same
> information can be encoded into the EIR data.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   11 +++++++++++
>  include/net/bluetooth/mgmt.h     |    1 -
>  net/bluetooth/mgmt.c             |   20 +++++++++++++-------
>  3 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 393bb73..02aa0f9 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -893,6 +893,17 @@ static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
>  	return false;
>  }
>  
> +static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
> +								u16 data_len)
> +{
> +	eir[eir_len++] = sizeof(type) + data_len;
> +	eir[eir_len++] = type;

Would it be better to use struct eir_info/hdr and assign fields len and
type? I saw already several places where this might improve readability
and remove magic formulas (like "+ 2 - 1").

Best regards 
Andrei Emeltchenko 

