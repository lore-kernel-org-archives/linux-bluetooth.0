Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05C9C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 19:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiJST4Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 15:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJST4W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 15:56:22 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673221D73EF
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 12:56:16 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a6so23579240ljq.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=18xTH4DSSE8cyaCHTDXsyYwfI4Fi3+aGCjiGBwU0OBk=;
        b=ckVEz74+IJYMGg8FcPC0XmIgmctYxXlHDCWgtRBJqV0k3yK5IrbGozGZT4AxF2SeBs
         wAUz4HDdZnvgHQkTx5aZtePXJgndx6jOM/RSBECA/JQScWd7ES1v+6DSVmS+q+Bc6RYQ
         VruHxpE+xHLa9gNRJ4tszu9xmb4MjvpR1n5Mg8wKgrXcs02f0fLONjKAmjs2FdhJ15SB
         z49UTb1eG14/n82MRTZ3Tig4LdqX/JF9YcN3B/C04FafOLqPCsEgMX/HDApqtNquegWD
         KbUdFk+xyIVjv/GPuoI9x+V7lwQiOJTkARQUbvX5yEihSlyKCiA8dV47k7r/3AsvTxXx
         iYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18xTH4DSSE8cyaCHTDXsyYwfI4Fi3+aGCjiGBwU0OBk=;
        b=rI7aPPGFDr+gDOZ+UvoiRVcO4XqjZoZuVGUb/zxEnWyCAxxzaG4D9ETjV4BFVynJzr
         9D+m7qaXXYUhNtzzBlbSc6VMh4hIbRsKmXOmjjulYA1vGVyKaczHqtCGEO0bGx8TRPcA
         7529+k8hajHXUVDxpxaC+EFezjr754Q0HvMWAQhGjy/meoZ2yVEYpHC8qJQR7RTPN5Qc
         54ZIXQMctuced3IME7kkH+f8RsBkGKqw8kEVm1x0C97bfaU4h+q5xeGb9De9k5YFkBTa
         ee8luZieuAZvIy3ESXBRKx0Xzes+dwBE/lzn+48RXd+zi6qIKrov+WPTI+Xs1iD9OLIN
         U2dw==
X-Gm-Message-State: ACrzQf34Q9aIhVrPwYrjid3vJbOtloRG7ws0UNiJKMNWGeCwZmgxxFek
        jLXW34ViMZcvXQCqbLrZAbH3q3BmvFLvPnIfAK4=
X-Google-Smtp-Source: AMsMyM5Ygwub+bzv7yWwRIy3Wt7yT+afZLRngOaCVbC3FMXUftbZt9xhXRB/yrPbomo/aq4FUR2DUXVWsnlA+EBiar4=
X-Received: by 2002:a2e:834b:0:b0:26d:e1f8:1453 with SMTP id
 l11-20020a2e834b000000b0026de1f81453mr3208858ljh.65.1666209374679; Wed, 19
 Oct 2022 12:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221019073008.3398136-1-yangyingliang@huawei.com>
In-Reply-To: <20221019073008.3398136-1-yangyingliang@huawei.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 Oct 2022 12:56:03 -0700
Message-ID: <CABBYNZK5ACQYUjvX=RoH00osgT9PPE1X0VTFJWm27PrTAZLg_g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: fix error handling in hci_register_dev()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.von.dentz@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Oct 19, 2022 at 12:31 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
>
> If hci_register_suspend_notifier() returns error, the hdev
> need to be put and deleted and rfkill need be unregistered
> to avoid leaks.
>
> Fixes: 9952d90ea288 ("Bluetooth: Handle PM_SUSPEND_PREPARE and PM_POST_SUSPEND")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  net/bluetooth/hci_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 0540555b3704..03b9374f3a97 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2660,7 +2660,7 @@ int hci_register_dev(struct hci_dev *hdev)
>
>         error = hci_register_suspend_notifier(hdev);
>         if (error)
> -               goto err_wqueue;
> +               goto err_hdev;

Perhaps we could disregard the error here, or print a warning, as it
just means we won't be handing suspend requests which I guess is
better than having to fail to register which would render the
controller useless.

>
>         queue_work(hdev->req_workqueue, &hdev->power_on);
>
> @@ -2669,6 +2669,11 @@ int hci_register_dev(struct hci_dev *hdev)
>
>         return id;
>
> +err_hdev:
> +       hci_dev_put(hdev);
> +       if (hdev->rfkill)
> +               rfkill_unregister(hdev->rfkill);
> +       device_del(&hdev->dev);
>  err_wqueue:
>         debugfs_remove_recursive(hdev->debugfs);
>         destroy_workqueue(hdev->workqueue);
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
