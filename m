Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Oct 2013 18:04:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove mgmt_valid_hdev() helper function
Message-ID: <20131006160439.GA16633@x220.p-661hnu-f1>
References: <1381073101-53030-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381073101-53030-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 06, 2013, Marcel Holtmann wrote:
> The helper function mgmt_valid_hdev() is more obfuscating the code
> then it makes it easier to read. So intead of this helper, use the
> direct check for BR/EDR device type.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 -
>  net/bluetooth/hci_core.c         |  4 ++--
>  net/bluetooth/mgmt.c             | 24 ++++++++----------------
>  3 files changed, 10 insertions(+), 19 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
