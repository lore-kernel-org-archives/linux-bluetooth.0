Return-Path: <SRS0=3clX=DM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCF7C4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Oct 2020 04:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3782080C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Oct 2020 04:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V55MA0z7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgJEEl0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Oct 2020 00:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgJEEl0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Oct 2020 00:41:26 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E5EC0613CE
        for <linux-bluetooth@vger.kernel.org>; Sun,  4 Oct 2020 21:41:25 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id ef16so5349495qvb.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Oct 2020 21:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vk3qLwcGDmr42iqdisLkvWF3x8lBolY8TWpfQcfJedw=;
        b=V55MA0z7yiW5BuFUyxSl8+JB34hufc68HHKFPJWzwZ9Iyrfyxol+0gAUqYe73rWvT8
         vswFagZR8eWN1ZDvF3jqKXCSQRAGF27R70wMmP14uv6XIuK8qQpIYNLOs4NKaqvZqfIB
         Rf0pjSbov8evQCmGXv9xeK9A2HyLrtuAgVtFeFoUTCdrrYBnqBtcL8eeBTA1Uxq+EbWv
         WJJ4q1JDxU6gugOB2AxWNaGAvuUWqlxh7yVQLFdLYeALyp4I45Mx94q3dvnNtKSKHBxa
         BmGHnDuMMJg3Ltaqc7GjS1q1NNUj+Wwz5P0uXfBUC7LaQm4Bf0NDu1Wd93rGY14jQhYj
         EZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vk3qLwcGDmr42iqdisLkvWF3x8lBolY8TWpfQcfJedw=;
        b=VADiJJ9Ljq9Z8M39+p0wS60jgBtOeJVLKhhJD9Tb1rQaFDQwn60XDqXPE/XcwzpT4m
         OM71NWzX8EfzpUree53FHlZEZytYgACmvm0vigf8KJcOk9/yGTnaFGsxSJVw5YHnVZ/O
         7plaIyZXuqYMuPxOpU1IOoR3DkgxW/wVXNMqF9ZFSRZTpuJni40elTv9ba7fPcrSH1DS
         hU1r6jiipo1fH2bDXBSs/mmu2UEOvksnzCelDXlc1o4iz0dOoRtgtQVKqBkH9Ks8+sT8
         uGvaq6Elzuq8MzakfX6RzGJNDkrzP/o+VblIV6WOuM7uEdPtyAjoNcDhyvVpyYoruWlp
         abQQ==
X-Gm-Message-State: AOAM530neA4lZQFEV7sQ5eJyhUh9BrraVuvZmDb/ogDgdcj7zMLWOHok
        Mi384jB0MaQtyB5lY+un0XkXHufea4hKzw==
X-Google-Smtp-Source: ABdhPJyUzrTe6Qy/s29ZZQFm9zhOhcbCbit2TFG8N2M2TI1Lk8YhQyAp074DMdRhoB7inR8KR/JX+Q==
X-Received: by 2002:a0c:8c4c:: with SMTP id o12mr4613180qvb.46.1601872884942;
        Sun, 04 Oct 2020 21:41:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.48.60])
        by smtp.gmail.com with ESMTPSA id t2sm5496847qte.47.2020.10.04.21.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 21:41:24 -0700 (PDT)
Message-ID: <5f7aa3f4.1c69fb81.a103d.1f5d@mx.google.com>
Date:   Sun, 04 Oct 2020 21:41:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3296642710578557391=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] shared/timeout-ell: Fix timeout wrapper implementation
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201005041932.99783-1-inga.stotland@intel.com>
References: <20201005041932.99783-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3296642710578557391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=359581

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


--===============3296642710578557391==--
