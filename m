Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDECC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 19:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B42E206D8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 19:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz+4UeTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgKITrW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 14:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgKITrW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 14:47:22 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8B6C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2020 11:47:21 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id e5so2971724qvs.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2020 11:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ea08/43/IZTMCsvqtrON3uOsex08EXUptVByx33VTfw=;
        b=mz+4UeTMPquVcl/FDvA00LuUu0cSb+fXfx50fO7dFIffMwAi/klomMQSAocx7h7tSv
         91yzlKtN6GiJ7SiF80EG0h/4mc+MB5WD7YwTXdvZDQUJqzDmOeuPgDjJ6fJUT1yAsPRE
         nhUQLHtIDF3CVaTBmo+BlioVGBDsNnwMm6WPE9wiMWMvG8qjqVBW4IgEqkNU3u6+ra/v
         Z5ya8lxNYx+duv1EF2+BjE+3OEnHXZ+pmdX7lhZFXIwxWkXiiZpHKH5wzpWaYhjGeWsp
         6k7cb26Wy2KABYxrobedakL0ARSCJLEHrUnm4HfiHnxPUHMJE3AgkOx/ZCviskvRemtN
         YoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ea08/43/IZTMCsvqtrON3uOsex08EXUptVByx33VTfw=;
        b=BjVh/mDENyweP2mBSCT3vi8u6WAkMoJ1/PRZMdCeH5ixe3QHzIGjwF0kbX5Yk0roRt
         St+Un9VbHdRvy10bkVqiE3ZytOHn3mZ6DdKlcBjhuQLdx6Z9eGnoXjeyahzFZmX6qu0N
         3Y+9tKqsZRzAemkLgPB0CFEVzTwFnaBkmLbwreB9M71wMoLeFYzosBVSQwMGyUhtFUOm
         /Ltyb3CSTAmN46wShNUELr2jPMBwVUDN6+/VqFWVmNnnzM7fPdbG8RV9qL23il8dzV1U
         wLYLAE+I4eh0daX9jHT8hFpSwCfr7sku3+V7nt1MA0ycK/iCc+GMWaOaeb8lqmkttDQC
         sgwQ==
X-Gm-Message-State: AOAM533krwBK0GvQOGgEguAkyMnPGr/HXaQnyr4dPpIUn+sj3aoa+U8/
        8HhhXX6J3rV5EcPmtZErU0h8O+EzeMfjbA==
X-Google-Smtp-Source: ABdhPJx8WTPJviUtf49juNr9B1mKUrfbsBFfQ44/UZdRJau9qxIlfUJzCLjPZDYt5btCZQY5ZnMPdw==
X-Received: by 2002:a0c:8143:: with SMTP id 61mr15765944qvc.6.1604951240799;
        Mon, 09 Nov 2020 11:47:20 -0800 (PST)
Received: from [172.17.0.2] ([52.167.139.168])
        by smtp.gmail.com with ESMTPSA id z6sm6213144qti.88.2020.11.09.11.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 11:47:20 -0800 (PST)
Message-ID: <5fa99cc8.1c69fb81.73e40.7565@mx.google.com>
Date:   Mon, 09 Nov 2020 11:47:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6952117095522571081=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] client: Remove reference to g_steal_pointer()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201109192742.42207-1-inga.stotland@intel.com>
References: <20201109192742.42207-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6952117095522571081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=380609

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


--===============6952117095522571081==--
