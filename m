Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Mar 2011 10:28:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v6 1/6] Add initial support for Out of Band (OOB)
 association model
Message-ID: <20110325082838.GA30796@jh-x301>
References: <1300974459-24076-1-git-send-email-szymon.janc@tieto.com>
 <1300974459-24076-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300974459-24076-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

Some coding style issues that still need fixing before this can be
pushed upstream:

On Thu, Mar 24, 2011, Szymon Janc wrote:
> +static int hciops_read_local_oob_data (int index)

No space before (

> +static int hciops_add_remote_oob_data (int index, bdaddr_t *bdaddr,
> +					uint8_t *hash, uint8_t *randomizer)

Same here.

> +static int hciops_remove_remote_oob_data (int index, bdaddr_t *bdaddr)

And here.

> +static int mgmt_read_local_oob_data (int index)

And here.

> +static int mgmt_add_remote_oob_data (int index, bdaddr_t *bdaddr,
> +					uint8_t *hash, uint8_t *randomizer)

And here.

> +static int mgmt_remove_remote_oob_data (int index, bdaddr_t *bdaddr)

And here.

> +static void (*local_oob_read_cb)(struct btd_adapter *adapter, uint8_t *hash,
> +		uint8_t *randomizer) = NULL;

Usually we try to avoid unnecessary typedefs, but since this function
pointer type is used in three different places and takes several
arguments, I think it'd make sense to have a typedef for it in oob.h,
e.g. oob_read_cb_t

> +void oob_register_cb( void (*cb)(struct btd_adapter *adapter, uint8_t *hash,
> +							uint8_t *randomizer))

No space before between ( and void

Johan
