Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25ABC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 00:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiGUAEp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 20:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiGUAEm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 20:04:42 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557AE7479D
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 17:04:41 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id l3so224701qkl.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 17:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IIByV8n4wPbDtDnHr7BxGZ/0ikn5M91ZaGvBmMDippw=;
        b=cikGhDZ49DSMtPJpuMMKJjIhighuyOCYZhW11cIAAbbMPaXahOqr3vdoPTURpy0UTB
         O6fEa9vFCcv9a+/rg4nPdwQgG5p5M3K6FdzLBI72UmP05HN6hkaLHfOtsSInyOvabJj9
         rvGkb5pnBP3vP2i1bNcE/NtDE2kLc5ZF0PWtAvEh2hSi97lYERQXxMERYzbrsZBM54q8
         9cx1uWgm/s3UYbMjT3OCCrZ3CbAiRcCzLHnUWW/S+R07UEeFIgOpqja/reN5Q9/jbWqH
         Jmd+D1Nf9sEvqX6eEA66jilScZbnc3nOIJv0d7qKGBkaROBUNlEdeeLRZQlwoy2GVVV6
         Gmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IIByV8n4wPbDtDnHr7BxGZ/0ikn5M91ZaGvBmMDippw=;
        b=c/QCjYAfDxh4RD3xG5Mw+usu0mrCWQJZIaQEBsl4Dabz1A4IaoXiMi/drZAea0qn1Y
         qctH7wpllja2+Qjbr2t4hsKsffggfmlHmJmb3eLIbYQZWmJZZwAhB+KU1mwIShPex7Fb
         sPYYHGlNZ3cfKuTkPY6coQlEhv+dRP82URf1Ak5BaoeIKJbnMLtrzm+qtFZqt0iElwYN
         ZkOT8sG/d/uy6ybbqrZ5IrwUjUvnbG5P1eTnVio0Gnl7YTWdeXmAdRNOA4LC8Mk67TdP
         0ANDDIxnWqStFON0jvw9cdk2erg4eUNofvS0fyZsQ63fjiZTyPmT3ljhAdm0l992aWGV
         U5Cw==
X-Gm-Message-State: AJIora/TNS4glLQoujKKmafvAIFqev84hIZImtUf/GyehtGO0C/gZea6
        stYQmIUzZFkgkZM4o4YqbXFDTtoL//o=
X-Google-Smtp-Source: AGRyM1v7euDqNE+dqDvouczhjBPwHcpi6I/tipUJaKU7sRDDiEY2pTYBIANGqewnrkBVgKUkgmV7Cw==
X-Received: by 2002:a05:620a:bcd:b0:6ab:84b8:25ee with SMTP id s13-20020a05620a0bcd00b006ab84b825eemr26674535qki.512.1658361880136;
        Wed, 20 Jul 2022 17:04:40 -0700 (PDT)
Received: from [172.17.0.2] ([137.116.62.102])
        by smtp.gmail.com with ESMTPSA id n14-20020a05622a040e00b0031b18d29864sm374031qtx.64.2022.07.20.17.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 17:04:39 -0700 (PDT)
Message-ID: <62d89817.1c69fb81.d0e83.12df@mx.google.com>
Date:   Wed, 20 Jul 2022 17:04:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5905963913447098414=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: Fix get clock info
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220720163548.kernel.v1.1.I4058a198aa4979ee74a219fe6e315fad1184d78d@changeid>
References: <20220720163548.kernel.v1.1.I4058a198aa4979ee74a219fe6e315fad1184d78d@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5905963913447098414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=661636

---Test result---

Test Summary:
CheckPatch                    PASS      1.88 seconds
GitLint                       PASS      1.06 seconds
SubjectPrefix                 PASS      0.90 seconds
BuildKernel                   PASS      35.95 seconds
BuildKernel32                 PASS      30.80 seconds
Incremental Build with patchesPASS      42.99 seconds
TestRunner: Setup             PASS      517.95 seconds
TestRunner: l2cap-tester      PASS      17.38 seconds
TestRunner: bnep-tester       PASS      6.03 seconds
TestRunner: mgmt-tester       PASS      98.29 seconds
TestRunner: rfcomm-tester     PASS      9.52 seconds
TestRunner: sco-tester        PASS      9.18 seconds
TestRunner: smp-tester        PASS      9.26 seconds
TestRunner: userchan-tester   PASS      6.15 seconds



---
Regards,
Linux Bluetooth


--===============5905963913447098414==--
