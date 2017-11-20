Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171120134244.24548-1-luiz.dentz@gmail.com>
References: <20171120134244.24548-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Nov 2017 17:13:02 +0200
Message-ID: <CABBYNZKPoSmBBKoOgDsDEBrEG5HSpL7dybzAL7wrn13YLcYyyg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] doc/device-api: Document behavior of Disconnect
 method with LE
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 20, 2017 at 3:42 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If and LE device is disconnected using device.Device method it won't
> be able to reconnect by itself.
> ---
>  doc/device-api.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 13b28818e..ac5604f9c 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -52,6 +52,10 @@ Methods              void Connect()
>                         This method can be also used to cancel a preceding
>                         Connect call before a reply to it has been received.
>
> +                       When connected over LE bearer calling this method will
> +                       prevent incoming connections until Connect method is
> +                       called again.
> +
>                         Possible errors: org.bluez.Error.NotConnected
>
>                 void ConnectProfile(string uuid)
> --
> 2.13.6

Applied.


-- 
Luiz Augusto von Dentz
