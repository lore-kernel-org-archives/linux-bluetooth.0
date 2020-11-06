Return-Path: <SRS0=OtJ6=EM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A03C388F2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 09:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C9820B80
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 09:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3+/8sTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgKFJtp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Nov 2020 04:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgKFJto (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Nov 2020 04:49:44 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5AEC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2020 01:49:44 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id k1so541542ilc.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2020 01:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=LpwrchydlQV2fCCnSRVtV9uvMREweeooIoa8Iz9Bd+A=;
        b=b3+/8sTNdzxNia25fBN0ym272DjqD7zEphUdIYOFpYXejOdk277988fJ1wzUoF92TX
         dre0DDCG7Bix4ac5dhOef99gz44/8Tl0aZ2XYLiEafJkrmuEQy8y9WIR3xPiZX/dhypW
         hXA2C3NzGqPTY904VdRaEtYB5kg+eCsueGYLC1oiuizih1Zmeo4xCwDyjtcOa9lLh/lb
         MxN4qTPQ2ao5hI6atND/KgBgQiMrVliWv7Pg3//9jPvDn2JVgyS3weXDNoD/LyegMrr1
         c5bBj3jTMm6Ej5T6VQp1iHdo+VZXN6r5Zb8/GTQOUYny12IlHYARLBtQqenGRPhHNr7x
         wXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=LpwrchydlQV2fCCnSRVtV9uvMREweeooIoa8Iz9Bd+A=;
        b=MfeTmLMd33XFG9tlntueRapDvxZLlngU6reyW58FcjQM+Z08gFmkv3Bssvhg4sMlB1
         VHiui27Vm/M+WZOTAUW9+U/U8ywr74jy8WFOZV8JZbkfqLNbUY0hAr0QQI4KYCPKYS7g
         RxiSjX86hZPfb4DmfihnYapErlcutXvkjKDVnJ8G86yC1oyR96dGfoLEUncrCJnRl8cP
         J0iwkmfX62YpkPfUFmQ2hb5SYS/mjO2YG6htHYZ4rSTxL3XV8QnmkndhFYj+GV/c/YvZ
         d9vgsAJWjSRNs0In7KTdK5NOdM+gswQ6R5acIm8N/O65Q4zjdIbzLtAovDg+nylKedSC
         lTEw==
X-Gm-Message-State: AOAM531vmi0n3EUYJblnpGI3ln46YIix93O/bWzCicDsx4q/OOFX1RPi
        k9qk+JZiwlyGBo50KkXZoT0A+FIm1gQ=
X-Google-Smtp-Source: ABdhPJyNVNujTYLZszvZ/nQuOBuq1NvtSThSgdkw+UaW1uV/eZULhTFtAN/kG28WyB29zU9KrMJnsg==
X-Received: by 2002:a92:5f1a:: with SMTP id t26mr852044ilb.0.1604656183967;
        Fri, 06 Nov 2020 01:49:43 -0800 (PST)
Received: from [172.17.0.2] ([40.79.16.30])
        by smtp.gmail.com with ESMTPSA id f8sm527191ioc.24.2020.11.06.01.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 01:49:43 -0800 (PST)
Message-ID: <5fa51c37.1c69fb81.44934.1e7d@mx.google.com>
Date:   Fri, 06 Nov 2020 01:49:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8899448384011661364=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: Bluetooth: btintel parse TLV structure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201106092024.20430-1-sathish.narasimman@intel.com>
References: <20201106092024.20430-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8899448384011661364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=378871

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============8899448384011661364==--
