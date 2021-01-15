Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77ADC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 19:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C42235F8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 19:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbhAOTQ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388430AbhAOTQY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jan 2021 14:16:24 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C1DC061794
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 11:15:44 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id w79so12744933qkb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 11:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jSVucJZjRyOAbciuq3koRR3mjkSxLbfxkCTC3GXmFaI=;
        b=S/Aeeg1a/tt8bj/iJdbNMA59KjfyoPVvgJQaZ+9Ed1hvVvBi3MHBzXaauN+wIzvJY8
         8YoeCbw7VFmkh5OPWw9TGWGQ2cOEyvNohnpI33PDBvzF0c2BgO0hSnO5Jw7dbhKMmqkF
         XF78s+q+x1YYYmZfJGEEB5eGvaWgFlNYrYV74AWDDKBdf8IO5CPm5kseH/nD+5UvmLKP
         1mgDevCbCmZmbiTTGc/7r0bCfE9M7sTN72qRzHWsaK1CuXbNeTraZQIjGTtmTLRS0u1V
         yaGpbuury7CYzi0Hul3IU0N6axG8YNwPirGsfIkodlnSzSxtd03YTcWGOY1NTDL+7JXP
         POXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jSVucJZjRyOAbciuq3koRR3mjkSxLbfxkCTC3GXmFaI=;
        b=TcJ7vz+8C2SwgNi835lFL+8v4XMk9fjhDRkf32glFby3U8Wg0cNNViNarlTLm0CwWo
         udsGq0CfSELL99RUW/8glUtYQ534CCcv20227axq81WAjcKjkj5kE/TIxsKjQ3nPQtvS
         zbHtaCzNOKm6haeUiAjc0Isd78G9qCX6wUHE0mMyYcq9gScpx8Avd8s7aYN1ZIht+Xnb
         RcLs4QSpoM0IxWtIO7Q3q9J9BV1Dot9EHMamTiiz6VdMNPa/HINjGX3XYsy7jpN3QkSX
         y4+4OkuE2ub5ngFgcf9BlSlk8ugofagv8fFH0ZzGnKNWp2uqw8P2p7E+ptjfOWgjlp2X
         nZRQ==
X-Gm-Message-State: AOAM532AcICWGRtYtKmRMdOXrE76QUZl+KXLzIx23L2PHNdjz7MGx99f
        BH2pvQSOiF4bgv5K4CVSsk1fVBYLoyrvig==
X-Google-Smtp-Source: ABdhPJzAZZqBtvWCZ2O47gTQFjQS2y6FegrX9/D2Lpwh1np7m2AIpr9BgCbe7DTDrz8BqByevBWncw==
X-Received: by 2002:a05:620a:16d5:: with SMTP id a21mr14359388qkn.188.1610738143099;
        Fri, 15 Jan 2021 11:15:43 -0800 (PST)
Received: from [172.17.0.2] ([104.46.3.146])
        by smtp.gmail.com with ESMTPSA id o5sm5306205qti.47.2021.01.15.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 11:15:42 -0800 (PST)
Message-ID: <6001e9de.1c69fb81.f24b7.335f@mx.google.com>
Date:   Fri, 15 Jan 2021 11:15:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5697996333542340006=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/crypto: Transform bt_cryto in a singleton
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210115190229.186479-1-luiz.dentz@gmail.com>
References: <20210115190229.186479-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5697996333542340006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=415727

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


--===============5697996333542340006==--
