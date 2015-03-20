Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Mar 2015 14:09:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use HCI_MAX_AD_LENGTH constant instead
 hardcoded value
Message-ID: <20150320120904.GB20503@t440s.ger.corp.intel.com>
References: <1426810945-21812-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426810945-21812-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Mar 19, 2015, Marcel Holtmann wrote:
> Using the HCI_MAX_AD_LENGTH for the max advertising data and max scan
> response data length makes more sense than hardcoding the value.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied bluetooth-next. Thanks.

Johan
