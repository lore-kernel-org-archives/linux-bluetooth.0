Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Feb 2012 19:51:05 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use NULL instead of integer for
 mgmt_device_connected param
Message-ID: <20120301015105.GH26492@x220>
References: <1329051335-14246-1-git-send-email-szymon@janc.net.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329051335-14246-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sun, Feb 12, 2012, Szymon Janc wrote:
> Last param of mgmt_device_connected is of pointer type, so use NULL
> instead of 0 for it. This fix following sparse warning:
> 
> CHECK   net/bluetooth/hci_event.c
> net/bluetooth/hci_event.c:3262:74: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Szymon Janc <szymon@janc.net.pl>
> ---
>  net/bluetooth/hci_event.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
