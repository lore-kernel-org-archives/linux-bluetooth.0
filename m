Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 29 Nov 2017 09:35:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Correct typo in config op defines
Message-ID: <20171129073511.GA26973@x1c.lan>
References: <1511801117.14298.4.camel@ewol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1511801117.14298.4.camel@ewol.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Mon, Nov 27, 2017, Steve Brown wrote:
> diff --git a/mesh/config-model.h b/mesh/config-model.h
> index be7acabb9..d7ee5e61f 100644
> --- a/mesh/config-model.h
> +++ b/mesh/config-model.h
> @@ -93,7 +93,7 @@
>  #define OP_NODE_RESET_STATUS			0x804A
>  #define OP_MODEL_APP_GET			0x804B
>  #define OP_MODEL_APP_LIST			0x804C
> -#define OP_VEND_MODEL_APP_GET			0x804C
> +#define OP_VEND_MODEL_APP_GET			0x804D
>  #define OP_VEND_MODEL_APP_LIST			0x804E

Applied. Thanks.

Johan
