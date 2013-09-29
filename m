Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Sep 2013 22:34:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Replace BDADDR_LOCAL with BDADDR_NONE
Message-ID: <20130929193450.GA1865@x220.p-661hnu-f1>
References: <1380441711-55190-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380441711-55190-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 29, 2013, Marcel Holtmann wrote:
> The BDADDR_LOCAL is a relict from userspace and has never been used
> within the kernel. So remove that constant and replace it with a new
> BDADDR_NONE that is similar to HCI_DEV_NONE with all bits set.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/bluetooth.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
