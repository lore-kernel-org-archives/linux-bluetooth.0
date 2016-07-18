Return-Path: <johan.hedberg@gmail.com>
Date: Mon, 18 Jul 2016 09:35:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Move hci_recv_frame and hci_recv_diag
 prototypes
Message-ID: <20160718063505.GA23227@t440s.P-661HNU-F1>
References: <1468778117-62931-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468778117-62931-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 17, 2016, Marcel Holtmann wrote:
> The protoypes for hci_recv_frame and hci_recv_diag are in the wrong
> location in the header file. Move them close to all the other hci_dev
> related exported functions.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

All three patches have been applied to bluetooth-next. Thanks.

Johan
