Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346164127-22102-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346164127-22102-1-git-send-email-anderson.lizardo@openbossa.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 28 Aug 2012 21:15:47 -0300
Message-ID: <CAMOw1v4t_KVBW6dJXracXmKEyCcs3Jg3M82mEwJDvorTt2hV8Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input: Fix build error due to O_CLOEXEC
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 28, 2012 at 11:28 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> On some (not so old) systems like Ubuntu 10.04 LTS, O_CLOEXEC is only
> defined if _GNU_SOURCE is defined.
>
> This fixes this build error:
>
> profiles/input/hog_device.c: In function 'hog_device_register':
> profiles/input/hog_device.c:712: error: 'O_CLOEXEC' undeclared (first
> use in this function)
> profiles/input/hog_device.c:712: error: (Each undeclared identifier is
> reported only once
> profiles/input/hog_device.c:712: error: for each function it appears
> in.)
> ---
>  profiles/input/hog_device.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
> index 000f173..b502274 100644
> --- a/profiles/input/hog_device.c
> +++ b/profiles/input/hog_device.c
> @@ -27,6 +27,7 @@
>  #include <config.h>
>  #endif
>
> +#define _GNU_SOURCE

this should be already in our config.h. It seems like we are missing
the following in our configure.ac:

AC_USE_SYSTEM_EXTENSIONS.

Btw, we should remove the other definitions of _GNU_SOURCE

>  #include <stdlib.h>
>  #include <errno.h>
>  #include <unistd.h>


Lucas De Marchi
