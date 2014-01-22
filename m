Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Refactor paths in Android.mk
Date: Wed, 22 Jan 2014 09:37:52 +0100
Message-ID: <15451655.4uoYhfFIrB@uw000953>
In-Reply-To: <1390347953-29901-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390347953-29901-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wednesday 22 of January 2014 00:45:53 Andrzej Kaczmarek wrote:
> Using source paths relative to android/ directory created mess in
> Android's obj directory since object files are created also relative
> to bluetoothd_intermediates (thus can be created outside it).
> 
> To avoid this we set LOCAL_PATH to absolute path (in terms of Android
> build root) of directory in which bluez/ is located and change and
> update source paths accordingly.
> 
> This also allows us to build in future glib and sbc easily using
> Android.mk in BlueZ.

Applied, thanks.

-- 
Best regards, 
Szymon Janc
