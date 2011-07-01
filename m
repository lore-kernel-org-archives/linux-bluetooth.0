Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Jul 2011 14:48:49 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: "Steven.Li" <Steven.Li@Atheros.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Steven.Li" <yongli@qca.qualcomm.com>
Subject: Re: [PATCH v2] Bluetooth: Add Atheros AR3012 one PID/VID supported
Message-ID: <20110701174849.GB23683@joana>
References: <1309500156-2118-1-git-send-email-Steven.Li@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309500156-2118-1-git-send-email-Steven.Li@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steven,

* Steven.Li <Steven.Li@Atheros.com> [2011-07-01 14:02:36 +0800]:

> The new Ath3k needs to download patch and radio table,
> and it keeps same PID/VID even after downloading the patch and radio
> table. This patch is to use the bcdDevice (Device Release Number) to
> judge whether the chip has been patched or not. The init bcdDevice
> value of the chip is 0x0001, this value increases after patch and
> radio table downloading.
> 
> Signed-off-by: Steven.Li <yongli@qca.qualcomm.com>
> ---
>  drivers/bluetooth/ath3k.c |    5 +++++
>  drivers/bluetooth/btusb.c |   12 +++++++++++-
>  2 files changed, 16 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo
