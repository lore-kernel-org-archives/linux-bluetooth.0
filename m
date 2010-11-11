Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 23:10:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH v2 3/7] Refactoring adapter_update_found_devices()
 function
Message-ID: <20101111211021.GD24514@jh-x301>
References: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
 <1289501521-21825-3-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289501521-21825-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 11, 2010, Vinicius Costa Gomes wrote:
> The common code from adapter_update_found_devices() was moved to
> update_found_devices().
> ---
>  src/adapter.c |   50 +++++++++++++++++++++++++++++++-------------------
>  1 files changed, 31 insertions(+), 19 deletions(-)

This one has also been pushed upstream after fixing the following coding
style issue:

> -void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
> -				int8_t rssi, uint32_t class, const char *name,
> -				const char *alias, gboolean legacy,
> -				name_status_t name_status, uint8_t *eir_data)
> +static struct remote_dev_info *get_found_dev(struct btd_adapter *adapter,
> +				const bdaddr_t *bdaddr, gboolean *new_dev)

Same thing as with the previous patch: the parameters on the second line
need to be indented past the opening ( on the first line.

Johan
