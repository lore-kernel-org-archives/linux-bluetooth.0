Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C78EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 03:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D290464F9D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 03:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhBFDiM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhBFDfu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Feb 2021 22:35:50 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796D7C061756
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Feb 2021 19:35:09 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id ew18so4509218qvb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Feb 2021 19:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wOW7UOkgas2pV13DeUNWwrj64/jNa4nhibE69PjnEIU=;
        b=ahRIJxNXsQ5bjiqWbLJbVZblQBxVnnHlkBCGjdgzuJ65D9WAOHdfOdOopTD5If7hYx
         8MCQvQkQLDCHtgd7PxKpv+skgeZYHp1v1R7fsTVHR90nnpw4mfLvy1Jmjjh6IxCseZwk
         kDmTlJmmUWLd9qZtteIkwYn44b8ZAINctaR4lBk2Ice039FvNDILmVEfY7zfnju/vtds
         ru3sZps/LRUKVxqU41xjAKGEzhltKzV8C6fW6ZUtdz/ZybdDo94vkuPMdlBjoKhRIatO
         ZSLWFBblQxymcqjUvBJh7TvZ/T9WnmrY3F9FANYafDguS3la2rXcBD9PofcYrP132ckt
         JGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wOW7UOkgas2pV13DeUNWwrj64/jNa4nhibE69PjnEIU=;
        b=U5w+cN8nHonEcEwGnLSUfGXWQXOP4d8VsRb4mRBMqtqbIKXyFi6gJ1/grU8hkdjgZt
         CA1rI3Ew1pDAflKmWraRfwvZcKryWY0EBCG55nuiE45AEQ5rv0HML4E28e829GmR/NIP
         Jkd4WCLguYPWA5vAZjvnZs0/T3lXW392akOZ1ub572fMiyMDYgv6x1arvQ/H1gwte40C
         N9fQMRBpGRVzDhtI0R4wvswzs/r1LXTHxCZb3fhbE/XJoOqsBldTRoVyr3sz3k/1gOYG
         tXfPzVdretbGTtr7AYtnmHmpXt1EtlTyH6XciswqQAJ7Wf8M3Mvau8WQ5RhMIXBjk8cg
         BC0A==
X-Gm-Message-State: AOAM532ng63dIYaJux+Ne4+UmFttHVZPGm8ISNBuyjA+VdE6E7a2RTXx
        A/Lgtpw6PL/PhrFkerHIXkI/QSYC5z1fRw==
X-Google-Smtp-Source: ABdhPJy44fdBbSsUc2km6sbjdtC/SSl6rosOCqjFzHt9YfvfbT3sUcsc+2hRUU462KvmCYi4YX1yGQ==
X-Received: by 2002:a05:6214:913:: with SMTP id dj19mr7652374qvb.33.1612582508569;
        Fri, 05 Feb 2021 19:35:08 -0800 (PST)
Received: from [172.17.0.2] ([20.36.190.40])
        by smtp.gmail.com with ESMTPSA id q50sm10991081qtb.32.2021.02.05.19.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 19:35:08 -0800 (PST)
Message-ID: <601e0e6c.1c69fb81.1552f.d6ea@mx.google.com>
Date:   Fri, 05 Feb 2021 19:35:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5108635999125702817=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Framework for non-interactive mesh test
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210206013140.390219-2-inga.stotland@intel.com>
References: <20210206013140.390219-2-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5108635999125702817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=429145

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
shared/tester: Create ell-based version of tester code
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#166: FILE: src/shared/tester-ell.c:118:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#171: FILE: src/shared/tester-ell.c:123:
+} __attribute__((packed));

ERROR:INITIALISED_STATIC: do not initialise statics to false
#816: FILE: src/shared/tester-ell.c:768:
+	static bool terminated = false;

- total: 1 errors, 2 warnings, 913 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] shared/tester: Create ell-based version of tester code" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

mesh: Add unit test IO
WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#126: FILE: mesh/mesh-io-unit.c:1:
+/*

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#674: FILE: mesh/mesh-io-unit.h:1:
+/*

- total: 0 errors, 2 warnings, 686 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] mesh: Add unit test IO" has style problems, please review.

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


--===============5108635999125702817==--
