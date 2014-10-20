Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Oct 2014 15:42:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 2/2] core: Add subscription API for Manufacturer
 Specific Data
Message-ID: <20141020134206.GB31414@t440s>
References: <1413290765-20398-1-git-send-email-fons@spotify.com>
 <1413290765-20398-3-git-send-email-fons@spotify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1413290765-20398-3-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

On Tue, Oct 14, 2014, Alfonso Acosta wrote:
> This patch allows plugins to be notified whenever an adapter receives
> Manufacturer Specific Data in the advertising reports from a device.
> 
> This can happen when new device is discovered or when we autoconnect
> to it.
> ---
>  src/adapter.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  src/adapter.h | 10 ++++++++++
>  2 files changed, 54 insertions(+)

This patch also doesn't compile (the error from the first patch might
have gone away, but then there's this new one):

src/adapter.c:4654:6: error: no previous declaration for ‘adapter_msd_notify’ [-Werror=missing-declarations]
 void adapter_msd_notify(struct btd_adapter *adapter, struct btd_device *dev,
      ^
cc1: all warnings being treated as errors
make[1]: *** [src/bluetoothd-adapter.o] Error 1


Johan
