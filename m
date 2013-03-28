Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v7 14/16] sbc: Update sbcdec for msbc
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1364465943-959-15-git-send-email-frederic.dalleau@linux.intel.com>
Date: Thu, 28 Mar 2013 08:34:24 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <17635E69-B778-4F16-92BF-7FAF877DE8D3@holtmann.org>
References: <1364465943-959-1-git-send-email-frederic.dalleau@linux.intel.com> <1364465943-959-15-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> ---
> src/sbcdec.c |   23 ++++++++++++++++++-----
> 1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/src/sbcdec.c b/src/sbcdec.c
> index 0077a82..8b67c2b 100644
> --- a/src/sbcdec.c
> +++ b/src/sbcdec.c
> @@ -4,6 +4,7 @@
>  *
>  *  Copyright (C) 2008-2010  Nokia Corporation
>  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
> + *  Copyright (C) 2012-2013  Intel Corporation
>  *
>  *
>  *  This program is free software; you can redistribute it and/or modify
> @@ -31,6 +32,7 @@
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdlib.h>
> +#include <stdbool.h>
> #include <string.h>
> #include <getopt.h>
> #include <sys/stat.h>
> @@ -44,7 +46,7 @@
> 
> static int verbose = 0;
> 
> -static void decode(char *filename, char *output, int tofile)
> +static void decode(char *filename, char *output, int tofile, bool msbc)
> {
> 	unsigned char buf[BUF_SIZE], *stream;
> 	struct stat st;
> @@ -98,7 +100,11 @@ static void decode(char *filename, char *output, int tofile)
> 		goto free;
> 	}
> 
> -	sbc_init(&sbc, 0L);
> +	if (msbc) {
> +		sbc_init_msbc(&sbc, 0L);
> +	} else {
> +		sbc_init(&sbc, 0L);
> +	}
> 	sbc.endian = SBC_BE;
> 
> 	framelen = sbc_decode(&sbc, stream, streamlen, buf, sizeof(buf), &len);
> @@ -228,14 +234,16 @@ static void usage(void)
> 
> 	printf("Options:\n"
> 		"\t-h, --help           Display help\n"
> -		"\t-v, --verbose        Verbose mode\n"
> 		"\t-d, --device <dsp>   Sound device\n"
> +		"\t-v, --verbose        Verbose mode\n"
> +		"\t-m, --msbc           mSBC codec\n"
> 		"\t-f, --file <file>    Decode to a file\n"
> 		"\n");
> }
> 
> static struct option main_options[] = {
> 	{ "help",	0, 0, 'h' },
> +	{ "msbc",	0, 0, 'm' },
> 	{ "device",	1, 0, 'd' },
> 	{ "verbose",	0, 0, 'v' },
> 	{ "file",	1, 0, 'f' },
> @@ -246,8 +254,9 @@ int main(int argc, char *argv[])
> {
> 	char *output = NULL;
> 	int i, opt, tofile = 0;
> +	bool msbc = 0;

please use false or true for assignments of bool variables.

> 
> -	while ((opt = getopt_long(argc, argv, "+hvd:f:",
> +	while ((opt = getopt_long(argc, argv, "+hmvd:f:",
> 						main_options, NULL)) != -1) {
> 		switch(opt) {
> 		case 'h':
> @@ -258,6 +267,10 @@ int main(int argc, char *argv[])
> 			verbose = 1;
> 			break;
> 
> +		case 'm':
> +			msbc = 1;
> +			break;
> +
> 		case 'd':
> 			free(output);
> 			output = strdup(optarg);
> @@ -285,7 +298,7 @@ int main(int argc, char *argv[])
> 	}
> 
> 	for (i = 0; i < argc; i++)
> -		decode(argv[i], output ? output : "/dev/dsp", tofile);
> +		decode(argv[i], output ? output : "/dev/dsp", tofile, msbc);
> 
> 	free(output);

Regards

Marcel

