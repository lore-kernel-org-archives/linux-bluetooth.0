Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCDFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 02:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52D92343E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 02:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395363AbgLLCAu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Dec 2020 21:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgLLCAc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Dec 2020 21:00:32 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9DEC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 17:59:52 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id b18so5170357qvt.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 17:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=r8IdXhLLzN7846wPKfm4MdWg9ZWFuWODinjZuN/dblY=;
        b=GZPP1TLNfbI8qoUaknqUDOqRnMZ1MEYJ38ITUlxkSV1kk7L97qTHPTyZUQxNrKmjob
         RkIJpLPjrhgcF0+DrDsUqBCkXlDNF7bssII+TmYD9V5RsQ6tm54+qCEBPD1m5oRsizn6
         Xd1fGeaySH5iNrJobeEQatM9+MNDFs4wyZ81+Om/mUyC/uNlwDAijq5QRC7JpMXjFq8K
         AnZmt2T1OmXPrQfjp30OGk36YsRcdk5p4i+AQpzXmULTL5gv7nRPjmf0uzvYTKVcEe5B
         HJ5fwNWm4QgsoOFy6TU73hXHg5AnM8KL7jNwFqjt7+Ugd2y0RCznH9H7GEYHNFs6+Vev
         XhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=r8IdXhLLzN7846wPKfm4MdWg9ZWFuWODinjZuN/dblY=;
        b=DR5FGoH1A89bYTJEusE8YgKunm0ManG+8KawXgBUITqI0j7dQi9ItRJ7tUf4p74+IS
         3NsyZmN1m1erM4Yp6JTUnrBODMcmTsQagu3AaQ9wfziRkqdnzVifj1TbXALsimusd/V8
         xlpVMM7qgEPV/AXOt7PCOXBrA9qEwtw0cd1vevpCTVJMaiI+RiHI8czURTabYYOasJbP
         S83mY0epCGjjfCaAFnbs2Ss4hsNR2Qi2SA/YXcTTcWN/jcJ2gKX2kupNwpL4h+/Jupuc
         wcseXdFvz/6ops+p5UWzwusbEbL+AghswgKe6HRJ7MYjeYqmxp35IW73BRAOT9BycPGw
         HqBA==
X-Gm-Message-State: AOAM532fu2fECaS0SzEqFPWDqUr9GFHtaNiCxaf/7tRr/A28AMWXccch
        poB53up/AkvXON4D/LsPDvzcCaiTGOpANA==
X-Google-Smtp-Source: ABdhPJzcaSINecr8dFQgthCHkthhGoIgkviAUwqY0sVl8uvGcduHXH6tDfIjHyj1t70UilChxy9Q9A==
X-Received: by 2002:a05:6214:98d:: with SMTP id dt13mr15485120qvb.37.1607738390334;
        Fri, 11 Dec 2020 17:59:50 -0800 (PST)
Received: from [172.17.0.2] ([20.186.36.31])
        by smtp.gmail.com with ESMTPSA id d123sm5503372qke.95.2020.12.11.17.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 17:59:49 -0800 (PST)
Message-ID: <5fd42415.1c69fb81.5ec18.7758@mx.google.com>
Date:   Fri, 11 Dec 2020 17:59:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8685418307738692510=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@chromium.org
Subject: RE: adapter: Change noisy log to DBG
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201211160253.1.Ideb5dbf81fdb531ff36814aed2c969980049dd28@changeid>
References: <20201211160253.1.Ideb5dbf81fdb531ff36814aed2c969980049dd28@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8685418307738692510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=400907

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============8685418307738692510==--
