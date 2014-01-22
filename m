Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390398620-1916-2-git-send-email-ncopa@alpinelinux.org>
References: <CABBYNZLmpK51xe80XxAwT7rBRkUGsZNhcmMWSnHSyuY--meu_w@mail.gmail.com>
	<1390398620-1916-1-git-send-email-ncopa@alpinelinux.org>
	<1390398620-1916-2-git-send-email-ncopa@alpinelinux.org>
Date: Wed, 22 Jan 2014 11:16:20 -0400
Message-ID: <CAJdJm_Mo=hGHMYFhurEO2+L_UPpT3YPy-is020d1_CMrXzDeRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] various header include fixes for building with
 musl libc
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Natanael Copa <natanael.copa@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Natanael Copa <ncopa@alpinelinux.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natanael,

On Wed, Jan 22, 2014 at 9:50 AM, Natanael Copa <natanael.copa@gmail.com> wrote:
> diff --git a/src/textfile.h b/src/textfile.h
> index b779bd2..e26da5d 100644
> --- a/src/textfile.h
> +++ b/src/textfile.h
> @@ -24,6 +24,8 @@
>  #ifndef __TEXTFILE_H
>  #define __TEXTFILE_H
>
> +#include <sys/stat.h>
> +

I believe the correct approach here is to include sys/stat.h on all
files that include textfile.h. We (usually) don't #include system
headers inside internal headers.

>  int create_file(const char *filename, const mode_t mode);
>  int create_name(char *buf, size_t size, const char *path,
>                                 const char *address, const char *name);

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
