Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 3/3] Bluetooth: Avoid WARN splat due to missing GPIOLIB
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <9ef8be4ef80c38b693e5755c738a88de9c907944.1514143015.git.lukas@wunner.de>
Date: Tue, 26 Dec 2017 21:57:25 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederic Danis <frederic.danis.oss@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Ronald Tschalaer <ronald@innovation.ch>,
        "Peter Y. Chuang" <peteryuchuang@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <6C0DCEC6-5E52-480C-B291-3671E57B6765@holtmann.org>
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
 <9ef8be4ef80c38b693e5755c738a88de9c907944.1514143015.git.lukas@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukas,

> Loading hci_bcm with CONFIG_GPIOLIB=n results in the following splat
> when calling gpiod_to_irq() from bcm_get_resources():
> 
>    WARNING: CPU: 0 PID: 1006 at ./include/linux/gpio/consumer.h:450 bcm_get_resources+0x50/0x80
>    CPU: 0 PID: 1006 Comm: kworker/u8:4 Tainted: G       A         4.15.0-rc4custom+ #4
>    Hardware name: Apple Inc. MacBook8,1/Mac-BE0E8AC46FE800CC, BIOS MB81.88Z.0168.B00.1708080033 08/08/2017
>    Call Trace:
>    bcm_serdev_probe+0x8b/0xc0
>    driver_probe_device+0x202/0x310
>    __driver_attach+0x85/0x90
>    ? driver_probe_device+0x310/0x310
>    bus_for_each_dev+0x57/0x80
>    async_run_entry_fn+0x2c/0xd0
>    process_one_work+0x1d2/0x3d0
>    worker_thread+0x26/0x3c0
>    ? process_one_work+0x3d0/0x3d0
>    kthread+0x10c/0x130
>    ? kthread_create_on_node+0x40/0x40
>    ret_from_fork+0x1f/0x30
> 
> We could call gpiod_to_irq() only if IS_ENABLED(CONFIG_GPIOLIB) but
> without GPIOLIB, the driver's power saving features can't be used,
> so selecting GPIOLIB seems more appropriate.
> 
> The same issue is present in hci_intel.c and hci_nokia.c, fix those up
> as well.
> 
> Reported-by: Max Shavrick <mxms@me.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> drivers/bluetooth/Kconfig | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

