Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v1 0/2] Fix for proto races in hci_serdev.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180822120412.20285-1-bgodavar@codeaurora.org>
Date: Fri, 24 Aug 2018 20:34:16 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Message-Id: <F6273EAE-0EC0-4E4F-B8A1-FF8A57DB116D@holtmann.org>
References: <20180822120412.20285-1-bgodavar@codeaurora.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Balakrishna,

> In recent testing we found that while removing hci_uart, we have seen
> execution of hci_uart_write_work() after calling vendor specific
> proto close. As we are freeing the vendor specific Tx and Rx buffers
> in vendor close, execution of functions i.e. Rx or Tx functions may cause
> a crash.
> 
> we already have a commit for hci_ldisc.c "e508e6026b19" and "048e1bd3a27f"
> to overcome the race condition.
> 
> Changes of v1:
> 
>  * clearing flag HCI_UART_PROTO_READY while mnodule deinit such that
>    we will not have any tractions further on Tx or Rx.
>  * added check of HCI_UART_PROTO_READY while dequeuing an packet.
> 
> 
> Balakrishna Godavarthi (2):
>  Bluetooth: hci_serdev: clear HCI_UART_PROTO_READY to avoid closing
>    proto races
>  Bluetooth: hci_serdev: Add protocol check in hci_uart_dequeue().
> 
> drivers/bluetooth/hci_serdev.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
