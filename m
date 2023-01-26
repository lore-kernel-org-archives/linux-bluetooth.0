Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC381C54EAA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 22:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjAZW0T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 17:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjAZW0S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 17:26:18 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA994DBE6
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 14:26:17 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r71so1174544iod.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 14:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nf1qi+ukGkL9yMv2OTo2/dYCDkezJX+iWVvI+AR8aOQ=;
        b=aobm3xt3yluIAalraHImtlPrlYRYPiUFl8P2/zlx9HZwwCsBFqEDNjtlajsyB50zpj
         mpvbcmLMgk/uuNKnVeLxwKIy+5QberVVtTIhsFMhOy8Jd67lPAbpffZ1e462mAy8aDkS
         ZztwtPsJQ//6d6Fxko3wuJy8ImhGiPM3Y0+gNh9YYw7AbXlYzrhJ//04x6c/xrTrGk92
         gWfELaKX/kjZh8GYUaJSnOsdWAemKGZLEkznU7Dan2VOBfWvIfO4xLMHAvFfqvtWOWsW
         D23pG0rePqchoQEXwnA/hHgYcQ9u/C0cOSWYboB9Jxxy03PNxDQ3MhN2zvfBgt76SfBP
         IFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nf1qi+ukGkL9yMv2OTo2/dYCDkezJX+iWVvI+AR8aOQ=;
        b=XQTy1ByeqoZ6hfTBwB8Xne3EDEaLrcVPqT2gZ657kAtdhjUU8t/o/2TMxJkLIH0Cvp
         XQlpf/RsDqTTHsmcA/wYI05RwkKF+KPD27evL9bJh42dNdKYORzUvqruQtFAg18G0+UK
         vrRiljijWxw2XxbtIqQcrP4LlW4uI4Qt9jCMLe4K3VpAtyxmCyLrFJ9/K+f/PcHS4XE8
         /yrpBf5Iue/UMtefEaMVjf4Q3UulmPnjCuAMaHC40WxFDTCEXwc6dzdaUX7yie5BuXmx
         +MGOAVNXxbp5fjKkJZmEtkq21W4oesIz28Q9s7w/BYXRIwJpgMGGqCLabZE1WqAcmeft
         m28w==
X-Gm-Message-State: AO0yUKXcGTUKBfWbRDL+c7zlzvT/4mhk9lJBAKVdmGvAcVJoiYCRzD/k
        lesubnDG+YJuyFWaFuuXnIte0XyNQWE=
X-Google-Smtp-Source: AK7set8dlvjQnYPFLOVR/bituZjyZ+kpllEwhEXpSYGMAB2pqBPboaUBysIqCk2BzjbIbZw7kHAMvQ==
X-Received: by 2002:a5d:8ac4:0:b0:704:6080:32df with SMTP id e4-20020a5d8ac4000000b00704608032dfmr2325487iot.21.1674771976392;
        Thu, 26 Jan 2023 14:26:16 -0800 (PST)
Received: from [172.17.0.2] ([40.86.18.81])
        by smtp.gmail.com with ESMTPSA id n2-20020a027142000000b0037477c3d04asm827805jaf.130.2023.01.26.14.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:26:16 -0800 (PST)
Message-ID: <63d2fe08.020a0220.a6ae3.2366@mx.google.com>
Date:   Thu, 26 Jan 2023 14:26:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3203233079429264712=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/5] shared/bap: Fix not detaching streams when PAC is removed
In-Reply-To: <20230126201242.4110305-1-luiz.dentz@gmail.com>
References: <20230126201242.4110305-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3203233079429264712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=715998

---Test result---

Test Summary:
CheckPatch                    FAIL      2.59 seconds
GitLint                       PASS      1.37 seconds
BuildEll                      PASS      28.29 seconds
BluezMake                     PASS      884.46 seconds
MakeCheck                     PASS      11.06 seconds
MakeDistcheck                 PASS      151.11 seconds
CheckValgrind                 PASS      249.55 seconds
CheckSmatch                   PASS      331.28 seconds
bluezmakeextell               PASS      99.03 seconds
IncrementalBuild              PASS      3699.68 seconds
ScanBuild                     PASS      1031.10 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,4/5] bap: Fix not checking if request fits when grouping
WARNING:REPEATED_WORD: Possible repeated word: 'that'
#86: 
without attempt to check that that would fit in the ATT MTU causing the

/github/workspace/src/src/13117701.patch total: 0 errors, 1 warnings, 69 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13117701.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3203233079429264712==--
