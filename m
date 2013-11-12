Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 15:33:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/pan: Add PAN related defines and event
 struct to hsl-msg header
Message-ID: <20131112133328.GG22931@x220.p-661hnu-f1>
References: <1384181621-8070-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1384181621-8070-2-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384181621-8070-2-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Mon, Nov 11, 2013, Ravi kumar Veeramally wrote:
> +#define HAL_EV_PAN_CONN_STATE			0x81
> +struct hal_ev_pan_conn_state {
> +	uint8_t  state;
> +	uint8_t  status;
> +	uint8_t  bdaddr[6];
> +	uint8_t  local_role;
> +	uint8_t  remote_role;
> +} __attribute__((packed));
> +
> +#define HAL_EV_PAN_CTRL_STATE			0x82
> +struct hal_ev_pan_ctrl_state {
> +	uint8_t  state;
> +	uint8_t  status;
> +	uint8_t  local_role;
> +	uint8_t  name[17];
> +} __attribute__((packed));

These are in different in hal-ipc-api.txt:

        Opcode 0x81 - Control State notification
	Opcode 0x82 - Connection State notification

You really need to start paying more attention to details like this. As
long as you don't do it it means I need to spend more time verifying
every detail in your patches, which in turn means that it takes longer
before your patches get reviewed and eventually go upstream.

Johan
