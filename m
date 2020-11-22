Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504A9C5519F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 13:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D49206F1
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 13:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3UhqQE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgKVNIE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Nov 2020 08:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbgKVNID (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Nov 2020 08:08:03 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9084FC0613CF
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2020 05:08:03 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id k4so13687111qko.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2020 05:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Y9zid5hH+EQMfZ0ycoKisuZ+KGd1lGlKkBXk+qt7ywQ=;
        b=K3UhqQE3mkUaWYPo6jjPvEBTh/s/k4LlpbojZT/rQn8nGri75DE8HA93HTp+eVZUF2
         mGwbDOHQwpZnnlzDTfkkdKr2/icJ/ZCthBpjUhk0jzu2h9N6oKCH2sC57E25i+v/oK2C
         OhXsHCBCxp4rFNSYQbdUhuwJXba/fBH7oFjv4QtscluikkRamv8ESQ1bkyV36wY657VH
         jZzDOyrhOh5KyIpwOpkEF/4NZlV2FI9w93ocqExsCQJD0NxVJQfB6+P7OScGoB6jvS2j
         GIABfbZI6aZHW/jh+7TfCgbAfOt3YmvWGvX6EOlvavf01OvrLbKUO1sy1D7XAUIN6vl/
         ELIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Y9zid5hH+EQMfZ0ycoKisuZ+KGd1lGlKkBXk+qt7ywQ=;
        b=ssIm9ba4f5lzRJGFCXadso05WDZ5HWC6ArhCfEYVw9qMJme+KqR6My2ah6tWV2i9cb
         3eV5ll7uq0zJbkFoy5cxWVhq8OhFSVtH0lvbV1qq7T8IUZxpVb2QKKwfkgg/RG/zpF9h
         aK6l3xpd5capf7oFrH0fi+/9blpMEX0eqoSSVqP69aJ9pnCnYKynMueL/BfSqa0A+Nax
         UTRRrllDEPv0dn6KCcfNCvHwKzFzrjQKdQinqFqMecAXzeVdK2QcaoeLtrCADDndsiOm
         zFddhJ5VSlP8OC3XXRqklA7BeUg63SU7ul+FTiOos4L2TI4ykH14rsXR40o6Iwk6F2CS
         OOBg==
X-Gm-Message-State: AOAM533c0bB3OegwK/DUz5F09PxDF19pLF6UApnQS/J2QEOwa2NckSNh
        qw62TPKjgTifOjOawMcvCOuBGPUKCA6UDA==
X-Google-Smtp-Source: ABdhPJxlo7oSOUOIqDtTXSYR76pK4eqFqnE/BGNM5ybEZJ8URVxChjmyxm29biS3okYJwt7/HVtDaA==
X-Received: by 2002:a05:620a:13a1:: with SMTP id m1mr25217762qki.173.1606050482579;
        Sun, 22 Nov 2020 05:08:02 -0800 (PST)
Received: from [172.17.0.2] ([40.65.226.233])
        by smtp.gmail.com with ESMTPSA id z26sm6546515qki.40.2020.11.22.05.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 05:08:02 -0800 (PST)
Message-ID: <5fba62b2.1c69fb81.0890.377a@mx.google.com>
Date:   Sun, 22 Nov 2020 05:08:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8778454131448835714=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: Bluetooth: revert: hci_h5: close serdev device and free hu in h5_close
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201122121725.54351-1-hdegoede@redhat.com>
References: <20201122121725.54351-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8778454131448835714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=389079

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============8778454131448835714==--
