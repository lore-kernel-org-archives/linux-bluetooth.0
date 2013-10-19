Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 Oct 2013 16:25:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Bluetooth: Move HCI device features into hci_core.c
Message-ID: <20131019132549.GA11607@x220.p-661hnu-f1>
References: <1382123092-35256-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382123092-35256-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 18, 2013, Marcel Holtmann wrote:
> Move the handling of HCI device features debugfs into hci_core.c and
> also extend it with handling of multiple feature pages.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c  | 34 +++++++++++++++++++++++++++++++++-
>  net/bluetooth/hci_sysfs.c | 14 --------------
>  2 files changed, 33 insertions(+), 15 deletions(-)

All seven patches have been applied to bluetooth-next. Thanks.

Johan
