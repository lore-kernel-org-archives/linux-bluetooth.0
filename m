Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1515417550.7000.787.camel@linux.intel.com>
Subject: Re: [PATCH v3 10/13] Bluetooth: hci_bcm: Support Apple GPIO handling
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
Date: Mon, 08 Jan 2018 15:19:10 +0200
In-Reply-To: <73222c916fea6b3f0ebe4c8674dd3e97e997d283.1515348092.git.lukas@wunner.de>
References: <cover.1515348092.git.lukas@wunner.de>
         <73222c916fea6b3f0ebe4c8674dd3e97e997d283.1515348092.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2018-01-07 at 20:16 +0100, Lukas Wunner wrote:

It looks like you are going to send another version, thus...

> +#else
> +static inline int bcm_apple_get_resources(struct bcm_device *dev)
> +{ return -EOPNOTSUPP; }

I would not do this kind of style, better to unroll to normal, like

{
	return -EOPNOTSUPP;
}

>  #endif /* CONFIG_ACPI */

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
