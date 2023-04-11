Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E47C77B6F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Apr 2023 12:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjDKMlS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Apr 2023 08:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjDKMlR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Apr 2023 08:41:17 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC0792
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Apr 2023 05:41:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id bn8so6841101qtb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Apr 2023 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681216876; x=1683808876;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xt9IeNFuWuW9xJgklTxxIu1zVaZR6gAsLTHH4XCFwVw=;
        b=ZV01Wv0zk1Ga7MqUCYkT6BbioLnNfxiu95yOkRDnpUpmpbrsRySecasQcizWBeqz2j
         lCsQRsQoDmKDH9CPjn+V9fDQqeyAzvTB7v7M8LiowZHkBV1Lujs1AvjatnaqdvV4Cqmm
         lwab9R4QoWIn476rTHu2yJMbfnCGiBLIJvrgmndRs8jdNY0oCojDCzC094OlUFOiUwq7
         K/AJ3gB7tc6W0d839FZj68TycyyjAmsMWUm60nWOEedOgr5qJ7o6R4MaK8LeG1DitLI8
         gsnN8F1mw1dHID9pYzT7SIiTn8q0tJjIDVRdWlIzZkplKmzkF1ojyH3E31g4Acmv/OGm
         Y88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681216876; x=1683808876;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xt9IeNFuWuW9xJgklTxxIu1zVaZR6gAsLTHH4XCFwVw=;
        b=6savaV7oeIiBNEYJ2hmF2HXpdHRF7JWAJ9lW3HQ8iMBfxgaqZCL9dXmBUF+VzYlho/
         6NwlBG1T+3dG4K1wwzwguLLFVc36AKhuO4Lu434bMvRlDx/pCq1VzxkXBZdR62d/7gDw
         pqNE2OCGMTwN4E4yCkkkOQ+s+xx/iOgmT6en/OHCZ8E2p7BbjSYvA9S3l7yt0TK1j3C2
         UVwz2gluJ8SzAhtf+VR/3cQYh7Lb9U3RFH1gyoBdg0ajPTbZZjtZfyVPMsez4cpiwxQf
         8I0knn9qHlOn0Pn5KjIY2nYBay+j1nZhe119it1Lj/40XVDOAq3Oxw3b5IlrJiB0YIqx
         UeJQ==
X-Gm-Message-State: AAQBX9cWjBT2DRECKO4W8IaD/60KRXB4gEhAae9LFKnH4hYo6pA9Qc+G
        qzJs205b2C05WOLj/BW88uNJ/X4ZHCE=
X-Google-Smtp-Source: AKy350a7hHxYy5SnTHftCRVylTVmaRbKuVkdttALaYx4pVioYv4Tz5udtzHbMliqCGTd8xqdclhtng==
X-Received: by 2002:a05:622a:189e:b0:3e6:7634:3d0a with SMTP id v30-20020a05622a189e00b003e676343d0amr24134879qtc.1.1681216876028;
        Tue, 11 Apr 2023 05:41:16 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.6.21])
        by smtp.gmail.com with ESMTPSA id a13-20020ac8720d000000b003e4e1dbdcc3sm3574835qtp.47.2023.04.11.05.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 05:41:15 -0700 (PDT)
Message-ID: <6435556b.c80a0220.289d6.ceea@mx.google.com>
Date:   Tue, 11 Apr 2023 05:41:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6064114093026913987=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: Optimize devcoredump API hci_devcd_init()
In-Reply-To: <1681213778-31754-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1681213778-31754-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6064114093026913987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=738746

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      32.61 seconds
CheckAllWarning               PASS      35.87 seconds
CheckSparse                   PASS      40.72 seconds
CheckSmatch                   PASS      111.13 seconds
BuildKernel32                 PASS      31.55 seconds
TestRunnerSetup               PASS      448.09 seconds
TestRunner_l2cap-tester       PASS      16.55 seconds
TestRunner_iso-tester         PASS      16.25 seconds
TestRunner_bnep-tester        PASS      5.26 seconds
TestRunner_mgmt-tester        PASS      111.33 seconds
TestRunner_rfcomm-tester      PASS      8.35 seconds
TestRunner_sco-tester         PASS      7.69 seconds
TestRunner_ioctl-tester       PASS      8.95 seconds
TestRunner_mesh-tester        PASS      6.70 seconds
TestRunner_smp-tester         PASS      7.61 seconds
TestRunner_userchan-tester    PASS      5.46 seconds
IncrementalBuild              PASS      28.56 seconds



---
Regards,
Linux Bluetooth


--===============6064114093026913987==--
