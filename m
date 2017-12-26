Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 2/3] Bluetooth: hci_bcm: Streamline runtime PM code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1958f497c2710a67d3549122ee7bd71a69b0dd6c.1514143015.git.lukas@wunner.de>
Date: Tue, 26 Dec 2017 21:57:23 +0100
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
Message-Id: <FD1727A3-BAAE-41ED-A2FD-50C5A756F4C6@holtmann.org>
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
 <1958f497c2710a67d3549122ee7bd71a69b0dd6c.1514143015.git.lukas@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukas,

> This driver seeks to force the Bluetooth device on for the duration of
> 5 seconds when the Bluetooth device has woken the host and after a
> complete packet has been received.  It does that by calling:
> 
>    pm_runtime_get();
>    pm_runtime_mark_last_busy();
>    pm_runtime_put_autosuspend();
> 
> The same can be achieved more succinctly with:
> 
>    pm_request_resume();
> 
> That's because after runtime resuming the device, rpm_resume() invokes
> pm_runtime_mark_last_busy() followed by rpm_idle(), which will cause
> the device to be suspended after expiration of the autosuspend_delay.
> 
> No functional change intended.
> 
> Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> drivers/bluetooth/hci_bcm.c | 11 +++--------
> 1 file changed, 3 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

