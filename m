Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B25C2BA80
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 19:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C655E206BE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 19:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgDGTta (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:49:30 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:48525 "EHLO
        7.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgDGTta (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 15:49:30 -0400
X-Greylist: delayed 84363 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Apr 2020 15:49:30 EDT
Received: from player732.ha.ovh.net (unknown [10.108.42.73])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id 3AF25999E3
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2020 21:42:21 +0200 (CEST)
Received: from labapart.com (mue-88-130-59-209.dsl.tropolys.de [88.130.59.209])
        (Authenticated sender: olivier@labapart.com)
        by player732.ha.ovh.net (Postfix) with ESMTPSA id CEC33111814D3
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2020 19:42:20 +0000 (UTC)
Subject: Re: [PATCH BlueZ v2] emulator: Fix command line parameters with
 optional argument
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200407194059.5734-1-olivier@labapart.com>
From:   Olivier MARTIN <olivier@labapart.com>
Message-ID: <167a95a1-38d1-9f1f-9556-7bd855c3fe81@labapart.com>
Date:   Tue, 7 Apr 2020 21:42:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200407194059.5734-1-olivier@labapart.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Ovh-Tracer-Id: 15536574291400945228
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudehgddufeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefqlhhivhhivghrucfoteftvffkpfcuoeholhhivhhivghrsehlrggsrghprghrthdrtghomheqnecukfhppedtrddtrddtrddtpdekkedrudeftddrheelrddvtdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpeholhhivhhivghrsehlrggsrghprghrthdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Oops, some debug leftover. Please ignore this patch.

On 07.04.20 21:40, Olivier Martin wrote:
> Some parameters were missing the indication that additional
> argument could be expected.
> ---
>   btio/btio.c     | 8 ++++++--
>   emulator/main.c | 6 ++++--
>   2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index e7b4db16b..56c59f84e 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -1676,12 +1676,16 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
>   	ret = parse_set_opts(&opts, gerr, opt1, args);
>   	va_end(args);
>   
> -	if (ret == FALSE)
> +	if (ret == FALSE) {
> +		fprintf(stderr, "bt_io_connect(type:%d) err1\n", opts.type);
>   		return NULL;
> +	}
>   
>   	io = create_io(FALSE, &opts, gerr);
> -	if (io == NULL)
> +	if (io == NULL) {
> +		fprintf(stderr, "bt_io_connect(type:%d) err2\n", opts.type);
>   		return NULL;
> +	}
>   
>   	sock = g_io_channel_unix_get_fd(io);
>   
> diff --git a/emulator/main.c b/emulator/main.c
> index 68c53488e..75cb79c7b 100644
> --- a/emulator/main.c
> +++ b/emulator/main.c
> @@ -56,10 +56,12 @@ static void usage(void)
>   	printf("options:\n"
>   		"\t-S                    Create local serial port\n"
>   		"\t-s                    Create local server sockets\n"
> -		"\t-l [num]              Number of local controllers\n"
> +		"\t-l[num]               Number of local controllers\n"
>   		"\t-L                    Create LE only controller\n"
> +		"\t-U[num]               Number of test LE controllers\n"
>   		"\t-B                    Create BR/EDR only controller\n"
>   		"\t-A                    Create AMP controller\n"
> +		"\t-T[num]               Number of test AMP controllers\n"
>   		"\t-h, --help            Show help options\n");
>   }
>   
> @@ -97,7 +99,7 @@ int main(int argc, char *argv[])
>   	for (;;) {
>   		int opt;
>   
> -		opt = getopt_long(argc, argv, "Ssl::LBAUTvh",
> +		opt = getopt_long(argc, argv, "Ssl::LBAU::T::vh",
>   						main_options, NULL);
>   		if (opt < 0)
>   			break;
