Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38F1C6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 19:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBXTLR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXTLQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 14:11:16 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1680C1ACDB
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 11:11:14 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z6so575744qtv.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 11:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677265873;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BMeIUtqLYhJGxHw6eVteXkl/4I6lACayN/oOMU4jEZw=;
        b=W67LtgU93YfTkmlDbcfozWBA4EPQSu2aKSspK1PL7J2xIeuh1TkbJbv6q1RxbF+5WS
         Btd57c5o0MXY0bomme49kmuxb0Z6CG9CEvVnHUwqToL+/skLi6BUMvXhs/ZfpizTZbwK
         Gb0IEgOs+JW+5r90Yk/1aSaaVCOj4g3ArnQpM//2r0GKee+SoXsc6dGtbLQUgQFqQC/8
         kaWD3dqZRM45oIWd8vM8Ej0sIij6iRKVgVH2wShqtU1mtmIrX/+P5RfNkeTYFZ4KGQi/
         MwQYDHWi0m7l+rj1HgUhnXB8YnBvLK440/PcR/QQs2/isYKwT/dD3xzlflTXZKVQPjXe
         TXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677265873;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMeIUtqLYhJGxHw6eVteXkl/4I6lACayN/oOMU4jEZw=;
        b=MujFzlMb854E4/XRNB8Hl53TAM15JjpVluclbhMNnN9KRc7lUuOCo8Yj2SfLs3Cj6U
         WQv+gtHuhtuO63vypIyTH6ArFZwO0eQDNfnkBUslW4GuhN2fse2cfLMvYNgtPYMffUi7
         srJUHtAEbySItbcpZVxu3BaNuwfYulcbxpwgj8G4TxIhBKynco8cHjTrlYSIzdIhcT1g
         rAnBfiD0mKoV4OT2Ic2NuyfmN7KZiHBxsNuqe2aIaTEcZ/lY8c+R9ci4SVMBOKAP2kjZ
         l+oIRtczrPuOoqpSrHQJklV88bOW8fUgp+qsk2hr5fB/UGAB9HQE1kg5/2pC1CvZXltY
         Eoxw==
X-Gm-Message-State: AO0yUKUjOXuCwD+NELQqGKyic3n4s/bIQssaug7CEu85ffIoopnLCOpf
        6J7brelhdfxRhQXSkB5d4PLK9yzyc+M=
X-Google-Smtp-Source: AK7set+7A3LArdDGJFMxKBBlGWAMM9vdy+ifzKQ5NXcF/3HcIIJECiYstSmHXG0TMM2xqRYaJPHu5Q==
X-Received: by 2002:a05:622a:170b:b0:3b8:1723:6d15 with SMTP id h11-20020a05622a170b00b003b817236d15mr26231645qtk.58.1677265872958;
        Fri, 24 Feb 2023 11:11:12 -0800 (PST)
Received: from [172.17.0.2] ([172.177.213.80])
        by smtp.gmail.com with ESMTPSA id i25-20020ac84899000000b003b9a6d54b6csm26707qtq.59.2023.02.24.11.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 11:11:12 -0800 (PST)
Message-ID: <63f90bd0.c80a0220.c4fe.02ff@mx.google.com>
Date:   Fri, 24 Feb 2023 11:11:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0203942512464143442=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] shared/bap: fix crash unregistering media endpoint while streaming
In-Reply-To: <fe1bf6efbd6bdfc8507e13559bb3852b23446f2f.1677261870.git.pav@iki.fi>
References: <fe1bf6efbd6bdfc8507e13559bb3852b23446f2f.1677261870.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0203942512464143442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=724727

---Test result---

Test Summary:
CheckPatch                    FAIL      0.96 seconds
GitLint                       FAIL      0.63 seconds
BuildEll                      PASS      26.04 seconds
BluezMake                     PASS      738.47 seconds
MakeCheck                     PASS      11.00 seconds
MakeDistcheck                 PASS      146.15 seconds
CheckValgrind                 PASS      238.35 seconds
CheckSmatch                   PASS      319.64 seconds
bluezmakeextell               PASS      95.26 seconds
IncrementalBuild              PASS      597.16 seconds
ScanBuild                     PASS      935.23 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] shared/bap: fix crash unregistering media endpoint while streaming
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#68: 
    #0 0x7f93b12b9388 in __interceptor_free.part.0 (/lib64/libasan.so.8+0xb9388)

/github/workspace/src/src/13151651.patch total: 0 errors, 1 warnings, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13151651.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] shared/bap: fix crash unregistering media endpoint while streaming

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
40: B2 Line has trailing whitespace: "    "
42: B2 Line has trailing whitespace: "    "
45: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============0203942512464143442==--
