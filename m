Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2083EC56202
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Nov 2020 05:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D232021741
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Nov 2020 05:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHAJEab8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbgKZFFd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Nov 2020 00:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387728AbgKZFFd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Nov 2020 00:05:33 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F20BC0613D4
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 21:05:31 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id b144so602317qkc.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 21:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=klCsZeXYANQSsAQq31VwilFAQz/pHwQnM7OucL+ODfc=;
        b=UHAJEab8LzewcalqWMsnL7NiQjlMa1Aej74MohQi1RlY2gIctmYSNebKb6VDCOojX4
         xzKIYD16C67tfb9/2C/71/R/KMcaqeWfzQ6Jeu9y21ZerLrJOPaT5vMzZ0xcw5v8Ujj9
         1pb1BsOe00XWQRZS7d5m3bjhFP9PWFARtzeIQvRDb35X5e1elHuBGsDxXwscUzEs8AsF
         dHGbWGfPV8TUymK/9PkWSUCo6iiv3qzOXc69AnllPYA40I0XGi5lCVi2tZivO2PGy7h/
         x6e2txjVryAtfcVcSmEvi3/qLhIj9iUWW45n9+raJhSGdgZ4WllKjTzxLQbMSc0b/suD
         bzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=klCsZeXYANQSsAQq31VwilFAQz/pHwQnM7OucL+ODfc=;
        b=l26PTNLOB6aV1EsX0V9zId7qiciWHD2LGqrsZpuEzbU6cyagwVcx4gk0Txvs8nL6pQ
         Y9PWl1fVgsePPbjFkSOhht9/8bwk2+icM6ovddcfr4yz1qWMGvcysZjjgGC1vnJgnt1G
         8nV0wuTQMOJnRxRIEtuCkXhGoYr2lLmY9TEqPQNOP348TGrmRupQPjia+YrxdxGPpXS3
         42QJaQppaSaXT7putjvsdnwen1kx06uCk1qJJYA7Ubzj0P/wkdiKwjYNIC4NtRM6juz1
         pfrOCWGXJoMeZCtEi3J5Nznh3/Z1Ky8EcfrMeMHcL3FVpfgmSy7bYbYzUwp1ddlIuf4s
         OblA==
X-Gm-Message-State: AOAM5328IYDXBXYIX1QB7FHIHDdB8mbdaNBbMI7/IDsT3kF0vJPFOC70
        6TjlvumdcfAOLnUUlhj558ZAVm024wnGKQ==
X-Google-Smtp-Source: ABdhPJwHO7FC9bsLLa5I1aIGpbcHRCX5KBZNImrK7h8+f+toNrsPaJ6PDbO4urvFreLNq4jSFckUdA==
X-Received: by 2002:a37:a4c3:: with SMTP id n186mr1502866qke.495.1606367130765;
        Wed, 25 Nov 2020 21:05:30 -0800 (PST)
Received: from [172.17.0.2] ([52.179.180.48])
        by smtp.gmail.com with ESMTPSA id z30sm1718139qtc.15.2020.11.25.21.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 21:05:30 -0800 (PST)
Message-ID: <5fbf379a.1c69fb81.93ee3.79bc@mx.google.com>
Date:   Wed, 25 Nov 2020 21:05:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7339228795111071932=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [v11,1/5] Bluetooth: Interleave with allowlist scan
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201126122109.v11.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
References: <20201126122109.v11.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7339228795111071932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=391285

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
Bluetooth: Refactor read default sys config for various types
CHECK: Macro argument '_param_name_' may be better as '(_param_name_)' to avoid precedence issues
#35: FILE: net/bluetooth/mgmt_config.c:20:
+#define TLV_SET_U16(_param_code_, _param_name_) \
+	{ \
+		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
+		cpu_to_le16(hdev->_param_name_) \
+	}

CHECK: Macro argument '_param_name_' may be better as '(_param_name_)' to avoid precedence issues
#41: FILE: net/bluetooth/mgmt_config.c:26:
+#define TLV_SET_U16_JIFFIES_TO_MSECS(_param_code_, _param_name_) \
+	{ \
+		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
+		cpu_to_le16(jiffies_to_msecs(hdev->_param_name_)) \
+	}

total: 0 errors, 0 warnings, 2 checks, 156 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Bluetooth: Refactor read default sys config for various types" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Bluetooth: Add toggle to switch off interleave scan
CHECK: Macro argument '_param_name_' may be better as '(_param_name_)' to avoid precedence issues
#70: FILE: net/bluetooth/mgmt_config.c:32:
+#define TLV_SET_U8(_param_code_, _param_name_) \
+	{ \
+		{ cpu_to_le16(_param_code_), sizeof(__u8) }, \
+		hdev->_param_name_ \
+	}

total: 0 errors, 0 warnings, 1 checks, 118 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Bluetooth: Add toggle to switch off interleave scan" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============7339228795111071932==--
