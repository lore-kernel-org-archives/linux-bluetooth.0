Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFD6C433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Mar 2021 11:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD456500D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Mar 2021 11:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhCLLJU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbhCLLJN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Mar 2021 06:09:13 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1B9C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Mar 2021 03:09:12 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id g14so4034912qvn.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Mar 2021 03:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MsrEWAT/UataKIpFPjoI6ClTE8mEUtZqt2Vs//QBgH4=;
        b=k/3chtBq2rrnnNgbHWSWPP0T5VSmSMnn27kx4RbPV2lOhWbI4+vy1kxucdOE761RdX
         nPMXsPtu8hWiH/tczjViz2t3l/fD1MQJx+hD5P5rXWRzd/u9o4uSxRas/KCHxB280Wf1
         byQyBlaFUloU+hugCTkVT0YpMo69YsCeMzZMfarvz7RuR9Dg3ulQIS/D34iElrJ0xYfH
         ElGbUf5E7lNZTZ/miuHwotHTVd/ybtLPmw1IAA7nMyG9ubAHJVPQLTyq6PvA25cIjuT8
         ms6d+AX3O4HUfKYQdKEbmHIitwovNl8lH25bjW2i4ojZmNU/1eTRpqd4VVfvBNKtmFrT
         x1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MsrEWAT/UataKIpFPjoI6ClTE8mEUtZqt2Vs//QBgH4=;
        b=FVkbzEvMc+Kj2n2Jb9cPMMCcUcDHYJveSnysgOcOeV87R0G+g6JDPrcuuZfr4oooLk
         Rk3basSybE3TdF44OXBElh5hERDAJhlh6+7cw+WdOXiaAxUUPzllyHSdcoxK7oAp9eyq
         tIegrNzIiyg2JJj0/lP+8eJzeavvTcSCJgj7lUjfbDMbH3UxLq2QGPte4hJLqNZxg2su
         TCcuNXDuVq6A7b4ulVEsvd2E8O/aiYEkIEq6DPP/8qN5S8wbG+Xdmg1rrsFpTK+sfaBG
         cBnuIYRCgOBa6OrpOxnqRoj+HDAKTIQw7/R0QfqUCIbq2UVKWBAm1ofNFnFzHrZuhFjC
         homQ==
X-Gm-Message-State: AOAM532A4WCJVpQa7lxv+TEY6R7zDyYvT0yREI9LnVOHy2rqPcpuYPCg
        QyOr1Upd6GZAgsG72VbNfpzSue0PHtajjQ==
X-Google-Smtp-Source: ABdhPJxTGCdWsvUaGeM3/A5ETQR88TosoktkGOBs2S6sTsx+2z2bHDtu5F3KR2uTy7eXVEpGCXEHhQ==
X-Received: by 2002:a05:6214:cad:: with SMTP id s13mr11700011qvs.53.1615547351810;
        Fri, 12 Mar 2021 03:09:11 -0800 (PST)
Received: from [172.17.0.2] ([40.84.60.120])
        by smtp.gmail.com with ESMTPSA id n35sm3585468qte.19.2021.03.12.03.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:09:11 -0800 (PST)
Message-ID: <604b4bd7.1c69fb81.6db40.644e@mx.google.com>
Date:   Fri, 12 Mar 2021 03:09:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2905342490921016206=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] adapter: Fix discovery trigger for 0 second delay
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210312105206.22534-1-frederic.danis@collabora.com>
References: <20210312105206.22534-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2905342490921016206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=446939

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
adapter: Fix discovery trigger for 0 second delay
WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#20: FILE: src/adapter.c:1801:
+		adapter->discovery_idle_timeout = g_idle_add(start_discovery_timeout,

- total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] adapter: Fix discovery trigger for 0 second delay" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============2905342490921016206==--
