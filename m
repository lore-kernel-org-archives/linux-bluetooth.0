Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86369C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 07:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJSH41 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 03:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJSH4Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 03:56:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8274D148
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 00:56:22 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MsjdV2zPSzpVfd;
        Wed, 19 Oct 2022 15:53:02 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 15:55:54 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 15:55:54 +0800
Subject: Re: [PATCH] Bluetooth: hci_core: fix error handling in
 hci_register_dev()
To:     <linux-bluetooth@vger.kernel.org>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <yangyingliang@huawei.com>
References: <20221019073008.3398136-1-yangyingliang@huawei.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <0f9158b4-d352-881d-a460-e47f16d46a79@huawei.com>
Date:   Wed, 19 Oct 2022 15:55:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221019073008.3398136-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 2022/10/19 15:30, Yang Yingliang wrote:
> If hci_register_suspend_notifier() returns error, the hdev
> need to be put and deleted and rfkill need be unregistered
> to avoid leaks.
>
> Fixes: 9952d90ea288 ("Bluetooth: Handle PM_SUSPEND_PREPARE and PM_POST_SUSPEND")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   net/bluetooth/hci_core.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 0540555b3704..03b9374f3a97 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2660,7 +2660,7 @@ int hci_register_dev(struct hci_dev *hdev)
>   
>   	error = hci_register_suspend_notifier(hdev);
>   	if (error)
> -		goto err_wqueue;
> +		goto err_hdev;
>   
>   	queue_work(hdev->req_workqueue, &hdev->power_on);
>   
> @@ -2669,6 +2669,11 @@ int hci_register_dev(struct hci_dev *hdev)
>   
>   	return id;
>   
> +err_hdev:
> +	hci_dev_put(hdev);
> +	if (hdev->rfkill)
> +		rfkill_unregister(hdev->rfkill);
> +	device_del(&hdev->dev);
rfkill_destroy() also need be called, I will send a v2 to add it.
Pls ignore this patch.

Thanks,
Yang
>   err_wqueue:
>   	debugfs_remove_recursive(hdev->debugfs);
>   	destroy_workqueue(hdev->workqueue);
