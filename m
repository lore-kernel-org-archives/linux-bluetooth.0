Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170901153546.17111-1-brian.gix@intel.com>
References: <20170901153546.17111-1-brian.gix@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 3 Sep 2017 22:15:59 +0300
Message-ID: <CABBYNZK93bwu4gYz+h5GuZDEdrm_rxmh2XFVHVJmBT=EZm+b9g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mesh: Enforce HIGH security when provisioning
To: Brian Gix <brian.gix@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Brian,

On Fri, Sep 1, 2017 at 6:35 PM, Brian Gix <brian.gix@intel.com> wrote:
> ---
>  mesh/prov.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mesh/prov.c b/mesh/prov.c
> index 32785dd..f78a876 100644
> --- a/mesh/prov.c
> +++ b/mesh/prov.c
> @@ -57,7 +57,7 @@
>  #define MESH_PROV_SEC_LOW      0
>
>  /* For Deployment, Security levels below HIGH are *not* recomended */
> -#define mesh_gatt_prov_security()      MESH_PROV_SEC_MED
> +#define mesh_gatt_prov_security()      MESH_PROV_SEC_HIGH

I fine having the security it as high by default, but should we have a
command to set to other levels for testing purposes?

>  #define PROV_INVITE    0x00
>  #define PROV_CAPS      0x01
> --
> 2.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
