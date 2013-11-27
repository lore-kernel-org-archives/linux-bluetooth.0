Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Nov 2013 12:58:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/bluetooth: Change discoverable mode only if
 connectable
Message-ID: <20131127105804.GD16389@x220.p-661hnu-f1>
References: <1385467227-11832-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385467227-11832-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 26, 2013, Szymon Janc wrote:
> There is no need to sending set_discoverable command if new settings
> are not connectable as clearing connectable also clear discoverable.
> Sending set_discoverable when not connectable result in 'rejected'
> mgmt response.
> ---
>  android/bluetooth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
