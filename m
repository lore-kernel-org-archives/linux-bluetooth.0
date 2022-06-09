Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AFCC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jun 2022 09:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbiFIJLi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jun 2022 05:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiFIJLf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jun 2022 05:11:35 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987501706B
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 02:11:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 15so20576176pfy.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jun 2022 02:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RrZeng+LszYKUwErlcfezo997Bwj8hvRAFcvywdwLh8=;
        b=G07STlTSxX72GJiQ1cPoW7YEWXhufRmM7AbJDiwwZXRLtiDYOb9zPB1LBL882cNu4Q
         NM00EsaVd7RAVYdYsgrQJzbdrRLNlYZuEwmogQe+vfgZoMd1jBdxS/MxXaa0XxEmM7Pw
         tgaXEx07POww1rx6Dnp/CiLLV4gajb9bfwXXPEsoj0PDcNFRhCYFbpDx03JULi2qt7ZM
         6mGwyyJwHvdKu1OzwxaMZjdzGP4NSt47a4Zfkj4Pu/d7dWP/H6hOhwrMbcLlbScV/gGS
         xeSFB+YwVFawkf2p/9c4JADg+yBK+RbxbVlMqF3OOENqkYajyH62zAP4GFUa8DizFJ+z
         fFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RrZeng+LszYKUwErlcfezo997Bwj8hvRAFcvywdwLh8=;
        b=xoOyxna2f0m7XZU7t7dW/M3Q7iND/itx/6Rg7hS7pO7nIu8TVFwXd1kTbMTzyWuZ+6
         nk1KhRD6YOMM97glhFmoBuf/hTvI2ZlVNCHm0FSpd5DyE8+F4qyhYiXBEITqPJqRIaVe
         4DPUUkkHoNNzhr3OQDSu0GIkiOqnIYsZpGZUWUCz8/fCgL5pxs/B316f168O7lvaX9WG
         ZgqMPgwDrufqNnAiq/xoQd1VSBu+avqdqkZ61VwSxwsNqZHO8M9IFkoc28gPznIzcXKe
         j5Pnk1KArtHrvoQcmkz2x8lfKs56XpALWVaUOrDXY/5lCQfkQ0q6Ru1/CdOoOtfoITLT
         KKvg==
X-Gm-Message-State: AOAM530pqdFX+2GPnxga2uFMpotZJQSRZ/el74/ll/hxELtJsmezKtZT
        Dtd5tEYcBuU1NfKkBDFnjwR/vCaQrr8=
X-Google-Smtp-Source: ABdhPJxXuS0BJA1B5MxFpi1Z2UdrLNiEPePbyPjVQl184SJ6l3/yAP3H0fAgQ7QT+HfZpaIb+yUCyg==
X-Received: by 2002:a63:b51:0:b0:3fc:cd1d:884 with SMTP id a17-20020a630b51000000b003fccd1d0884mr33670730pgl.98.1654765893895;
        Thu, 09 Jun 2022 02:11:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.131.19])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79911000000b0050dc7628179sm16836258pff.83.2022.06.09.02.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:11:33 -0700 (PDT)
Message-ID: <62a1b945.1c69fb81.9ab4d.2041@mx.google.com>
Date:   Thu, 09 Jun 2022 02:11:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3728682709809356201=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix setup CVSD SCO failure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1654762252-19603-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1654762252-19603-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3728682709809356201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=648738

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
GitLint                       PASS      0.53 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      31.51 seconds
BuildKernel32                 PASS      28.05 seconds
Incremental Build with patchesPASS      38.59 seconds
TestRunner: Setup             PASS      471.67 seconds
TestRunner: l2cap-tester      PASS      17.03 seconds
TestRunner: bnep-tester       PASS      5.80 seconds
TestRunner: mgmt-tester       PASS      98.08 seconds
TestRunner: rfcomm-tester     PASS      9.28 seconds
TestRunner: sco-tester        PASS      9.06 seconds
TestRunner: smp-tester        PASS      9.11 seconds
TestRunner: userchan-tester   PASS      5.97 seconds



---
Regards,
Linux Bluetooth


--===============3728682709809356201==--
