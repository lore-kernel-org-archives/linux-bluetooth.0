Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A0CC388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 22:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21BAA20714
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 22:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX2gwlh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbgJ1WgM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387836AbgJ1WgK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 18:36:10 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA23C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 15:36:09 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y20so1252186iod.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 15:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ghMDdqAxSTDpq/QP4IDwwTfOr/08c6QjApp9ts1mvGk=;
        b=EX2gwlh8n0+8mnHBMqCN9Ayx5FUleWdQ76NU51X7aXAqFAUJOzy7mejIAmg36/5Ag7
         DgTgRcG+PwU19r/4fEB7+lTpwEsu2Dffp1h2IG+lDJdcFRn8nL7q/wQGZz8P5WPhV7KI
         P4zqC+SGa5P8hsWVxn8wgz9mtjoGs2yeziffYfN3QHQMJK2jhzbim15RpcQpyT8IEvjp
         11J6CTPSNZ5jSeiqbLJY6g91ubpNnQkwu3rBmSOsZU9ifKvCQRLp4hCG76+Qr9glA1TD
         mySh8hA26pqa+qUYPPzrbp5EovvPjInDxWWmrYfUMQMspSKaCA/ArGVo3C9gU5EiEQWy
         54Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ghMDdqAxSTDpq/QP4IDwwTfOr/08c6QjApp9ts1mvGk=;
        b=aamWI03zR6S77HpARyCvjteMwS0hMS4rY4BLRnaPz+C6Fltjez+KSfBZFTd2J1vRwc
         udu5dBJrlGTIx4RQ8PMf5zVNO9rpo7aHcK4V6ItlirrrqkjhLr6f7D0elX+rWDgw64o5
         cBmEVrsToIQ4f79lFEvcpXx/dU5pFch3PBfQKhJuE2p7h5RHLnfNfO/YXYCeIEEw8l3/
         CqHyJ+jQQXhXoJuznqsV43NdCth0a4Wy7oaNQ80edGQ4cIXoH+/wkj7UT0CqPsJC0Vic
         Fjb5T2byNEtlxsg74R2wMozzkehHc30oTBMszEBOaoirK3HM/aHYIt/fAaQZdr0TcXq7
         ruUg==
X-Gm-Message-State: AOAM530ao0HDe71oPiTX01kpkB2e27ZoDkknmL8tirP+YEprHNAvfX8n
        CoVAvamiV66hp2sKS/eTlGb/Cqt7+4c=
X-Google-Smtp-Source: ABdhPJznwME+poZvsCFAVkR7Ot4G750QmmDcK83Ms0+liz17vWmVnEyT/LfiE/aKFebPuqlTWU7ACg==
X-Received: by 2002:a5d:8b4c:: with SMTP id c12mr1274984iot.167.1603924569131;
        Wed, 28 Oct 2020 15:36:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.147.166.226])
        by smtp.gmail.com with ESMTPSA id c82sm760332ilf.53.2020.10.28.15.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 15:36:08 -0700 (PDT)
Message-ID: <5f99f258.1c69fb81.87b73.4097@mx.google.com>
Date:   Wed, 28 Oct 2020 15:36:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7609171610043988638=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] mgmt: Add support of mgmt TLV API
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201028215824.608794-1-luiz.dentz@gmail.com>
References: <20201028215824.608794-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7609171610043988638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=372299

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
core: Split LE and BR/EDR parameters
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#602: FILE: src/main.c:84:
+static const char *br_options[] = {

WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#616: FILE: src/main.c:98:
+static const char *le_options[] = {

- total: 0 errors, 2 warnings, 1036 lines checked

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


--===============7609171610043988638==--
