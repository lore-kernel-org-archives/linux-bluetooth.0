Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] android/bluetooth: Make possible to start BlueZ in LE mode only
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1398204991-5165-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Tue, 22 Apr 2014 17:29:12 -0700
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Message-Id: <F332EBA9-C4B5-43C1-B50C-48EB46AEFFC1@holtmann.org>
References: <1398204991-5165-1-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> This patch adds possibility to start BlueZ only in LE mode only.
> 
> It is useful for testing purpose, when you want test BlueZ in
> peripheral mode against any dual mode device.
> ---
> android/README          |  3 +++
> android/bluetooth.c     |  7 ++++++-
> android/hal-bluetooth.c | 15 ++++++++++++++-
> android/hal-msg.h       |  1 +
> 4 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/android/README b/android/README
> index 6254d34..9b08610 100644
> --- a/android/README
> +++ b/android/README
> @@ -166,6 +166,9 @@ options.
> 
> Property	Value		Description
> -------------------------------------------
> +mode		le_only		Enable BlueZ in Low Energy mode only.
> +		<none>		Enable BlueZ in default mode - enable br/edr/le
> +				if possible.

we better do “bredr” and “le” here. If left empty it will default to auto detect mode with BR/EDR and LE enabled if available with your kernel and supported by the controller.

There might be actually an use case where you have a dual-mode controller, but want to just only use BR/EDR. It will be especially hard to fine BR/EDR only controllers.

Regards

Marcel

