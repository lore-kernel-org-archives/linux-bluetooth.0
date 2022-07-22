Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D3DC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 11:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiGVLMC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 07:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGVLMB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 07:12:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4E0225
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 04:12:00 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v21so4336694plo.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 04:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Eh7xF3HUT2oHPqZeFKDHYls2enfYgvruOhEb7bLhlKI=;
        b=mxDD6EXNbEZjsh1n2rAWUX1icuK3seU6zAYHnDf5ixr5xhNIKJCShklUNXr/QA4aDo
         nM0uarIwVYySVtd8ssb+lkmAVnDMXOoHcL+Cbv5+6bG9iQ/xewaYUS9MrYYcJwbycVSK
         /NhvzTMqqTcwaGZXBrSxSF5f9IpZwNpSL2+9jHdZiDH8ZsEKuOtOaCe4Z+hoq/3P4j+s
         lC6dwoaviWwwf0IF8VyEG4eUjwoNtv28BZ6TxlNS2Yq008z1F4iIjVVdNO3XDHKhZVu5
         rMgk/4lkllnvyZWpM8DtaoBeNNMwRWfcV10F/TN9arQ/eiJH5RyzBneV1QfFh/l+wWg4
         Xs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Eh7xF3HUT2oHPqZeFKDHYls2enfYgvruOhEb7bLhlKI=;
        b=FPBQRcok4WPEiv9h73zzYtLpgnH+YAzw6NOwbyEjxqFzKWFQWvXn6UxS5Rzy/XpHT5
         gN1n33wVocbiyPBf8kzesdyqmPkmVcWvpsKtD33Ge7wgrCtOoT2MxwiKlI7RF7Ywj2Gj
         vf8oIWlChmaeWYFBt5zrWPw7jTAQjOPQGu6iuxKV4U/DFjg9lLFGyopUVL4wjUs0lANL
         T1soBenmjtZCe8CWD+VObqfiJhTT67rUN9RIwYM+xa0E5XFuhi9/ifZYE4XhVOCw/8++
         jD62EcDQHEdEpywb4DpXlrzJSPsPSyKuB6x7gXwNnprplpBQ+4mPcBt6iLqaPjF5Cq80
         w/pA==
X-Gm-Message-State: AJIora8AjgMcABu6HiP8QqDi4dwHwvNtZul9kZJPk6u9uS0gHWw/ze7+
        rlQz/OCkccRV62ChMiFwNL77lE8Kzro=
X-Google-Smtp-Source: AGRyM1vS2/TQwX4lU991BK85/L6enZg/IMUvhj3CJ29/TAOCpuknANCXeVGhjwe3eZzyg0pPxq9/gw==
X-Received: by 2002:a17:902:8543:b0:16b:fbd1:9f68 with SMTP id d3-20020a170902854300b0016bfbd19f68mr2940022plo.101.1658488319463;
        Fri, 22 Jul 2022 04:11:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.55.245])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902b94500b001635b86a790sm3435568pls.44.2022.07.22.04.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 04:11:58 -0700 (PDT)
Message-ID: <62da85fe.1c69fb81.25beb.5849@mx.google.com>
Date:   Fri, 22 Jul 2022 04:11:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7139282237510892608=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Bluetooth: hci_sync: Use safe loop when adding accept list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220722182248.1.I20e96c839200bb75cd6af80384f16c8c01498f57@changeid>
References: <20220722182248.1.I20e96c839200bb75cd6af80384f16c8c01498f57@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7139282237510892608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662196

---Test result---

Test Summary:
CheckPatch                    PASS      1.40 seconds
GitLint                       PASS      0.53 seconds
SubjectPrefix                 PASS      0.32 seconds
BuildKernel                   PASS      42.52 seconds
BuildKernel32                 PASS      37.05 seconds
Incremental Build with patchesPASS      59.45 seconds
TestRunner: Setup             PASS      641.48 seconds
TestRunner: l2cap-tester      PASS      20.19 seconds
TestRunner: bnep-tester       PASS      6.83 seconds
TestRunner: mgmt-tester       PASS      113.16 seconds
TestRunner: rfcomm-tester     PASS      10.66 seconds
TestRunner: sco-tester        PASS      10.45 seconds
TestRunner: smp-tester        PASS      10.45 seconds
TestRunner: userchan-tester   PASS      7.07 seconds



---
Regards,
Linux Bluetooth


--===============7139282237510892608==--
