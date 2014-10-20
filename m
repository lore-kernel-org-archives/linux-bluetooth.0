Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHF=Y4q0ZRbGAUMtMi5vA13hQFn8JCmu+7B1rLdRxDSO6jxiCg@mail.gmail.com>
References: <1413290765-20398-1-git-send-email-fons@spotify.com>
 <1413290765-20398-3-git-send-email-fons@spotify.com> <20141020134206.GB31414@t440s>
 <CAHF=Y4q0ZRbGAUMtMi5vA13hQFn8JCmu+7B1rLdRxDSO6jxiCg@mail.gmail.com>
From: Alfonso Acosta <fons@spotify.com>
Date: Mon, 20 Oct 2014 16:53:33 +0200
Message-ID: <CAHF=Y4psnk823Rk9kxXkpCuYUnuYre4NFMj7oQ0rm5xB7+3vsQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] core: Add subscription API for Manufacturer
 Specific Data
To: Alfonso Acosta <fons@spotify.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,


>
> This patch also doesn't compile (the error from the first patch might
> have gone away, but then there's this new one):
>
> src/adapter.c:4654:6: error: no previous declaration for ‘adapter_msd_notify’ [-Werror=missing-declarations]
>  void adapter_msd_notify(struct btd_adapter *adapter, struct btd_device *dev,
>       ^
> cc1: all warnings being treated as errors
> make[1]: *** [src/bluetoothd-adapter.o] Error 1


v5 corrects this problem.

I didn't know that -Wall is only enabled when passing
--enable-maintainer-mode to configure (which I wasn't doing).

-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
