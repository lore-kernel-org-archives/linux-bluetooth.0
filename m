Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BD2C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 16:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1775F2220B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 16:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZB0DJUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgKQQqC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKQQqC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 11:46:02 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDF6C0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 08:46:00 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id n132so21039061qke.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 08:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=AuhXdB7pXLpSx8ACoMN3G2yhp7GLDAfsd7zaDCfPZeM=;
        b=VZB0DJUzGZxGtBzoJXS5m/fh8BbdIbOsFMRruCYEKx3l1hlbR+YZtasS6a6dsdiBLj
         Du3H/y5XeGDwuEcYmB1oMFdqeHC3Cf//5uOZZsfQAQSw7cfIo4gRALWS3fmJaqzgyOgq
         x1Qxq7ieX3X04KYl+Eu27aB/Vx59VWA2XLZXBuPqYGfOkusMT3fQOnnOIR/mP2C//rWh
         I1qUWeXkmT6vKutnP2lqRd6u4rQTJ/Lik0VORexAHiXN6e7RlNRldmgLXb02F53d4sZZ
         0vgyF2B227PBIlGT6I+aw7fWNoE0u4u/emf8nf614Eh9x91gyrpbo1tAYnyM4Er0gskY
         WsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=AuhXdB7pXLpSx8ACoMN3G2yhp7GLDAfsd7zaDCfPZeM=;
        b=PsWYQcqHCKYz5xpfbaszx66koSsN4oeBKF5YjhM+32dS8sxfN908ipXNsrfkm5M+PO
         WsnrdlB2sAKhoyKmmP6HSws4TzrTPmFPeldpHuVhd0R9FwsAprmeBUTSZMQTEPwrJwG8
         3eBnZKxhi2s6ByDZTV3FwCtn/Ax35ANNbGVPX5fxH2ngub57CeAsbOQaspr9WUPo8bfQ
         UDNlh2HmdP989lSriNw5+AIMSKr4GciIGADf7Lp4eKUeHrMK9jPJqwRDgFq3EO9ZC6RD
         PtIcOMaYK3eUV1YwJ4hRY0g3xEAz08cTaRqqTG10R0KsCG/BbG5DWl7jh3HN75YOfiLL
         V1aQ==
X-Gm-Message-State: AOAM530i9KZ5eL/rB1uGMRUw1vMMvlCz5+pXPZv/geZP/7uAMQzucFYO
        XKVFVZDVv+KoRN8uGi8LWzxCz3FhyYVKuQ==
X-Google-Smtp-Source: ABdhPJxuySD3ib8sodZRwX/CUw0RglGNENf1Hat1KTnZSXHpHzYQIbgnLF5r9UTddWfJT1OqsPOu1w==
X-Received: by 2002:ae9:ef94:: with SMTP id d142mr409485qkg.69.1605631559752;
        Tue, 17 Nov 2020 08:45:59 -0800 (PST)
Received: from [172.17.0.2] ([52.177.17.156])
        by smtp.gmail.com with ESMTPSA id z133sm10530151qka.20.2020.11.17.08.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:45:58 -0800 (PST)
Message-ID: <5fb3fe46.1c69fb81.baefe.4e47@mx.google.com>
Date:   Tue, 17 Nov 2020 08:45:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8170250664278181770=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, szymon.janc@codecoup.pl
Subject: RE: device: Update cache only if content changed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201117155703.30268-1-szymon.janc@codecoup.pl>
References: <20201117155703.30268-1-szymon.janc@codecoup.pl>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8170250664278181770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=386087

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


--===============8170250664278181770==--
