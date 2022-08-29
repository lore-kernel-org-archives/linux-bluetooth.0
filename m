Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84720ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 22:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiH2Waz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 18:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiH2Wax (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 18:30:53 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234D565579
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 15:30:50 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11f0fa892aeso4413289fac.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 15:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=025FWm/Lhu7iabC9EfbOsTVReX4WjqKIYoPyUOhMHcw=;
        b=mKvuD0jqqjUV4Mh4ym/+Fuj6wMj4JW/Ijd/s84xeukK8f54LOi1aaqOYPntldGgqEO
         Nkxmnx6CJjarGuxHJeuaqLzg9lLVvF5a0hBexjIhuBClEA+7Y38z7Ol+5G+FguXBvlqF
         GNzQMbzQGLaw5P0uXv9FXn8mXgKPO+3z/XRv0HwedfTtejpDKtDYK1EfupGMUZ4NRuEj
         YfnLN6L8F3GrpmDI2Frlr3S+Chu0Sh3S9yNeZn/7UpQT0haQ5x89scof8bl33lt2ygPn
         R4nFlfGVz+j9bVbU8qcQvpayC64I6tLaO4YGLAiFAgZ/XGFEWwdjcmkduNBsv5Mrh1zX
         kAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=025FWm/Lhu7iabC9EfbOsTVReX4WjqKIYoPyUOhMHcw=;
        b=8ErACyawG1+tgQV1CC32pUJZIb5VCSbgJ2fC/PGWHVQiWTeizrjbLrttFkSIUDDRXT
         b7cCDZbUBQki6Veml8OpFZQyURlNPXqaQXuHgYwOrjBI3DKjDjvTgL1qR9vAgnDSfgcl
         5Fd7LnkO+j4yTqfxSte2s34JBHbLL+kC7F1fgErhJG/F8yy+SrHHS2DREXPuSAO8/71E
         ksEI5ks1d8PiEYrH6Niiqw+ZERGl5TyUvoXhYjmFWY58UoeT345nxkGtNlkhks69YNKl
         B0w8pW7dG3+k8tjuPZkvhc35basMPbfHLlWn6AnTCIK81s+CzXEPZ1qrkPbZZlRT92FE
         sLCA==
X-Gm-Message-State: ACgBeo2eq1IFSwSEMm1s2xGonqJxWqVUTH196YIVzac78banYgDqeVGs
        bFivr1sj8QVV4AqXxs5698M42i4dsWI=
X-Google-Smtp-Source: AA6agR5Kmup4y7EdrC9/qIOZC2SU6aYQuybtCeRQd8g7rCqizpL0FokeWIQzBAZxBLWm6dqhpEn7Iw==
X-Received: by 2002:a05:6808:1304:b0:345:52b3:4b42 with SMTP id y4-20020a056808130400b0034552b34b42mr8350145oiv.145.1661812248936;
        Mon, 29 Aug 2022 15:30:48 -0700 (PDT)
Received: from [172.17.0.2] ([23.102.155.61])
        by smtp.gmail.com with ESMTPSA id d12-20020a05680813cc00b003448fac8b00sm5489706oiw.29.2022.08.29.15.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 15:30:48 -0700 (PDT)
Message-ID: <630d3e18.050a0220.70648.ec30@mx.google.com>
Date:   Mon, 29 Aug 2022 15:30:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7196335430059527182=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] shell: Set empty argument if optarg is NULL
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220829213738.779598-1-luiz.dentz@gmail.com>
References: <20220829213738.779598-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7196335430059527182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672191

---Test result---

Test Summary:
CheckPatch                    FAIL      2.26 seconds
GitLint                       PASS      1.52 seconds
Prep - Setup ELL              PASS      32.33 seconds
Build - Prep                  PASS      0.79 seconds
Build - Configure             PASS      10.36 seconds
Build - Make                  PASS      958.09 seconds
Make Check                    PASS      13.15 seconds
Make Check w/Valgrind         PASS      348.11 seconds
Make Distcheck                PASS      292.00 seconds
Build w/ext ELL - Configure   PASS      10.67 seconds
Build w/ext ELL - Make        PASS      100.25 seconds
Incremental Build w/ patches  PASS      237.25 seconds
Scan Build                    WARNING   643.54 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,2/2] client: Add -e/--endpoint option to auto register endpoints
WARNING:LINE_SPACING: Missing a blank line after declarations
#216: FILE: client/player.c:625:
+		GDBusProxy *proxy = l->data;
+		print_player(proxy, NULL);

/github/workspace/src/12958474.patch total: 0 errors, 1 warnings, 185 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12958474.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
client/player.c:1758:25: warning: Dereference of null pointer
        iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
                               ^~~~~~~~~~~~~~~~~~~~~
1 warning generated.
src/shared/shell.c:1135:19: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        data.timeout = atoi(optarg);
                                       ^~~~~~~~~~~~
src/shared/shell.c:1155:13: warning: Access to field 'options' results in a dereference of a null pointer (loaded from variable 'opt')
                        if (c != opt->options[index - offset].val) {
                                 ^~~~~~~~~~~~
2 warnings generated.




---
Regards,
Linux Bluetooth


--===============7196335430059527182==--
