Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Dec 2013 00:03:53 +0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use macros for connectionless slave broadcast
 features
Message-ID: <20131208200353.GA5869@x220.p-661hnu-f1>
References: <1386532533-48770-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386532533-48770-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Dec 08, 2013, Marcel Holtmann wrote:
> Add the LMP feature constants for connectionless slave broadcast
> and use them for capability testing.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      | 6 ++++++
>  include/net/bluetooth/hci_core.h | 6 ++++++
>  net/bluetooth/hci_core.c         | 6 +++---
>  3 files changed, 15 insertions(+), 3 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
