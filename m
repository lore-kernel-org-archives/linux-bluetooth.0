Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AF55EC03-6D36-4150-B314-0F5DB2F46485@holtmann.org>
References: <1368721510-14339-1-git-send-email-anderson.lizardo@openbossa.org>
	<AF55EC03-6D36-4150-B314-0F5DB2F46485@holtmann.org>
Date: Fri, 17 May 2013 07:05:25 -0400
Message-ID: <CAJdJm_NefGTEAgXrU7uZVeG0t11QnNG7UvsYh589dNrdYDrYqg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] plugins: Use open()/read() instead of
 fopen()/fread() on autopair
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, May 17, 2013 at 1:14 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Also I wonder why this is all so complicated.
>
>         if (fd < 0) {
>                 int n;
>
>                 n = read(fd, ...);
>                 if (n < sizeof(...))
>                         seed = time();
>
>                 close(fd);
>         } else
>                 seed = time();

I intentionally avoided nested if()'s and the duplicated "seed =
time(...)" assignment because it seemed to actually make it more
complex IMHO. I will change to the version above, but I don't see why
it is more readable than my v2 (plus the changes you proposed above).
My main concern for this specific code is still to get the build fixed
:)

Note that the cast is necessary because "sizeof()" is unsigned.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
