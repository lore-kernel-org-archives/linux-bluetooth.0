Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2F5C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 21:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EAB64DA3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 21:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBZVcu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 16:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhBZVcn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 16:32:43 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CC7C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 13:32:02 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id w6so7701645qti.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 13:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RVVJMXI17ZEHB2p4G0ymEQXucPjvMjDngJN0eo6ZUfQ=;
        b=a1LfUR9KHgEL8Cn3j9MWOoKaF4IhBeo6fLyHl12rFw2d9+kKPzl4uDvQqaeHdFxHnk
         +TAJYlBp/CwNy5g8am79L2VocWwBTVUjVahZsLp/oqRov4sRmdEgU8rTnBziOHrNoJPn
         8dDKtdCesD8cqOM88FgseN61Ws/cne1bBMxnr3JUS9bI8CXvI/ouoGRkFfG982lIyN9e
         0hdO+f6NQwuWfFWSj0k2QdB7rAmlxmzUL3Pws6P1ql7nFQCenvP0wK8FpBncS3tqhY8p
         iLv7oQ2mEE6z3jZYE5d7IQt2xynTNNSwRX6vqas3L8YRtElouRcBGapp72ILHfEAxa82
         ToAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RVVJMXI17ZEHB2p4G0ymEQXucPjvMjDngJN0eo6ZUfQ=;
        b=gnsqpylVOpdrLN/484YRYN+dA0cJIS0hU5HN7goHE+GGZq/CfYWF+/M0WDq3n5gemZ
         5Lfg7++DGtuZ0MPCfklp1dLHPEsIaxNk+Jh6Lfs9920B7QRczhdjlmIWArFxKidB3l6U
         AFvO0FwjYMtq2M2XlFr9hGs/W7Jayz75E20dLN0ZQK4lFfkHnGDYz4ReZIQH1JVpidMP
         ysgD3bo8PkgHcnzGSC5MEOeU2fE+RCkspG2uesqIsu2gWhqoGXrdc2ZSus0UPFgpkr00
         xjmXMSyj78cYmQrdXzZe1K5762AYFt6yeU+XqjtHJoncXeD2wtj63VlWMv+dGWihCenh
         ZXUw==
X-Gm-Message-State: AOAM530AlSmZjothKNfJ33LuOETI5CTi6LI1afpk8dDHzG8HvmsiBMDt
        s/HcSpE00L9lUywpT6xrPS/xbk1QYx9sIw==
X-Google-Smtp-Source: ABdhPJx/M/kvFcwOcXvA+UuN9W5g6SsYYh3X9czK0NP0Iylr3LZxtpWrrroCKr0lKRRm00AXa/Yn4A==
X-Received: by 2002:ac8:7514:: with SMTP id u20mr4491781qtq.66.1614375121910;
        Fri, 26 Feb 2021 13:32:01 -0800 (PST)
Received: from [172.17.0.2] ([20.57.120.149])
        by smtp.gmail.com with ESMTPSA id m30sm5490290qtd.30.2021.02.26.13.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 13:32:01 -0800 (PST)
Message-ID: <603968d1.1c69fb81.f4cb8.33b8@mx.google.com>
Date:   Fri, 26 Feb 2021 13:32:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3084821196163398287=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v3] monitor: Add option to set fallback width
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210226205232.6844-1-sonnysasaka@chromium.org>
References: <20210226205232.6844-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3084821196163398287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=439199

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
monitor: Add option to set fallback width
WARNING:FUNCTION_ARGUMENTS: function definition argument 'int' should also have an identifier name
#95: FILE: monitor/display.h:78:
+void open_pager(int);

- total: 0 errors, 1 warnings, 107 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] monitor: Add option to set fallback width" has style problems, please review.

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


--===============3084821196163398287==--
