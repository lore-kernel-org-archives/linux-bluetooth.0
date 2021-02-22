Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4877C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 06:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F4A64EB4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 06:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBVGjl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Feb 2021 01:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhBVGjl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Feb 2021 01:39:41 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFABC061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Feb 2021 22:39:01 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id e9so5612068qvy.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Feb 2021 22:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=GzJx2mgSYc4nxKqqLFNXIcFMJqq9rVMEY3jvyf11KRo=;
        b=TXuOwiSi4Co4GAW96J6Fh1vEaaqHc1Nye2qjyV5C79ObsJfvicnWJYlKSAY30W9Oio
         2YkUp0VIj3wwjZ/CUHrat17aPJJH2ItHhBFTmObyCWLbiBHtzDeuAN94ffxSOoQHA7Ru
         Cq53kD/D3HfoVfS756mF7s1HUKEjpkG900NkjXPoTfLh1XE97uPYbGJ3Meb45kHS8dpD
         g2KZpgYLcT9YoWPtY0HqiVC9tbsS+IFlcfkQCr0NXm7md7t/a2LMxt1NPtthMbuZJAuu
         VFcmcVd2mIxCI6YlgjEiKb89C8Efjo3E61ygmjaP26dRDUx9BQOr0kFSUplQJjqoQvpQ
         jHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=GzJx2mgSYc4nxKqqLFNXIcFMJqq9rVMEY3jvyf11KRo=;
        b=jrqLQyxmifizIu325WYN2zb2uRUMmcxniGx3gX5fk0cBZx+nH+wIlFmFT4UHDLQlTh
         2KLJB35gkNvGZKTgxZpIXT6Ey6drrpMnTD0Nj3CDhByy449GNXjpm4jBjMof+FqBsxQP
         F4/WjuVT5tTx30ssY0vTQOXfatg79mxERat2nw7+c9OHOueCiI9ThvIV12k9gs7AgvXf
         lm7n1oj+2S/Xnk7Nqw0cKZHOge4aX8lMcaQ73XNQhojXr+sMlWwYugA5QGqjJFjbohD8
         xCDeMIzcEubifcVuqJeBuumaQi45dGpiFazndi8xgqIBqaQr4kbq6eo+SuAt9ENfFqbz
         HuUQ==
X-Gm-Message-State: AOAM531ORTPnOQst1m1fTJ/g0/um+kfd5QMLf2zHZ9zDth/5C/spvhHv
        u5u5deR8VH7wbkqFa+4av4SEjHT8ZKDRfw==
X-Google-Smtp-Source: ABdhPJyGL4/nRJ9XMhwDLcLJlyb6/S2uQyVcbHSZsCsqMSB3GlCc7uhS4HHvrlXg4eSta3x4m+yJCQ==
X-Received: by 2002:a0c:8c87:: with SMTP id p7mr19203916qvb.46.1613975940269;
        Sun, 21 Feb 2021 22:39:00 -0800 (PST)
Received: from [172.17.0.2] ([52.167.229.4])
        by smtp.gmail.com with ESMTPSA id u4sm11861853qkc.42.2021.02.21.22.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 22:38:59 -0800 (PST)
Message-ID: <60335183.1c69fb81.117b2.74cd@mx.google.com>
Date:   Sun, 21 Feb 2021 22:38:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6278519938286623246=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez] adapter: fix set_mode MGMT_OP_SET_BONDABLE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210222140727.Bluez.1.I127ac7b2fadba6ef4cce42360efd9b8129251753@changeid>
References: <20210222140727.Bluez.1.I127ac7b2fadba6ef4cce42360efd9b8129251753@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6278519938286623246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=436335

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


--===============6278519938286623246==--
