Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Sep 2010 22:28:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Fix bluetoothd not starting on cold boot
Message-ID: <20100922192819.GA21611@jh-x301>
References: <1285155481.13582.99.camel@cookie.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285155481.13582.99.camel@cookie.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Wed, Sep 22, 2010, Bastien Nocera wrote:
> Subject: [PATCH] Also run bluetoothd on udev change events
> 
> Fixes bluetoothd not starting on cold boot with newer versions
> of udev. See:
> https://bugzilla.redhat.com/show_bug.cgi?id=634205
> ---
>  scripts/bluetooth.rules.in |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/scripts/bluetooth.rules.in b/scripts/bluetooth.rules.in
> index 6809e9d..64df69d 100644
> --- a/scripts/bluetooth.rules.in
> +++ b/scripts/bluetooth.rules.in
> @@ -1,3 +1,4 @@
>  # Run helper every time a Bluetooth device appears
>  # On remove actions, bluetoothd should go away by itself
>  ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="@prefix@/sbin/bluetoothd --udev"
> +ACTION=="change", SUBSYSTEM=="bluetooth", RUN+="@prefix@/sbin/bluetoothd --udev"

Thanks. The patch has been pushed upstream.

Johan
