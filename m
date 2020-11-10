Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAFAC388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 10:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7297E2076E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 10:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3PCx6+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgKJKpW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 05:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJKpV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 05:45:21 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E78CC0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 02:45:21 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id l12so8751925ilo.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 02:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=c3PdZyTjF6Xek0n394im/ObyYMpuvSIdb7a0vx3bgjE=;
        b=a3PCx6+t0zLcd3zXOVGE2+L5oxPo5rZ19VK3mT2/SuQ3HVtVL5acQkxoU0yTvorkK0
         C8tPao3Ev7L8jQdc8zyewBNsAuohSX9kcHowdGLfdIgfe09f03tnTI+Ye/mph6KZg6j8
         jQu9TCwZi2EKLz+LMkrhp8JEfuEyi1KM7g7FJOVtwuN8U7benzIPxkeJyrzIJuzcpa7Q
         vcfsDsZ9m9YHNWUZZlGrU43gdD1mclMWqX8EYrWGZzZg9mwSJRXbHEgkO2FUdMpx51NM
         LBxxoB17FCE8ZFqnA7YKPFc6PQFp3aA13IIdU/ZBHcSfLe3cPbaqBk/yn8Vmo4/N+vGs
         6ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=c3PdZyTjF6Xek0n394im/ObyYMpuvSIdb7a0vx3bgjE=;
        b=rFwXoZguYb5t8aBks1vqZUObqds4zrgDZOMYhEuuR7rF818Iietcbj/dXt2EhVGhA+
         ZNOSY1+LXqVNMNdN+a08aV24+jLj2sL4xTiBH7nHi0ixAY9+zsBgKHyzqT9rGCNblRou
         +nK2Xz0xRxld5+zmXTbIXrmTb/wgQNnIEs+xyQnAlso1FTVa+TFzjyKRdNrEcNHxdl0K
         wLoryqiOO2iMzie4/RszLH96APgjECC8vCI6CfaX7gdZ6XNAXKHoUJG2R4BXTIZQMtzU
         fTOHYwKnnmhH895BjAIIzhMqzJ0rk2q1XAIxyk39junXR19SRKyohjShND2PMaUB6IxU
         +vUQ==
X-Gm-Message-State: AOAM530rEtqHiXeeOspDW5m1hinjTZttpT4f/CPKb2zmP4yldb/p1U9h
        6GN2JVhHZqdpiJtSuGYPupUm15pK8/g=
X-Google-Smtp-Source: ABdhPJx8coi9dlQdUo5mvQ5eM8I0QEqd29rX/07bbex0Ubs4mzYcqSZbJmqoQKbkc2M4SvYkuL7wmg==
X-Received: by 2002:a92:8b09:: with SMTP id i9mr12818817ild.149.1605005120531;
        Tue, 10 Nov 2020 02:45:20 -0800 (PST)
Received: from [172.17.0.2] ([40.75.80.61])
        by smtp.gmail.com with ESMTPSA id o23sm7394411iob.47.2020.11.10.02.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 02:45:20 -0800 (PST)
Message-ID: <5faa6f40.1c69fb81.88c6c.bcf2@mx.google.com>
Date:   Tue, 10 Nov 2020 02:45:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4484991332816827264=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [v8,1/6] Bluetooth: Replace BT_DBG with bt_dev_dbg in HCI request
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201110181740.v8.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
References: <20201110181740.v8.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4484991332816827264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=381075

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


--===============4484991332816827264==--
