Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DC0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Mar 2022 22:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiC1WQK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiC1WPo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Mar 2022 18:15:44 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2BF26E005
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 15:06:50 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v15so12653511qkg.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YKi/xHflXTOaAd4VxjWQ3DXoSWlo5DrzWtxfHO+yRBU=;
        b=JWFVbkaDFP5HP5V257TQ5QN1bInVcnPfhWOngCQj7FzneYlEauqBaaCfpevsV0LITp
         r5hvK/5W9lkLN//bpsvbt0g4MVBzUBdhiCoKftcn7Hpy3ZK1ZzgGk7n5V7wfVlLQ/taE
         QCzykR+IEffO3JHooyHt8+6XExGcEdxYcgJr4PpU+QvAbl/vUv0oecHl1b7oZQ+la8Zh
         4LQLvxfUhLIX7D3VzCUYnv8uwbEmsJLgylUGCDwlp1FRs9+bjTyZKF5ENGxIvzi6DAqK
         KOdWFE8ImnueZ67qIxpKYfm0ZSUMoSuCJbC0QaMCcdQcDBmCHOpaMRHGUyyi4yF1rCc+
         YGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YKi/xHflXTOaAd4VxjWQ3DXoSWlo5DrzWtxfHO+yRBU=;
        b=IUHYFZ808USG6ckCQCwt/bW0Lf41TAB9Lor590mIoS2eH2fpCw98h4Hss/J8dNfH2+
         /o8GBDt4lolXkH6cv8j1IY8E2u5ySKsCBC6B0sA84eALPt5zO9JzMfMn1iU4E6Wf4Uh5
         IqRleR+aVHKwXWmimB/n1GUzCYfi0fP/vXD13ZHRj8/DGaKxyY3kR/gz5ar1oKD21hBY
         pUPFVnTdJuNdrI3/B+ecv/hHW5Wraof+RrVH9HxieEwCgPbWyoehVYxcdLb5rdBXl22O
         1kCV3wInsUZgGVV7CXUjV84Cd1rYlbT4f0oPI+FylyuEg/K/C0axu4zjYqoM4PsaO0Dy
         Dxgw==
X-Gm-Message-State: AOAM531ZOqTGum7s/NlbB/jdfqbmQfhVDYAm3nE+8nl+hPTgrvqvHHTt
        atzu+4yalCKt53+9FzJ38+YvlObmnbWFEg==
X-Google-Smtp-Source: ABdhPJyU7lRSpJZ9UdpKrrif6tsToZDZACD7cnE0rRNSKm1w0rPt/DsZIsUZAGFPmKGExLJ/TZihxw==
X-Received: by 2002:a05:620a:1a89:b0:649:33c4:bd5f with SMTP id bl9-20020a05620a1a8900b0064933c4bd5fmr18081613qkb.687.1648505209182;
        Mon, 28 Mar 2022 15:06:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.124.223.243])
        by smtp.gmail.com with ESMTPSA id r21-20020a37a815000000b0067d15afb9ebsm9025258qke.90.2022.03.28.15.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 15:06:48 -0700 (PDT)
Message-ID: <62423178.1c69fb81.a64a3.eb18@mx.google.com>
Date:   Mon, 28 Mar 2022 15:06:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3033670169067889020=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] a2dp: Fix crash when SEP codec has not been initialized
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220328203621.1853081-1-luiz.dentz@gmail.com>
References: <20220328203621.1853081-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3033670169067889020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=626995

---Test result---

Test Summary:
CheckPatch                    PASS      1.52 seconds
GitLint                       PASS      0.97 seconds
Prep - Setup ELL              PASS      57.14 seconds
Build - Prep                  PASS      0.91 seconds
Build - Configure             PASS      11.52 seconds
Build - Make                  PASS      1949.57 seconds
Make Check                    PASS      12.99 seconds
Make Check w/Valgrind         PASS      592.63 seconds
Make Distcheck                PASS      313.99 seconds
Build w/ext ELL - Configure   PASS      12.12 seconds
Build w/ext ELL - Make        PASS      1927.87 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============3033670169067889020==--
