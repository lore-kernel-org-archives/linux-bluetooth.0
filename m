Return-Path: <cyrus@holtmann.org>
Date: Sat, 20 Dec 2014 23:02:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Remove duplicate constant for RFCOMM PSM
Message-ID: <20141220210225.GB20741@t440s.P-661HNU-F1>
References: <1419094841-41659-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419094841-41659-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Dec 20, 2014, Marcel Holtmann wrote:
> The RFCOMM_PSM constant is actually a duplicate. So remove it and
> use the L2CAP_PSM_RFCOMM constant instead.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/rfcomm.h | 2 --
>  net/bluetooth/rfcomm/core.c    | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
