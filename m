Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E743C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 10:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiKVKrU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 05:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiKVKqx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 05:46:53 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6D342F6A
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 02:44:44 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id q9so14008481pfg.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 02:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3F5qZ9YyI3eYaV1FFM9JsxLecrCY1aqBRJlKPPcwvfk=;
        b=Je9gAWmUHyspmSw72Oyu05d+jC45THAroL/hNYUCZQ2A7YRrMwNfFew5ICUnWF5PCn
         QPywHPyj8A8tr78nyxICKLg89kpf72k5vu9P18aNKNdyTj1H0h3UaZ8IQyyTx4tc+dBb
         gKES9SkyUgpdggL8yWm48yjrv7kU3lVlNJjs+RBSNWs+xcUBaUtd+mugcvCOMlkbzbM3
         iCcwrPUabh5MaDAwXQnAE0tjHHGnmSU0EIgB3t7mHQEtEac3GOAIChuH98jJWQPbGz39
         /IlP/GjBExv2H55i8nzZleT1pMTctaPlAggMGr60jpdAeqteg8HWQQF1aaCENdjmtdc/
         lfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3F5qZ9YyI3eYaV1FFM9JsxLecrCY1aqBRJlKPPcwvfk=;
        b=UP1dUTq2Gp5sWFH9bp1+QtLUHMMvQ4AY1Yt/awZoGj69auJrVz6ruM0wIefXtAHFSC
         9/Fzv2B85yrJ7c/+hA9gW57B4uwrF88iDsvkBFGHu51oTp2R+AVs1toLdgEM6+Ux3aJo
         fH0PHX0pdWW0Sz/xSYp7VTQ6CF+9zdZdid5WUcWSjm8bN2Qrzbtf2vt3wmoAc4QPMkLK
         6i8ZIYUEJEE2zNEm0yB5dhy20Ja98pvFpZzs6G2IUYynBIZ4WZJ7FPom6788HLzijEG7
         apQZAES9yxowDi6n6AgN4QWKWFz4Nu9GKZ1lNQZPRounaEaLvzFzWHt0qeHMc2DPLfya
         Bhiw==
X-Gm-Message-State: ANoB5pl6+IZB52QZVdYUC4C5YmkpPKTt5I5oZnfB7DyZ6J3Hbi4RL6LK
        SkKmI2EnT4nvuLPdGH5dcl/3ogOwyuU=
X-Google-Smtp-Source: AA0mqf4SmUvhfELsbPhOPyOVzU7nBsn0Qf356Yk8BH2trtkizhUyWKPNj3UNyycH90Pjutun/kNcgA==
X-Received: by 2002:a63:cd52:0:b0:42a:9ba8:8c6b with SMTP id a18-20020a63cd52000000b0042a9ba88c6bmr21780347pgj.407.1669113883490;
        Tue, 22 Nov 2022 02:44:43 -0800 (PST)
Received: from [172.17.0.2] ([20.253.180.235])
        by smtp.gmail.com with ESMTPSA id p22-20020a17090adf9600b0020b2082e0acsm9322181pjv.0.2022.11.22.02.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:44:43 -0800 (PST)
Message-ID: <637ca81b.170a0220.f5153.d2e8@mx.google.com>
Date:   Tue, 22 Nov 2022 02:44:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0940747198713985333=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2,1/2] Bluetooth: Add hci_nxp to hci_uart module to support NXP BT chipsets
In-Reply-To: <1669112583-29804-1-git-send-email-neeraj.sanjaykale@nxp.com>
References: <1669112583-29804-1-git-send-email-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0940747198713985333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: tools/btattach.c: does not exist in index
error: tools/hciattach.h: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0940747198713985333==--
