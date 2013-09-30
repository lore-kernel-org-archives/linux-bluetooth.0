Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Sep 2013 21:15:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Provide high speed configuration option
Message-ID: <20130930181547.GA26405@x220.p-661hnu-f1>
References: <1380514261-21742-3-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380514261-21742-3-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 29, 2013, Marcel Holtmann wrote:
> Hiding the Bluetooth high speed support behind a module parameter is
> not really useful. This can be enabled and disabled at runtime via
> the management interface. This also has the advantage that his can
> now be changed per controller and not just global.
> 
> This patch removes the module parameter and exposes the high speed
> setting of the management interface to all controllers.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/hci_core.c      |  6 ------
>  net/bluetooth/l2cap_core.c    | 35 +++++++++++++++++++----------------
>  net/bluetooth/l2cap_sock.c    | 10 ----------
>  net/bluetooth/mgmt.c          | 11 ++---------
>  5 files changed, 22 insertions(+), 41 deletions(-)

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
