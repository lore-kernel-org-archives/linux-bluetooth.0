Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B32C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 01:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6702722EBD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 01:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbhAGBmC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 20:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAGBmB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 20:42:01 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92353C0612EF
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jan 2021 17:41:21 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id o6so4642407iob.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Jan 2021 17:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=U3F7C+l4/du+0vE/RTe/j4iEU2qcB1WgyDddbnOJZgc=;
        b=WOzTeRw0dU0wkqhCq1aetVv0GuFvvrecgj3XeDUd/Eg8Ds6uUIEFEUrgkWzpW6DrDW
         hYxgMJqi5L0AOREGYPOqpUaexWPqv7xaHGg56IE8/HMBIKiEFUuZa2CtQ3x6L/7H+PA5
         Ocb4hXVNqtIsSWX3EpYX0DUtGe8R0V4Jw6NjS8tob3lF3iRlJCsiY4E1mG9TrpN8kyFP
         HAm2wg7ARrmBze20FtPemOlkOjBQyCcMtgLdv3ph3QfdshD8CYnWZHOo0cvU18uQlSrq
         jqn9BpQe0LpMouyYXfqF9gLytB22RkDieYlv4JdPzlJ+y0xhkrVaCZCxhYnMLMBAIOJq
         Y2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=U3F7C+l4/du+0vE/RTe/j4iEU2qcB1WgyDddbnOJZgc=;
        b=N0EtCxV994r2OBCIwGnR7Xc2piJVvh2hQ8wppEr96qIl1JgCM8s9hJ6elb+Ue2Pmxv
         FKPkvE4XyjjRq1kGUlEH/XbBnlRmUd9yGI3VexoI0rlGQ8N1cKsX67IJGAqXQkjN8Cm3
         pNrKjD5l/81+dCh71rfaho6YmkhBO0XRUmq0EU6lk0bKyKnZaKNQUVKci9db213llOzJ
         Txqe0OdPUKe8OWpcVuuVh4dL3ac844jV+mpuis4BpRcUPQbKFpsCXZ1AOu/iOYkN5g+I
         EFuztZ5C+kyigrh13YzFKRaKQyAFiCaWr0DC1+OvnIyRs5oyzedH7MtGyr7E5Djtq7SG
         yh1Q==
X-Gm-Message-State: AOAM531Sd0fR1bacCE/0I4KvDtj5BWgRNwvVyC8mFC14MVWXSv4McTIj
        zo6GTitMa+7kr9Zu7F7ke4e5moNTJs0=
X-Google-Smtp-Source: ABdhPJz+Gnlt7aZMuBgfPUPC/aus425np3yWd6hHwl8aJpYQpWjTOlIa9cELLI6Uf5F6q6VMOvbZ+Q==
X-Received: by 2002:a6b:c414:: with SMTP id y20mr5027426ioa.150.1609983680759;
        Wed, 06 Jan 2021 17:41:20 -0800 (PST)
Received: from [172.17.0.2] ([52.247.67.112])
        by smtp.gmail.com with ESMTPSA id f10sm3192149ilq.64.2021.01.06.17.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 17:41:20 -0800 (PST)
Message-ID: <5ff666c0.1c69fb81.1ffe7.dfd6@mx.google.com>
Date:   Wed, 06 Jan 2021 17:41:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8476649585952154857=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/gatt-server: Fix not accepting multiple requests
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210107010631.3806496-1-luiz.dentz@gmail.com>
References: <20210107010631.3806496-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8476649585952154857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=410277

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
shared/gatt-server: Fix not accepting multiple requests
WARNING:TYPO_SPELLING: 'oustanding' may be misspelled - perhaps 'outstanding'?
#8: 
if there is already an oustanding request.

- total: 0 errors, 1 warnings, 126 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] shared/gatt-server: Fix not accepting multiple requests" has style problems, please review.

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


--===============8476649585952154857==--
