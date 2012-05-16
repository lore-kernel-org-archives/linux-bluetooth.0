Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1336657428-14129-1-git-send-email-vishal.agarwal@stericsson.com>
References: <1336657428-14129-1-git-send-email-vishal.agarwal@stericsson.com>
Date: Wed, 16 May 2012 13:32:08 +0530
Message-ID: <CA+_sZW8tYxCyfKrc8_r0E+toOj=HQxfDWaQTY=ezmxd6Jtg+AA@mail.gmail.com>
Subject: Re: [PATCH] textfile: fix missing call to munmap in wite_key
From: vishal agarwal <vishal.bluez@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vishal Agarwal <vishal.agarwal@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 5/10/12, Vishal Agarwal <vishal.agarwal@stericsson.com> wrote:
> In some cases it was possible that munmap is not called corresponding
> to mmap, which might result in future read or writes to fail.
> ---
>  src/textfile.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/src/textfile.c b/src/textfile.c
> index 2712cd8..9d88fbc 100644
> --- a/src/textfile.c
> +++ b/src/textfile.c
> @@ -220,8 +220,8 @@ static int write_key(const char *pathname, const char
> *key, const char *value, i
>  	len = strlen(key);
>  	off = find_key(map, size, key, len, icase);
>  	if (!off) {
> +		munmap(map, size);
>  		if (value) {
> -			munmap(map, size);
>  			lseek(fd, size, SEEK_SET);
>  			err = write_key_value(fd, key, value);
>  		}
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Did you get a chance to look at it. Just to brief about the problem -
If we try to pair unpair device many times then in certain conditions
munmap is not called and after some times the mmap starts failing.
which will result in nsuccessful pairing or unpairing.
This patch fixes this issue.

Thanks
Vishal
