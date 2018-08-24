Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v1 0/2] Bug fixes for qualcomm BT chip wcn3990. 
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180822122005.11218-1-bgodavar@codeaurora.org>
Date: Fri, 24 Aug 2018 20:32:57 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Message-Id: <2B1E9B66-FCDD-4851-BE99-8DA452AE9354@holtmann.org>
References: <20180822122005.11218-1-bgodavar@codeaurora.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Balakrishna,

> When we set an KASAN flags, we are seeing an crash while removing module hci_uart.
> This is due to dereference of hdev. As in module deinit we are calling function
> hci_free_dev() to free hdev.
> 
> Changes in v1:
> 
>  * removed dereference of hdev in qca_power_shutdown i.e. qca_close.
>  * moved serdev open & close call from qca_open & qca_close.
> 
> 
> Balakrishna Godavarthi (2):
>  Bluetooth: hci_qca: Remove serdev_device_open/close function calls
>  Bluetooth: hci_qca: Remove hdev dereference in qca_close().
> 
> drivers/bluetooth/hci_qca.c | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)

both patches haven been applied to bluetooth-next tree.

Regards

Marcel
