Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 1/2] android: Add "eSCO transparent data is mSBC" mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1394751135-2747-1-git-send-email-szymon.janc@gmail.com>
Date: Thu, 13 Mar 2014 18:40:24 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FAC34E2D-4197-48C0-A5BB-0C35467ECB7D@holtmann.org>
References: <1394751135-2747-1-git-send-email-szymon.janc@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This is usefull for platforms that assume transparent eSCO data is
> mSBC e.g. Nexus 4.
> ---
> android/hal-ipc-api.txt | 1 +
> android/hal-msg.h       | 1 +
> 2 files changed, 2 insertions(+)
> 
> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
> index e4a4e9c..acfb8a0 100644
> --- a/android/hal-ipc-api.txt
> +++ b/android/hal-ipc-api.txt
> @@ -757,6 +757,7 @@ Bluetooth Handsfree HAL (ID 5)
> Android HAL name: "handsfree" (BT_PROFILE_HANDSFREE_ID)
> 
> 	Service modes:               0x01 = Headset Profile only mode
> +	                             0x02 = eSCO transparent data is mSBC mode

actually lets do them a little bit different here:

		0x00 = Headset Profile only mode
		0x01 = Handsfree Profile (narrowband speech)
		0x02 = Handsfree Profile (narrowband and wideband speech)

We should default to HSP only since that is the only safe default we can have here. The existence of a cellular modem is not always given.

Which means on a device like the Nexus 7 or any other WiFi only tablet, the defaults will work just fine.

Regards

Marcel

