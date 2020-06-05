Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878BFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 00:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640632065C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 00:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLupIr/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgFEAMd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEAMc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 20:12:32 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A16C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 17:12:32 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id n141so8182487qke.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 17:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=WQaSP78SjWOBc6Dc/y3C/ghIdpQ97X0sqD+vkmzu8x8=;
        b=fLupIr/HKXCUF6eXdvrrad+0Ih5nCykC0nFEA2KuFYr+p4keDJ5Exv7Xvw3CQiSJFU
         Qne7SVGLethXAIPoO5dPfg6vdm0zF2pRrsas2AevlO/rsd5zAa4mYKCT/+M58DndEi99
         cnxz1/9EUsT2KeAPKBfUrpObUF0FK3wfj+Gi01S82fq/A9ARbPHyTifzQ8GAplEW7hx5
         R0yxW1JgqB7VgDXhyqRtwwvbncweSBxQNnSpYiJ479ih/8F01PkOzTp0wuyq3Tl+J5RB
         ktwPtLkNuNezZd4376S1lPC51Rl2xT1wSYL4668jnE+J3WI6hMjdBd/VskkUkAz0+0Zl
         m/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=WQaSP78SjWOBc6Dc/y3C/ghIdpQ97X0sqD+vkmzu8x8=;
        b=iEmYy+3OG5gjhewb/alXKXdW/EhgAUNgwpT+xTKwEXgkYgb7i9EOi1muDkxXR8j6vF
         PVMGq2fOVom2aq98VcMOvAZPhVuDw0IuG+DrlVCZQfyW329UGrN0BHyHwq6N1xdLyhXh
         CsKpGXE9j9+hrkntSSq0KHy3t6ZZn5/RYEbtbTHhrB8joJGtSiLFk9JhzfLxkhOyd2UY
         OnU2jB1V5AKCwTgGUJScpn75wVY3NHNfSmVUctMaN6XtsY+kE2o7U5hNgNca5tp0LEGy
         7tV3ZxBI5r8quGp59LTsgXx94I1D5t7AcVRKEvnYXDdq97DR2uQ4w5wPVUtbAt3CpweX
         NHcg==
X-Gm-Message-State: AOAM532c7tG35OheF0jBp11dmyRH5jP4HioIcAl8uY2n+oTkgl6DMlpR
        X/ofOXxd/pbuTiUVLMUFngf22J8y03U=
X-Google-Smtp-Source: ABdhPJygsDPP772s4sWvYH+BlQQtogZAfO2IwDZiGCdcJI6p2IuFfeBe15VIuTHiaOnKsES/8gM+gw==
X-Received: by 2002:a37:7902:: with SMTP id u2mr7363976qkc.53.1591315951401;
        Thu, 04 Jun 2020 17:12:31 -0700 (PDT)
Received: from [172.17.0.2] ([52.184.167.57])
        by smtp.gmail.com with ESMTPSA id v59sm6014609qte.96.2020.06.04.17.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 17:12:30 -0700 (PDT)
Message-ID: <5ed98dee.1c69fb81.bbaea.1dd2@mx.google.com>
Date:   Thu, 04 Jun 2020 17:12:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2935253699520115538=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pali@kernel.org
Subject: RE: btio: Fix registering Object Push, File Transfer and other L2CAP profiles
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200604231541.4170-1-pali@kernel.org>
References: <20200604231541.4170-1-pali@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2935253699520115538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
1: T1 Title exceeds max length (73>72): "btio: Fix registering Object Push, File Transfer and other L2CAP profiles"
5: B1 Line exceeds max length (147>80): "bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for Message Notification: setsockopt(L2CAP_OPTIONS): Invalid argument (22)"
6: B1 Line exceeds max length (141>80): "bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for Message Access: setsockopt(L2CAP_OPTIONS): Invalid argument (22)"
7: B1 Line exceeds max length (144>80): "bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for Phone Book Access: setsockopt(L2CAP_OPTIONS): Invalid argument (22)"
8: B1 Line exceeds max length (140>80): "bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for File Transfer: setsockopt(L2CAP_OPTIONS): Invalid argument (22)"
9: B1 Line exceeds max length (138>80): "bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for Object Push: setsockopt(L2CAP_OPTIONS): Invalid argument (22)"



---
Regards,
Linux Bluetooth

--===============2935253699520115538==--
