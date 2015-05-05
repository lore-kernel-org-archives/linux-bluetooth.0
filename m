Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1430783850-21140-1-git-send-email-armansito@chromium.org>
References: <1430783850-21140-1-git-send-email-armansito@chromium.org>
Date: Tue, 5 May 2015 14:57:00 -0700
Message-ID: <CAHrH25TPnkoWYY5Et8WWyBL_byH2o8QEm0mYwNi4qRTtB4ZFwQ@mail.gmail.com>
Subject: Re: [RFC BlueZ] doc/device-api: Add GattServices
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: =?UTF-8?Q?Giovanni_Ortu=C3=B1o?= <ortuno@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> On Mon, May 4, 2015 at 4:57 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch introduces the GattServices property that contains the object
> paths of exported GattService1 objects. The purpose of this property is
> to signal when all GATT services on a remote device have been
> discovered.
> ---
>  doc/device-api.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 20d6c65..a8076a2 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -211,3 +211,11 @@ Properties string Address [readonly]
>
>                         Service advertisement data. Keys are the UUIDs in
>                         string format followed by its byte array value.
> +
> +               array{object} GattServices [readonly, optional]
> +
> +                       List of GATT service object paths. Each referenced
> +                       object exports the org.bluez.GattService1 interface and
> +                       represents a remote GATT service. This property will be
> +                       updated once all remote GATT services of this device
> +                       have been discovered and exported over D-Bus.
> --
> 2.2.0.rc0.207.ga3a616c
>

Since there have been no objections, I pushed this proposal. It's a
simple enough addition anyway, and it's consistent with the current
GATT API.

Thanks,
Arman
