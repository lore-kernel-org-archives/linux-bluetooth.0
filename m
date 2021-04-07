Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B8AC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 09:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B8761262
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 09:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349903AbhDGJE5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Apr 2021 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349897AbhDGJE4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Apr 2021 05:04:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D670C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Apr 2021 02:04:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d5-20020a17090a2a45b029014d934553c4so210547pjg.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Apr 2021 02:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5th8LTi2fy8irgGa3QsWlsphZ7l2c1WrSWLXzTfQ1qw=;
        b=UvDDFZLl5MvIjQ+blL3MPoKwX4YByn/YSsHy0UPEtpF8tgnifSgf2YNNk0VBU4g/XF
         zJLBaEyP517EYFAIGYTK8XdOs+iqoZB3rLKPID+81qla7bg3mcSdezQFZvRztsIA2m3m
         RPGCzzL9cgOMOKBqGPYaM+U6HLqSYuOgyXhZtySgA4hkHn9JEa28mLsT6AC/darbM8EH
         8xqFTo69KuBZ/g6lafoiU3clinUrvbZgBsN4BOcb42yUe+gi/+GsKVADxOHWJOru0gMi
         aGyBqMpD+HoJFv/gUWufCAmugL5xXgvDhT4epy671vev2Yt21VAtfPckUjIHeCyf4LqF
         HPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5th8LTi2fy8irgGa3QsWlsphZ7l2c1WrSWLXzTfQ1qw=;
        b=T94Q4KlevnvXhJcm4v0G2AE5XcjHuAF2y2UsSuf3lf0AoSBe9EpLHrWsTyztg2ggR0
         eU6QgYsBZMZgxQXLvv8cRtuGVAJGQ0qAjpiTYXj6swP+J+SEeGJFVLtNi8ug/o8fFtwN
         dlmNzd0Fg6YTn8lUDwU5qR6LB+KfU3DToPbia/nMUbP5UPNRq0FAKB9eV4K9XHeM5654
         7GWqR+10USTQyugfVQUPIHR2c/SYX3tqx2gNTYQuuWZRw849LbLVMzmsOsmrHhuWdYD0
         K62LwJCxe/O/qgG2lh9l8xgRVPAx2l42EwCRM+HUhKUjnISODbU/LKbgtURgECoyKFjq
         Qytg==
X-Gm-Message-State: AOAM530EElcHjdzBD2PIv7rZsiE9BwdJVc6ssJVmSNhs7rfCn+/8qigr
        zCL7isIfuAMgRPQ138Fx2FSKq1DEo8g=
X-Google-Smtp-Source: ABdhPJzOCM4o+pj2/N9j6w3bcNgc2+lDxRn94PmLRIbEE9LnfaQ6Ksv7HITCP+gXu7nZaJ5hjb+R+Q==
X-Received: by 2002:a17:90b:1946:: with SMTP id nk6mr592341pjb.61.1617786286608;
        Wed, 07 Apr 2021 02:04:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.247.25])
        by smtp.gmail.com with ESMTPSA id m1sm4840869pjf.8.2021.04.07.02.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 02:04:46 -0700 (PDT)
Message-ID: <606d75ae.1c69fb81.f7dce.d147@mx.google.com>
Date:   Wed, 07 Apr 2021 02:04:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6545603418162058892=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v2] input/hog: support multiple variable length notification
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210407163723.Bluez.v2.1.I4ff127dde9bc6adb2a07507af2bf2cc6b6bcf0f2@changeid>
References: <20210407163723.Bluez.v2.1.I4ff127dde9bc6adb2a07507af2bf2cc6b6bcf0f2@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6545603418162058892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=462197

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild: Setup ELL - PASS

##############################
Test: CheckBuild: Setup - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS

##############################
Test: CheckBuild w/external ell - PASS



---
Regards,
Linux Bluetooth


--===============6545603418162058892==--
