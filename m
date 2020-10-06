Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B612FC4363A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 01:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D184207F7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 01:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEYMNDjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgJFBMo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Oct 2020 21:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgJFBMn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Oct 2020 21:12:43 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA2CC0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2020 18:12:43 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id e7so11563119qtj.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2020 18:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1kLFDLQI9lB5jMNL9SIqTUsmgxHw6Jkgpi+whsAmsFY=;
        b=gEYMNDjLbEFvPpIk10Q9NYdLquW9/TotcwRdy4n1Vmuyii2l09gYCsHg3O+QE4eOrf
         i4+9OP/TS0oCB1gVT8di704cWJfsVuXlLYrLFzSFO59J59QT9qjX0x6C8BiHDp5KjCK3
         HttOhpiZCm6Q36xwpebuLWgFy00FPh8PfHgiys9tEzU7A4kiZJMx1y8qddtX0ovYhmnk
         LxHnuN/grE0wdPbsRnkS1F9gNxjVqY98xCSjOxJgvfYuxQVz3AW5bo+b/VeEYikGSiwk
         UM1cK/j1Lgwg8+Zo/9aoqzTxtWzDp0CPDJszGKZu5EOAl77DO9WKBfWgVaHZIKmJbpJY
         1sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1kLFDLQI9lB5jMNL9SIqTUsmgxHw6Jkgpi+whsAmsFY=;
        b=IU/xsTT8rnrVPQsfdqyIj2AyTrfptl29wlXZiPdzFA9Bi+qu1knRaKRY3Eqo441dDF
         ZUZjvLow7ALKtr9b9G3K1OtXbMJOGEExXTwZu3sID+GmefPAVqp1X7rTaTUYCrQrVO7e
         570YzgbrTKsHFfFy8ChgvPwgvrjvW0JUkEzQ+WwhG/YAzk2L8dgZr7ktDor+FyS08yHI
         jRLve277WapAusMIK09TGK5NwjR5fwCQZyxL7NBhpi/ZJ+Ex87Bky7KzVAvOz/B6v3t8
         zzVOMLzlfvGPG6Cd1eFUaq0sGDjX7iEYBZJr+nlJnx9PCeWohSuUBDodNZU66lQcG4bB
         Oy6Q==
X-Gm-Message-State: AOAM533TBAoqDmwW0ezzclxCDQuFT7jrq2M/5ZByz8hKZ8v+PUjJjRxZ
        EpKjjp9PUBe1lOK388SQ8O4FEvgMmp3CtA==
X-Google-Smtp-Source: ABdhPJxRfJny9yaBnRjRJXca2HwiP8Y2yb7Iryboe0DPncuQevB0H1EscA1LjoFc/2cPgA1KlmwPWQ==
X-Received: by 2002:aed:23f1:: with SMTP id k46mr2855101qtc.377.1601946762953;
        Mon, 05 Oct 2020 18:12:42 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.134.196])
        by smtp.gmail.com with ESMTPSA id x21sm1521165qkb.78.2020.10.05.18.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 18:12:42 -0700 (PDT)
Message-ID: <5f7bc48a.1c69fb81.347c8.8775@mx.google.com>
Date:   Mon, 05 Oct 2020 18:12:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1295013325056910575=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v5,1/6] PRE-UPSTREAM: adv_monitor: Implement RSSI Filter logic for background scanning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201005174640.BlueZ.v5.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201005174640.BlueZ.v5.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1295013325056910575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=360075

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
PRE-UPSTREAM: adv_monitor: Implement RSSI Filter logic for background scanning
1: T1 Title exceeds max length (78>72): "PRE-UPSTREAM: adv_monitor: Implement RSSI Filter logic for background scanning"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============1295013325056910575==--
