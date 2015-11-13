Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1447078515-14340-1-git-send-email-luiz.dentz@gmail.com>
References: <1447078515-14340-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 13 Nov 2015 14:32:11 +0200
Message-ID: <CABBYNZK1qHZVxfjm=9K6QvNFmUhjk23C4B=HFqso79O0MSp+zw@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ] core/device: Fix not responding to Connect
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 9, 2015 at 4:15 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If profile is removed while its connection is pending it may not respond
> to Connect method and not cleaning up properly leaving dev->connect set
> which will prevent any attempt to connect to the device again.
> ---
> v2: Keep code removing service for the list since it is no garanteed that
> device_profile_connected will be called as it depend on the profile state.
>
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index 6722976..e76b8bb 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1498,7 +1498,7 @@ static void device_profile_connected(struct btd_device *dev,
>                 btd_device_set_temporary(dev, false);
>
>         if (dev->pending == NULL)
> -               return;
> +               goto done;
>
>         if (!btd_device_is_connected(dev)) {
>                 switch (-err) {
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz
