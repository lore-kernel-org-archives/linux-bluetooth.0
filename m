Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Oct 2013 18:30:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android: Add initial Android Bluetooth HAL protocol
 API doc
Message-ID: <20131014153055.GB26449@x220.p-661hnu-f1>
References: <1381737959-9138-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381737959-9138-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Oct 14, 2013, Szymon Janc wrote:
> This IPC is used to communicate Android BlueZ daemon and HAL.
> 
> Currently specified are BT HAL "bluetooth" (BT_HARDWARE_MODULE_ID)
> and following profile HALs:
>   "socket"    (BT_PROFILE_SOCKETS_ID)
>   "hidhost"   (BT_PROFILE_HIDHOST_ID)
>   "pan"       (BT_PROFILE_PAN_ID)
>   "handsfree" (BT_PROFILE_HANDSFREE_ID)
>   "ad2p"      (BT_PROFILE_ADVANCED_AUDIO_ID)
>   "health"    (BT_PROFILE_HEALTH_ID)
> ---
>  android/hal-ipc-api.txt | 1247 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1247 insertions(+)
>  create mode 100644 android/hal-ipc-api.txt

Both patches have been applied. Thanks.

Johan
