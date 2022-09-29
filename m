Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4243C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 21:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiI2VQB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 17:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiI2VP7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 17:15:59 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700D9160E61
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:15:58 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-131de9fddbaso2256579fac.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=hqqOt6gqJFPJpY42Lr8wQ6mbHLKTUqmLiOU/MpJRs2Q=;
        b=evir3eblVOQ8VwNxP5LAQVzgdP27l5sK4nnalqoHWOGGeQgZbj5eSMbjnhbH9O2pc4
         6iiFoQWZv9jCY0Sg+Y8a0Zh6OaNvvVEsyln9xSqH1fQYNum+a17XFEQ8JM+imI2P3vCw
         3wShtInCX+IfPC38K8GaC2+Wu+D15A0SMFUCRH5AKuP2AFuq/F86EUmkhlOxcf6f96Jh
         L1bnaEMXOlncJAkd3cIJGHeEyxHK0Wg72kSvZ2qCXpzl+erSvUwg69WKF2vXDyvxGIoG
         B6zarJ6jjbu/MLqVg1kE++MGsmrMKePQsOspCzuWq5Z2OZlotYf8uycHMQbJOevkiEze
         5s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=hqqOt6gqJFPJpY42Lr8wQ6mbHLKTUqmLiOU/MpJRs2Q=;
        b=PX6rPqKz8/drSgU+UMqKJjuIv9u7bY5DpYiOvopBmdfYGHlt4r89KiC63iS6/FvKMe
         i/KiWUtXuOyoyfGewctGLrqbSS93hIAfO99bqGKzu5bpETyHao2Bk6+YWF7e5j+teBsw
         fgUcAi/1ReGjZOZqV2rLncA6MI2jfb91hmfe0tGNOUMJzD0Ew5GtcUOXO7cgjQwb5IT/
         Ilak7LAi8j6Q7NNJXqRp2u42JExJc6RC3CWwdAa0To4N4HdpDpuoKyA94jFCAMWoAR3h
         +UroU04C+9TR4mODazDOFjgXT+bNoJWifgI+zoD1Yp3O3i3VZIE4PzZFtYOELFKHdQH9
         t1lQ==
X-Gm-Message-State: ACrzQf041SqkpekMgKe1r2Z4nfwv0bhxi8hVPcIpsyWJbtT06GTOWEs5
        702vGM6CdwxiTcfmwNsADdEkG378JVo=
X-Google-Smtp-Source: AMsMyM6eEiz+8gg8Yqp9GtDHXE1MQrm+iDnrsg9FSetiGUb3Sqd5dkzHXhnUhbA/ENmt1hyQbPHZ8Q==
X-Received: by 2002:a05:6870:a18b:b0:131:a278:7db9 with SMTP id a11-20020a056870a18b00b00131a2787db9mr3037852oaf.201.1664486157424;
        Thu, 29 Sep 2022 14:15:57 -0700 (PDT)
Received: from [172.17.0.2] ([13.65.188.74])
        by smtp.gmail.com with ESMTPSA id g189-20020aca39c6000000b003431d9b3edfsm112522oia.2.2022.09.29.14.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 14:15:57 -0700 (PDT)
Message-ID: <63360b0d.ca0a0220.dfcce.0814@mx.google.com>
Date:   Thu, 29 Sep 2022 14:15:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0275584230302805566=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix user-after-free
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220929203241.4140795-1-luiz.dentz@gmail.com>
References: <20220929203241.4140795-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0275584230302805566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=682039

---Test result---

Test Summary:
CheckPatch                    FAIL      1.35 seconds
GitLint                       PASS      0.77 seconds
SubjectPrefix                 PASS      0.63 seconds
BuildKernel                   PASS      42.47 seconds
BuildKernel32                 PASS      36.84 seconds
Incremental Build with patchesPASS      52.41 seconds
TestRunner: Setup             PASS      621.55 seconds
TestRunner: l2cap-tester      PASS      19.43 seconds
TestRunner: iso-tester        PASS      19.76 seconds
TestRunner: bnep-tester       PASS      7.57 seconds
TestRunner: mgmt-tester       PASS      120.62 seconds
TestRunner: rfcomm-tester     PASS      11.86 seconds
TestRunner: sco-tester        PASS      11.05 seconds
TestRunner: ioctl-tester      PASS      12.94 seconds
TestRunner: smp-tester        PASS      11.09 seconds
TestRunner: userchan-tester   PASS      7.68 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.35 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: L2CAP: Fix user-after-free\ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: unsaf ("ace/src' is owned by someone else)")'
#86: 
Bluetooth: chan 0000000023c4974d

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: unsaf ("ace/src' is owned by someone else)")'
#87: 
Bluetooth: parent 00000000ae861c08

total: 2 errors, 0 warnings, 0 checks, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12994594.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0275584230302805566==--
