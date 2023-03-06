Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7B3C678D4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Mar 2023 16:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCFQPc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Mar 2023 11:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjCFQO5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Mar 2023 11:14:57 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CF23755A
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 08:11:30 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id be16so697044oib.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Mar 2023 08:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678118992;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZClIPZK4zCLAsLsgqc0stFBmYs6xxE6Tch786qcHPLA=;
        b=BjSE4HqUJwG2AjdsoR7UoMwF0OCYzb66GNQQ+x99wTLL25CTd2yLEdivs9F80JqOgs
         9Tmls9oUCf4ptwI8x0Og5xNgjRLywIGT2QbsUS9kXQjesclLHIelYM4AEjWd9UfTETp2
         MTMeELIIpkqQWrT3bmsErusvGE1A50VHmM2d/u9ugQdozn8gUwPI1wxfAT/0E3lTAz5G
         lD7YqMXWX65yQD5m0euwDKi9XUoph8AZhdhrKy2hrM9NZhOyF9dfNnYTszlaKzqi1OYa
         czA1YJmITwtWuQu41cEzkQ6U54YLH6lPBjb2TexVD/ZFcJAsbtH4XiP3mV5h5r16ztv8
         Ehlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678118992;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZClIPZK4zCLAsLsgqc0stFBmYs6xxE6Tch786qcHPLA=;
        b=kSIIZU4AkKIERe7EFjQQxn+cMuzTnrIoO4jaWI/Z1ULPD5k6PA0jrAXy+++1nm7Gzk
         DyJYLqS/uTv4KFPvTFWOhebkDxUFdk3SU8mUryt2HXs40L/07LpcXDK8vJxSFXJWWfaT
         rxH3lKZU1GFfBVctC5LUVhamFKMGfqZWO0UyUw09c+zUKLfSE1PqZzZ3Z09/UNi7SkG9
         n7EZXhrpBK+VhQ8DrGO8jEDqZyG6jp5H6KPh6NgewRSZHRtFkuQbzdIEquOeVeLq3yXW
         thYeetgo9uioJBDMzjiPIruhEe2P3g8VZ1t+bmTsGJBfkzaXZaxX+K6YMS/WV2hj5Um7
         7cag==
X-Gm-Message-State: AO0yUKVmTtW1J5896vSjzFc+wZTjQWK8sou80ZWsb/aadwMyOpF2SIju
        lTileG2fTSdODcZuo90LvGH85OHMDD8=
X-Google-Smtp-Source: AK7set+C5INbP/cObK4+Tw+b33Xjp+wH5A3ZqHbpeW9r8PyfUCK+RDeMl56e4pFb3hMe135F/jA7Pg==
X-Received: by 2002:a05:6808:2805:b0:384:3a60:e2de with SMTP id et5-20020a056808280500b003843a60e2demr5214992oib.29.1678118992242;
        Mon, 06 Mar 2023 08:09:52 -0800 (PST)
Received: from [172.17.0.2] ([104.210.133.20])
        by smtp.gmail.com with ESMTPSA id m186-20020acabcc3000000b00384d3003fa3sm14128oif.26.2023.03.06.08.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 08:09:51 -0800 (PST)
Message-ID: <6406104f.ca0a0220.618ce.018e@mx.google.com>
Date:   Mon, 06 Mar 2023 08:09:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0433500801208622529=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lukasz.rymanowski@codecoup.pl
Subject: RE: [BlueZ] btmon: Fix decoding truncated data
In-Reply-To: <20230306145217.7662-1-lukasz.rymanowski@codecoup.pl>
References: <20230306145217.7662-1-lukasz.rymanowski@codecoup.pl>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0433500801208622529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=726931

---Test result---

Test Summary:
CheckPatch                    FAIL      0.71 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      26.59 seconds
BluezMake                     PASS      757.14 seconds
MakeCheck                     PASS      11.34 seconds
MakeDistcheck                 PASS      148.52 seconds
CheckValgrind                 PASS      239.58 seconds
CheckSmatch                   PASS      319.68 seconds
bluezmakeextell               PASS      96.15 seconds
IncrementalBuild              PASS      607.68 seconds
ScanBuild                     PASS      959.22 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] btmon: Fix decoding truncated data
WARNING:TYPO_SPELLING: 'lenght' may be misspelled - perhaps 'length'?
#82: 
In such a case, included lenght is smaller the original size.
                         ^^^^^^

/github/workspace/src/src/13161351.patch total: 0 errors, 1 warnings, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13161351.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0433500801208622529==--
