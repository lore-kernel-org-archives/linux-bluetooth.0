Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F43C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 04:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D4F64ED4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 04:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhBBEIs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Feb 2021 23:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhBBEIl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Feb 2021 23:08:41 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE598C061573
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Feb 2021 20:08:00 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id k193so18653392qke.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Feb 2021 20:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vQutzAMGu/DkHVB6XA5erTW1jJ+PPNB5YdeRKh/QWiI=;
        b=K+bOCZAtwSemkyXKLzoGkEMH2xsao2Psm3KsX+qsGD07RsTriazwMd/IGg0UtFyuod
         MvjGrairP0m784e/LSOxgvtbL6vaalZ7n0CgTIRSElMx86wWWrJxp3LuXVNgYiNZZJM5
         XQqPlCVG2WKdihShpduO8QvmFaDt2Afmh2K2BJP00WClyB/MOvdNC7yYK3PWrDxYZX2K
         TQTDag/cvqgGErzfetY3Dg3NHMC6VvDK/8d4NbIJlii+3AkPo+cumBgCyjdRPnPoG+GK
         SZyaHiiaMGTUGtu2P7KWV/ct1hbCviyiIkEKFm1AHSz98m30dxfmzMLRjKZJlkUmihO6
         7hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vQutzAMGu/DkHVB6XA5erTW1jJ+PPNB5YdeRKh/QWiI=;
        b=KwC+Pv0S5K0TA9CxLJwuzm7QuGX9bixsQoKB3rnEy2hb1V7ZJl7xfxYT2odu+M9IZN
         rNSzSKMmZ0+Wf3IMOV+7C12L9E2l1oZh6QkF8NzaNQpTrp9SVDBpzegcPsFXVJtfdtDl
         fyIIyXoHuVEA2kT6cTNRwnMiyYMWYwqC6nU1iVTY7QSerwveS6jgPTYADmM4ku/0PGhK
         LZfHVs08VNl3hfWIxd58E4Pvllvdp251v7jowcsW1s5m3u9css/CMoFas+FbEzI33mEt
         ywioLhrrS5JBnGB3FTDxipoHW0/ZctUJ8D9Khe/CVUQHNOQFKAi3WwYiaPEU1pYtVWba
         PDmQ==
X-Gm-Message-State: AOAM533AkRAbTfr7F1CCxhs/EkX+FFPY5ofPTNRpYfsBhDTZHfDYwKHZ
        dNyRPtvkNwdVtzbjAfZmcodxxn5IL+c=
X-Google-Smtp-Source: ABdhPJwQCT85sYIuoffCIj+SIiMUTlJYuWv8edHW+Icox7CxzAzi8TxvMF9D4ni4xnt4xJnNjVlxAA==
X-Received: by 2002:a37:8cd:: with SMTP id 196mr5212603qki.434.1612238880013;
        Mon, 01 Feb 2021 20:08:00 -0800 (PST)
Received: from [172.17.0.2] ([52.184.163.4])
        by smtp.gmail.com with ESMTPSA id z132sm16484114qka.131.2021.02.01.20.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 20:07:59 -0800 (PST)
Message-ID: <6018d01f.1c69fb81.45e86.488c@mx.google.com>
Date:   Mon, 01 Feb 2021 20:07:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0906602126776357256=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v4,1/2] tools/bluemoon: Display FW version of firmware file
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210202034005.27697-1-hj.tedd.an@gmail.com>
References: <20210202034005.27697-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0906602126776357256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=425781

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
tools/bluemoon: Add support for checking other firmware file types
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#59: FILE: tools/bluemoon.c:757:
+} __attribute__ ((packed));

- total: 0 errors, 1 warnings, 168 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] tools/bluemoon: Add support for checking other firmware file" has style problems, please review.

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


--===============0906602126776357256==--
