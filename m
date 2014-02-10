Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1392033059-3346-1-git-send-email-szymon.janc@tieto.com>
References: <1392033059-3346-1-git-send-email-szymon.janc@tieto.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Mon, 10 Feb 2014 15:35:15 +0100
Message-ID: <CAF3PWx0fcUUQtdvm2c4m985vDNMdtOQKjKaFeg9L-LOZ+-dcxA@mail.gmail.com>
Subject: Re: [PATCH] android/README: Update with implementation status summary
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 10 February 2014 12:50, Szymon Janc <szymon.janc@tieto.com> wrote:
>
> This will give a better overview of implemented features.
> ---
>  android/README | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/android/README b/android/README
> index e3c314f..49536e2 100644
> --- a/android/README
> +++ b/android/README
> @@ -132,15 +132,42 @@ automatically on HAL library initialization. To deinitialize HAL library and
>  stop daemon type 'bluetooth cleanup'. Type 'help' for more information. Tab
>  completion is also supported.
>
> +=====================
> +Implementation status
> +=====================
> +
> +Summary of HALs implementation status.
> +
> +complete    - implementation is feature complete and Android Framework is able
> +              to use it normally
> +partial     - implementation is in progress and not all required features are
> +              present, Android Framework is able to use some of features
> +initial     - only initial implementations is present, Android Framework is
> +              able to initialize but most likely not able to use it
> +not started - no implementation, Android Framework is not able to initialize it
> +
> +profile ID    HAL header         status
> +core          bluetooth.h        complete
> +a2dp          bt_av.h            complete
> +gatt          bt_gatt.h          not started
> +              bt_gatt_client.h   not started
> +              bt_gatt_server.h   not started
> +handsfree     bt_hf.h            initial
> +hidhost       bt_hh.h            complete
> +health        bt_hl.h            not started
> +pan           bt_pan.h           complete
> +avrcp         bt_rc.h            partial
> +socket        bt_sock.h          complete

This should be 'partial' since you application cannot register server
on custom UUID with channel being assigned dynamically
(BluetoothAdapter::listenUsingRfcommWithServiceRecord). I have patches
which add this support but need to fix other code first in order to
make them work properly.

BR,
Andrzej
