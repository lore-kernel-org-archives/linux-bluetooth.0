Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C03C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3291520739
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOLhSGR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFPAMb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFPAM2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 20:12:28 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36488C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:12:27 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id j32so14162374qte.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=PqUkJDQGqnIz1xMRg1ZqgV5aSgqEwUGHX+Q0bYvPYUQ=;
        b=FOLhSGR9tOz5TOLbIXLsUCu8KtIlXukGwjducr2/wWZeSlIeiWkM/Q+SieY/78qIhF
         tYi3xKhREnF6UgPsVovkck6x6Q4YHavOydwS3xqA6x3mYgex4G/FvwsDfN1lZVb+ZSeJ
         mrmT65shhx/YcpR0TJWh1E6LmYgPDqvtl3piHd0muW1w+RSC4+hjyQOIRjQttrA6NKuL
         CKKiwAhKcvMVw2JYrLa/lhAJSJk+uIeO9qVfB5cTmeI2abDIuDe2S0ZJZmDaYbLy3uOM
         2y4S/7msjBAKXvImRNmuvIQNoGSLf8TbK5vfOq/7aoYBKsNVXbTrqaivRx4npU6BvOj5
         0NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=PqUkJDQGqnIz1xMRg1ZqgV5aSgqEwUGHX+Q0bYvPYUQ=;
        b=UUzKKFmxxjSuXT82zRlq+AsF6EgtBtAytbPSDb1cf1EAIVL8qXNSviMIV7I1jzLQ1R
         rKM/ORWDcZD7UnIx0zFyxqtQt35LmlRHaLMnoVD4ZCpJs3uo6WyvEuzrjQHV1LQDhJZU
         f7byZ2tv+TCehNje3Jct3/pCAJoJix4L8+dYWu6qqPtDffrQlz1wTLq7mXgMnliWh6Th
         f+cqjRZ8viWXm+jfuWKitQ1hSPrS3Qu86LlR+0hRkR9IZEmYTfoX7lFEN+v0QDEiFZBq
         o6M1uKV6uBWBJw/dHcbW5dnL9Nt1G3cQtbJVgp1ajPJ9w9UppAgnFrm6oYSVaZXPnX3Z
         tWaA==
X-Gm-Message-State: AOAM5329FED41qQuHpWvcLco4piqiPLAMG6qNJOaC6tO4MrDxHaZvydh
        PzK5VfIFpyYmm9kJMHGineTG9ipN
X-Google-Smtp-Source: ABdhPJxeG4/P+HL+uqesJf6INUc1kYU/D1dncPBOVKGzmjxUiKUexV8VtvT7rDULFWkCDQW1GcAKeg==
X-Received: by 2002:ac8:3fdb:: with SMTP id v27mr18692914qtk.220.1592266345776;
        Mon, 15 Jun 2020 17:12:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.191.240])
        by smtp.gmail.com with ESMTPSA id o21sm1376186qkk.4.2020.06.15.17.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 17:12:25 -0700 (PDT)
Message-ID: <5ee80e69.1c69fb81.137a4.8518@mx.google.com>
Date:   Mon, 15 Jun 2020 17:12:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1099034768328737238=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michaelfsun@google.com
Subject: RE: [bluez,v1,1/3] btmgmt: Add btmgmt command advmon-features
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200616000318.42664-2-michaelfsun@google.com>
References: <20200616000318.42664-2-michaelfsun@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1099034768328737238==
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
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#25: FILE: tools/btmgmt.c:4570:
+static const char *advmon_features_str[] = {

WARNING:BRACES: braces {} are not necessary for single statement blocks
#81: FILE: tools/btmgmt.c:4626:
+	for (i = 0; i < num_handles; i++) {
+		print("\t0x%04x ", le16_to_cpu(rp->handles[i]));
+	}

- total: 0 errors, 2 warnings, 93 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============1099034768328737238==--
