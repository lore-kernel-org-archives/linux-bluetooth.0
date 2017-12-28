Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1514446716.7000.293.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] Bluetooth: hci_bcm: Support Apple GPIO handling
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Lukas Wunner <lukas@wunner.de>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frederic Danis <frederic.danis.oss@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Ronald Tschalaer <ronald@innovation.ch>,
        "Peter Y. Chuang" <peteryuchuang@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Thu, 28 Dec 2017 09:38:36 +0200
In-Reply-To: <6E039068-0B7D-4E69-B0BB-A240FAE12089@holtmann.org>
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
         <6E039068-0B7D-4E69-B0BB-A240FAE12089@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2017-12-26 at 21:50 +0100, Marcel Holtmann wrote:
> Hi Lukas,
> 
> > 

> > +
> > +	if (!acpi_dev_get_property(adev, "baud", ACPI_TYPE_BUFFER,
> > &obj) &&
> > +	    obj->buffer.length == 8)
> > +		dev->init_speed = *(u64 *)obj->buffer.pointer;
> 
> 	if (!ACPI_SUCCESS(..))
> 		return -ENODEV;

ACPI_FAILURE()

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
