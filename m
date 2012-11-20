Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Nov 2012 11:23:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio: Auto connect AVRCP in case of A2DP source
 is connected
Message-ID: <20121120092332.GA4273@x220>
References: <1353402781-21791-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353402781-21791-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Nov 20, 2012, Luiz Augusto von Dentz wrote:
> This enables the same logic used for A2DP sink, so it attempt to
> connect AVRCP if remote device support it.
> 
> Note this is necessary for some devices e.g. WP7 that don't connect
> even when being the initiator because it is not mandatory for target
> to do so even though it is recommended to avoid collisions while trying
> to estabilish the connection.
> ---
>  profiles/audio/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
