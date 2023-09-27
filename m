Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B48E82CA1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 15:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjI0PD7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 11:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjI0PD5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 11:03:57 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E7012A
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 08:03:56 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c0ecb9a075so82921755ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695827035; x=1696431835; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FGRGkr81yf5h/jryOr3RnhKT/JuGOXKK4XJE+8n0dg0=;
        b=jULRJgZ7Flxw6D5eeEt8+sFjRxUVFNMu4UXtR4Ef1k4GDxwo84V3cJVkYYwim/1tJY
         +80by6Rh2Fol42/1AhlvvqNrbSk3JAL7SUxinNIlTttaQr/JtPpSxqHDEdrRlHGBKZGp
         accVofOhBKKcMWg9eBgBGgPo/WGjaO8uy8jyspVInQKh0EKO21Dn2vSlrO8xabCeSxYt
         ioQLV12Ndegw8L6ls9B/INzFpeZ0jYohnlmnvMMRue4Cj5nSNZnG5l9lDsRaBugpoDOy
         hCYLs4iYFd2NJMBEF/KkCQBJrwoRc4X5pYwah2ZUYzMjot1TAX+RTJqY/4Cru5P2x6tZ
         +3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695827035; x=1696431835;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGRGkr81yf5h/jryOr3RnhKT/JuGOXKK4XJE+8n0dg0=;
        b=XWkW2ePihijUeE3luU4SUgcjxARdJBMtYW9ob7ii27Tf6/hube5vL4BC8Q40wq9Sxi
         aUhnnSmfpYyjwNxSupaDDCqVN/G6pBkyswxklHxHdjJvVK93obanYs5GL+lIFS6EIvtK
         AqEotHqE2YcFJhhyaHmZ1sZzEQc9q+c8ZjVBwE5UxVrbUVw0aHLBNbvJCBX548lXs4wi
         nBJVYVjzeda534bWetWlLPYWZ3TwX+LP45kq6zISSNsSH6OF627o0svFbZvrX/oAdcGZ
         RyKmOuwHYaTgQEwayFHdNQvMCgPqL6PFEoF6f9NeTIiui3E/DTV+OWxHA7tR/ZWSJBB2
         WfUg==
X-Gm-Message-State: AOJu0YwzhB8D7sRUmQ+3k/TlFGBCtz99uBhPFee/J1wlJxZgvAAErtOg
        VEOHRdZAnxRePFnZ/JHB/Q9qN2s2TCU=
X-Google-Smtp-Source: AGHT+IEdjk89U63QMGS8rNPEiTpYGLqUgnm4DNwp/GHr2rgmRauxRL/vwWC7vOYGaJffAnP8UlVijg==
X-Received: by 2002:a17:902:b282:b0:1c3:8679:6ed4 with SMTP id u2-20020a170902b28200b001c386796ed4mr2002151plr.8.1695827035417;
        Wed, 27 Sep 2023 08:03:55 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.164.224])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001c6187f2875sm6867264pld.225.2023.09.27.08.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:03:55 -0700 (PDT)
Message-ID: <6514445b.170a0220.f2fb2.6f2e@mx.google.com>
Date:   Wed, 27 Sep 2023 08:03:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8859616996943576514=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, andrei.istodorescu@nxp.com
Subject: RE: [BlueZ,1/2] bap: Remove memory leaks and buffer usage after free
In-Reply-To: <20230927133001.6639-1-andrei.istodorescu@nxp.com>
References: <20230927133001.6639-1-andrei.istodorescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8859616996943576514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788126

---Test result---

Test Summary:
CheckPatch                    FAIL      0.92 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      37.96 seconds
BluezMake                     PASS      1276.07 seconds
MakeCheck                     PASS      14.42 seconds
MakeDistcheck                 PASS      222.45 seconds
CheckValgrind                 PASS      350.82 seconds
CheckSmatch                   PASS      486.05 seconds
bluezmakeextell               PASS      147.46 seconds
IncrementalBuild              PASS      1105.79 seconds
ScanBuild                     PASS      1526.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/2] bap: Remove memory leaks and buffer usage after free
WARNING:LONG_LINE_COMMENT: line length of 90 exceeds 80 columns
#214: FILE: profiles/audio/bap.c:387:
+	/* Update caps and meta with received Codec Specific Configuration and Metadata */

WARNING:LONG_LINE_COMMENT: line length of 87 exceeds 80 columns
#249: FILE: profiles/audio/bap.c:824:
+	/* Update endpoint with the value received from the peer's (BAP source) BASE */

/github/workspace/src/src/13400808.patch total: 0 errors, 2 warnings, 150 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13400808.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8859616996943576514==--
