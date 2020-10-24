Return-Path: <SRS0=OoyO=D7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDCBC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 22:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AED20BED
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Oct 2020 22:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTOac0Cg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762610AbgJXWdU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Oct 2020 18:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762538AbgJXWdU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Oct 2020 18:33:20 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C92C0613CE
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2020 15:33:20 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id cv1so2640160qvb.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2020 15:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8G6o6kCgmCpwhOco/1Wtng0SjrVarDLhb1/RFi5fnVY=;
        b=GTOac0Cg2XvQnHfU9kaLx2xjiqTVXkeV12VQzb/VP3pDIY0QlHIj4AtQdQlbk6yB/H
         xQYKWDYiB0ne4h0ziduy0eHm1Wj5TioODMYQ41VtSWg1ypCbNogYUplCIz6KB++AqYbg
         g/B5O/UhCQkzO5A+kDNdOQA2ojR4ZAom2QEhhMLFI6wOj6zE36yeVargIMDRrkEiUKT+
         yepX/Rv0D93yRJPUp37bG1P87HcOw/xORvJoP27oblOY106pJu0kuKEMOx9WmnyIds4M
         N1Vc+xVLpVaqDQnW84YDzrS+gLuHdDw2EfVt/6LuaNkZDzKFzZfToVCbNOFRB14T8De8
         G7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8G6o6kCgmCpwhOco/1Wtng0SjrVarDLhb1/RFi5fnVY=;
        b=Jfk5WpXyAl6vV8tcUfURtZBw+P4HynDg+2SonuTiGQg8YL7TRRc2k8+mO92jDI08dz
         I+VcFgfa26rN+jWK7K7Q8UMw4Ouxrr8lBShNJSntkI5e69cJeEjrmNyEbJwZUqLWEpDY
         lQACI5K+0ZyVi46YEYd2jmEh28OUuTtuxCEdXqqqhHCwrAr0nN1kq34kHL2pQbHowex+
         zAz+Ww8mie0z1VTBXK2p8z7bPi/ngUsq+syGD4n906fdPQ4MNdmBLz/RghbnlG76dh0A
         7MGZ3vO0rIQAcdNA1WUmTKMJsgZOxwHGxk5170OG6rC1Qqt/8ymEbIo9O/crtKo1i0vD
         TczA==
X-Gm-Message-State: AOAM532/HkSwD8NPjPqhEh3CmAOt0h2n8tbUru856PNVDwgoeakaiO49
        VtPspxHt8HAoQfyQah4wHuI8mImLMbmPGQ==
X-Google-Smtp-Source: ABdhPJzjHeB4yTmDjy//U7X9PfpafkD0j77JQ9hYmKgxM1kqVZwU7Up6J7bIfZ4EtIMThkTU78Yakg==
X-Received: by 2002:a05:6214:1267:: with SMTP id r7mr5964080qvv.50.1603578799031;
        Sat, 24 Oct 2020 15:33:19 -0700 (PDT)
Received: from [172.17.0.2] ([52.138.80.247])
        by smtp.gmail.com with ESMTPSA id r190sm3686576qkf.101.2020.10.24.15.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 15:33:18 -0700 (PDT)
Message-ID: <5f94abae.1c69fb81.9ad29.53c9@mx.google.com>
Date:   Sat, 24 Oct 2020 15:33:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4969770525514194950=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marijns95@gmail.com
Subject: RE: [BlueZ] audio/media: Destroy transport if SetConfiguration fails
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201024220956.3051848-1-marijns95@gmail.com>
References: <20201024220956.3051848-1-marijns95@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4969770525514194950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=369951

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


--===============4969770525514194950==--
