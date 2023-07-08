Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68990EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Jul 2023 01:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjGHBEv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jul 2023 21:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjGHBEu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jul 2023 21:04:50 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3C5210B
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jul 2023 18:04:50 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-565a8d9d832so1962791eaf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jul 2023 18:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688778288; x=1691370288;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JTtsP0v5oCR6LBeoHSFqnBvz12KoS0FlBeCZr6L+XCk=;
        b=EEbOqNfzGk9NdulHTK8eDwTJH0WN2dUN+xGiLuw22d5Pzl3dtmFxonVumvjhG8IIEK
         KGycmALrU0HwvV+ctCUy5q3s3MCCO4tZGCCntJpr3XbWYUHAL4AsYunapbxHN6J9yVDt
         s9ZM3LuPRJI3pGZxjV3Q3Y9ye2zn31pl0G7KHCjrmpFCWP3SXEUw5lvyetd0eNFL/cQI
         Swj9kvigyjQGvE6pzLLmQ8xP6n5PNLVA+CzzferirlJXd1HeHBHP1cgKZ2LwClyjXk+Q
         RMU+osS9NFA/Tpw6QnoyhJX7NKAR2/1Na21D4yQrg9tsXiQmAXr/rPHLpVQMKudKER45
         d5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688778288; x=1691370288;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTtsP0v5oCR6LBeoHSFqnBvz12KoS0FlBeCZr6L+XCk=;
        b=BI4iREBgeAOHEVbQ67kGNXezVMp47VB4jPz8YsniaHkdTidKEx8Z1wKDpVSXuBtTqX
         dooKAa8au/BkYTLapphooNlnzdMsn5mw+bP1d6AZqeI2aHQp4fSrHPZ7n1HaYTiRhr3b
         Z1pgU0bec4UNATZ4bBMMa+wXbL55lQEUv4/gz1C2Tqs71XTvR+n0XzYW650fQj9sED28
         A8ueURPcPGoyffhA3CUHMZgLs6jS/wf332ySIt4cJrjhkqkt2R1af5jlpB4iEBqlyU2o
         58Vsp9oPxMLfQnUjlc5mCjl7lozG2QJZv7avd7IQluUQcdNGwjtPL5WWiDuSqw3eNptF
         vxxQ==
X-Gm-Message-State: ABy/qLb8KKpBoMyXYcB1/CvydL9kj+kaMPTRpkQnCDNBbpTa18oomd+v
        QjqfrBT9pfapZWeLsZP44fXr86Y69vE=
X-Google-Smtp-Source: APBJJlF7zGmHZWLyL31uv11hl78B0ytJC2f7B1jj63JJceBLaXURiLP7BWQRJ/+CDbc2+tjAw9hL9A==
X-Received: by 2002:a05:6358:7e8b:b0:132:f2dc:e961 with SMTP id o11-20020a0563587e8b00b00132f2dce961mr6673734rwn.10.1688778288367;
        Fri, 07 Jul 2023 18:04:48 -0700 (PDT)
Received: from [172.17.0.2] ([137.135.38.226])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902e90300b001a1b66af22fsm3832368pld.62.2023.07.07.18.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 18:04:48 -0700 (PDT)
Message-ID: <64a8b630.170a0220.5ca70.84e9@mx.google.com>
Date:   Fri, 07 Jul 2023 18:04:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5830325777436611266=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/4] mgmt-tester: Fix tests that consider 31 bytes the max adv lenght
In-Reply-To: <20230707224434.677627-1-luiz.dentz@gmail.com>
References: <20230707224434.677627-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5830325777436611266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=763577

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
GitLint                       PASS      1.11 seconds
BuildEll                      PASS      34.28 seconds
BluezMake                     PASS      1015.70 seconds
MakeCheck                     PASS      13.60 seconds
MakeDistcheck                 PASS      188.77 seconds
CheckValgrind                 PASS      308.41 seconds
CheckSmatch                   PASS      404.99 seconds
bluezmakeextell               PASS      124.11 seconds
IncrementalBuild              PASS      3196.63 seconds
ScanBuild                     WARNING   1268.29 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/ad.c:381:19: warning: Use of zero-allocated memory
                                buf[(*pos)++] = ad_type;
                                              ^
1 warning generated.



---
Regards,
Linux Bluetooth


--===============5830325777436611266==--
