Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Gix, Brian" <brian.gix@intel.com>
To: Lukasz Rymanowski <lukasz.rymanowski@codecoup.pl>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ 3/3] mesh: Use security low as default
Date: Thu, 31 Aug 2017 23:07:51 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4373E1D2A0B@ORSMSX103.amr.corp.intel.com>
References: <20170831101257.1644-1-lukasz.rymanowski@codecoup.pl>
 <20170831101257.1644-3-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20170831101257.1644-3-lukasz.rymanowski@codecoup.pl>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It would be an extremely bad idea to set the default Mesh Security to LOW.

If anything, the default security should be raised to HIGH.

We set it to Medium initially to aid in testability, however, we can show that any mesh that *ever* provisioned even a single node with LOW or MEDIUM security will be permanently compromised.

There is a white paper currently being written in the Mesh Working group which discusses this issue in detail, but the gist of the problem is that it is Extremely Simple to design a Man-in-the-Middle attack which will expose the entire Network Key, the Device Key, and all shared Application keys to any device provisioned with LOW security.

It is not much more difficult to compromise MEDIUM security if the only OOB material is a value between 0-9.

While I believe LOW security does have purpose for manufacturer device testing (to test and validate encryption algorithms) we must be extremely careful that it is never release "In the Wild".

I had honestly intended to change this to HIGH before making the initial push of this code... and leave it up to developers to *temporarily* lower the security level for short term testing on an as-needed basis. Because even MEDIUM is a security compromise we cannot risk for this technology.

I will in fact shortly send a patch to increase the default security level to HIGH.


Please note that this is 100% different from standard point-to-point Bluetooth.  In Point-to-Point relationships, a compromised LTK (Long Term Key) requires a simple re-pairing. In Mesh, every single node in the mesh must be reprovisioned.



> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Lukasz Rymanowski
> Sent: Thursday, August 31, 2017 3:13 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: £ukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
> Subject: [PATCH BlueZ 3/3] mesh: Use security low as default
> 
> ---
>  mesh/prov.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mesh/prov.c b/mesh/prov.c
> index 32785dda1..964259cd0 100644
> --- a/mesh/prov.c
> +++ b/mesh/prov.c
> @@ -57,7 +57,7 @@
>  #define MESH_PROV_SEC_LOW	0
> 
>  /* For Deployment, Security levels below HIGH are *not* recomended */
> -#define mesh_gatt_prov_security()	MESH_PROV_SEC_MED
> +#define mesh_gatt_prov_security()	MESH_PROV_SEC_LOW
> 
>  #define PROV_INVITE	0x00
>  #define PROV_CAPS	0x01
> --
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
