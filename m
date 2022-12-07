Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46C5C352A1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Dec 2022 02:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLGClh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Dec 2022 21:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiLGClg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Dec 2022 21:41:36 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DED4C27E
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 18:41:35 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c15so15291307qtw.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Dec 2022 18:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FVjcrNIjz0i1Y2+HJAAZorkTQdVpycCfq4j3rNmyEFQ=;
        b=I6cd7Tpz2GdJDM7szD54e8YjWO335U+tyg22pUtKrmPz8r4MiwfR+Us8ke3rrHv2Nx
         KrBAQ3Za0I/0YcKTflbj2j6/CYMF+b923Tpj7Zz4z9+nk2wEdV5GdSBDtSWJ/V9N+TCZ
         kD2Ikjb3zrOvF0IctBgRyt5x2K/tES93Iw4eKaKw5Jec4RHzfpOn7YBw7Q+mtytbyAkQ
         0udIddU63V5UaS/BNRSHFNNvxd8jLBgYgQE5Cw6nUrOj+lN4QKP59NOsLvdLbrXtW5VZ
         XYs++USB5WyGqxGgCKfvQuTSyI4b1Y2TDQYrrXpnaDF8rT2BKCKAQMBiPFRlQX08LNn+
         rF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVjcrNIjz0i1Y2+HJAAZorkTQdVpycCfq4j3rNmyEFQ=;
        b=uac5D7WDg10G5cmEII9oA8/0/B2wntmeLu/ircsggOmKpFgyBcn4t6kr/FrZI3vIN8
         DWmoVhGf6oETeUrwtabEFcqFMK9ag/kCl2XLRq5IgKMVoqYDOCNd/l1IItYIZpF/9QwE
         MZ8WB6owQMRbig+44/uX4VihgIUo6HtN2KgHFaKPlMKb5O4QzQdAsZgZIpxHQZLfScu9
         MOz468McSyGo59CpmL8fcaGWnUig2obTRx3/ArhnN8oJsLFcLaCBmAMklOg1QQ4WYmS+
         PWjG1fTwSJ8HfiTuuaPBj/r+2XdH5aC7NfKnM7E/YwOwloeg8Hc8a2AzHRNIGA/gu/yV
         1zhQ==
X-Gm-Message-State: ANoB5pnSg07xIrgYH8SNNtuL7E9Ue/X0ZD6D3+WoJohW6mDz4Mf0zsmI
        zLU8Gpb1P3/9nn5rfbmgsGKVozmzk53wiQ==
X-Google-Smtp-Source: AA0mqf7Vnr2tSHndUoIgeMUavMD4va3Ug+XcxMX5kYE44SPIsapou8Yw6ySacb0aHOiHfmn8k187qw==
X-Received: by 2002:ac8:4415:0:b0:3a6:a81b:c971 with SMTP id j21-20020ac84415000000b003a6a81bc971mr13507483qtn.437.1670380894454;
        Tue, 06 Dec 2022 18:41:34 -0800 (PST)
Received: from [172.17.0.2] ([20.230.76.182])
        by smtp.gmail.com with ESMTPSA id d7-20020ac86687000000b0038d9555b580sm12489168qtp.44.2022.12.06.18.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 18:41:34 -0800 (PST)
Message-ID: <638ffd5e.c80a0220.3539f.494c@mx.google.com>
Date:   Tue, 06 Dec 2022 18:41:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0432056408193350042=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yangyingliang@huawei.com
Subject: RE: Bluetooth: don't call kfree_skb() under spin_lock_irqsave()
In-Reply-To: <20221207021835.3012559-2-yangyingliang@huawei.com>
References: <20221207021835.3012559-2-yangyingliang@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0432056408193350042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=702385

---Test result---

Test Summary:
CheckPatch                    PASS      3.86 seconds
GitLint                       PASS      2.04 seconds
SubjectPrefix                 PASS      0.73 seconds
BuildKernel                   PASS      33.83 seconds
BuildKernel32                 PASS      29.74 seconds
TestRunnerSetup               PASS      419.28 seconds
TestRunner_l2cap-tester       PASS      15.69 seconds
TestRunner_iso-tester         PASS      15.34 seconds
TestRunner_bnep-tester        PASS      5.32 seconds
TestRunner_mgmt-tester        PASS      103.24 seconds
TestRunner_rfcomm-tester      PASS      9.19 seconds
TestRunner_sco-tester         PASS      8.62 seconds
TestRunner_ioctl-tester       PASS      9.78 seconds
TestRunner_mesh-tester        PASS      6.68 seconds
TestRunner_smp-tester         PASS      8.49 seconds
TestRunner_userchan-tester    PASS      5.56 seconds
IncrementalBuild              PASS      59.18 seconds



---
Regards,
Linux Bluetooth


--===============0432056408193350042==--
