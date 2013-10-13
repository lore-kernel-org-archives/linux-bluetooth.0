Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Oct 2013 17:57:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Remove l2cap_conn->dst usage from AMP
 manager
Message-ID: <20131013145755.GA23382@x220.p-661hnu-f1>
References: <1381656221-9821-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381656221-9821-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Oct 13, 2013, Marcel Holtmann wrote:
> The l2cap_conn->dst address is just a pointer into the hci_conn->dst
> structure. Use hci_conn->dst directly instead.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/a2mp.c | 3 ++-
>  net/bluetooth/amp.c  | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

All four patches in this set have been applied to bluetooth-next. Thanks.

Johan
