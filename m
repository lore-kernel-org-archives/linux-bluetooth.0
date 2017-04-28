Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: Add module license for HCI UART Nokia H4+
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1493378771-22557-1-git-send-email-frederic.danis.oss@gmail.com>
Date: Fri, 28 Apr 2017 18:06:36 +0200
Cc: Sebastian Reichel <sre@kernel.org>, linux-bluetooth@vger.kernel.org
Message-Id: <7AE12B9F-95F6-47C4-9844-20091DDF8A1A@holtmann.org>
References: <1493378771-22557-1-git-send-email-frederic.danis.oss@gmail.com>
To: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Fix the following error preventing to load Nokia H4+ module:
>  kernel: [  826.461619] hci_nokia: module license 'unspecified' taints kernel.
>  kernel: [  826.461629] Disabling lock debugging due to kernel taint
>  kernel: [  826.461836] hci_nokia: Unknown symbol gpiod_get_value_cansleep (err 0)
>  kernel: [  826.461876] hci_nokia: Unknown symbol devm_kmalloc (err 0)
>  kernel: [  826.461908] hci_nokia: Unknown symbol gpiod_set_value (err 0)
>  kernel: [  826.461937] hci_nokia: Unknown symbol serdev_device_set_baudrate (err 0)
>  kernel: [  826.461994] hci_nokia: Unknown symbol gpiod_set_value_cansleep (err 0)
>  kernel: [  826.462021] hci_nokia: Unknown symbol hci_uart_tx_wakeup (err 0)
>  kernel: [  826.462043] hci_nokia: Unknown symbol serdev_device_set_flow_control (err 0)
>  kernel: [  826.462064] hci_nokia: Unknown symbol gpiod_to_irq (err 0)
>  kernel: [  826.462085] hci_nokia: Unknown symbol serdev_device_open (err 0)
>  kernel: [  826.462106] hci_nokia: Unknown symbol gpiod_get_value (err 0)
>  kernel: [  826.462150] hci_nokia: Unknown symbol clk_prepare (err 0)
>  kernel: [  826.462182] hci_nokia: Unknown symbol pm_runtime_enable (err 0)
>  kernel: [  826.462204] hci_nokia: Unknown symbol h4_recv_buf (err 0)
>  kernel: [  826.462246] hci_nokia: Unknown symbol serdev_device_write_flush (err 0)
>  kernel: [  826.462268] hci_nokia: Unknown symbol serdev_device_get_tiocm (err 0)
>  kernel: [  826.462298] hci_nokia: Unknown symbol driver_unregister (err 0)
>  kernel: [  826.462318] hci_nokia: Unknown symbol serdev_device_wait_until_sent (err 0)
>  kernel: [  826.462347] hci_nokia: Unknown symbol __serdev_device_driver_register (err 0)
>  kernel: [  826.462384] hci_nokia: Unknown symbol serdev_device_set_tiocm (err 0)
>  kernel: [  826.462417] hci_nokia: Unknown symbol clk_get_rate (err 0)
>  kernel: [  826.462454] hci_nokia: Unknown symbol __pm_runtime_resume (err 0)
>  kernel: [  826.462486] hci_nokia: Unknown symbol serdev_device_close (err 0)
>  kernel: [  826.462524] hci_nokia: Unknown symbol cancel_work_sync (err 0)
>  kernel: [  826.462546] hci_nokia: Unknown symbol btbcm_set_bdaddr (err 0)
>  kernel: [  826.462567] hci_nokia: Unknown symbol clk_disable (err 0)
>  kernel: [  826.462610] hci_nokia: Unknown symbol __pm_runtime_disable (err 0)
>  kernel: [  826.462632] hci_nokia: Unknown symbol hci_uart_register_device (err 0)
>  kernel: [  826.462653] hci_nokia: Unknown symbol clk_enable (err 0)
>  kernel: [  826.462675] hci_nokia: Unknown symbol __pm_runtime_idle (err 0)
>  kernel: [  826.462700] hci_nokia: Unknown symbol clk_unprepare (err 0)
> 
> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
> ---
> drivers/bluetooth/hci_nokia.c | 7 +++++++
> 1 file changed, 7 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

