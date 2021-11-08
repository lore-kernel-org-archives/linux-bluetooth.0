Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33941C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Nov 2021 19:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175D160555
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Nov 2021 19:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbhKHTft (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Nov 2021 14:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhKHTft (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Nov 2021 14:35:49 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9107CC061570
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Nov 2021 11:33:04 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id o12so14771857qtv.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Nov 2021 11:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/3GrRjEl2OkVG40YWS6EtTTstQTt3Svv1MxOlPk+guQ=;
        b=BzfxSTyvhFRtwmJyqsSEAbmy1+jFMNRCuwjWIevfWmBOU/ILfHX+eB5rQr2i1URB6h
         Yt2mymo6qluVYilEoc6yYXE3Ts20jHSaVEfmjEnDuDcZxrjalUG6v9cCBW7q7aA0bLk4
         Kae7g/LEphsshiiUuTn8AKiucK4fIwvHa7L6zpF62bP/YV60i/r30M0CcBP9LNj8XaYl
         tIOoNRHlYq35Xhh66by6MePksEZQa3k1JIt9YJjMjhUppamfqCgMm1+O003GioZiPCbd
         fBwsLHeaNCAAKXsvsZa3MdanNKgJCtL3PQhxbO8jW8heyqVa0zfBYfZsnxus4hrDah3j
         h05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/3GrRjEl2OkVG40YWS6EtTTstQTt3Svv1MxOlPk+guQ=;
        b=dDSsoCgPAXSdw32IFrKImldKVlTH5OBPY5aB0h3LTAl3bLqF0GJ4dwONCZzW9dwGcu
         SfLa3cN+KaI8rqEb9U4F8kWzFRV5w4uh/rgHDYCZGYIWtcnI20ITkXKz0pKBw+ymX5t+
         28sYNM525saKn5wCrqxdVAm5epGzXcXaKehIiCNnobEzE+QzIxQt2+0BK6RCKWKoQdlc
         gEpzGxFT8PEPfk0f5BfrAN4aBkT8zX2yOVzSGtoN1NvtQYNe+hofpAdA/zL1DeVP0V6h
         El0HPqB8Ab3FRPZsHmYzrzZgeWCCqKbrqvi9NUSU3Mj6A+4JcZ7e+Jb0nYljtRkkVHTS
         QCEw==
X-Gm-Message-State: AOAM530pmSgINHTDtAWOkoL4MI33lnrgiIUPB6IYNgum6jZ6dFu+ntTb
        HPtz/LDduMST3hIzQz1oESm5REL+axY8ng==
X-Google-Smtp-Source: ABdhPJxjaOa/H4+9Mli+W70oABziDSy3zVqBqHwaKZqc5V8PXFq+PHQCdso6T+wAAuFpJ3ds3k48fg==
X-Received: by 2002:a05:622a:118f:: with SMTP id m15mr2105257qtk.81.1636399983610;
        Mon, 08 Nov 2021 11:33:03 -0800 (PST)
Received: from [172.17.0.2] ([13.92.195.45])
        by smtp.gmail.com with ESMTPSA id y73sm1768533qkb.113.2021.11.08.11.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:33:03 -0800 (PST)
Message-ID: <61897b6f.1c69fb81.62006.a2f2@mx.google.com>
Date:   Mon, 08 Nov 2021 11:33:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1306479338077971868=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client/gatt: Fix using atoi
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211108191752.895782-1-luiz.dentz@gmail.com>
References: <20211108191752.895782-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1306479338077971868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=577055

---Test result---

Test Summary:
CheckPatch                    FAIL      1.51 seconds
GitLint                       PASS      0.93 seconds
Prep - Setup ELL              PASS      51.58 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      9.50 seconds
Build - Make                  PASS      215.23 seconds
Make Check                    PASS      9.67 seconds
Make Distcheck                PASS      256.66 seconds
Build w/ext ELL - Configure   PASS      9.57 seconds
Build w/ext ELL - Make        PASS      204.08 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] client/gatt: Fix using atoi
WARNING:TYPO_SPELLING: 'prefered' may be misspelled - perhaps 'preferred'?
#84: 
likely the prefered format for the likes of handles, etc, so this
           ^^^^^^^^

/github/workspace/src/12608969.patch total: 0 errors, 1 warnings, 117 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12608969.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1306479338077971868==--
