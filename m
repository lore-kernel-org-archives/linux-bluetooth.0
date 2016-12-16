Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161209131731.4888-1-luiz.dentz@gmail.com>
References: <20161209131731.4888-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 16 Dec 2016 14:21:32 +0200
Message-ID: <CABBYNZ+JCESJ39ZPM14u7+7qugR=kH0X5nhZJY9s3=XaN0gbvg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor/rfcomm: Remove packed attribute from structs
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 9, 2016 at 3:17 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> These structs do not represent the raw PDU format thus they don't need
> to be the exact same size.
> ---
>  monitor/rfcomm.c | 10 +++++-----
>  monitor/rfcomm.h | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
> index b32ad40..fd7bbdc 100644
> --- a/monitor/rfcomm.c
> +++ b/monitor/rfcomm.c
> @@ -90,13 +90,13 @@ struct rfcomm_lhdr {
>         uint16_t length;
>         uint8_t fcs;
>         uint8_t credits; /* only for UIH frame */
> -} __attribute__((packed));
> +};
>
>  struct rfcomm_lmsc {
>         uint8_t dlci;
>         uint8_t v24_sig;
>         uint8_t break_sig;
> -} __attribute__((packed));
> +};
>
>  struct rfcomm_rpn {
>         uint8_t dlci;
> @@ -111,16 +111,16 @@ struct rfcomm_rpn {
>  struct rfcomm_rls {
>         uint8_t dlci;
>         uint8_t error;
> -} __attribute__((packed));
> +};
>
>  struct rfcomm_nsc {
>         uint8_t cmd_type;
> -} __attribute__((packed));
> +};
>
>  struct rfcomm_lmcc {
>         uint8_t type;
>         uint16_t length;
> -} __attribute__((packed));
> +};
>
>  struct rfcomm_frame {
>         struct rfcomm_lhdr hdr;
> diff --git a/monitor/rfcomm.h b/monitor/rfcomm.h
> index c157352..f95e9c7 100644
> --- a/monitor/rfcomm.h
> +++ b/monitor/rfcomm.h
> @@ -38,14 +38,14 @@ struct rfcomm_hdr {
>         uint8_t address;
>         uint8_t control;
>         uint8_t length;
> -} __attribute__((packed));
> +};
>
>  struct rfcomm_cmd {
>         uint8_t address;
>         uint8_t control;
>         uint8_t length;
>         uint8_t fcs;
> -} __attribute__((packed));
> +};
>
>  #define RFCOMM_TEST    0x08
>  #define RFCOMM_FCON    0x28
> @@ -62,12 +62,12 @@ struct rfcomm_cmd {
>  struct rfcomm_mcc {
>         uint8_t type;
>         uint8_t length;
> -} __attribute__((packed));
> +};
>
>  struct rfcomm_msc {
>         uint8_t dlci;
>         uint8_t v24_sig;
> -} __attribute__((packed));
> +};
>
>  struct rfcomm_pn {
>         uint8_t  dlci;
> @@ -77,4 +77,4 @@ struct rfcomm_pn {
>         uint16_t mtu;
>         uint8_t  max_retrans;
>         uint8_t  credits;
> -} __attribute__((packed));
> +};
> --
> 2.9.3

Applied.


-- 
Luiz Augusto von Dentz
