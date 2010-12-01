Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Dec 2010 15:50:36 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Bala Shanmugam <sbalashanmugam@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Add new PID for Atheros 3011
Message-ID: <20101201175035.GB16125@vigoh>
References: <1290773146-4705-1-git-send-email-sbalashanmugam@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290773146-4705-1-git-send-email-sbalashanmugam@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bala,

* Bala Shanmugam <sbalashanmugam@atheros.com> [2010-11-26 17:35:46 +0530]:

> Atheros 3011 has small sflash firmware and needs to be
> blacklisted in transport driver to load actual firmware
> in DFU driver.
> 
> Signed-off-by: Bala Shanmugam <sbalashanmugam@atheros.com>
> ---
>  drivers/bluetooth/ath3k.c |    4 ++++
>  drivers/bluetooth/btusb.c |    3 +++
>  2 files changed, 7 insertions(+), 0 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
