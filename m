Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Oct 2013 15:59:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com,
	andrei.emeltchenko@intel.com
Subject: Re: [PATCH v3] android: Fix build error for Android
Message-ID: <20131023125918.GB23296@x220.p-661hnu-f1>
References: <1382532559-25830-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382532559-25830-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Oct 23, 2013, Lukasz Rymanowski wrote:
> Android uses functions and defines from sys/capability.h which
> requires additional include. However file capability.h shows up
> in bionic in version Android 4.3, therefore we do check
> PLATFORM_SDK_VERSION to no break builds of previous Android versions.
> In previous Android version unistd.h contain this functionality.
> ---
>  android/Android.mk | 3 ++-
>  android/main.c     | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
