Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170825235633.23101-1-inga.stotland@intel.com>
References: <20170825235633.23101-1-inga.stotland@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Aug 2017 14:27:40 +0300
Message-ID: <CABBYNZ+wVTvzeP2qO3=EgeZnW3EuhrAAUMSSPX1oentcj3MfHA@mail.gmail.com>
Subject: Re: [PATCH] mesh: move GATT defines to the appropriate header file
To: Inga Stotland <inga.stotland@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Sat, Aug 26, 2017 at 2:56 AM, Inga Stotland <inga.stotland@intel.com> wrote:
> Group mesh GATT definitions in mesh/gatt.h file.
> Also remove unused members in mesh_node structure.
> ---
>  mesh/gatt.h | 11 +++++++++++
>  mesh/node.c |  2 --
>  mesh/node.h | 11 -----------
>  3 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/mesh/gatt.h b/mesh/gatt.h
> index a2aae2540..2878587b1 100644
> --- a/mesh/gatt.h
> +++ b/mesh/gatt.h
> @@ -23,6 +23,17 @@
>
>  #include "gdbus/gdbus.h"
>
> +/* Largest Possible GATT Packet: Provisioning Public Key + type + sar */
> +#define MAX_GATT_SIZE  (64 + 1 + 1)
> +
> +#define GATT_SAR_MASK          0xc0
> +#define GATT_SAR_COMPLETE      0x00
> +#define GATT_SAR_FIRST         0x40
> +#define GATT_SAR_CONTINUE      0x80
> +#define GATT_SAR_LAST          0xc0
> +#define GATT_TYPE_INVALID      0xff
> +#define GATT_TYPE_MASK         0x3f
> +
>  uint16_t mesh_gatt_sar(uint8_t **pkt, uint16_t size);
>  bool mesh_gatt_is_child(GDBusProxy *proxy, GDBusProxy *parent,
>                         const char *name);
> diff --git a/mesh/node.c b/mesh/node.c
> index 9c004880d..b6685509f 100644
> --- a/mesh/node.c
> +++ b/mesh/node.c
> @@ -77,12 +77,10 @@ struct mesh_node {
>         uint16_t primary;
>         uint16_t oob;
>         uint16_t features;
> -       uint8_t gatt_pkt[MAX_GATT_SIZE];
>         uint8_t dev_uuid[16];
>         uint8_t dev_key[16];
>         uint8_t num_ele;
>         uint8_t ttl;
> -       uint8_t gatt_size;
>         bool provisioner;
>         struct mesh_node_composition *comp;
>  };
> diff --git a/mesh/node.h b/mesh/node.h
> index 68c60ebef..1fab80a13 100644
> --- a/mesh/node.h
> +++ b/mesh/node.h
> @@ -21,17 +21,6 @@
>   *
>   */
>
> -/* Largest Possible GATT Packet: Provisioning Public Key + type + sar */
> -#define MAX_GATT_SIZE  (64 + 1 + 1)
> -
> -#define GATT_SAR_MASK          0xc0
> -#define GATT_SAR_COMPLETE      0x00
> -#define GATT_SAR_FIRST         0x40
> -#define GATT_SAR_CONTINUE      0x80
> -#define GATT_SAR_LAST          0xc0
> -#define GATT_TYPE_INVALID      0xff
> -#define GATT_TYPE_MASK         0x3f
> -
>  struct mesh_node;
>
>  #define ACTION_ADD             1
> --
> 2.13.5

Applied, thanks.

-- 
Luiz Augusto von Dentz
