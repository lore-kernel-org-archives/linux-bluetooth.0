Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AF7C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Mar 2023 02:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCFCqB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Mar 2023 21:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCFCqA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Mar 2023 21:46:00 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F07F97C
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Mar 2023 18:45:58 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id t22so5992593oiw.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Mar 2023 18:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678070758;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qoug8xhTr1eqlQI4wZqyF3AbqMXAgSDNlJHNSNo85qA=;
        b=GZ+4LzsoLXbLuH0Yog77KhKPCrJQ5rmXuRyL+ZWP2JvX22AjzmGNLR2DKQM+YodA73
         I53otTiCaxnHWrnVxpDgh43/OyXUOHMc0BaUqeMr7vNvxZLnoeFNSIYzZvgYklRpHu+T
         NitlP+8CAHbeH21gLawtIgDaN0/kjKLVRx9w837UpDfO8PgGeHFibFfof+qvrd3bcBcG
         KFLRLY8bQm4xf1bxRJodDwbHYvwNFJsIKYx5HGQrwI/FAUIJE9Su8I25xH/whaEF5WSR
         xZfHWZZ22G/6Zdh1vDm+XuPFG97UTJpOeYk0ssTt3PI2iA1hu0oBVG+GiDafyziAvj6o
         77JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678070758;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qoug8xhTr1eqlQI4wZqyF3AbqMXAgSDNlJHNSNo85qA=;
        b=4xmvQUQp7o9Cn/BzK6z7PR8bSZZ6xfodDpNwsYYKlLQh5qd8xnq0La511+vbIexf/N
         2eJ0yq2F6nFuTvnGTB3fvuFjv2nJlP+a7cBRAnvEaG5i5zWlQv83vc8mNBTEz12Uu2jZ
         00qgIiMyN5uWMoMYLRkLAExHJnv+pzNLnbYIo64q5dcL621MikVmoFy+zmO6yqr254wp
         8+2cu2QDp5x1SIPiJWpDN8RlqYtt6uI8ilXDk4pTAeSw0YcGXewfTQGxO0DpI+7/c9GT
         /eo1WMASM3YLjsI+cVEcK0TP9ktDK4AQsRaVSZaD2A/NKu75+FhRPqxFeIm1mkj5TA9h
         8nKA==
X-Gm-Message-State: AO0yUKXTTac8UvYHhj9OZ6JNrLZqTtgznJo1Q4EHeghKdZWPMKMQ7aPH
        Mf+vx9+kMa5+Qg8ZX7UBNqZgr9PFTuA=
X-Google-Smtp-Source: AK7set/46dTqunoVlW10vKGnTeMXwCot+yuTtkhhYrueJ8/t2/muHs0OqWoa5B4yaFbkIclyoyhQ5w==
X-Received: by 2002:a54:468e:0:b0:37b:9e0:dca1 with SMTP id k14-20020a54468e000000b0037b09e0dca1mr3841947oic.23.1678070757963;
        Sun, 05 Mar 2023 18:45:57 -0800 (PST)
Received: from [172.17.0.2] ([40.84.170.17])
        by smtp.gmail.com with ESMTPSA id q204-20020acac0d5000000b0037d74967ef6sm3519204oif.44.2023.03.05.18.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 18:45:57 -0800 (PST)
Message-ID: <640553e5.ca0a0220.d62b5.eb21@mx.google.com>
Date:   Sun, 05 Mar 2023 18:45:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5761748589694807195=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tangmeng@uniontech.com
Subject: RE: Bluetooth: Add VID/PID 0489/e0e4 for MediaTek MT7922
In-Reply-To: <20230306014459.25023-1-tangmeng@uniontech.com>
References: <20230306014459.25023-1-tangmeng@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5761748589694807195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=726728

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.92 seconds
CheckAllWarning               PASS      36.56 seconds
CheckSparse                   PASS      41.33 seconds
CheckSmatch                   PASS      109.61 seconds
BuildKernel32                 PASS      32.04 seconds
TestRunnerSetup               PASS      456.59 seconds
TestRunner_l2cap-tester       PASS      16.87 seconds
TestRunner_iso-tester         PASS      18.19 seconds
TestRunner_bnep-tester        PASS      5.74 seconds
TestRunner_mgmt-tester        PASS      114.09 seconds
TestRunner_rfcomm-tester      PASS      9.14 seconds
TestRunner_sco-tester         PASS      8.45 seconds
TestRunner_ioctl-tester       PASS      9.91 seconds
TestRunner_mesh-tester        PASS      7.37 seconds
TestRunner_smp-tester         PASS      8.39 seconds
TestRunner_userchan-tester    PASS      6.06 seconds
IncrementalBuild              PASS      30.11 seconds



---
Regards,
Linux Bluetooth


--===============5761748589694807195==--
