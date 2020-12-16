Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A10EC4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 07:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD63B23343
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 07:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgLPHhh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgLPHhh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Dec 2020 02:37:37 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5011C061793
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 23:36:56 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id 2so21696982ilg.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 23:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=LTbWq9ncX2MS5KFx9RMe0a6J30vjtAKk6QC3rh6pj+Q=;
        b=TIandlLm+t8fySO0dXxWiOg9NTLnC2vr9OGRgcKHxqs4S+qKgclcd1Y+gNTwG2sM2t
         Kos/yMZrAhK8TH0xCAoIVXmFroGBa21/KBDpVQsIQpi8/3xektTLEM7Jryf5g7dXsW9u
         bJGrgCWhBVNyducwE1C9KSDpl8P+P5x/ETP1w6WWJTqOhktXfYWZDwHuo3p8UOQIDdeS
         Ay7gjKWXaOgWEg2qM9F4QuRAmwzhhj3UMpSTZ6hUFwgSmtXB2l4uBq/vUMKVQWvIChBk
         t9NYRbhRIRSIR2RObbV0EujX8dbQn8ic5sy4Bq36uwVVUNFQZP+bgK/lCtktXZw47w2X
         PJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=LTbWq9ncX2MS5KFx9RMe0a6J30vjtAKk6QC3rh6pj+Q=;
        b=JP+Gi5BMDxuX1w1A+B59fGBdM6E7XEoeauZausTAHaed++amumGtt58F2aeBBmg/fg
         3xlGV3aAriPn91WKfyLNaon3fh/hfHa4JOH0YR2QbOU7yUzXeYAnqpNMNu1ZNSYetbgS
         3ulUH73w/Cw4cT007LH+nVnJZOaDUx1/IPokGRpRPtt8WGWyluLck/XLMgPiM+UinvHo
         C0tC9rwYT894UgGJlCKabRG8jqGGkdxhIBqNFtkxQ4w6fgRlf0ZK5mvvWUxckGoRSvXI
         0453+jDGPxCUOXvmvpwJQwsO6PWiSvKROWUVDkE3fZFtF936gLCstdUBYjL1YF0caPii
         SGvQ==
X-Gm-Message-State: AOAM533TP+Fa/whLu9MwCT2Dnwre7ai8d7GQp+pS39Rn2Lc1hGMmIgfq
        P8P9iIG50yxS1F602x9NR8hpOGUZG4k=
X-Google-Smtp-Source: ABdhPJyFyFJIHWY0gDiP7RYJRNr2LKovipp8mNUskeOqjYjttzxyeCdfBYK2R9sHrJDPxG/kvhbL+w==
X-Received: by 2002:a05:6e02:13c4:: with SMTP id v4mr44563407ilj.118.1608104215946;
        Tue, 15 Dec 2020 23:36:55 -0800 (PST)
Received: from [172.17.0.2] ([104.209.241.18])
        by smtp.gmail.com with ESMTPSA id v5sm12269850iob.26.2020.12.15.23.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 23:36:55 -0800 (PST)
Message-ID: <5fd9b917.1c69fb81.e0793.4357@mx.google.com>
Date:   Tue, 15 Dec 2020 23:36:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2004283492023048768=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [BlueZ,v1] core: Disable advmon manager interface for old kernel
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201216151748.BlueZ.v1.1.I6e3ace32f08a22879ede97a1433f524189bf24df@changeid>
References: <20201216151748.BlueZ.v1.1.I6e3ace32f08a22879ede97a1433f524189bf24df@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2004283492023048768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=402711

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


--===============2004283492023048768==--
