Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1514984774.7000.569.camel@linux.intel.com>
Subject: Re: [PATCH v2 05/10] Bluetooth: hci_bcm: Add helper to toggle
 device wake GPIO
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frederic Danis <frederic.danis.oss@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Ronald Tschalaer <ronald@innovation.ch>,
        "Peter Y. Chuang" <peteryuchuang@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Wed, 03 Jan 2018 15:06:14 +0200
In-Reply-To: <5f656f915ada50079fd5606ee591e59239ab6a2b.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
         <5f656f915ada50079fd5606ee591e59239ab6a2b.1514916630.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2018-01-02 at 20:08 +0100, Lukas Wunner wrote:
> There is already a bcm_gpio_set_power() helper to toggle the power
> enable pin.  Add a corresponding helper to toggle the device wake pin.
> This will allow us to more easily integrate support for MacBooks which
> use custom ACPI methods to access both pins.
> 
> The only functional change here is an additional 15 ms delay when
> toggling the device wake pin in bcm_gpio_set_power().  It is unclear
> why
> this delay is observed in bcm_suspend_device() and
> bcm_resume_device(),
> but not in bcm_gpio_set_power() so far.

Btw, can we switch to msleep() ?
I don't check if it's atomic context when it's used.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
