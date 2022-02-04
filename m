Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FA8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 21:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbiBDVkj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiBDVkj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Feb 2022 16:40:39 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A62C061714
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Feb 2022 13:40:38 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id o25so5848201qkj.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Feb 2022 13:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=k23ajSHoKu7u8xnCwwBUOPNsoiEFIFJTGMTYXpZIZbU=;
        b=WlU1RG39Tzj/3XDS/FaupH/JZpftlZZ8RkhAb6NK9ctRF2DFJUMR6F7gz2oPBuQUdQ
         jy/dBQRAVbXvKwJFFzUQTRmctLPb9ZE008r20ZH9FvHIjtJx6sTBT/Wro10w02A/qyKP
         4wvstU07eEtLUf0tLSanGEoepFn5LEOMwIvOZemjZVO0iJMOkA/6sZ0jFJlM1n1xZ5oI
         wt7GvHI3sE2ku4RCDWT3nGw6oWRQCXrFcc2RyLN4t0Zwc9THv+pS9rKLzn0sQFRjtH+K
         nyjJkVaOoLVGofsUBtyPGwuj5WAoq8FPhO+kuqAUsEx/qy5hEmL1d+sAupsprc4fQceU
         k+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=k23ajSHoKu7u8xnCwwBUOPNsoiEFIFJTGMTYXpZIZbU=;
        b=FRt0PrDRltu6bFah8Y1xoITtW6fV3KdXkvmYC/QsmKhJJ3Kq2ox0oMKb/dU891vFJI
         B2hoWEpTL0CI2q4EOtfBhu3vP1FyZrn8FXfJUOqxQEMJTpk3uFxoaIB4ItywELjkG4vD
         00lST4D7T/CQ53ZRuz2DanTjm7shxEu6WvDG+1t0ukakOTHbkdUtg+BXUGV7zfBq/8v7
         FetloshVmA4xyTQkIN9czwdH6qKRd63CvJopC0L542pBF0PKv4Ig7aI9O2dInfMI9b2B
         L6ehvOFOq8hyHZLbGesAPCT4nWOX1K8KBTM1vaN/eYCKwTDO/Jk1dwVddG5yM6RAfnYx
         YxjA==
X-Gm-Message-State: AOAM530DGF9GWTvuJOw0wQKRVFJcYR1dT9d/lBnRYJBH6j179v8P4Phk
        dR0bqSnOSGVSF/MYLRvln1qNcMOv/nY=
X-Google-Smtp-Source: ABdhPJzaAZDVsRQfiYi6+tjbgTirGo1UZElz9hKgxx6ljwZcUT0Q68Muc3Q/p4FiERIljLpD5uBkpg==
X-Received: by 2002:a05:620a:24c:: with SMTP id q12mr650837qkn.81.1644010837470;
        Fri, 04 Feb 2022 13:40:37 -0800 (PST)
Received: from [172.17.0.2] ([52.179.155.82])
        by smtp.gmail.com with ESMTPSA id s4sm1694868qko.113.2022.02.04.13.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:40:37 -0800 (PST)
Message-ID: <61fd9d55.1c69fb81.ca2fa.a14c@mx.google.com>
Date:   Fri, 04 Feb 2022 13:40:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4628127548994293092=="
MIME-Version: 1.0
Subject: RE: [RFC] Bluetooth: hci_core: Introduce hci_recv_event_data
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
In-Reply-To: <20220204211236.2690926-2-luiz.dentz@gmail.com>
References: <20220204211236.2690926-2-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4628127548994293092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/hci_core.c:2740
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4628127548994293092==--
