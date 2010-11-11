Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 23:09:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: Re: [PATCH v2 2/7] Refactor get_eir_uuids() to get EIR data length
 parameter
Message-ID: <20101111210901.GC24514@jh-x301>
References: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
 <1289501521-21825-2-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289501521-21825-2-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 11, 2010, Vinicius Costa Gomes wrote:
> get_eir_uuids() will be reused to parse LE advertising data as well, as
> they share the same format. But for Advertising, maximum data length is
> different (31 bytes vs. 240 bytes for EIR), and the radio is not
> required to send the non-significant (zero-filled) bytes.
> 
> adapter_emit_device_found() now also accepts a EIR data length
> parameter, so it can be reused for LE and can propagate the exact data
> length.
> ---
>  src/adapter.c |   17 ++++++++++-------
>  src/adapter.h |    2 +-
>  src/event.c   |    2 +-
>  3 files changed, 12 insertions(+), 9 deletions(-)

Pushed upstream after I fixed the following coding style issue:

>  void adapter_emit_device_found(struct btd_adapter *adapter,
> -				struct remote_dev_info *dev, uint8_t *eir_data)
> +	struct remote_dev_info *dev, uint8_t *eir_data, size_t eir_length)

The parameters on the second line should be indented if possible enough
that they're past the opening ( on the line above (in this case it means
that you need three lines for the parameters).

>  void adapter_emit_device_found(struct btd_adapter *adapter,
> -				struct remote_dev_info *dev, uint8_t *eir_data);
> +	struct remote_dev_info *dev, uint8_t *eir_data, size_t eir_length);

Same here.

Johan
