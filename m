Return-Path: <gregkh@linuxfoundation.org>
Date: Sat, 7 Oct 2017 08:42:56 +0200
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>
Cc: robh@kernel.org, marcel@holtmann.org, sre@kernel.org,
	loic.poulain@gmail.com, johan@kernel.org, lukas@wunner.de,
	hdegoede@redhat.com, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] serdev: Add ACPI support
Message-ID: <20171007064256.GA19701@kroah.com>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 04, 2017 at 10:51:29AM +0200, Frédéric Danis wrote:
> This patch allows SerDev module to manage serial devices declared as
> attached to an UART in ACPI table.
> 
> acpi_serdev_add_device() callback will only take into account entries
> without enumerated flag set. This flags is set for all entries during
> ACPI scan, except for SPI and I2C serial devices, and for UART with
> 2nd patch in the series.
> 
> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
