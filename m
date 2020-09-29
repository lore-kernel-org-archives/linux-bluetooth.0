Return-Path: <SRS0=RRj3=DG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BA2C47423
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 12:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69F920789
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 12:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpd8obrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgI2Mac (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Sep 2020 08:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbgI2LaU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Sep 2020 07:30:20 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB824C0613DF
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 04:30:20 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g72so3885854qke.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 04:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vC9R9wv5B72aKfh7NSgM/as8tM2aaUytUPZyyP8VuRE=;
        b=kpd8obrjO6i0R4/ID5jGIhYt6Nfy+5AMgPxpuf9A915nOhPiQlpCVGsoQ3Cdz9z/hU
         wIED1U+X0oZAatMEEoCydm6GHX4xPucxnbL9xYlDt2lPjjmzy/BuLnDEXMXLO3gN9HHa
         ks7cMeOWD7bYDydZhjB+U5uLfk/lCfYEMCpiJFj+HYSSfiYYToKO7kwiqMpj3LwMU3F7
         R3RkxQ3Iq/UMjbVi5jFHk/Lcxt2ba8KPcTemomd7tFUTLAOY/m6ZxqfJXjS3CfTHKtYV
         U29IF4RMrLSsZVP0eKxN8xf13kupmGmvUwD3a2hqZq4lbj7gqm/KpLdblcP4v/LtX1yE
         dvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vC9R9wv5B72aKfh7NSgM/as8tM2aaUytUPZyyP8VuRE=;
        b=ejd8B4TwrO4zWh4zse2Gh8Z9uuVxiARyMv5nM6uUAvXOD0v5Tt/kBlFgZ/Q3J8JYga
         LsW0WEH3XAS0KyjAH2BBxb/FHGkCnoV/fTe1wGLzs5AfVY4QTiFSGJpcKviypyyZdRJd
         PfShmIoELIlOwzKYAnsXoIEA9DgO18jokmWbDSq7YRyhC6Pzq71+l8kfWTDbR0sHrIsD
         UYuscZ/XkjQVWaIP7KLmNR041QbfrYsWgBooqHDLU08Ynsi9S972vsycK3Bn4vt+Gv0C
         jHtc7lXlHzxm+qyPV8AKVcaTZByipnSbo3AoKm0VFWWI+1w8pyhB17hm+GBPKrwWakeO
         FhTA==
X-Gm-Message-State: AOAM5326OS7F8ynVyXDzJYVGmAZjUru8JyXWerHP8DXZdz4q5UufF92k
        B1H07qdNsTFRsNirTJt35IKLdNsEBqLB5A==
X-Google-Smtp-Source: ABdhPJxh12Nc9rxkiPs2zdgp6h7+rhvbTvHVHEhVhO1DDfPLJKoOv7PZh3mbpNVQa8oaMsvP/PMavw==
X-Received: by 2002:a37:54a:: with SMTP id 71mr3499171qkf.407.1601379019758;
        Tue, 29 Sep 2020 04:30:19 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.233.117])
        by smtp.gmail.com with ESMTPSA id l19sm5251361qtu.16.2020.09.29.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 04:30:19 -0700 (PDT)
Message-ID: <5f731acb.1c69fb81.24cd5.3502@mx.google.com>
Date:   Tue, 29 Sep 2020 04:30:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3393406711640374454=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [BlueZ,v5,1/3] core: Add params to set interleaving durations
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200929185522.BlueZ.v5.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
References: <20200929185522.BlueZ.v5.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3393406711640374454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=357041

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
core: Add param to disable interleave scan
WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.le_multi_adv_rotation_interval'
#133: FILE: src/main.c:379:
+		  sizeof(main_opts.default_params.
+						le_multi_adv_rotation_interval),

WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.advmon_allowlist_scan_duration'
#214: FILE: src/main.c:460:
+		  sizeof(main_opts.default_params.
+						advmon_allowlist_scan_duration),

WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.enable_advmon_interleave_scan'
#225: FILE: src/main.c:471:
+		  sizeof(main_opts.default_params.
+						enable_advmon_interleave_scan),

- total: 0 errors, 3 warnings, 233 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

doc: Add definition of advmon related parameters
WARNING:TYPO_SPELLING: 'advertisment' may be misspelled - perhaps 'advertisement'?
#6: 
This adds definition of the newly added parameters for advertisment

- total: 0 errors, 1 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

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


--===============3393406711640374454==--
