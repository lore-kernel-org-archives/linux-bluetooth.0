Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Mar 2011 15:54:35 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Marco Sinigaglia <marco.sinigaglia@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Adjust timeout LE and API
Message-ID: <20110304185435.GH21452@jh-x301>
References: <4D6FBAB3.20304@csr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D6FBAB3.20304@csr.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marco,

On Thu, Mar 03, 2011, Marco Sinigaglia wrote:
> The hci_send_req 100ms timeout is not enough when the chip is in deep
> sleep.  The timeout value has been hardcoded on hci_send_req call and,
> instead, it should be passed from above (for ex from
> hci_le_set_scan_enable).  This patch removes the hardcoded value from
> hci_send_req and it increases the timeout to 1000ms.
> 
> From: Marco Sinigaglia, marco.sinigaglia@csr.com
> 
> ---
>  lib/hci.c         |   12 ++++++------
>  lib/hci_lib.h     |    6 +++---
>  tools/hciconfig.c |    2 +-
>  tools/hcitool.c   |    6 +++---
>  4 files changed, 13 insertions(+), 13 deletions(-)

The patch looks good but doesn't apply with git am. Could you please
recreate it with git format-patch and resend with git send-email?
Thanks.

Johan
