Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Jun 2014 15:34:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Move hci_pend_le_conn_* functions to
 different location
Message-ID: <20140629123424.GC7248@t440s.P-661HNU-F1>
References: <1404042111-60574-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404042111-60574-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 29, 2014, Marcel Holtmann wrote:
> The hci_pend_le_conn_* function should be placed before their actual
> users. So move them before hci_conn_params_* functions.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 144 +++++++++++++++++++++++------------------------
>  1 file changed, 72 insertions(+), 72 deletions(-)

All three patches have been applied to bluetooth-next. Thanks.

Johan
