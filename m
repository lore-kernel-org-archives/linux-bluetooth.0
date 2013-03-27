Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v6 16/17] sbc: Update sbcinfo for msbc
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362565163-3567-17-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 26 Mar 2013 19:28:09 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <11C7EDD2-CFA0-4392-BFE9-8DEFA9C99F7D@holtmann.org>
References: <1362565163-3567-1-git-send-email-frederic.dalleau@linux.intel.com> <1362565163-3567-17-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> ---
> src/sbcinfo.c |   52 +++++++++++++++++++++++++++++++++++++---------------
> 1 file changed, 37 insertions(+), 15 deletions(-)
> 
> diff --git a/src/sbcinfo.c b/src/sbcinfo.c
> index 8cfb54a..676b949 100644
> --- a/src/sbcinfo.c
> +++ b/src/sbcinfo.c
> @@ -4,6 +4,7 @@
>  *
>  *  Copyright (C) 2008-2010  Nokia Corporation
>  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
> + *  Copyright (C) 2012       Intel Corporation
>  *
>  *
>  *  This program is free software; you can redistribute it and/or modify
> @@ -61,12 +62,11 @@ struct sbc_frame_hdr {
> #error "Unknown byte order"
> #endif
> 
> -static int calc_frame_len(struct sbc_frame_hdr *hdr)
> +static int calc_frame_len(struct sbc_frame_hdr *hdr, int nrof_blocks)
> {
> -	int tmp, nrof_subbands, nrof_blocks;
> +	int tmp, nrof_subbands;
> 
> 	nrof_subbands = (hdr->subbands + 1) * 4;
> -	nrof_blocks = (hdr->blocks + 1) * 4;
> 
> 	switch (hdr->channel_mode) {
> 	case 0x00:
> @@ -89,13 +89,12 @@ static int calc_frame_len(struct sbc_frame_hdr *hdr)
> 	return (nrof_subbands + ((tmp + 7) / 8));
> }
> 
> -static double calc_bit_rate(struct sbc_frame_hdr *hdr)
> +static double calc_bit_rate(struct sbc_frame_hdr *hdr, int nrof_blocks)
> {
> -	int nrof_subbands, nrof_blocks;
> +	int nrof_subbands;
> 	double f;
> 
> 	nrof_subbands = (hdr->subbands + 1) * 4;
> -	nrof_blocks = (hdr->blocks + 1) * 4;
> 
> 	switch (hdr->sampling_frequency) {
> 	case 0:
> @@ -114,7 +113,7 @@ static double calc_bit_rate(struct sbc_frame_hdr *hdr)
> 		return 0;
> 	}
> 
> -	return ((8 * (calc_frame_len(hdr) + 4) * f) /
> +	return ((8 * (calc_frame_len(hdr, nrof_blocks) + 4) * f) /
> 			(nrof_subbands * nrof_blocks));
> }
> 
> @@ -175,7 +174,7 @@ static int analyze_file(char *filename)
> 	double rate;
> 	int bitpool[SIZE], frame_len[SIZE];
> 	int subbands, blocks, freq, method;
> -	int n, p1, p2, fd, size, num;
> +	int n, p1, p2, fd, size, num, msbc;
> 	ssize_t len;
> 	unsigned int count;
> 
> @@ -191,17 +190,30 @@ static int analyze_file(char *filename)
> 		fd = fileno(stdin);
> 
> 	len = __read(fd, &hdr, sizeof(hdr));
> -	if (len != sizeof(hdr) || hdr.syncword != 0x9c) {
> +	if (len != sizeof(hdr) || !(hdr.syncword == 0x9c ||
> +			hdr.syncword == 0xad)) {
> 		fprintf(stderr, "Not a SBC audio file\n");
> 		return -1;
> 	}
> +	msbc = (hdr.syncword == 0xad) ? 1 : 0;

actually lets do a proper check for both sync words and fail nicely if we encounter an unknown one.

Also we could do that right at the header check.

> +
> +	if (msbc) {
> +		hdr.subbands = 1; /* 8 */
> +		hdr.sampling_frequency = 0x00; /* 16000 */
> +		hdr.allocation_method = 0; /* Loudness */
> +		hdr.bitpool = 26;
> +		hdr.channel_mode = 0x00; /* Mono */
> +
> +		blocks = 15;
> +	} else {
> +		blocks = (hdr.blocks + 1) * 4;
> +	}
> 
> 	subbands = (hdr.subbands + 1) * 4;
> -	blocks = (hdr.blocks + 1) * 4;
> 	freq = hdr.sampling_frequency;
> 	method = hdr.allocation_method;
> 
> -	count = calc_frame_len(&hdr);
> +	count = calc_frame_len(&hdr, blocks);
> 
> 	bitpool[0] = hdr.bitpool;
> 	frame_len[0] = count + 4;
> @@ -213,7 +225,7 @@ static int analyze_file(char *filename)
> 
> 	if (lseek(fd, 0, SEEK_SET) < 0) {
> 		num = 1;
> -		rate = calc_bit_rate(&hdr);
> +		rate = calc_bit_rate(&hdr, blocks);
> 		while (count) {
> 			size = count > sizeof(buf) ? sizeof(buf) : count;
> 			len = __read(fd, buf, size);
> @@ -237,14 +249,23 @@ static int analyze_file(char *filename)
> 		if (len == 0)
> 			break;
> 
> -		if ((size_t) len < sizeof(hdr) || hdr.syncword != 0x9c) {
> +		if ((size_t) len < sizeof(hdr) || !(hdr.syncword == 0x9c ||
> +				hdr.syncword == 0xad)) {
> 			fprintf(stderr, "Corrupted SBC stream "
> 					"(len %zd syncword 0x%02x)\n",
> 					len, hdr.syncword);
> 			break;
> 		}
> 
> -		count = calc_frame_len(&hdr);
> +		if (msbc) {
> +			hdr.subbands = 1; /* 8 */
> +			hdr.sampling_frequency = 0x00; /* 16000 */
> +			hdr.allocation_method = 0; /* Loudness */
> +			hdr.bitpool = 26;
> +			hdr.channel_mode = 0x00; /* Mono */
> +		}
> +
> +		count = calc_frame_len(&hdr, blocks);
> 		len = count + 4;
> 
> 		p1 = -1;
> @@ -273,10 +294,11 @@ static int analyze_file(char *filename)
> 			count -= len;
> 		}
> 
> -		rate += calc_bit_rate(&hdr);
> +		rate += calc_bit_rate(&hdr, blocks);
> 		num++;
> 	}
> 
> +	printf("mSBC\t\t\t%d\n", msbc);
> 	printf("Subbands\t\t%d\n", subbands);
> 	printf("Block length\t\t%d\n", blocks);
> 	printf("Sampling frequency\t%s\n", freq2str(freq));

Regards

Marcel

