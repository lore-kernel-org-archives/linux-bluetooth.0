Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FFAECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 11:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiIALcQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 07:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiIALcN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 07:32:13 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75065115191
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 04:32:11 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id i77so14268460ioa.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Sep 2022 04:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Ocg5hg204PIznyLczyDiUkr9ec2xgPZWc/RDbZ4X3/E=;
        b=fSGlp/Hj7URyR3dllkQ3QeoXGugQy+ZhTDUGlRTlZ7FCg8BMkx7nUx7vzheEd8SMX0
         X6KNC5fISCzH99RRzw9VkNkURUn3PBIWyavwKfnRY1wqoRHg3ERy7jVXiZWhsgkkhoLe
         zlLxR7JLhaVymaYJHipVmzKvW6YuwGae/crJBLglbWl86mluT0W4wb2p7fwN1gOdfJ8j
         Dpk5YCxY3XZyZsx2IjOE2esF7DnR8tugvJy9wLsBpWW57mxTiE9laOgZvSKc5qUVm4yI
         5lBn5c9nL+IFVgrdim9TaE+NK8a8WzDD82sEi2JWGE9tP09N+8pjNAgeO9U4s8m1pLXu
         zmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Ocg5hg204PIznyLczyDiUkr9ec2xgPZWc/RDbZ4X3/E=;
        b=loVrFNXeynFUV4+j7pzgdNVfz6gvDharuVCJnB+NUU0UgkWVQtZgSZCXdiVvWrUcT0
         qtZlXceJudLZPTFrOvm/k8TzSzKlonqn0kgnRHLyeAMeuj+d9LwcCLxSxmvnhAMUzVuL
         Q4ION8rvZOV+D7YckLQC66MrjmRCIZQIGFeao4i6cbwmkNx6NIgiONoCSl4/nURPb/Im
         CgsYY5ZuR2ILygaaVmrt1OVRaZJaENSvp5rBBOpFE42bJIHBQXDWdF9+3kBadscFS4Pi
         7qp3+zWuyrhGrRq0pkvfirYqV8rQi+g25wps2RWF5gGBSupd7itRcpa5Lah3p5nx8gtR
         SlTA==
X-Gm-Message-State: ACgBeo0sHnZep1Glrq6EXg7b1dOwNk8xtD+KqhfCw3wy6KWZYANfq/oC
        KdsclMjPSjslHvrIAAUPsnXlHpzT/pU=
X-Google-Smtp-Source: AA6agR6hPox4qtLR0Pf82nF+Th1Pu/cjl3vnot7LeN+7v3RrF9AmuK4rdLqHHCDgToboLYWTVwGyUQ==
X-Received: by 2002:a5d:9383:0:b0:67b:adc2:c053 with SMTP id c3-20020a5d9383000000b0067badc2c053mr15042026iol.102.1662031930363;
        Thu, 01 Sep 2022 04:32:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.221.167])
        by smtp.gmail.com with ESMTPSA id i7-20020a02a0c7000000b00349d044cddfsm7751810jah.119.2022.09.01.04.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 04:32:09 -0700 (PDT)
Message-ID: <63109839.020a0220.3f6f9.9259@mx.google.com>
Date:   Thu, 01 Sep 2022 04:32:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7828493987340404669=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v6,1/6] adapter: Keep track of whether the adapter is rfkill'ed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220901104331.174588-1-hadess@hadess.net>
References: <20220901104331.174588-1-hadess@hadess.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7828493987340404669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=673181

---Test result---

Test Summary:
CheckPatch                    FAIL      6.85 seconds
GitLint                       PASS      4.57 seconds
Prep - Setup ELL              PASS      26.48 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.06 seconds
Build - Make                  PASS      714.85 seconds
Make Check                    PASS      11.37 seconds
Make Check w/Valgrind         PASS      284.31 seconds
Make Distcheck                PASS      232.78 seconds
Build w/ext ELL - Configure   PASS      8.10 seconds
Build w/ext ELL - Make        PASS      81.59 seconds
Incremental Build w/ patches  PASS      578.06 seconds
Scan Build                    PASS      585.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v6,2/6] adapter: Implement PowerState property
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#137: FILE: src/adapter.c:659:
+static void reset_power_state_target(struct btd_adapter *adapter, uint32_t value)

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#177: FILE: src/adapter.c:714:
+			adapter_set_power_state(adapter, ADAPTER_POWER_STATE_OFF_BLOCKED);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#191: FILE: src/adapter.c:758:
+						ADAPTER_POWER_STATE_OFF_ENABLING :

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#192: FILE: src/adapter.c:759:
+						ADAPTER_POWER_STATE_ON_DISABLING);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#233: FILE: src/adapter.c:3025:
+			adapter_set_power_state(adapter, ADAPTER_POWER_STATE_OFF_BLOCKED);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#326: FILE: src/adapter.c:6830:
+		DBG("Power state: %s", adapter_power_state_str(adapter->power_state));

/github/workspace/src/12962285.patch total: 0 errors, 6 warnings, 278 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12962285.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7828493987340404669==--
