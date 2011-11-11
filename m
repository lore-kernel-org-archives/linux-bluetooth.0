Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1321021134-31809-2-git-send-email-johan.hedberg@gmail.com>
References: <1321021134-31809-1-git-send-email-johan.hedberg@gmail.com>
	<1321021134-31809-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 11 Nov 2011 10:37:53 -0400
Message-ID: <CAJdJm_PLSU5wckLrXRjnL8WJb-YAq49s1oMwA_Y72rTbE_pPEQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: Create a unique mgmt error code hierarchy
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Nov 11, 2011 at 10:18 AM,  <johan.hedberg@gmail.com> wrote:
> +#ifndef NELEM
> +#define NELEM(arr) (sizeof(arr) / sizeof((arr)[0]))
> +#endif
> +

What about using ARRAY_SIZE() from  kernel.h ?

include/linux/kernel.h:#define ARRAY_SIZE(arr) (sizeof(arr) /
sizeof((arr)[0]) + __must_be_array(arr))

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
