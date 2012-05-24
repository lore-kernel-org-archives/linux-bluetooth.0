Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 13:21:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH v1 3/3] device: Ignore DUN if PAN is present
Message-ID: <20120524102120.GC23856@x220>
References: <1337853618-7261-1-git-send-email-wagi@monom.org>
 <1337853618-7261-4-git-send-email-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337853618-7261-4-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Thu, May 24, 2012, Daniel Wagner wrote:
> --- a/src/device.c
> +++ b/src/device.c
> @@ -63,6 +63,8 @@
>  #include "btio.h"
>  #include "attrib-server.h"
>  #include "attrib/client.h"
> +#include "network/common.h"
> +#include "serial/common.h"

I don't really like the idea of creating dependencies from the core
daemon (src/*) to plugin or profile directories. Any other (clean) way
we could avoid this?

Johan
