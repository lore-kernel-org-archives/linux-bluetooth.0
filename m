Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7112DC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Feb 2023 07:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBFHBn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 02:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBFHBl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 02:01:41 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6813A98
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Feb 2023 23:01:39 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id g8so11788912qtq.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Feb 2023 23:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EiykGfbqsZcdiNqhcpYOBVhB5SrnOZOXlE2t02AGtQ4=;
        b=ehuv05sVOwDYs9FQ2pEgLbSrxYuDiATSmFYPpJryEAO1aoTAFoCvlw9PSTZMRURpjl
         HqahEDXkFuTOuD6kiGuwrgC5F+ztpAbC0V547rXuQpfb66+O/sBFO6Fpzco9CC/2mJto
         fpi+xrDp0NqUp5zBP+GmbmhjaAVR5Bwm4+LC217NoSig1ksPMXZ16Bjj3Z9Iix9GyrW+
         K5SXzwazKclxSlu19kr+kMVNZ7teLKqxYFFIZKTu/Hp249+qJf7ARY2kvo4PtBqaEYEp
         wYKWqHiHeP9+5JlTP50HU8xvqxeGKj3xURlhjfIa6cvxfAtfZfP2D0s4ZCh/py7iv+vT
         6WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EiykGfbqsZcdiNqhcpYOBVhB5SrnOZOXlE2t02AGtQ4=;
        b=7dWD+t+YEutawKcItpgeOjJo3gvZxSSU7NHqkc4z/oh5dq/4jdSel2Za5+3kcbkLBd
         /Ms3k6o/IPAokz/6UWvKBy//5JryHB5TOR+apBIcm/G6oQemPoCyWkJrhq8a9kd/FhiX
         bPZGuY3ZA3RpdFIsYlxjnZ6vYuriEUpxib7TP5K3tB8fzMXDpLkxpjOv+i1/oAyqixGK
         8iQpTxHrDVCKSjr36d0UA9wNHHRKmLLkJQQskgY7CChZMz6qTL8PNBNo4YGSxvIibmRi
         lb7gSLslbmVwVt2UZp9mtjqHmcW2yg5Naa9JSwRtpQvJxn3c3n8qenbyo+yLpWO7/aQo
         sC3w==
X-Gm-Message-State: AO0yUKWfuLu73WQl3QbUlKVs/WHBNDgcg65WeH28zQ5roSvL2jB36C5L
        E4NMzS3EH1/LL4uJxL9s6Zxb1helr/qSVA==
X-Google-Smtp-Source: AK7set91nXHeSRY+4MNWzRktNW2fvyQAuv+e7/NBC/BjI8Lx958qdwTXGhQpjKHfvPEeXNqqjgkYew==
X-Received: by 2002:ac8:5c94:0:b0:3b8:6a3b:3bfc with SMTP id r20-20020ac85c94000000b003b86a3b3bfcmr36369225qta.24.1675666898928;
        Sun, 05 Feb 2023 23:01:38 -0800 (PST)
Received: from [172.17.0.2] ([172.177.120.49])
        by smtp.gmail.com with ESMTPSA id c30-20020a05620a201e00b006e07228ed53sm6912896qka.18.2023.02.05.23.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 23:01:38 -0800 (PST)
Message-ID: <63e0a5d2.050a0220.5b2b0.2e56@mx.google.com>
Date:   Sun, 05 Feb 2023 23:01:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3385881822278317432=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, victor@allwinnertech.com
Subject: RE: [RESEND] Bluetooth: btrtl: Add support for RTL8852BS
In-Reply-To: <20230206063334.45861-1-victor@allwinnertech.com>
References: <20230206063334.45861-1-victor@allwinnertech.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3385881822278317432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=719009

---Test result---

Test Summary:
CheckPatch                    PASS      0.98 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      31.72 seconds
CheckAllWarning               PASS      34.55 seconds
CheckSparse                   WARNING   38.58 seconds
CheckSmatch                   WARNING   107.40 seconds
BuildKernel32                 PASS      30.13 seconds
TestRunnerSetup               PASS      434.48 seconds
TestRunner_l2cap-tester       PASS      16.45 seconds
TestRunner_iso-tester         PASS      16.78 seconds
TestRunner_bnep-tester        PASS      5.42 seconds
TestRunner_mgmt-tester        PASS      109.76 seconds
TestRunner_rfcomm-tester      PASS      8.72 seconds
TestRunner_sco-tester         PASS      8.08 seconds
TestRunner_ioctl-tester       PASS      9.43 seconds
TestRunner_mesh-tester        PASS      6.93 seconds
TestRunner_smp-tester         PASS      7.90 seconds
TestRunner_userchan-tester    PASS      5.72 seconds
IncrementalBuild              PASS      28.52 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3385881822278317432==--
