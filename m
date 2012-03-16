Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:31:33 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Handle EIR tags for Device ID
Message-ID: <20120316153133.GA21196@x220>
References: <1331519532-26505-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331519532-26505-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Mar 11, 2012, Marcel Holtmann wrote:
> The Device ID information can be provided via Extended Inquiry Data
> as well. If a valid source is present, then include it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |    4 ++++
>  net/bluetooth/mgmt.c             |   13 +++++++++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
