Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B19C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 01:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiCABga (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 20:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiCABg3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 20:36:29 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EDE3D4A1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 17:35:50 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id e2so8749848qte.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 17:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pB7CdC/OIDZLgQ1e76Cf8tXIEKwZEobwDZews/IjHNo=;
        b=d3psqEx0sTd3El7FfPpJfnf6VTsvj1bwY149ChmlYK3JTLZ970ngfsjhbZK2sYijFp
         z2kw5/ISPrB1rt1ZgHg2Bs+IVX8eexVegRZIRkuaDaAzrrQZ3gty82RKR9X8MhIeVKCA
         AvMulG4HwgbMEfHuM8HLaIn0myaMB+jrHdPIdpslhPqzT4fx5Ib5IQu4dPOLZekdkPEH
         BlOEwonFg3BdJoJxBgwkANMn7WZqK6GrZqqTG56IBzuwTV9rv70opD/hAQZl+GV6f2Qr
         iSKtucfeXFfP8EhGwm3fqAgDjlQwZHy6iSdIbsywEj4IXFNWKIDzYe+cPaR/h0zQS/FT
         bBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pB7CdC/OIDZLgQ1e76Cf8tXIEKwZEobwDZews/IjHNo=;
        b=o0MvnFkBehndUxLEPmwmaYJ0BWNM6A9OqbsGVdK/oB6/MsJH++atvioigf0eOxLk/A
         bpchTME4PxvVeyIR+XeCjyZ6I4xGdyIAcxvICfdsMVgPpg7TjXmQ0KSHW1VzE+YXOf/J
         fP2F67QrSNNnr31mYEk74Q88Dm255fl33kNTaB7CSikxNerfiQOVzy/KWq+IalcS2n9q
         KC5HHTDquOzCYxmbID65qY8MXwrTygEdrf82SimgIaoVip60VfwnYwsvkxBTL1SoHVId
         aO3jFG+kfwlqBvj4TEATFsCCj3CyLFV1/zn10FUxhYWrFM39m3PwyeS5kKqe1ITyboQY
         H8Uw==
X-Gm-Message-State: AOAM530zetIIDzjNzlsozfM5Zk1qBrUPYi41vSg28AWqgEisckcrd+UH
        PS6VSsX/IVnCxRMr209yFumn1Hm277h84g==
X-Google-Smtp-Source: ABdhPJxrlQnZyebN1n4v3e04KtDTC+Oxw1Nr5ktqOZ1dcrRDmh1u3ap36zkrvBCUMVfC9qn5zlfjHg==
X-Received: by 2002:a05:622a:198c:b0:2de:707:b1d9 with SMTP id u12-20020a05622a198c00b002de0707b1d9mr18274025qtc.233.1646098549145;
        Mon, 28 Feb 2022 17:35:49 -0800 (PST)
Received: from [172.17.0.2] ([52.191.10.113])
        by smtp.gmail.com with ESMTPSA id f7-20020a05622a104700b002d4b318692esm8022639qte.31.2022.02.28.17.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 17:35:48 -0800 (PST)
Message-ID: <621d7874.1c69fb81.407e5.af3c@mx.google.com>
Date:   Mon, 28 Feb 2022 17:35:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4944983197840532679=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/shell: Introduce bt_shell_exec
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220301000022.1628080-1-luiz.dentz@gmail.com>
References: <20220301000022.1628080-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4944983197840532679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=618923

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       PASS      1.04 seconds
Prep - Setup ELL              PASS      56.16 seconds
Build - Prep                  PASS      0.99 seconds
Build - Configure             PASS      11.32 seconds
Build - Make                  PASS      1937.78 seconds
Make Check                    PASS      13.71 seconds
Make Check w/Valgrind         PASS      582.70 seconds
Make Distcheck                PASS      309.17 seconds
Build w/ext ELL - Configure   PASS      11.54 seconds
Build w/ext ELL - Make        PASS      1907.17 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4944983197840532679==--
