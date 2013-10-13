Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Oct 2013 17:58:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Remove pointless bdaddr_to_le() helper
 function
Message-ID: <20131013145817.GB23382@x220.p-661hnu-f1>
References: <1381661859-32200-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381661859-32200-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 13, 2013, Marcel Holtmann wrote:
> The bdaddr_to_le() function tries to convert the internal address
> type to one that matches the HCI address type for LE. It does not
> handle any address types not used by LE and in the end just make
> the code a lot harder to read.
> 
> So instead of just hiding behind a magic function, just convert
> the internal address type where it needs to be converted. And it
> turns out that these are only two cases anyway. One when creating
> new LE connections and the other when loading the long term keys.
> In both cases this makes it more clear on what it going on.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h |  2 --
>  net/bluetooth/hci_conn.c         |  5 ++++-
>  net/bluetooth/hci_core.c         | 12 ------------
>  net/bluetooth/mgmt.c             | 10 +++++++---
>  4 files changed, 11 insertions(+), 18 deletions(-)

Both patches in this set have been applied to bluetooth-next. Thanks.

Johan
