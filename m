Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Jul 2013 14:37:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio/player: Fix overflowing position
Message-ID: <20130731113708.GA21662@x220.p-661hnu-f1>
References: <1375270072-13140-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375270072-13140-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jul 31, 2013, Luiz Augusto von Dentz wrote:
> The position should stop at UINT32_MAX after that the progress can no
> longer be calculated, this should also prevent the position to change
> when the remote stack doesn't support it which is also indicated with
> UINT32_MAX which apparently is the case of Spotify on Android 4.3:
> 
> [CHG] Player /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/player0 Position: 0xffffffff
> [CHG] Player /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/player0 Status: playing
> [CHG] Player /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/player0 Position: 0x000000
> ---
>  profiles/audio/player.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
