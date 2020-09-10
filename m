Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40033C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC5012076C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKw2n8xK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgIJEr7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgIJEru (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:47:50 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B8C061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:47:48 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o5so4801806qke.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/PI89umKW0pAnG0notwsHzZB9en2DbzgnAf0XUhw6Gk=;
        b=LKw2n8xKEL89vN/79eSapuaGBiniRJsRbEQMmZZa5d50mcTGt9vyD8Gdvp6Fq8FV6B
         3fO9HZLg3YWIXvuMHI2gyJdlmryrzFzCgpSgk8RvrQQj/rqRPT3owAfb3uFVlFwgCr/w
         LPYqefaO4/8Cpr1WO1irrtYthgfhRVwZByR7ljDFNZujovu7uGWFjHKAdkTcf/8JZ3Y4
         JkYNks++q+XSCYrSAdw8FXryH+JbNdsqjP+AwCLuzhhKZPfTwezIuhQyXoX5GuyfiaGI
         DXp095FoSCqu3Wom3a+iAAx0o5YnwKHwnQV5u4YbKN7slUXHuXDyhbbs2sNHxfcN5cdh
         UPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/PI89umKW0pAnG0notwsHzZB9en2DbzgnAf0XUhw6Gk=;
        b=gstoPdUtxN2oni9AR+R4fq7dpK5YgmND18XdphpjsU3ByJkRCNrGEeANobso/G1wx+
         JYkvkeGZiJ7nyQz3UW3HsWyw1WSjBJLrbphy4EQGKV++T6iiv/v8hLMFnF3w7SD06CfS
         dSWVBq9+EURdZTJZjeMh9IHNFFcqvd7lagggA4J9uOCiDw78XJJLnWx6GefbrGWCx7zI
         A5QGubqhVFlPpy1B7AbXP5Te+hrKPHVRA8jY/GhE7/+7YjYW1O7KxhqmojkgUObCUVvz
         YQDE0y+eN0FxX6S6CDZjwZ7pCp6I3QP5GNMkctTbqKPhb3gGI4v5eOs126hkofFKTEuF
         u5Jw==
X-Gm-Message-State: AOAM5335DRUhEMlkC+a18qG7OVLuIhh9m+4ZXYc5YrRBQ9fwjA9/0pbA
        pHg87Edu2FbxLCOmdvrWkGSc88YAAmnH7g==
X-Google-Smtp-Source: ABdhPJwKLoZwq9LMiKh0xMwKvERnUmZBAruUa8fi/xVL7IRxq8DE5ttzcXiC5TIvdsg06K1wK0hOTw==
X-Received: by 2002:a37:a781:: with SMTP id q123mr6491715qke.436.1599713267903;
        Wed, 09 Sep 2020 21:47:47 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.25.207])
        by smtp.gmail.com with ESMTPSA id u55sm6146212qtu.42.2020.09.09.21.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 21:47:47 -0700 (PDT)
Message-ID: <5f59aff3.1c69fb81.6cc41.f176@mx.google.com>
Date:   Wed, 09 Sep 2020 21:47:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1697491141037719967=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v2,1/7] PRE-UPSTREAM: adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1 interface
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200909213423.BlueZ.v2.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200909213423.BlueZ.v2.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1697491141037719967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#99: FILE: src/adv_monitor.c:1:
+/*

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#253: FILE: src/adv_monitor.h:1:
+/*

- total: 0 errors, 2 warnings, 236 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============1697491141037719967==--
