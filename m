Return-Path: <SRS0=DAWq=DY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A31CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Oct 2020 06:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1780520720
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Oct 2020 06:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grooHsCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411668AbgJQGBg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Oct 2020 02:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408610AbgJQGBf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Oct 2020 02:01:35 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE8DC061755
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 16:49:38 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id k1so4505999ilc.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 16:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=yFTxOD7OHctKXWaDI+xlkF+DI4YlJhO8R5phiTixPkg=;
        b=grooHsCADdbADMnHQ5YwXbud+Z3vOjuF5h4RzmtNCEH+tOh4RArP1jpVq1E+06hrAs
         02b5ZOug5ytoYxw70ODmRyaIczSNB4ZcqitTi0PBdIUef8x1TcpFf9DPT5kxfX/+ChVH
         XZhca2cARBMguFT9dEmADG277pbxoRUbD7Nl8HEVfshDzKZOsbYUEIlfoPacYkkXjHed
         3uSsNAKObscHWc+FC+Yj/FvMrwq0M7qoY3huXC2Iao7ebNTfdxjhWSMqQJ44glJwipxF
         GzcVGcvre97gEdMfMUeuCMoSwY+XjBy6XwMC2aoWWWaCPYauWtzdsmeKpI4VQl/uRP1i
         EdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=yFTxOD7OHctKXWaDI+xlkF+DI4YlJhO8R5phiTixPkg=;
        b=Urloox9oteHV5u+lasQV+ChNcpvQCRAu7IH6xKGO3CyQZ3UThnU/JS2BztqcD0Fl1E
         DvDVcM4P+61b07jadKnlXS2PkKFGBBNuvg2Id1koNP8lti9YunhINzeQql23KM8ouKD5
         bDzAQi5AYuHrqOtI9jzvke7/d7mRDsHnudHcLKs5UYNb6SgSqsbCLMeTaGWX6M909oII
         r0bqkYWDjU9te1f9LYNLaYFa7cWXcmdtPykcIF3zzPJWYts11p/BnQ9CkLOoc6MCMdn7
         xEtxu+zfScUTdPpku1fJsqY7cPukxgahSTBvsgMSK5S+jSvTXELyIbP6RFUKdUNwSm9n
         LtWQ==
X-Gm-Message-State: AOAM5305MkflvoJStiSmbo6wuC3DOit3ShpwedARuWZWsaQxKvbluM2P
        Zngv0b5UBTqBArN2ytsjrLK/SxzaWx8=
X-Google-Smtp-Source: ABdhPJxGbOhoTovYhCF/7kYypOjXxasSNEGLxZ9t35xs5e8u/x8omREFkYj7U6ZIDOPAvBm6A50lTg==
X-Received: by 2002:a92:907:: with SMTP id y7mr4415756ilg.276.1602892177006;
        Fri, 16 Oct 2020 16:49:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.22.34])
        by smtp.gmail.com with ESMTPSA id q83sm4284104ili.16.2020.10.16.16.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:49:36 -0700 (PDT)
Message-ID: <5f8a3190.1c69fb81.52a5c.96f0@mx.google.com>
Date:   Fri, 16 Oct 2020 16:49:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7686520350009280082=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, danielwinkler@google.com
Subject: RE: [Bluez,v2] doc/advertising-api: Enable new data types in adv data / scan response
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201016163331.Bluez.v2.1.Ida2ffbf34e18b5a810dffd2abd2bb9e431df3ae4@changeid>
References: <20201016163331.Bluez.v2.1.Ida2ffbf34e18b5a810dffd2abd2bb9e431df3ae4@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7686520350009280082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=365989

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


--===============7686520350009280082==--
