Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C000C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 22:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D0D619D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 22:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhCWWkc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 18:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhCWWkS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 18:40:18 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0900C061763
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 15:40:17 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z10so16185910qkz.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7B1fsfVxge2ax/Gp7Kh9kJiSl+lRNopCYHSnWcv4Q94=;
        b=Tt7HsY8p4moYNjR4MVygEDRA/DlbYYeHh5QNKzPSyKVcK0KWg0EcJkWx8qS7wbt7Xy
         DkbSOtgbYz0qFJFjftcxaTmjmMyYo4ogRzBIz9SeAqvm8IfBs2UnvGS4xFxFiyRnRt1m
         UKJNghw8rwN5xJ+nw6dYsFWjHKpfGpxQ4t+s9z37EiYsQRTjxbG5tO5n5nHLK690/Bcn
         +2O0mLG8faTZNsk6lXYbpBAreCnqFijo6hI7thc5g7tdGfAQUsDv7HXKSoxjIiBuUwEQ
         wJubv1TSgzrDOQpUWEmyLaLylf61Dm9MVjZqlfMJuHhvcMNfhrj39WR0qm4qtI3QXdmF
         9G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7B1fsfVxge2ax/Gp7Kh9kJiSl+lRNopCYHSnWcv4Q94=;
        b=sOe4jiJHarNis7w/oO0BJ5OhOC2xRI7zIoZa/DohS3AvfvtZM8BWBBfkc8zLhtQsZu
         mVGiCVZVgOxsRGmzDW3gkmHhHERp+VCY4g4nZHo/o96RHm6CgA8RBsLNtfq7p0dFY8DF
         8HmrGJpquTNhfW06a2ZN2e5UUS0wW/y/KPHtZYcO1sksbS3c5Q/etEf/NteeMt9znF8g
         oZSLaV9HUVO+aPlr2Ky84hxx1APO3T8dV5tq5BTzz3hM1bGPqeIcSdGV760f4sOYeUQN
         fFumz+fwkQ6MTQJIZ0ysY48TcGWX1s4kgy3mo8teKgMMsI1FjNIs68dheWHy4OhffBfP
         FdEQ==
X-Gm-Message-State: AOAM5324PshEK0RbV0hBnaJGFYNjkhtU0sbO9pNgrZocAl3wnlaNmjW0
        CTvbfZJs3JpgeLxLRD5+7UnJHk01wmiSUA==
X-Google-Smtp-Source: ABdhPJzDECjdPHLjUncdUij/nDGxdz7DJ2COLTiSdm+M6VHmQ17KxU0lTd4GXoPjDExxmuoHRcmHlQ==
X-Received: by 2002:a05:620a:13ec:: with SMTP id h12mr326301qkl.460.1616539217068;
        Tue, 23 Mar 2021 15:40:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.190.236.224])
        by smtp.gmail.com with ESMTPSA id m3sm276634qkk.15.2021.03.23.15.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:40:16 -0700 (PDT)
Message-ID: <605a6e50.1c69fb81.8dcff.1cdb@mx.google.com>
Date:   Tue, 23 Mar 2021 15:40:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1036516935995190775=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yudiliu@google.com
Subject: RE: [RFC,v1] doc/mgmt-api - Return connection direction in Device Connected Event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210323145555.RFC.v1.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
References: <20210323145555.RFC.v1.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1036516935995190775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=454217

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


--===============1036516935995190775==--
