Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE61BC64EC4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Mar 2023 18:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCISnF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 13:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjCISnD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 13:43:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A06C12594
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 10:42:59 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so7191278pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 10:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678387378;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6VvVBIIyFOGeeiEhdFGBuZNx8V3KDmSqGMkkojeF6RE=;
        b=EjXI4VK/kqnDyT/I46aeUmFN1umWnfwgch5PQ4Fb8ZmSSc0p1l34Uot3M8J2jG6xvY
         JVP/aqYj3ze5t+3LqXOaf5w/bNZ+qe7Ct3VaFCGnad2MvlHQMaSzlJGXSA028u3AgDX1
         EqmBDDH0IuZmebEUDbGtN0rvIQ6Kf5mlIi73eBZBNpv/PTDOeCZL0vV/w7zOWmelosy9
         X22Jr3e0cLj4zcg+O3Q7JFtPGVh9B7aqbDJRRofTPihtceBabmmITQgRw/T41KODFJNk
         pAdi9eBxzRd22QUsqQjm4y8dntVS0r/JnpDXB8gplMYF2ghBIzxEA0WfEiaOepYaby6h
         050Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678387378;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VvVBIIyFOGeeiEhdFGBuZNx8V3KDmSqGMkkojeF6RE=;
        b=xkvqimAsWRzLJxwmCZtAgOTzNLOVvMbd9O5pfDxqJl/Y+VpR/zWU1q9hm2+jGU6XOx
         uGkOBg6vwHSrRDwa/ieS5ppyOgNvKDK7kn3W4V8nROFQm4SafFwqfxLxHgLkS7grETfK
         eqIiI4/Mu0DhGI5GHR9m7fC3x0VHGz+Up2SQ85ZoJyAHpUtrYsriwPABIyLJwfM/d2Og
         gJqy0AihDR8GRpqsOU/GV95Qqboq97p/OAhk7OuupO0LA/C94NB91jnEuaWHZOVnmH3U
         d7lr1hqWpsu1FPxHJJa9mSiZNL2LvMJAbhKk9PyKNbGvMXGKbBiFFvSz1FCVNAJo5Snq
         MVLQ==
X-Gm-Message-State: AO0yUKXaEvnesbgKrhyU3zLRHb9uBkSA35nV6cwjyI8aYX3vd06kzERV
        kXKBTUOHU7PriRweEHNId/bdjIjTuSk=
X-Google-Smtp-Source: AK7set910pRxfpYLCo7CF8jNkg886HzsHSed8qDf3Tk0G9Lx6Op9Zxi+8Ry83wh6Ei/UoPA3zlYHow==
X-Received: by 2002:a17:902:b614:b0:19e:8c78:8cf6 with SMTP id b20-20020a170902b61400b0019e8c788cf6mr19695660pls.62.1678387378600;
        Thu, 09 Mar 2023 10:42:58 -0800 (PST)
Received: from [172.17.0.2] ([13.73.36.80])
        by smtp.gmail.com with ESMTPSA id i6-20020a1709026ac600b001991e59fde6sm11847352plt.216.2023.03.09.10.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 10:42:58 -0800 (PST)
Message-ID: <640a28b2.170a0220.c16f0.62f1@mx.google.com>
Date:   Thu, 09 Mar 2023 10:42:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1977878487130986510=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pchelkin@ispras.ru
Subject: RE: Bluetooth: hci_sock: purge socket queues in the destruct() callback
In-Reply-To: <20230309181251.479447-2-pchelkin@ispras.ru>
References: <20230309181251.479447-2-pchelkin@ispras.ru>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1977878487130986510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:888
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1977878487130986510==--
