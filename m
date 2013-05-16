Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH BlueZ] plugins: Fix compilation error on autopair
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1368712856-30692-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Thu, 16 May 2013 16:07:20 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9C2AAC1D-11FF-42B4-8658-0FFBC50A2A46@holtmann.org>
References: <1368712856-30692-1-git-send-email-anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> Fix this error caught using gcc 4.6.3:
> 
> plugins/autopair.c: In function ‘autopair_init’:
> plugins/autopair.c:154:8: error: ignoring return value of ‘fread’,
> declared with attribute warn_unused_result [-Werror=unused-result]
> ---
> plugins/autopair.c |    8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/plugins/autopair.c b/plugins/autopair.c
> index 5d90f9d..5afc357 100644
> --- a/plugins/autopair.c
> +++ b/plugins/autopair.c
> @@ -146,15 +146,19 @@ static struct btd_adapter_driver autopair_driver = {
> static int autopair_init(void)
> {
> 	/* Initialize the random seed from /dev/urandom */
> -	unsigned int seed = time(NULL);
> +	unsigned int seed;
> +	size_t nread = 0;
> 	FILE *f;
> 
> 	f = fopen("/dev/urandom", "rb");
> 	if (f != NULL) {
> -		fread(&seed, sizeof(seed), 1, f);
> +		nread = fread(&seed, sizeof(seed), 1, f);
> 		fclose(f);
> 	}
> 
> +	if (f == NULL || nread != 1)
> +		seed = time(NULL);
> +
> 	srand(seed);

lets redo this in actually readable code ;)

Checking f twice is not acceptable. And I still wonder why fopen() is here preferred over open().

Regards

Marcel


