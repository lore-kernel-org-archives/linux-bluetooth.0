Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF718C43464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 01:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7A42075B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 01:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp8YSCvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIRBdf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 21:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgIRBde (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 21:33:34 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6887C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 18:33:34 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id w12so4469427qki.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 18:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=d3H/e4nwFw4hpR6f9BWrd5+zgTfYJV7A4FUJzsEtRDo=;
        b=Mp8YSCvmq/iHGXYd+hckY27AirWyGmHQfa2Lsd0ScqarGQk5BnGvvjxOB/WATWG0OI
         fjgIFx0ZVJlemAiThfKsrdADQZup+fJ7T+heKrgkaJSlFmoRyVl4SzOUr+9/UPaV9XY/
         pEmVAJtigDSXRO30WTVoJwNgwMZC+7lF0cQHjmyH+RB+V5es836+Qw6Z91T5tzp8NnWk
         KLzbhozwTgU5NQSXnaJ+CYdDHuh8AXoSOx8e0bzTPWMH4Li5y+UEeLE9LIr7TQXsKbRv
         kBJq6Ff0kAZemV/U2rqEs4oZ5gWXbiRLqDsmgu/BeLBPoAcq6d/qX8e7Q4YcRoP0/uIZ
         tLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=d3H/e4nwFw4hpR6f9BWrd5+zgTfYJV7A4FUJzsEtRDo=;
        b=bMqc0Ff4TnlfsrDzwPRURyEepBwYHmCaqMST2yQO7yyJja1rH2ig+5qaIN58v41rrF
         a+1JLppfwI6TngMdthcykyn3+dIDEblgPdxa15msoIlkBFGuK0FCrI5SMbEbYM1Mw/AK
         mW844AEMq+m6onCAOTSYJpt85HSt4cbfR99npGF4IdfAiXEkBILBihs29KK8U/s3FLWC
         yjBjKoowujKqulFMPz45EJnNTGlDvEoyKTwdhlmCisT/7Uz0/3yCn94np/h2W7QXuB6W
         i7Uk57MZj7ZOGIonG04FTIl6xI6ZUEYduv4A/nb+9bi5JGuu1DUoI8EVOPuu7Uf6Y/KG
         VU0w==
X-Gm-Message-State: AOAM532pbRZB+S0K/CAYGZhF+FetwGJV1gscH+AQ8rRNXQo0N+rBcKFe
        g/2qyuNdmEIXrT73zNFR8mAInTS6kSesEA==
X-Google-Smtp-Source: ABdhPJzBpCE9NMEm2wQ71SG/s3mLQ0u7jUeCgTcbn8KzOFHj1bsALzogFS61nIq0i2hTupQ7/R3P7A==
X-Received: by 2002:a37:674d:: with SMTP id b74mr32079193qkc.189.1600392813550;
        Thu, 17 Sep 2020 18:33:33 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.79.178])
        by smtp.gmail.com with ESMTPSA id p205sm1099486qke.2.2020.09.17.18.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 18:33:33 -0700 (PDT)
Message-ID: <5f640e6d.1c69fb81.2be96.793d@mx.google.com>
Date:   Thu, 17 Sep 2020 18:33:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3255440781536906701=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] avdtp: Fix not checking if stream is already set as pending open
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200918011042.3141447-1-luiz.dentz@gmail.com>
References: <20200918011042.3141447-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3255440781536906701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:TYPO_SPELLING: 'reseting' may be misspelled - perhaps 'resetting'?
#9: 
reseting resulting in another setup and yet another timer leaving the

- total: 0 errors, 1 warnings, 24 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============3255440781536906701==--
