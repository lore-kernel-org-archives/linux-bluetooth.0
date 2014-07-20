Return-Path: <cyrus@holtmann.org>
Date: Sun, 20 Jul 2014 18:43:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix endian and alignment issue with ath3k
 version handling
Message-ID: <20140720154319.GA7032@t440s.P-661HNU-F1>
References: <1405870199-32499-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405870199-32499-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 20, 2014, Marcel Holtmann wrote:
> The ath3k driver is treating the version information badly when it
> comes to loading the right firmware version and comparing that it
> actually matches with the hardware.
> 
> Initially this showed up as this:
> 
>   CHECK   drivers/bluetooth/ath3k.c
> drivers/bluetooth/ath3k.c:373:17: warning: cast to restricted __le32
> drivers/bluetooth/ath3k.c:435:17: warning: cast to restricted __le32
> 
> However when fixing this by actually using __packed and __le32 for
> the ath3_version structure, more issues came up:
> 
>   CHECK   drivers/bluetooth/ath3k.c
> drivers/bluetooth/ath3k.c:381:32: warning: incorrect type in assignment (different base types)
> drivers/bluetooth/ath3k.c:381:32:    expected restricted __le32 [usertype] rom_version
> drivers/bluetooth/ath3k.c:381:32:    got int [signed] <noident>
> drivers/bluetooth/ath3k.c:382:34: warning: incorrect type in assignment (different base types)
> drivers/bluetooth/ath3k.c:382:34:    expected restricted __le32 [usertype] build_version
> drivers/bluetooth/ath3k.c:382:34:    got int [signed] <noident>
> drivers/bluetooth/ath3k.c:386:28: warning: restricted __le32 degrades to integer
> drivers/bluetooth/ath3k.c:386:56: warning: restricted __le32 degrades to integer
> 
> This patch fixes every instance of the firmware version handling and
> makes sure it is endian safe and uses proper unaligned access.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/ath3k.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
