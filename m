Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE444C4727E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 22:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B17C21775
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 22:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNhw8tol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgIYWww (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 18:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIYWwv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 18:52:51 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1452C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 15:52:51 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id j10so2260918qvk.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 15:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=93RPlggnTdwFWzhdBEiO+/j4AAlsF5QW/wNwJompZ3Y=;
        b=CNhw8tolUYor4hthCYjfKrWILU0286p2HIlfk3FqI1SNrScpaf9eKkDMSGzWOYNUw8
         nazLN1OFwBd0sC7UMaDYVQuuX7Pp2+UaWcSHHUwmxAwxoC3Fp5/IRAMHdpEAn9FCM5/f
         y2pEEjwdxvkXkrnEwWQsaeNpVkI89zNiW/s1bdKMPUpiDGpt56kJ58++CdwAfHAXrbX0
         Uu8bFkwWrunOGmPuDCgn7qBot5uYNo7WHTAvvIUceuviMyq7U7KHXJ9REG4aIcpysMdi
         Qewc/1BnXXO8IbzTdbqOPQI6yOa4mtO7yXN5aUSaxUqRJb5kt9fqDsWfG3rZY2FgdOGu
         2LyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=93RPlggnTdwFWzhdBEiO+/j4AAlsF5QW/wNwJompZ3Y=;
        b=W+QuCOQa/kgjPS2qNLajQ5IP5gxbCehB6O4JVVbL/HrO4kgn1c+wlYlotsAb/OYZEI
         1TAo1e+p5qCHr+5XwVuy4hGnCP38mlPah/6wKls6piZclWe408qpHS4vdhOGXtsIDm1q
         X7YgT1DAbbdnB1n0RH0JBrckx0i8Si9UA/qHVxMoOnwdNtd0Z0WkHGU+hn0846lPtlvf
         uBQSFax+YoSjuGLtqzWvfryxnQc98iW2eMI1gI/6xq+UVLp1GMUcT+J8EPeWnfP86kpr
         dSNnnaoCqwYdckLai03Tl0ZBQWvRTKwFovTl+U8iqDEp4cwLMawBBn0FnqlDebAiqxi/
         EcwQ==
X-Gm-Message-State: AOAM530xZ1wv0wf1C41rlu5HXpnLmNbcKdciEZpp5P6OOBjPA/H04fVy
        Apa7nQI8Y0ZEgAfx5KCTYcqci7Q8NlE6IQ==
X-Google-Smtp-Source: ABdhPJx0uRNYiN/92fWWmdc9te0gHX7nrPEzWQn7H5sU6HcOpfw0TjzH0HcI9BnWoG+1HyjHz/z7Ew==
X-Received: by 2002:a0c:b410:: with SMTP id u16mr1032904qve.52.1601074370513;
        Fri, 25 Sep 2020 15:52:50 -0700 (PDT)
Received: from [172.17.0.2] ([13.77.77.246])
        by smtp.gmail.com with ESMTPSA id j31sm3084750qtc.33.2020.09.25.15.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 15:52:49 -0700 (PDT)
Message-ID: <5f6e74c1.1c69fb81.c2e26.5e7e@mx.google.com>
Date:   Fri, 25 Sep 2020 15:52:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0453956559309429863=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] shared/io-ell: Add reference count to io structure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200925223849.76623-1-inga.stotland@intel.com>
References: <20200925223849.76623-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0453956559309429863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=355719

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


--===============0453956559309429863==--
