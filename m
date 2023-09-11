Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C44EE57DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Sep 2023 07:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjIKHFE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 03:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjIKHFE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 03:05:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CEC10C
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 00:04:56 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rkd152sMczMl8W;
        Mon, 11 Sep 2023 15:01:29 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 11 Sep 2023 15:04:54 +0800
Subject: Re: [PATCH BlueZ v2 1/1] bap: Use defer setup when syncing to a BIS
 source
To:     Vlad Pruteanu <vlad.pruteanu@nxp.com>,
        <linux-bluetooth@vger.kernel.org>
CC:     <claudia.rosu@nxp.com>, <mihai-octavian.urzica@nxp.com>,
        <silviu.barbulescu@nxp.com>, <iulia.tanasescu@nxp.com>,
        <andrei.istodorescu@nxp.com>
References: <20230911061624.30600-1-vlad.pruteanu@nxp.com>
 <20230911061624.30600-2-vlad.pruteanu@nxp.com>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <9971ad4e-e07d-9d63-2bb0-ec9ae4e0db5c@huawei.com>
Date:   Mon, 11 Sep 2023 15:04:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20230911061624.30600-2-vlad.pruteanu@nxp.com>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> This commit uses the newly added bt_io_bcast_accept function from
> btio.c to implement the defer setup for the BIS sync process.
> Now, information from the BIG Info advertising report can be
> used when sending the BIG Create Sync command.
> ---
>  profiles/audio/bap.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index ee90426b9..8a2da24dd 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -840,6 +840,22 @@ drop:
>  
>  }
>  
> +static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
> +{
> +	GError *err = NULL;
> +
> +	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
> +				user_data, NULL, &err)) {
> +		error("bt_io_bcast_accept: %s", err->message);
> +		g_error_free(err);
> +		goto drop;
> +	}
> +	return;
> +
> +drop:
> +	g_io_channel_shutdown(io, TRUE, NULL);
> +}
Maybe we do not need goto. It's can be more concise as following:

static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
{
	GError *err = NULL;

	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
				user_data, NULL, &err)) {
		error("bt_io_bcast_accept: %s", err->message);
		g_error_free(err);
		g_io_channel_shutdown(io, TRUE, NULL);
	}
}

or

static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
{
	GError *err = NULL;

	if (bt_io_bcast_accept(io, iso_bcast_confirm_cb,
				user_data, NULL, &err)) {
		return;
	}

	error("bt_io_bcast_accept: %s", err->message);
	g_error_free(err);
	g_io_channel_shutdown(io, TRUE, NULL);
}


William Xuan
> +
>  static bool match_data_bap_data(const void *data, const void *match_data)
>  {
>  	const struct bap_data *bdata = data;
> @@ -1587,7 +1603,7 @@ static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
>  	if (bt_bap_stream_get_io(stream) || data->listen_io)
>  		return;
>  
> -	io = bt_io_listen(iso_bcast_confirm_cb, NULL, ep->data, NULL, &err,
> +	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, ep->data, NULL, &err,
>  			BT_IO_OPT_SOURCE_BDADDR,
>  			btd_adapter_get_address(ep->data->adapter),
>  			BT_IO_OPT_DEST_BDADDR,
> 
