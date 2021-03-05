Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1234DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7014650A0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhCEXii (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhCEXiI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 18:38:08 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B00C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 15:38:08 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id b130so3755052qkc.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 15:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5PhQ1p9C/Su9ymk3v2poL1PYsQ6/qNUavNMHdwL1gic=;
        b=sTCRiZdVkINNrBlhefT/zot5rWBNbUH/dzP11JRWD53go6dloLBhGcsQ4t5sRHCXHA
         PRC8n//0x6xyKYi8wDdnRMQleZOjXucB9ucyk7zDmOY0SzR1GZyhhFOaSsbEUFr3smgt
         EKjKy+bqZkTk9JOGIT0SRqjJsIq4NcEJusPlItOaJgEaWb1uTzmArHtYnZJRSNdoH56o
         pcaEMIQCy41cmBZ28f/3bYkc982TAS60tZo3IiNMA80OPe6DBbyFYX3l0dIMQsjjE+lV
         MFybwnlEFwYJT9efWtm/JDAb4GpdHl78QDKWar5ghiRaUMso58gFX3CSxUlEJ/oUX9mn
         OSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5PhQ1p9C/Su9ymk3v2poL1PYsQ6/qNUavNMHdwL1gic=;
        b=evGouNw1swpXL9+WVHKRkB21h9HwYKgmKGxJz62BW3/DI6uMEwFsIscdWV9pmLWc9p
         F3mRU/CzkOKM6BQ2mWHWQ+g1Ny3D0r1VPPwnKhTgRQghDp2jdGmOPMifQndoxZ7178S4
         e+0iLMlisYWz0CIGVjAyp4YltTR+kUI2bs7mg1yyzZ+BVXVNqu9VK875QtF46fdfLymB
         BelVIetm4Q1FQzWDwbXYJxbl7656IzrMryb5w0PwAYQmsLkyD0ns1LmD7J3P5+3NYfMi
         QEEuZ1XdmZcpaH84gxKqCEy91pxxmT1pA4oiIXW+dJ3qqpYgx9xt+lZdHHgayk8j7X17
         miKA==
X-Gm-Message-State: AOAM532cEcEiFd79u8Rbpn2sxJfJice5tCrwC2vNd+jw41Oa58UptL2t
        D9pNhR+4d9ZfLwjBuYP4wXyOZc5SKkAKCg==
X-Google-Smtp-Source: ABdhPJzn8gIUZ9ykOiKybxz2fwowmBKq9c3m1abn0W4XFe8gQuMF8AX05RQnRpNFPyVi7MiG7bOs2Q==
X-Received: by 2002:a37:4783:: with SMTP id u125mr11742366qka.186.1614987487227;
        Fri, 05 Mar 2021 15:38:07 -0800 (PST)
Received: from [172.17.0.2] ([20.62.105.34])
        by smtp.gmail.com with ESMTPSA id r2sm2982613qti.4.2021.03.05.15.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:38:06 -0800 (PST)
Message-ID: <6042c0de.1c69fb81.b4075.4f10@mx.google.com>
Date:   Fri, 05 Mar 2021 15:38:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7954226945824159884=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] main.conf: Enable passing false to DeviceID
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210305230004.4010887-1-luiz.dentz@gmail.com>
References: <20210305230004.4010887-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7954226945824159884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=443019

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


--===============7954226945824159884==--
