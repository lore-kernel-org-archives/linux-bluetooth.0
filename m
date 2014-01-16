Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jan 2014 10:38:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Bluetooth: Track Secure Connections support of
 remote devices
Message-ID: <20140116083816.GA12252@x220.p-661hnu-f1>
References: <1389854262-62467-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389854262-62467-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 15, 2014, Marcel Holtmann wrote:
> It is important to know if Secure Connections support has been enabled
> for a given remote device. The information is provided in the remote
> host features page. So track this information and provide a simple
> helper function to extract the status.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 8 ++++++++
>  net/bluetooth/hci_event.c        | 3 +++
>  2 files changed, 11 insertions(+)

All patches in this set have been applied to bluetooth-next. Thanks.

Johan
