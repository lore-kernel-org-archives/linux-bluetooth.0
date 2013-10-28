Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382716327-25283-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1382716327-25283-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Mon, 28 Oct 2013 11:53:36 +0200
Message-ID: <CABBYNZLpen=3t+N45oDQYpHOd3y8D=sJk8ybjSnbFnKm2ggMhw@mail.gmail.com>
Subject: Re: [PATCH 1/6] android/hal: Fix typo in A2DP HAL service name
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Fri, Oct 25, 2013 at 6:52 PM, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@tieto.com> wrote:
> A2DP was misspelled as AD2P
> ---
>  android/hal-ipc-api.txt | 2 +-
>  android/hal-msg.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
> index 0c2fd25..dc0d067 100644
> --- a/android/hal-ipc-api.txt
> +++ b/android/hal-ipc-api.txt
> @@ -1023,7 +1023,7 @@ Notifications:
>  Bluetooth Advanced Audio HAL (ID 6)
>  ===================================
>
> -Android HAL name: "ad2p" (BT_PROFILE_ADVANCED_AUDIO_ID)
> +Android HAL name: "a2dp" (BT_PROFILE_ADVANCED_AUDIO_ID)
>
>  Commands and responses:
>
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 172cecb..5de8eb2 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -40,7 +40,7 @@ struct hal_hdr {
>  #define HAL_SERVICE_ID_HIDHOST         3
>  #define HAL_SERVICE_ID_PAN             4
>  #define HAL_SERVICE_ID_HANDSFREE       5
> -#define HAL_SERVICE_ID_AD2P            6
> +#define HAL_SERVICE_ID_A2DP            6
>  #define HAL_SERVICE_ID_HEALTH          7
>  #define HAL_SERVICE_ID_AVRCP           8
>  #define HAL_SERVICE_ID_GATT            9
> --
> 1.8.4.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
