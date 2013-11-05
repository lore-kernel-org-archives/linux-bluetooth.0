Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Nov 2013 10:29:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 06/11] android/hid: Implement hid get report in daemon
Message-ID: <20131105082901.GB20907@x220.p-661hnu-f1>
References: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1383603615-9953-7-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383603615-9953-7-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Nov 05, 2013, Ravi kumar Veeramally wrote:
> This patch requests hid device report and reads reply
> message and sends notification to hal.
> ---
>  android/hal-hidhost.c |   1 +
>  android/hal-msg.h     |   8 ++++
>  android/hid.c         | 104 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 111 insertions(+), 2 deletions(-)

Again, I'd split this into separate patches. One to update the
hal-msg.h, one for the daemon and another for the HAL.

> +#define HAL_EV_HID_GET_REPORT		0x84
> +struct hal_ev_hid_get_report {
> +	uint8_t bdaddr[6];
> +	uint8_t status;
> +	uint16_t len;
> +	uint8_t data[0];
> +} __attribute__((packed));

In our hal-ipc.api.txt this event is defined as 0x85. Not 0x84. Is the
code or documentation wrong?

Also, please follow the same alignment for the variables in the struct
as elsewhere in hal-msg.h.

Johan
