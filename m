Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9B4C61DD8
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Nov 2020 18:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCAD2225B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Nov 2020 18:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwWOeIuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgKOSwG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Nov 2020 13:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbgKOSwF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Nov 2020 13:52:05 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B633C0613D1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2020 10:52:04 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id z17so7576493qvy.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2020 10:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=qANCNAa5hduUVxxUCfC55XjHg+Nxxb/pXNB9rX2OoV8=;
        b=YwWOeIuPJ0jjkYWFCm9x+cOHfhc3BmPWnHyEsgZpa2RwnCkJsXq2mCvjzFkf0IL9ej
         nVPSQSCVzmr07sKqzXrQIfw8D+ojNL195cHwzFprELoKvhb0hx2mhwW8NndW3aCJZrhs
         E4TXg9iR8XETzwouZ64SqH5Gq7Lvvmgiby8PQCeKpJw7C8ukErjK4w5ayj9ZMJ8e1fbH
         IC6F52DqUap4p403K+AYLA4VV+qLKrUsMzy1/W7qevMZWoAqU5+2CZ+1lZTe6g1ZWBge
         cruOST0qbb7GT9cbmV7xshzcW2kJssvAdop/dgJust7QPk1TCTTXbZaVvswfgvKojjNP
         h4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=qANCNAa5hduUVxxUCfC55XjHg+Nxxb/pXNB9rX2OoV8=;
        b=aVRYicyc+uvOEnms9MQGSNVlWj3DlVyBcFEHT0rquv/iFCGfO8E5YcnLnG5vU73kQ2
         sbqrFHbhzMZsQuEL5+Rv3S0NcW9F5fHpCcG48+XDgUWfLmPR//ktLGgPkMJDtlVyUGdc
         2wXk8s81AOm8RncjHQMWHb3ecySDCA4NTln8QtHkdm7lOy1FnEXR4Ip/8GHa+f9leU66
         i2bLPWn1ZwA1KKs/5yggyFR/UmlBrT6pUPiz3GSSnhxkhE4MqkohXh3a6pRpokIOngFd
         HBHvoLpv7b+NCgzi8DulFIgh24QPRnCuDufOirueB1y0mamB13Ur3O+vICa9xY+LO/AU
         V2Ow==
X-Gm-Message-State: AOAM533HRAJGuw8ovrY8PZh6iM48Y6DDDxVRRSB+IjBPAhoQ0eBrlkga
        MoNW+h4VADdwCWyeQ24G6U45709spdrseA==
X-Google-Smtp-Source: ABdhPJw+hOTMiIheZ3MVjhX+oyiLTh1SB+ITaZO2rqdsvyBAqQ0h1Y8hiZNdy7GzjQKjAMxfE91Xyg==
X-Received: by 2002:a0c:9799:: with SMTP id l25mr11643667qvd.27.1605466323683;
        Sun, 15 Nov 2020 10:52:03 -0800 (PST)
Received: from [172.17.0.2] ([52.179.191.134])
        by smtp.gmail.com with ESMTPSA id t205sm749943qke.35.2020.11.15.10.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 10:52:03 -0800 (PST)
Message-ID: <5fb178d3.1c69fb81.b79a1.4046@mx.google.com>
Date:   Sun, 15 Nov 2020 10:52:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4574616635553820706=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [v10,1/5] Bluetooth: Interleave with allowlist scan
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201112120532.v10.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
References: <20201112120532.v10.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4574616635553820706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=382415

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
workflow: Add workflow files for ci
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#18: 
new file mode 100644

ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] workflow: Add workflow files for ci" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

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


--===============4574616635553820706==--
