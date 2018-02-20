Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180219154952.24339-1-luiz.dentz@gmail.com>
References: <20180219154952.24339-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 Feb 2018 16:58:30 +0200
Message-ID: <CABBYNZ+v30qq6-ve96wCeTvidfSP6A5C0+h=bJZ1cDQ=T3-REg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: Fix probing service twice
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 19, 2018 at 5:49 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If there is already a service for a given profile there is no point in
> probing it again.
> ---
>  src/device.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 1acecce33..0da4184f6 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4202,6 +4202,7 @@ static struct btd_service *probe_service(struct btd_device *device,
>                                                 struct btd_profile *profile,
>                                                 GSList *uuids)
>  {
> +       GSList *l;
>         struct btd_service *service;
>
>         if (profile->device_probe == NULL)
> @@ -4210,6 +4211,10 @@ static struct btd_service *probe_service(struct btd_device *device,
>         if (!device_match_profile(device, profile, uuids))
>                 return NULL;
>
> +       l = find_service_with_profile(device->services, profile);
> +       if (l)
> +               return l->data;
> +
>         service = service_create(device, profile);
>
>         if (service_probe(service)) {
> --
> 2.14.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
