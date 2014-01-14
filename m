Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389697905-18532-5-git-send-email-szymon.janc@tieto.com>
References: <1389697905-18532-1-git-send-email-szymon.janc@tieto.com>
	<1389697905-18532-5-git-send-email-szymon.janc@tieto.com>
Date: Tue, 14 Jan 2014 17:49:54 +0200
Message-ID: <CABBYNZJRVE50AVx0Tm+y_MMuO94U4wEARetXyhRf8UckJCwJcw@mail.gmail.com>
Subject: Re: [RFC 4/5] android/bluetooth: Add support for caching remote
 device info
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jan 14, 2014 at 1:11 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Cache is limited to DEVICES_CACHE_MAX. Devices are sorted with
> timestamp so if cache is full olderst device is removed.
> ---
>  android/bluetooth.c | 69 ++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 55 insertions(+), 14 deletions(-)
>
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 8c91d87..df442a3 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -70,6 +70,8 @@
>  /* Default discoverable timeout 120sec as in Android */
>  #define DEFAULT_DISCOVERABLE_TIMEOUT 120
>
> +#define DEVICES_CACHE_MAX 100

Is this being limited because Android UI cannot handle more than that?
Or perhaps because our IPC/MTU cannot carry more than that? If the
latter I believe we can actually calculate the maximun e.g. MTU / pdu
size.
