Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1368073016-28434-5-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1368073016-28434-5-git-send-email-lucas.demarchi@profusion.mobi>
Date: Thu, 9 May 2013 06:45:48 -0400
Message-ID: <CAJdJm_MzO3rQ6q2Rv_hQzokHiG5KE_GHdyKAoKDVc+=EG9QhGg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 05/26] attrib: Get rid of guint* types
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, May 9, 2013 at 12:16 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> guint -> unsigned int
> guint8 -> uint8_t
> guint16 -> uint16_t
> guint32 -> uint32_t
> guint64 -> uint64_t
>
> Add "#include <inttypes.h>" where appropriate and prefer this one over
> stdint.h.
> ---
>  attrib/att.c         |   2 +-
>  attrib/gatt.c        | 124 ++++++++++++++++++++++++++-------------------------
>  attrib/gatt.h        |  33 +++++++-------
>  attrib/gattrib.c     |  51 ++++++++++-----------
>  attrib/gattrib.h     |  21 +++++----
>  attrib/gatttool.c    |  19 ++++----
>  attrib/interactive.c |  35 ++++++++-------
>  7 files changed, 148 insertions(+), 137 deletions(-)
>
> diff --git a/attrib/att.c b/attrib/att.c
> index d2b78bd..e196fa3 100644
> --- a/attrib/att.c
> +++ b/attrib/att.c
> @@ -27,7 +27,7 @@
>  #endif
>
>  #include <errno.h>
> -#include <stdint.h>
> +#include <inttypes.h>
>  #include <stdlib.h>

Any reason to include inttypes.h instead of just stdint.h? Are we
using any of the PRI* format conversion macros?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
