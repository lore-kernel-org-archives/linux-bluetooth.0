Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A56BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 05:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D89207F7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 05:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXZdvpdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgFEFgI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEFgI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 01:36:08 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7322BC08C5C2
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 22:36:08 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id cv17so4124189qvb.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 22:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YXA7BxoD2VtzJzLFvE/k4mQ1tW44EQWOEo09p/h/eps=;
        b=eXZdvpdhRqSItX88LkduCJosR2MwYrke05VLQViuObMe1lFUbmp+peE5XSs3y4Z9N8
         vmRleqTCGBLlozsV8sngXlMZ6WGVhNXp02x8c/O4Fj2ABhAU6l7Vdep76JhpOWvujE8L
         CD3mywTzWfMLq/yv2D7xbTFFwWIT7IkgK2P8q7ta8wZCdYF8al3xhbtaBEM95f190E1Z
         I7DPWf9Hrg0EG3kz7sc1xXYorb7sNMjpnNfl+ovDAMX57kOoPuImTwrmPl/QLLyZpL1t
         yloblrr8rulG1FskkU3V/Ip+Y/Hpo+HFsBZOmjlecDAYZsUc1WBUdJs/UMCaoi+9GWTl
         CkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YXA7BxoD2VtzJzLFvE/k4mQ1tW44EQWOEo09p/h/eps=;
        b=WJmpDtmUrpQRLS20WN6Ynbx6HxXjFH7MmAuK3YXhgUyvY7WX0Xj86KV299vqZWVl+x
         9jQjzJ91cvqdQH7pPn0VMwvZGvxzf4A7TQnSzolVUByiYhUjliQpdBo0iELaIpiy7wh7
         gb+YR5Sdmr6Nis7Jo+wuSLqb4EahogNyzrtvKh73pT2K2YfpToPvWwUkIsyLJeyZOL6k
         MakKypLvhIdAsDW87362dcpSlqXS40lxgmDhM+OZIInnx+OLBdUxuFQG+Cxzbh4/w25k
         YxBHzdtUNoMCfUOYJWOwlWld+PkpOBsIsz2NAT/XGQu6UcJ0ZS3xDclZlDlKkHW1Rzqh
         bKNg==
X-Gm-Message-State: AOAM533WM/SpBo22sk7209wTB09MapYr79kwg4VMeznPVeOEWn/UyRfR
        W2KkPajtZ5+G5AALMBDQb0mteiajl3Q=
X-Google-Smtp-Source: ABdhPJwk+VvM5vToImzpHza7v58wERehEJxuQyhybgzPtBbS9Gwuotva4IdzXKP986KAgzCm0tFfPg==
X-Received: by 2002:a0c:8e04:: with SMTP id v4mr162689qvb.213.1591335367514;
        Thu, 04 Jun 2020 22:36:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.59.137])
        by smtp.gmail.com with ESMTPSA id v189sm6287642qkb.64.2020.06.04.22.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 22:36:07 -0700 (PDT)
Message-ID: <5ed9d9c7.1c69fb81.a6149.34e7@mx.google.com>
Date:   Thu, 04 Jun 2020 22:36:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7806691646011392002=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [2/2] tools/btpclient: Use mgmt api for limited discovery
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200605051509.10766-2-tedd.an@linux.intel.com>
References: <20200605051509.10766-2-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7806691646011392002==
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
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#32: FILE: tools/btpclient.c:85:
+static struct mgmt *mgmt = NULL;

ERROR:SPACING: space required before the open parenthesis '('
#225: FILE: tools/btpclient.c:3294:
+	else if(strlen(arg) > 3 && !strncasecmp(arg, "hci", 3))

ERROR:FUNCTION_WITHOUT_ARGS: Bad function definition - void btp_mgmt_release() should probably be void btp_mgmt_release(void)
#248: FILE: tools/btpclient.c:3317:
+static void btp_mgmt_release()

WARNING:LONG_LINE: line over 80 characters
#266: FILE: tools/btpclient.c:3334:
+	while ((opt = getopt_long(argc, argv, "+hs:vqi:", options, NULL)) != -1) {

- total: 3 errors, 1 warnings, 271 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============7806691646011392002==--
