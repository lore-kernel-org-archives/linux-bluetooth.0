Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26888C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 21:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E036664E42
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 21:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBPVdD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Feb 2021 16:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBPVdB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Feb 2021 16:33:01 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC221C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Feb 2021 13:32:20 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z32so8123773qtd.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Feb 2021 13:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7Eu7ds/5EesMXMRtNb4qBtKn68VHM59Nb0XGD546nos=;
        b=LUldQarw5uqh2+EbNTzy/+tbCQWCyX0hhoK1Lij7qsYWi5SJrc56U6638rFP7Bs1t5
         eWfTM8hkDd6lcY65YLJOgBaJRIe9Dt5DDJzhic6vGnRiQDNQiLFy7xZBvozMXfLveTLo
         3OkagSru5p1jQMn+rZ4AHa90cqaw40QYnAhgRxLg2K/H05sR6Unjjepau7GURIQu9/+g
         jm7Ma69NKPI9q/fZlAiXDUZFT1xdkjvPSPgY195X8+wbAcEBPCqcMZUOzw3tvoIyO3yN
         isfmFGsfGtG3ORr+mMEIkSGES2l6yJigcGubgj9IutMO/1Rh5yyb/L4WLG6RpUDARPz6
         8vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7Eu7ds/5EesMXMRtNb4qBtKn68VHM59Nb0XGD546nos=;
        b=rbAQdzeX+UCV7V/rCRSwfLnUZYJT9xRApCk2oadHoqywdAdtvTeA9U/shi1sQVGRUC
         jqvQ695zDi6/7h/UNg07DYwqTAw4F2KQwugLBUZvFaH+84boN6Y2isOZtH2ZDA92aljj
         UY3cf50/8hJt4A9o713AmOjgOZnYkKWG67vdc55lXQbsHes3yK0UPguCgovNqDZCCQ81
         1xgcDpyxv47hJPd6qhybAIBVQu4ifBSi+dnQ79p2lGQ+nchWELkbw2iw0g2IkGaX8V1n
         mSFxTinSbdgAOADEKJeom5xQ7ReMOr3aV32VLVwrY+lWjTg0UZJTDKk57kL9fNlrZwoS
         1m5w==
X-Gm-Message-State: AOAM531PQE7foB1g6k4nExHqGGUY1VGbsmuUsTX3aDbLjtL/jh4B6C8M
        aAa735M2ilIZkElLrrXlzhprLUOPlU8R0A==
X-Google-Smtp-Source: ABdhPJwGQdWI1uM6W4lxWXT8vF9C6owOkbgj7yEIDI0AT+0jpjMu5xt8mg5LdH+fFKoE6eMPzGI/3Q==
X-Received: by 2002:a05:622a:93:: with SMTP id o19mr20922827qtw.336.1613511139914;
        Tue, 16 Feb 2021 13:32:19 -0800 (PST)
Received: from [172.17.0.2] ([20.44.102.58])
        by smtp.gmail.com with ESMTPSA id r67sm132136qkd.93.2021.02.16.13.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 13:32:19 -0800 (PST)
Message-ID: <602c39e3.1c69fb81.bbed9.0db5@mx.google.com>
Date:   Tue, 16 Feb 2021 13:32:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2569186235234792471=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: Combine common functions for NetKeys and AppKeys
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210216205256.15300-1-inga.stotland@intel.com>
References: <20210216205256.15300-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2569186235234792471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=434249

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
mesh: Combine common functions for NetKeys and AppKeys
WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUSR | S_IWUSR' are not preferred. Consider using octal permissions '0600'.
#52: FILE: mesh/keyring.c:58:
+		return open(fname, flags, S_IRUSR | S_IWUSR);

- total: 0 errors, 1 warnings, 183 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] mesh: Combine common functions for NetKeys and AppKeys" has style problems, please review.

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


--===============2569186235234792471==--
