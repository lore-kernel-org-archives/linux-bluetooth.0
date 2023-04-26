Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC827C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Apr 2023 19:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjDZTts (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Apr 2023 15:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZTtr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Apr 2023 15:49:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F3310F
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 12:49:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a98ac97d47so25402055ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682538585; x=1685130585;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lzSCO/dyX0HIUvr/7yfvJwYKAwfOXgGBW+wy6jB/ASY=;
        b=H3XQJFvf3o4GdCqEZGFE1GXr99jlOg6AK+6cqGnWaa4nLEJ1nQW0qkQX8MOpeJWHpQ
         93z90p+kS0Vma21dhiurqp/5npZS9od/wamNPxbyZgxTZsTgempMlpSCW6ML1cowBO/u
         Nk2e3El8gsWj6l6aqQ/uTPe3indVFFyJ/if3uL0e6bwEwYKTHBI3Z5rXOEMAOhDfbQK7
         49jl/l5cTbiE3cG0KDA008JpEDbBt6LfJoLRQt0DO8DrPb2jYdH2v+QnSc1BKNKZ2vBo
         o4bXptL5v6zL6Yn1RAMTai8F/GFfHxl2gbah7hQReHVtYLGuhx/Sws95gQQCloDtgCc0
         U8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682538585; x=1685130585;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzSCO/dyX0HIUvr/7yfvJwYKAwfOXgGBW+wy6jB/ASY=;
        b=KH+SQwbqOqyaxPoZ+C905NSYY1hXyXCnxmulCXRvtuVIQgWlzN2CifO/o4rzymqyeH
         tMSGkg7ubzwpZSd29VtWQx8UEZdqU8GjgOvY0nmKRFVptuIU15XgeqVg+P//nTiTOd4z
         bdzEy7OyDR/vmNd/dOF7HgCFhZu43sP/L8OXfkGBzpg3/MqkDe9pQoU5W7wAAqeMPWhe
         nN670jAJrjJoUZLpwnIFZqWXEKHC/6k0yIVVL39INoiuYYKw9Gq3B0B9Z/VbIxFkyrKn
         gHVwDtKMQdm1QZnlKHH6VUrfsPgY1qA7sPnXKXHgOUoXt50hvJKbmemvam9QlwzmbHjo
         mD7Q==
X-Gm-Message-State: AAQBX9ekOM42JSGnKGq1P+coVb6id+CLLcN4tqZ4FctgiAZCTj9UG27G
        SnFzbfYPKdzw+kXxUWBokjFuQmaX94I=
X-Google-Smtp-Source: AKy350bsjEbLGpELSAaoyzt5QXcvTyp4kbqjAcM/0GuDsNa2J9g8sMjUOQtvYtqLXDLz+5FTH6CY/Q==
X-Received: by 2002:a17:903:22c9:b0:1a6:81f8:63c5 with SMTP id y9-20020a17090322c900b001a681f863c5mr27606857plg.12.1682538584998;
        Wed, 26 Apr 2023 12:49:44 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.50.90])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b001a9ac65ca7csm266590plh.309.2023.04.26.12.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 12:49:44 -0700 (PDT)
Message-ID: <64498058.170a0220.1d169.0f93@mx.google.com>
Date:   Wed, 26 Apr 2023 12:49:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7814575068590065635=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/7] media: Fix not storing Preferred Delay properly
In-Reply-To: <20230425204729.3943583-1-luiz.dentz@gmail.com>
References: <20230425204729.3943583-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7814575068590065635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=743154

---Test result---

Test Summary:
CheckPatch                    FAIL      4.01 seconds
GitLint                       PASS      1.94 seconds
BuildEll                      PASS      37.01 seconds
BluezMake                     PASS      1276.07 seconds
MakeCheck                     FAIL      14.14 seconds
MakeDistcheck                 PASS      211.72 seconds
CheckValgrind                 PASS      346.42 seconds
CheckSmatch                   PASS      474.73 seconds
bluezmakeextell               PASS      141.60 seconds
IncrementalBuild              PASS      7451.95 seconds
ScanBuild                     PASS      1514.41 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,6/7] shared/lc3: Update configuration to use iovec
ERROR:SPACING: need consistent spacing around '>>' (ctx:WxV)
#124: FILE: src/shared/lc3.h:56:
+	LC3_IOV(0x02, LC3_FREQ, _freq, _freq >>8, \
 	                                     ^

/github/workspace/src/src/13223798.patch total: 1 errors, 0 warnings, 125 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13223798.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: MakeCheck - FAIL
Desc: Run Bluez Make Check
Output:

make[3]: *** [Makefile:11261: test-suite.log] Error 1
make[2]: *** [Makefile:11369: check-TESTS] Error 2
make[1]: *** [Makefile:11777: check-am] Error 2
make: *** [Makefile:11779: check] Error 2


---
Regards,
Linux Bluetooth


--===============7814575068590065635==--
