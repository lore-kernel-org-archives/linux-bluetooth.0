Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CFAC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 19:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiI2TuF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiI2TuE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 15:50:04 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102716B8CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:50:02 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l5so2672762oif.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=TlBfF31DQ7jkpdRopDSpyYFCycbslVs1wRektXTodtc=;
        b=c8N7PCJsoVVmrZCIjq1leCCX0xGDWjSF1dLFEO6sXQ//pQlzvn0ZB0qJ/e0VKkVajN
         DEAbjeDT5E6haOcVgtIOxGbmhayYR2iD51PnUwr+uT5xt08k9LUhTORTYc0yxQT2Hn5r
         yN6CM4S2VU037yv1mCPtL6xeAonjd1OUYtDXYl5BKEFP2IOYlKzAY0hOmJYZY4QkUL1r
         ybjtZvIqypO2ys+/aOyRjNPOmdqWdXevggW/BV+PKPe3fShznA4CMiPBp7uLtH/ZM/ab
         JCFYt2KPo+OVe3hnJHBR1VS5v6Ei8rtRREHMnX0Gvp60pVFevh9wWfg9CLR0yrzeHOo5
         +HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=TlBfF31DQ7jkpdRopDSpyYFCycbslVs1wRektXTodtc=;
        b=rbSvNlxjy9HEUKvTXBQdyBeChNNzL+q/+bdaBSVx2xD0uIrdgrj3PsonycZuSSFxse
         zoPMGG8lvs0UbQxJODl52bUCZn+5svbdBxjzcxXvsbcAjJmLR+oMfS9ogHuNTEJPFtZy
         YA2efe3WmX+pjUM0hDD05JwtaqRU/4HacUME0cOY78WPtc/4Bz/fWanTVc7dMTA405Td
         Q/aGfsusYHGfX0SYBF5epcCvC0hgDtFUXb/cn8lmGrsxrFBIjTciBFQ1GG5JPw2cLdif
         DWU9DxZVoqze98dPqDsOfSdf3gPYp6N6fSJAJ/2ltja1FLG1lUCMF2KZtu4gRVhAC6LT
         GIqg==
X-Gm-Message-State: ACrzQf0kwGWgQt7coWVPGjdGBL8+b1sqfoBapnopgKWNSBNdg/AJ6uUH
        +mES23Hw7wFJyXgtJHdB/LnYi57Wfuuppg==
X-Google-Smtp-Source: AMsMyM776DtpIREBwncuD/14/NXzwtEXhrLfnHjihJe3yisFUu1FoCQ89gUwDMI4zTvy858pP1pZkQ==
X-Received: by 2002:a05:6808:1188:b0:34b:90d1:766 with SMTP id j8-20020a056808118800b0034b90d10766mr2347199oil.167.1664481001142;
        Thu, 29 Sep 2022 12:50:01 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.235.34])
        by smtp.gmail.com with ESMTPSA id x93-20020a9d20e6000000b00657865c9827sm135060ota.46.2022.09.29.12.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:50:00 -0700 (PDT)
Message-ID: <6335f6e8.9d0a0220.1dce5.0b32@mx.google.com>
Date:   Thu, 29 Sep 2022 12:50:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5230726936584560146=="
MIME-Version: 1.0
Subject: RE: [v4,03/18] Bluetooth: RFCOMM: remove define-only RFCOMM_TTY_MAGIC ex-magic-number
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nabijaczleweli@nabijaczleweli.xyz
In-Reply-To: <f6d375201dfd99416ea03b49b3dd40af56c1537e.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
References: <f6d375201dfd99416ea03b49b3dd40af56c1537e.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5230726936584560146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: Documentation/process/magic-number.rst:78
error: Documentation/process/magic-number.rst: patch does not apply
error: patch failed: Documentation/translations/it_IT/process/magic-number.rst:84
error: Documentation/translations/it_IT/process/magic-number.rst: patch does not apply
error: patch failed: Documentation/translations/zh_CN/process/magic-number.rst:67
error: Documentation/translations/zh_CN/process/magic-number.rst: patch does not apply
error: patch failed: Documentation/translations/zh_TW/process/magic-number.rst:70
error: Documentation/translations/zh_TW/process/magic-number.rst: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5230726936584560146==--
