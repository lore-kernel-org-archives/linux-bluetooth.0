Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] android/README: Update with implementation status summary
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392033059-3346-1-git-send-email-szymon.janc@tieto.com>
Date: Mon, 10 Feb 2014 10:37:58 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <762992F3-C997-4C16-B309-9B1413A40BDC@holtmann.org>
References: <1392033059-3346-1-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This will give a better overview of implemented features.
> ---
> android/README | 37 ++++++++++++++++++++++++++++++++-----
> 1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/android/README b/android/README
> index e3c314f..49536e2 100644
> --- a/android/README
> +++ b/android/README
> @@ -132,15 +132,42 @@ automatically on HAL library initialization. To deinitialize HAL library and
> stop daemon type 'bluetooth cleanup'. Type 'help' for more information. Tab
> completion is also supported.
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

use a ------ line here to separate header for content.


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
> +

Regards

Marcel

