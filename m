Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Mar 2014 22:03:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Track current configured LE scan type
 parameter
Message-ID: <20140321200302.GA15605@t440s.P-661HNU-F1>
References: <1395429490-10884-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395429490-10884-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 21, 2014, Marcel Holtmann wrote:
> The LE scan type paramter defines if active scanning or passive scanning
> is in use. Track the currently set value so it can be used for decision
> making from other pieces in the core.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_event.c        | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
