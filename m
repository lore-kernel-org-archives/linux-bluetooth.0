Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH V2 4/7] Bluetooth: Add mutex to hci_uart_tty_ioctl()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1474653392-28770-5-git-send-email-Dean_Jenkins@mentor.com>
Date: Sat, 24 Sep 2016 06:41:40 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <1E61CF84-3998-49C6-BDD7-C4E6A87B3BBC@holtmann.org>
References: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
 <1474653392-28770-5-git-send-email-Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

> Add global mutex lock to prevent reentrancy in the hci_uart_tty_ioctl()
> ioctl handling. This prevents concurrency of all function calls within
> hci_uart_tty_ioctl() handling including hci_uart_set_proto().
> 
> Signed-off-by: Vignesh Raman <Vignesh_Raman@mentor.com>
> Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 9497c46..01590f6 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -51,6 +51,8 @@
> 
> #define VERSION "2.3"
> 
> +static DEFINE_MUTEX(ioctl_mutex);
> +

explain to me why we need a global lock. I think that look can be per struct hci_uart.

Regards

Marcel

