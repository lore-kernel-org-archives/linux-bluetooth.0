Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:30:51 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add TX power tag to EIR data
Message-ID: <20120316153051.GI20650@x220>
References: <1331519241-24778-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331519241-24778-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Mar 11, 2012, Marcel Holtmann wrote:
> The Inquiry Response TX power tag should be added to the Extended
> Inquiry Data (EIR) as well.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      |    4 ++++
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_event.c        |    9 ++++++---
>  net/bluetooth/mgmt.c             |    9 +++++++++
>  4 files changed, 20 insertions(+), 3 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
