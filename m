Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH BlueZ 1/2] plugins: Use open()/read() instead of fopen()/fread() on autopair
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1368721510-14339-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Fri, 17 May 2013 07:14:17 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AF55EC03-6D36-4150-B314-0F5DB2F46485@holtmann.org>
References: <1368721510-14339-1-git-send-email-anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> open()/read() is more common on BlueZ code. Incidentally, get rid of
> this compilation error (using gcc 4.6.3):
> 
> plugins/autopair.c: In function ‘autopair_init’:
> plugins/autopair.c:154:8: error: ignoring return value of ‘fread’,
> declared with attribute warn_unused_result [-Werror=unused-result]
> ---
> 
> WARNING: compilation tested only.
> 
> plugins/autopair.c |   20 +++++++++++++-------
> 1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/plugins/autopair.c b/plugins/autopair.c
> index 5d90f9d..63f906d 100644
> --- a/plugins/autopair.c
> +++ b/plugins/autopair.c
> @@ -27,6 +27,8 @@
> 
> #include <stdbool.h>
> #include <stdlib.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> 
> #include <bluetooth/bluetooth.h>
> #include <glib.h>
> @@ -146,15 +148,19 @@ static struct btd_adapter_driver autopair_driver = {
> static int autopair_init(void)
> {
> 	/* Initialize the random seed from /dev/urandom */
> -	unsigned int seed = time(NULL);
> -	FILE *f;
> -
> -	f = fopen("/dev/urandom", "rb");
> -	if (f != NULL) {
> -		fread(&seed, sizeof(seed), 1, f);
> -		fclose(f);
> +	unsigned int seed;
> +	ssize_t nread = 0;
> +	int fd;
> +
> +	fd = open("/dev/urandom", O_RDONLY);
> +	if (fd != -1) {

we are still checking this with fd < 0.

> +		nread = read(fd, &seed, sizeof(seed));
> +		close(fd);
> 	}

	else
		nread = -1;

I really dislike initialized variable if there is no reason for doing that.

> 
> +	if (nread < (ssize_t) sizeof(seed))
> +		seed = time(NULL);
> +
> 	srand(seed);

Also I wonder why this is all so complicated.

	if (fd < 0) {
		int n;

		n = read(fd, ...);
		if (n < sizeof(...))
			seed = time();

		close(fd);
	} else
		seed = time();

Regards

Marcel

