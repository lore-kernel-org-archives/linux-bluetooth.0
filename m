Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331720036-31535-4-git-send-email-chen.ganir@ti.com>
References: <1331720036-31535-1-git-send-email-chen.ganir@ti.com>
	<1331720036-31535-4-git-send-email-chen.ganir@ti.com>
Date: Wed, 14 Mar 2012 06:41:30 -0400
Message-ID: <CAJdJm_P-ECvY-XO9h515O4Dr5bGG8_ew2mxuqq=rBDfBk9hfqA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] GATT: Profile support for EnableGatt
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Mar 14, 2012 at 6:13 AM,  <chen.ganir@ti.com> wrote:
> @@ -28,6 +28,7 @@
>
>  #include <stdint.h>
>  #include <glib.h>
> +#include <errno.h>
>
>  #include "plugin.h"
>  #include "hcid.h"
> @@ -37,8 +38,8 @@
>  static int time_init(void)
>  {
>        if (!main_opts.gatt_enabled) {
> -               DBG("Attribute server is disabled");
> -               return -1;
> +               DBG("GATT is disabled !");
> +               return -ENOTSUP;

Your patch series looks ok, only a minor nitpick: I would use "GATT
support is disabled"  and skip the exclamation.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
