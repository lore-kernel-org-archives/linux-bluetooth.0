Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v3 5/9] Bluetooth: btrtl: Add support for a config
 filename postfix
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180710081117.25078-6-hdegoede@redhat.com>
Date: Sat, 14 Jul 2018 18:06:06 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
Message-Id: <330BDF4A-9729-4DFE-B9DA-F5A02EB6B09A@holtmann.org>
References: <20180710081117.25078-1-hdegoede@redhat.com>
 <20180710081117.25078-6-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> The contents of the rtl_bt/rtlXXXX_config.bin file may be board specific
> allow the caller of btrtl_initialize to specify a postfix identifying
> the board, which if specified will make btrtl_initialize look for
> rtl_bt/rtlXXXX_config-<postfix>.bin instead.

frankly I do not get this patch. Where would the <postfix> come from? Is that something we would put into DT or where? I think you need a bit more explanation here.

Regards

Marcel

