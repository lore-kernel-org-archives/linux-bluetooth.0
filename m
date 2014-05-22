Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/bluetooth: Add bonded information to found device callback
Date: Thu, 22 May 2014 13:13:24 +0200
Message-ID: <2469505.QrkjKaLJfi@uw000953>
In-Reply-To: <1400600254-19736-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400600254-19736-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Tuesday 20 of May 2014 17:37:34 Lukasz Rymanowski wrote:
> If device is bonded then discoverable flag is not set. This cause that
> gatt application will not get scan callback with advertising bonded
> device.
> 
> ---
> 
> Not sure if it should work like that but lets do it for now. It is
> useful for testing at least.

As we discussed applications should just connect on already bonded devices and
get notify when connected. But Bluetooth SIG reference app expects to have
device appear in scan result (even if bonded) to be able to do anything with it.

Since it is likely that this scheme will be copied by apps developer this
patch is now pushed upstream. Thanks.

-- 
Best regards, 
Szymon Janc
