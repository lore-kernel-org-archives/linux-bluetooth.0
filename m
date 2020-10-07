Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D0EC4363C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 03:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF9720B1F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 03:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohj5CpKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgJGDdt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 23:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgJGDdt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 23:33:49 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6B9C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 20:33:49 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c5so557619qtw.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 20:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=b4jUYuQTv74oLDusKKQFCOP3fzFoMJEpuauSpyQj8PM=;
        b=ohj5CpKBr/pgs2brmFTNs9A7rHysCaV4NrgU3UILaaL7amal+NlzaGYXRDFMse0Oek
         JjKMamtMIG8QMd80lYioZO9FD5tMAm57bYjg/h+bK/L3+ix6pGTH5qLy+OVFn84BMEzo
         Nhp4HYoN6v3r+iB79qgqrVRF24kFqxEypyNIbzgnnKNhJ2vTdLnkjJYP8Aihcne2e7Wl
         0Vy6Bpgey1zJx7O6yVQiRA9bHHHaVp0sbFk36nh3ZAZ8CsSjVOWIGWwI26bo/ouXrV9v
         fnWIl4j6C91lC9CIgVxZizOqgf2Ky+cDDXxKLMZnWfVy7b1HvOCPHLg8SVOjbQFAY+Z2
         iaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=b4jUYuQTv74oLDusKKQFCOP3fzFoMJEpuauSpyQj8PM=;
        b=V7yBsMow6BJqWFYYexlISYzGtn57vOFi5O7iBVDHXRUlSD3PLMKoLJDo9hhNG+uMtS
         NhxOPcQpEsV3y4UVXQaOxrq2f+mt8CIYHrl1lcWYYgIKQBwe9KZCY8g4/h2Ua5PYrFNy
         V1TqAtovwGMPRmw4rvKyLVF+0Lq63Lhr9Y+/nNOAgePPFfbOW7cQ5qQhUOkU79tX1EzW
         7HUlttlo3EF5EHqWoP6e9uZQc7I9WAwNbCGw4zw8CXnEIa5M4GRPgO5b7eKNvSWbX7T8
         TEh1xQCEzmhn25PnFmP8QfS9URRHklD1AFsh7FyuZ6Ry7L7NbSu+NaqzezPRYY2N0PFC
         n+3g==
X-Gm-Message-State: AOAM531OirNBs8ixqEiPSYO8p9FERaIajarUXXsTGp8/mLG22580Wmrc
        1AA7SauxIrSZtFrmpmb/B/EIpqlQEqK/qw==
X-Google-Smtp-Source: ABdhPJwkK+BjER3UDKrWZViasNSmGxdQSYj7a943iawd0e5aqW1nRWdiFksNY1KHYvW4Ki5kKw9M7w==
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr1398203qta.176.1602041628062;
        Tue, 06 Oct 2020 20:33:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.139.18])
        by smtp.gmail.com with ESMTPSA id g7sm673709qtc.19.2020.10.06.20.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 20:33:47 -0700 (PDT)
Message-ID: <5f7d371b.1c69fb81.76639.4b93@mx.google.com>
Date:   Tue, 06 Oct 2020 20:33:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8051967544448426134=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [BlueZ] adv_monitor: parse AD type as hex value
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201007110032.BlueZ.1.I09f767132567613957435203a827e5151b26a15e@changeid>
References: <20201007110032.BlueZ.1.I09f767132567613957435203a827e5151b26a15e@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8051967544448426134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=360615

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


--===============8051967544448426134==--
