Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Oct 2013 10:50:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] Bluetooth: Add address type to device blacklist table
Message-ID: <20131018075006.GA4148@x220.p-661hnu-f1>
References: <1382055860-12572-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382055860-12572-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 17, 2013, Marcel Holtmann wrote:
> The device blacklist is not taking care of the address type. Actually
> store the address type in the list entries and also use them when
> looking up addresses in the table.
> 
> This is actually a serious bug. When adding a LE public address to
> the blacklist, then it would be blocking a device on BR/EDR. And this
> is not the expected behavior.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  3 ++-
>  net/bluetooth/hci_core.c         | 21 +++++++++++----------
>  net/bluetooth/hci_event.c        |  2 +-
>  3 files changed, 14 insertions(+), 12 deletions(-)

All eight patches have been applied to bluetooth-next. Thanks.

Johan
