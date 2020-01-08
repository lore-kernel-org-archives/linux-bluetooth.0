Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B20C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 12:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1851A206DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 12:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TcQEnChL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgAHMbQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:31:16 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:34416 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726967AbgAHMbP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 07:31:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578486674; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=7BY+YDpvD+FCZPPlZGH7NQ/yH7pyhZGmScGsJHBppFg=;
 b=TcQEnChL54jCmCAtsMk0AUA8U1NM8saoQbTtSMcPDHeJI0IOoio29xbXKNmG9zATI13jDUDG
 vDVtip1rCFJmFLr73xu94ADAYG2zvJBrObOXLr8jmGEe/p7CXqGC5sHunnuytEGqHfemETdk
 tmGb1Wja7aFEYYsbRyB57RQIemg=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e15cb8e.7f5f3e7c85e0-smtp-out-n03;
 Wed, 08 Jan 2020 12:31:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4B977C447A3; Wed,  8 Jan 2020 12:31:10 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 526B1C43383;
        Wed,  8 Jan 2020 12:31:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Jan 2020 18:01:09 +0530
From:   bgodavar@codeaurora.org
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org,
        hemantg@codeaurora.org
Subject: Re: [PATCH -next] Bluetooth: hci_qca: Use vfree() instead of kfree()
In-Reply-To: <20200108035931.51209-1-weiyongjun1@huawei.com>
References: <20200108035931.51209-1-weiyongjun1@huawei.com>
Message-ID: <79e6ab011f21bc6edad81fc8a01aaf9a@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2020-01-08 09:29, Wei Yongjun wrote:
> Use vfree() instead of kfree() to free vmalloc()
> allocated data.
> 
> Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory
> dump during SSR")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/bluetooth/hci_qca.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 9392cc7f9908..a17260641283 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -529,7 +529,7 @@ static void hci_memdump_timeout(struct timer_list 
> *t)
>  	bt_dev_err(hu->hdev, "clearing allocated memory due to memdump 
> timeout");
>  	/* Inject hw error event to reset the device and driver. */
>  	hci_reset_dev(hu->hdev);
> -	kfree(memdump_buf);
> +	vfree(memdump_buf);
>  	kfree(qca_memdump);
>  	qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
>  	del_timer(&qca->memdump_timer);
> @@ -1437,7 +1437,7 @@ static void qca_wait_for_dump_collection(struct
> hci_dev *hdev)
>  		bt_dev_err(hu->hdev, "Clearing the buffers due to timeout");
>  		if (qca_memdump)
>  			memdump_buf = qca_memdump->memdump_buf_tail;
> -		kfree(memdump_buf);
> +		vfree(memdump_buf);
>  		kfree(qca_memdump);
>  		qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
>  		del_timer(&qca->memdump_timer);

Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
