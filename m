Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B490C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 07:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjE2Hot (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 03:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjE2Hon (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 03:44:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7489A7
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 00:44:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2553663f71eso1985064a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 00:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685346281; x=1687938281;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6i5OQHBoeoFKndC2wB0L55Jkdp7Wi74wEYrHM5GU5R8=;
        b=GpLXjc4IhI/ExzV82DxQMCa8O0rCK5M2cjs17cIoURgH6AjY9KQ/NEYnGxBeuLV7WY
         AcXpp91fkzF2B4+3Kb/3YmoPPHgPj/o1NJACwkn02C/31WA98SXuHxACTv55YdFpoRB0
         3GtA4lyaYVs/zog5R9kSXwi7jZnWNBF8EAHOrO9mXadGMmcqXsdGcNgjJy6bOFKH/3kG
         QtfFo9kfbfte92wXtJ9QPsi2Bif29G6cmFWDzo3ksCL/NYIt2GuhHo6zMiZvdbaAY1Wl
         Ta3l8LOLtHqnQbX9k97Xihej6WVF1h6lG1sY8x19Y4bAejmjq7U2Yvibn66FpyTLqVa+
         t29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685346281; x=1687938281;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6i5OQHBoeoFKndC2wB0L55Jkdp7Wi74wEYrHM5GU5R8=;
        b=Ni+S5Fn9Tns9Az/Rqziat0CqCbevSDwCno/6Q4dLTxFJAk9xWpfMkyTTiPfrZyq8Ll
         xsnE8IeIphWxItnIF5CP7Aoqmm8Tg4HH2v4m9xJPVTvLrcilvvDEUSWfBQNDF/FAoqM3
         HvOdm20awKjXpAbDpQ23io0USZV0SQ1yT0fPA/vqjTIBVenUQk1h4shGAGsnmf4XiCJQ
         ZavxPX7f2AYE/nuOQfqk5cOHx5RzkyiI0/Q8MVfwvhF/zLQo/IkFjwVc46f8x5HPHyGc
         /T0rSByCp3399enbhpezthsCNtZRX2WV3uTQByoSvhVf/nnjSRxA4GM6VeNGrDa2dKhd
         wTMQ==
X-Gm-Message-State: AC+VfDzS4AArswEZwpozpirzTEn8FzFOCugDQsICauwI3JH0OvRB9Sy5
        ZS1NYgLuPsNsUdvbFYod3LqqrDXBGdE=
X-Google-Smtp-Source: ACHHUZ4vRQc/G9D7cWZRRmAeMJ2CZ40BxlI7u+fEilZvWezT+TJQBEssCMz2PLiRbgZnY967QlWRzg==
X-Received: by 2002:a17:90a:ec0b:b0:256:7650:479e with SMTP id l11-20020a17090aec0b00b002567650479emr3031927pjy.16.1685346281152;
        Mon, 29 May 2023 00:44:41 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.244.128])
        by smtp.gmail.com with ESMTPSA id dw5-20020a17090b094500b0024b79a69361sm4932782pjb.32.2023.05.29.00.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 00:44:40 -0700 (PDT)
Message-ID: <647457e8.170a0220.250b7.8c11@mx.google.com>
Date:   Mon, 29 May 2023 00:44:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2314984362807529856=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: isotest: Add support for creating/synchronizing to multiple BISes
In-Reply-To: <20230529062734.3685-2-iulia.tanasescu@nxp.com>
References: <20230529062734.3685-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2314984362807529856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751752

---Test result---

Test Summary:
CheckPatch                    FAIL      0.97 seconds
GitLint                       FAIL      0.55 seconds
BuildEll                      PASS      30.88 seconds
BluezMake                     PASS      952.83 seconds
MakeCheck                     PASS      12.78 seconds
MakeDistcheck                 PASS      176.93 seconds
CheckValgrind                 PASS      293.06 seconds
CheckSmatch                   PASS      389.15 seconds
bluezmakeextell               PASS      117.00 seconds
IncrementalBuild              PASS      783.28 seconds
ScanBuild                     PASS      1202.15 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] isotest: Add support for creating/synchronizing to multiple BISes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#117: 
isotest[7178]: QoS [BIG 0x01 BIS 0x01 Packing 0x00 Framing 0x00 Encryption 0x00]

/github/workspace/src/src/13258247.patch total: 0 errors, 1 warnings, 433 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13258247.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/1] isotest: Add support for creating/synchronizing to multiple BISes

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
24: B1 Line exceeds max length (81>80): "isotest[7178]: Output QoS [Interval 10000 us Latency 10 ms SDU 40 PHY 0x02 RTN 2]"
29: B1 Line exceeds max length (81>80): "isotest[7178]: Output QoS [Interval 10000 us Latency 10 ms SDU 40 PHY 0x02 RTN 2]"
83: B2 Line has trailing whitespace: "        Codec Configuration: "
99: B2 Line has trailing whitespace: "        Codec Configuration: "
261: B2 Line has trailing whitespace: "        Codec Configuration: "
277: B2 Line has trailing whitespace: "        Codec Configuration: "


---
Regards,
Linux Bluetooth


--===============2314984362807529856==--
