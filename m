Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4192ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 05:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIUFuj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 01:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIUFuh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 01:50:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419D77E033
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Sep 2022 22:50:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so1119422pjk.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Sep 2022 22:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GUsGWfFjCkkYsZi2T7tEP8EOmCJsERhGD1rIFTAC9ZY=;
        b=jAZADw4rSApjIKIYgI3rFD3HMNngYtZlPtD9Hrs7uJ1wTOhPgGSOuVTMWB6m8gfW4j
         t/+iMlI+NsR0WmPtr5aeGByPr8nyX31fWNBUYoXK5vj3a0T3sg3xHS7vfjZGzI2yW5Vb
         9JGeBNdAw3D0MX95z4qXjuARktMCZwrBfg66S30FJl7EdJmariQxaA6856rwaQnHPPRF
         pBf6j8JAMbTskgYm7OmcUexVdxgv6e83AnFmBQEJyNz8KnSCGoUFud2YpIcfIqx1uUFL
         j+ExxKGGyZU1Iq0WYmVdNSLbeola4N/MYJrCA+eQuRzWUqsRWI5ieVasqNd1WFiRoms6
         u+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GUsGWfFjCkkYsZi2T7tEP8EOmCJsERhGD1rIFTAC9ZY=;
        b=iIseHgFLOlfm2SavMJeVEJMJ6GL1r6m/e2Z0QajwMU5kVFyPPdF1b7tbkMvdnaEOSE
         mZjdjyM56CIEr9hpBMBzErkRKOSd/WrNTPqDVSmMm1cVFf5HqA9tI2L2mRq0TMIUhHSI
         72CsE9NlybyjBiAJi89CbdDn3R9pm5JrT8REtU/SozhtEsl8bSddaklEDSQejfUfRYNo
         IaSR9x23YA90aPRz0UHuZq66ogf8DSBPXiGQc+glwnrkBuhrT8YYcIg6StFmru8QCPGF
         v/RZomdP5pHItvldVLh7t4mzvuNzcf62cOEVPW3H76dCOn9EZC0HF5ossApq0DfM4ygk
         nJFw==
X-Gm-Message-State: ACrzQf0oZFHI/D4tjXvk6XRpVHy12AkPCnLSa2KTb1EocLIElLOkLtc7
        8ypWzDiViGbYgqRMGsmvhI4BfbkKAIjHGetF
X-Google-Smtp-Source: AMsMyM65FhrRbZVwPQUbO/4JYXyP2Tgzn0JV5SKlqogiPJkXDBdfepTxWjFpRaEDF1ntj5hncxa4iQ==
X-Received: by 2002:a17:903:22c9:b0:178:18a1:d170 with SMTP id y9-20020a17090322c900b0017818a1d170mr3238346plg.2.1663739435574;
        Tue, 20 Sep 2022 22:50:35 -0700 (PDT)
Received: from localhost ([36.112.86.8])
        by smtp.gmail.com with ESMTPSA id u16-20020a632350000000b004277f43b736sm925172pgm.92.2022.09.20.22.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 22:50:35 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        Hawkins Jiawei <yin31149@gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
Date:   Wed, 21 Sep 2022 13:50:26 +0800
Message-Id: <20220921055026.380196-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919175700.1649726-1-luiz.dentz@gmail.com>
References: <20220919175700.1649726-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> device_add shall not be called multiple times as stated in its
> documentation:
> 
>  'Do not call this routine or device_register() more than once for
>  any device structure'
> 
> Syzkaller reports a bug as follows [1]:
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:33!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> [...]
> Call Trace:
>  <TASK>
>  __list_add include/linux/list.h:69 [inline]
>  list_add_tail include/linux/list.h:102 [inline]
>  kobj_kset_join lib/kobject.c:164 [inline]
>  kobject_add_internal+0x18f/0x8f0 lib/kobject.c:214
>  kobject_add_varg lib/kobject.c:358 [inline]
>  kobject_add+0x150/0x1c0 lib/kobject.c:410
>  device_add+0x368/0x1e90 drivers/base/core.c:3452
>  hci_conn_add_sysfs+0x9b/0x1b0 net/bluetooth/hci_sysfs.c:53
>  hci_le_cis_estabilished_evt+0x57c/0xae0 net/bluetooth/hci_event.c:6799
>  hci_le_meta_evt+0x2b8/0x510 net/bluetooth/hci_event.c:7110
>  hci_event_func net/bluetooth/hci_event.c:7440 [inline]
>  hci_event_packet+0x63d/0xfd0 net/bluetooth/hci_event.c:7495
>  hci_rx_work+0xae7/0x1230 net/bluetooth/hci_core.c:4007
>  process_one_work+0x991/0x1610 kernel/workqueue.c:2289
>  worker_thread+0x665/0x1080 kernel/workqueue.c:2436
>  kthread+0x2e4/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>  </TASK>
> 
> Link: https://syzkaller.appspot.com/bug?id=da3246e2d33afdb92d66bc166a0934c5b146404a
I tried the reproducer from syzkaller, and it didn't trigger any issues.
And I also tryied multiple HCI_LE_CIS_Estabilished events, still normal.

Test-by: Hawkins Jiawei <yin31149@gmail.com>

> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 4e3e0451b08c..08542dfc2dc5 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -48,6 +48,9 @@ void hci_conn_add_sysfs(struct hci_conn *conn)
>  
>  	BT_DBG("conn %p", conn);
>  
> +	if (device_is_registered(&conn->dev))
> +		return;
> +
>  	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
>  
>  	if (device_add(&conn->dev) < 0) {
> -- 
> 2.37.3
