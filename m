Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8B4EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jul 2023 07:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjGCHh0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Jul 2023 03:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjGCHhW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Jul 2023 03:37:22 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EF8E43
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jul 2023 00:37:20 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76571dae5feso382091385a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jul 2023 00:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688369839; x=1690961839;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SmDabrPjS0rFCjHUVJObSe/97OS/eWOtyIcAxheddvA=;
        b=VojUk4cmPduvtGdFdcFi+3qQbnNuJXX0xG0gN0ahcJ7abtnCKje6MSTayVWudwkAZB
         2JVHbdASVPjcj/fjcepY4mKugQO2fPhailLnWkKwwBiKF5BLPjVOopdigg15XJSmUhvm
         3ZdHyMdQuEJCnw3qNaKzTaLwkIDDFvIEon9L+I0X/Hv+LPo4XZEi90j3MLTRQWKwt8QB
         x5zSOlbzh7MILdPsOgcxNNobv1FWEfEExpZulv0XtBPPnUlB4xpzBTQst0N2ieQHq3+P
         gP2tToWyxc/5QTvsaA9bdNMc0EpIwFt0cohDhZWuTet7iDXchuioq5W2K8cTF3asxHmx
         eFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688369839; x=1690961839;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmDabrPjS0rFCjHUVJObSe/97OS/eWOtyIcAxheddvA=;
        b=JG+6EVWD4cqZ9Ls5utURYCMTj5N9ILDBbDHtL6c6aPytGbqohOiAqkDSXRP1GGKyY6
         IKvuWe162OHfFJ+yFpBpO+N02plaMtlm1aYIAsMMUZCnMlhPmtmu9ly5N0T7O8h3K9We
         /D95Fh3U4OWQcj4S3+9JQ+2pTIVZAGPQ3jKUPfyYcUPy9EO3Bvdz9ZiPH4YLk48+NBxZ
         GH2IUgrUryxvaqhojRerBCZDRqIbyOfpK/+/AuPVjIkVU1MFiSNjGhIz0fSFwoT9QMMp
         Nn23xEHsQsLeZ4D+tzPGV3lUgkO2WKzHiwEcmWuhOurhTMVyOJCpH7kxxV0ajpI40K/8
         MsfQ==
X-Gm-Message-State: ABy/qLYmMZw4aMrkBNvQ8EDj+zgBUgnKC/B3z1g6Hs06GD+o+uQNZSi1
        QtgBYs9IYnxliWqjJGIFwSVj03el00k=
X-Google-Smtp-Source: APBJJlFMWfh6Q7qdCjrjSmNKDC2MWG+eD7s7M5biTTyAo8R40rucWUNjIVdI+/HWOcJNS+8hNtRWug==
X-Received: by 2002:a05:6214:2028:b0:62f:fad5:1e97 with SMTP id 8-20020a056214202800b0062ffad51e97mr16126782qvf.8.1688369839073;
        Mon, 03 Jul 2023 00:37:19 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.146])
        by smtp.gmail.com with ESMTPSA id l11-20020a056214028b00b006238b37fb05sm11108203qvv.119.2023.07.03.00.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 00:37:18 -0700 (PDT)
Message-ID: <64a27aae.050a0220.3f36.9a43@mx.google.com>
Date:   Mon, 03 Jul 2023 00:37:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2946667557739867956=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Notify user space about failed bis connections
In-Reply-To: <20230703070238.4193-2-iulia.tanasescu@nxp.com>
References: <20230703070238.4193-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2946667557739867956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761909

---Test result---

Test Summary:
CheckPatch                    PASS      1.75 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      40.20 seconds
CheckAllWarning               PASS      43.32 seconds
CheckSparse                   WARNING   49.56 seconds
CheckSmatch                   WARNING   133.03 seconds
BuildKernel32                 PASS      38.73 seconds
TestRunnerSetup               PASS      543.68 seconds
TestRunner_l2cap-tester       PASS      16.41 seconds
TestRunner_iso-tester         PASS      30.26 seconds
TestRunner_bnep-tester        PASS      7.77 seconds
TestRunner_mgmt-tester        PASS      162.96 seconds
TestRunner_rfcomm-tester      PASS      11.73 seconds
TestRunner_sco-tester         PASS      12.88 seconds
TestRunner_ioctl-tester       PASS      12.47 seconds
TestRunner_mesh-tester        PASS      9.27 seconds
TestRunner_smp-tester         PASS      10.91 seconds
TestRunner_userchan-tester    PASS      7.73 seconds
IncrementalBuild              PASS      36.31 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============2946667557739867956==--
