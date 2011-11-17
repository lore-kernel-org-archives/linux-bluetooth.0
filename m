Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1321458294-20000-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1321458294-20000-1-git-send-email-mikel.astiz@bmw-carit.de>
Date: Thu, 17 Nov 2011 11:15:26 +0200
Message-ID: <CABBYNZLN7zFCrK_wULf2t8KbVPOdO3H+NBy=NMCk5Ph=fWmptw@mail.gmail.com>
Subject: Re: [PATCH obexd] syncevolution: added missing header file
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, Nov 16, 2011 at 5:44 PM, Mikel Astiz <mikel.astiz@bmw-carit.de> wrote:
> ---
>  plugins/syncevolution.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
> index 41386b3..8a8b531 100644
> --- a/plugins/syncevolution.c
> +++ b/plugins/syncevolution.c
> @@ -30,6 +30,7 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include <glib.h>
> +#include <sys/types.h>
>  #include <dbus/dbus.h>
>
>  #include <bluetooth/bluetooth.h>
> --
> 1.7.6.4

Could you please add a description to it and if it is a build error
please attach it too, also it is suggested that bug fixes like this
should start with fix e.g. syncevolution: fix... to be reviewed asap.

-- 
Luiz Augusto von Dentz
