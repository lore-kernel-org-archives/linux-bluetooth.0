Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786C2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577CE60EBC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhKAWiF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 18:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhKAWiC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 18:38:02 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353E6C061714
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 15:35:28 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id n15so4542219qkp.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 15:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6G+aGuf5Q5i0EpaplN0VsYHsRezkQXgEEZuc+Fv18dU=;
        b=C3KlYJGBXaRZrjoN+qVzwH/JaGXKzHUCno/dVXcazVOqWFbq1/msHCLm054juIg+cA
         FopXoVBH/jdyug9lIqx8dKH4PN4fN/EjmIgBpyxThTnrifc4i/QFVj18sjng333re++h
         x9d11cLxu3/9g0Y97DftNagQNAVBwYzzqjV14XbORUCv3G2Bj2roB10msyZmqd6nV8Ey
         8FseTxUJRZVgUu1/3uGkWTplz+F4FL71kgLRxuzK2YltmxpQ0e/n2pCKksR9nRzIsNwz
         y5ZUwe49Zrk5k2rRjMUtCZ3CbeVtKOEejucSpBezdHMervxZtfg15T3RKd6dL+J3pw4h
         hF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6G+aGuf5Q5i0EpaplN0VsYHsRezkQXgEEZuc+Fv18dU=;
        b=uMGJKN1lU6cc/H9YMKYRY3MIf8b5B9X1QfjI7K5YiWxz5pm96EEhispgg5X/mp1SXK
         rDLZyGFhkfvAn7Wk0HZkTkY2iA9WjtS9jBCZksrs5w/5JKUYU1Mj0uAObYRJ9FBXNZUc
         br3XTBWxoeq3izPitKwW3uBm6qu1Aovl/H3ybqkz5WTpxpW+uQ3yuSrEgz6mLzJzSxUH
         luciwEq393sNy4dK8/S0kTTmFthe597gcgBlkIe0dQR2J+VcIDXndrP2BwUju2M7UL98
         +DHy5hEz8esYeLdMVEEQhe96wQQUpj5BKu0s46rx2SULxZlHOz70ekhpBhomhO/YH9SW
         1Jow==
X-Gm-Message-State: AOAM530Psriq3zYjuE6dOktMRmJ6xrPL08fvF/FPxbrlpEJ4a8ouYpMm
        kCpsS+pyhz5IGQ5kDbyyZC9TiPM2U54uIQ==
X-Google-Smtp-Source: ABdhPJw9T2fUdmu4IwKMQTubVBXlY2Qzp8ZXrfhSSzflnPEb9/s+FBixQPs9ONAa57yibMN1gn3XLQ==
X-Received: by 2002:a05:620a:2443:: with SMTP id h3mr5049218qkn.299.1635806127200;
        Mon, 01 Nov 2021 15:35:27 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.169.249])
        by smtp.gmail.com with ESMTPSA id h12sm11245318qkp.52.2021.11.01.15.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 15:35:26 -0700 (PDT)
Message-ID: <61806bae.1c69fb81.d8253.6dc1@mx.google.com>
Date:   Mon, 01 Nov 2021 15:35:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1432698570163589983=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] main.conf: Fix Privacy modes
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211101220411.2753274-1-luiz.dentz@gmail.com>
References: <20211101220411.2753274-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1432698570163589983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=573749

---Test result---

Test Summary:
CheckPatch                    PASS      1.35 seconds
GitLint                       PASS      0.92 seconds
Prep - Setup ELL              PASS      48.90 seconds
Build - Prep                  PASS      0.52 seconds
Build - Configure             PASS      9.21 seconds
Build - Make                  PASS      207.74 seconds
Make Check                    PASS      9.64 seconds
Make Distcheck                PASS      253.13 seconds
Build w/ext ELL - Configure   PASS      9.16 seconds
Build w/ext ELL - Make        PASS      197.45 seconds



---
Regards,
Linux Bluetooth


--===============1432698570163589983==--
