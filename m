Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9168C43463
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A105E2087D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPI6YD8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIQW1N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgIQW1M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 18:27:12 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBA7C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:27:12 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id z18so1853843qvp.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MW1jIf4XW7dmvTkaEvdEHJkJjLhhazMtsSWWDiGFp6g=;
        b=fPI6YD8bwT/GfwNputLwt5rxvpp79qMpcqgIPyOLNNKd6H+NRSvxb/WE8t9AR+Hhfc
         13vPkn8kBg5DBFRo4BdOCBkLHnW0V+0hpFQj/OnrSUX8LfO42gXla81yxk/y/GlVZK8N
         Ze2/uSm0hqldeMNLfO+mfTc5pmO6dvFWD0M5woyOJaB0AC+hZyv9Avu6uU1pmfGq3ULZ
         y33c8RjV7N1ZEbnCMythc0k7OtL67bSIHuCUXqXwoz1JxZQ535mJduU6M4ArEmSKqqRZ
         6kaVU+PWhKfURRQmJYekKCMvdEYzA/paEkLz8aA1+YsXaFEYKlvkR9VVdHH1UaHFKxZ7
         k/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MW1jIf4XW7dmvTkaEvdEHJkJjLhhazMtsSWWDiGFp6g=;
        b=nZqUN9XZ0pe/EA4boev3iLf9UTi9RTBOLI733yjx+P6AQfw6cGJdZQp92WzB+UTCg+
         OEBu+XWLImFZJV0RSO/qMskBo3sdoqwnvvD9d6DW9SL33q2v4e1UIfz5AQhPplMJDhx/
         qKecNq36Y2lPl4kyfQ+EB28QGqIDWuYeUEYfWk1xBmiUufbB9sRAXrnwPL1p30KBF7/m
         OmO8GHMf06Xa+zGRqBkuti3L3tYnc4WrpHiQdZY91TdmN5YsGRIHGv9/G9DhrbFlA6hH
         PJMIqNdgckRc2x1e0O/yUYrcJSqjEUxa1IwHyT59alsYen6qoEfvJrbosLF/dRD7j/th
         N6Ug==
X-Gm-Message-State: AOAM532yNjx3ygvdfwqlYDKQvuOXQ372J+BipQL6nHVJVztGVkMBySzv
        mZgse/UUcsMa990vVUQRLFyAD6eFvfzSCg==
X-Google-Smtp-Source: ABdhPJwNjueDcxiQs9RsWiZlAWVfeU2TwsZskizTXTBaeWw1mn+ahyT00EGD/oPHuTddrmLE0ul3pw==
X-Received: by 2002:a0c:f1c5:: with SMTP id u5mr31009501qvl.10.1600381631227;
        Thu, 17 Sep 2020 15:27:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.138.83.123])
        by smtp.gmail.com with ESMTPSA id m6sm818574qkh.106.2020.09.17.15.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 15:27:10 -0700 (PDT)
Message-ID: <5f63e2be.1c69fb81.bb9b2.5acc@mx.google.com>
Date:   Thu, 17 Sep 2020 15:27:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2147787060672591220=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v2] a2dp: Keep track of ref ownership of a2dp_setup
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200917221034.154218-1-sonnysasaka@chromium.org>
References: <20200917221034.154218-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2147787060672591220==
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
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#31: 
    frame #5: 0xf679523c libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3182

- total: 0 errors, 1 warnings, 146 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============2147787060672591220==--
