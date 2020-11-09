Return-Path: <SRS0=/O/j=EP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01842C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 08:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4642206ED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 08:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQy3PJAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgKIIxE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 03:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgKIIxE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 03:53:04 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C229C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2020 00:53:02 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id z2so7549708ilh.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2020 00:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6NCkNkAm219ROrfEzjaYu0vIltHfvqCnM/dF35QF2dY=;
        b=hQy3PJAE9KHDqF/kyZZ5e9WEoTJ7rHO3pGn+jp4EqR7/P36QvyzdTUapyI53OBYb4S
         x/K1Z/OSFie4gBZof6udz8tQqNvKjmoHpCBXvGjmOEcNbRq7fnS2S95qawX1H66uKR5f
         fqWRj3Y6Z31IJVoavYdlTMZaB4atqefV4Pkt2fHwm2J/Kx7sPuvxZUX3bQHIKvzi3fLs
         CUpnTQiutO6cgYxPfuASLEdnzKg5J+YjP9EKeXmGDcexTUAuuWYAgBli8DtGdJAeHhLF
         iss1Ivv3BLyKefYtk1Y6o0jcU9V3p0ONgqJ2eucVSTz7bc3DizYiUWIxfFhbvGq6UCOH
         VKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6NCkNkAm219ROrfEzjaYu0vIltHfvqCnM/dF35QF2dY=;
        b=L/AJrO9a0hcsaaOwm91NX3SW9yrzmzqyUtBSuewA/2rcAe6z1LYtx4YLb6LbQGGuYD
         N6/3wpDqfSCPKcJb8FY7sVnfu6C5vpCtjqOQaTyM2BKDdQYtGAF8V2nybchsUBDJrIZt
         bqx8VB4XZj2DwUZI4deAvpuNz4FVmdez4RYJS8iA4qdtpZDVaSlERlPpg0YDMT2M1mc2
         ZaZxGzOND6BrkkUKr/4+thvv+g9YFxUbjVJUG2eBX1CW5PFi5yZ6I2QIyYxVxrlb1sYF
         lniu3V0u/ZG0a7aI2fAS5GeT96Fpy++aH/QN4xqMvPdVbEnS3UPQc9ykb8O4wtmCvlmQ
         6cEw==
X-Gm-Message-State: AOAM532wUKkRGBvVkSt/uMFcGc66UpzLkTYwiGNpE/QdmEMqMiaAYeAt
        ywOjwWsE7ZCqVGST2SSW8uxe56p1daQ=
X-Google-Smtp-Source: ABdhPJx3RSZtQqHqxc6/qUMt6dlHqDn7+txLIVBpIru/BOEfAn35pbwLj8Tz5+2jz/PEivj3VBAx0g==
X-Received: by 2002:a92:290b:: with SMTP id l11mr9821907ilg.46.1604911981774;
        Mon, 09 Nov 2020 00:53:01 -0800 (PST)
Received: from [172.17.0.2] ([52.251.52.179])
        by smtp.gmail.com with ESMTPSA id v85sm6764923ilk.50.2020.11.09.00.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 00:53:01 -0800 (PST)
Message-ID: <5fa9036d.1c69fb81.256bf.8415@mx.google.com>
Date:   Mon, 09 Nov 2020 00:53:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4406876077463626839=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [v7,1/5] Bluetooth: Interleave with allowlist scan
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201109155659.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
References: <20201109155659.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4406876077463626839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=380067

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
mgmt: Add supports of variable length parameter in mgmt_config
CHECK: Macro argument '_param_name_' may be better as '(_param_name_)' to avoid precedence issues
#35: FILE: net/bluetooth/mgmt_config.c:20:
+#define TLV_SET_U16(_param_code_, _param_name_) \
+	{ \
+		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
+		  cpu_to_le16(hdev->_param_name_) \
+	}

CHECK: Macro argument '_param_name_' may be better as '(_param_name_)' to avoid precedence issues
#41: FILE: net/bluetooth/mgmt_config.c:26:
+#define TLV_SET_U16_JIFFIES_TO_MSECS(_param_code_, _param_name_) \
+	{ \
+		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
+		  cpu_to_le16(jiffies_to_msecs(hdev->_param_name_)) \
+	}

total: 0 errors, 0 warnings, 2 checks, 156 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] mgmt: Add supports of variable length parameter in" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Bluetooth: Add toggle to switch off interleave scan
CHECK: Macro argument '_param_name_' may be better as '(_param_name_)' to avoid precedence issues
#70: FILE: net/bluetooth/mgmt_config.c:32:
+#define TLV_SET_U8(_param_code_, _param_name_) \
+	{ \
+		{ cpu_to_le16(_param_code_), sizeof(__u8) }, \
+		  hdev->_param_name_ \
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


--===============4406876077463626839==--
