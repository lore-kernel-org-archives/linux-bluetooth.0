Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4FBEEAA7B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 22:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjINW4A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 18:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjINWz5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 18:55:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8342707
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 15:55:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-274972a4cb6so176904a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 15:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694732146; x=1695336946; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o8PJROiuCvCgMLZ7FN9RUBACSnc66fca4i0+hGdxUbQ=;
        b=OUdMlVcNUpoviz91tnEtgSLJbISb93eX3yInxOfX/YC/DLzZScGthuXg3UNbG0qvQ1
         b1t8miQ4OzyWz6x/WGajK1NX8ppN//bYprg/CEKKKr8fA2xnrKx2/sSK1CVHB1ALyHxq
         nfGrTgbwmifgt7qQN63bOn+//rVkwG2qBR53QNq6AiUtkT9mG7Y5udqjaqce9hjSXxZD
         hIWt9lfxqMNoHODAHomfB4qfdiTmow8iUeMPcPUIDbJZuPO/y21ssWimT2U1nrroxWZG
         pnBEEl0m+DcM2v/UQx6Ntf9VYd7hvW5spY7YebKEdeSDo2pmoJcSCoFKpqKeEm/PpnUg
         trpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694732146; x=1695336946;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8PJROiuCvCgMLZ7FN9RUBACSnc66fca4i0+hGdxUbQ=;
        b=PruYESm1wfYhGoFvE9Oa0szLPKsdkR8PXHZ1cKudYbkHUHg1wBUVlG3WtZNDKSIGE2
         ZIN4Taq9Wekq6R5FTgmG08TNAb7Fv8OURZnw+9Q/5xHqkjLFPqOmFhhGQimzz8CJWfrK
         I/EYzl6bzTJg1YGJvMm5VoFDqVTVbznlFGGWH5nsTspN/CdlCzfEW4kdlsa2cmHOMNID
         1SgpxAxg9glk6peY/GbE+NfPAqodMJmmuRKux26k/CdcHuRhWDrYx5r45F/iFrzQQnh1
         2A5E2RrPdfYAXAGM0XG1519VJw5Ja0aF7Pg7gK4xxZRkm7rc0hutcHjyE8gbSRxWxrQ6
         i/Ug==
X-Gm-Message-State: AOJu0Yy+oN62qK7tzXQXEKe1oND4dET/HnTHp7q4KdI5I0oDoH0j7ThO
        1Xwxkwuyz7okZczbXpXjQH/GzdfSGBo=
X-Google-Smtp-Source: AGHT+IFD5NK8tJRgqoN8OFgIdu11rL2W308fGUy0hmqv5yax18prNmx0A0FMUbMkWoU3eHp4wEx6IQ==
X-Received: by 2002:a17:90a:fb98:b0:274:9823:b481 with SMTP id cp24-20020a17090afb9800b002749823b481mr503613pjb.9.1694732146026;
        Thu, 14 Sep 2023 15:55:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.158.209])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a004b00b002694da8a9cdsm1965058pjb.48.2023.09.14.15.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 15:55:45 -0700 (PDT)
Message-ID: <65038f71.170a0220.e51e1.863a@mx.google.com>
Date:   Thu, 14 Sep 2023 15:55:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4634514226402255558=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] l2cap-tester: Add tests for closing socket before connection completes
In-Reply-To: <20230914205949.3334335-1-luiz.dentz@gmail.com>
References: <20230914205949.3334335-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4634514226402255558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=784340

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       FAIL      0.85 seconds
BuildEll                      PASS      37.63 seconds
BluezMake                     PASS      1261.67 seconds
MakeCheck                     PASS      14.05 seconds
MakeDistcheck                 PASS      214.96 seconds
CheckValgrind                 PASS      338.27 seconds
CheckSmatch                   PASS      480.74 seconds
bluezmakeextell               PASS      145.79 seconds
IncrementalBuild              PASS      2183.73 seconds
ScanBuild                     PASS      1510.61 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/2] l2cap-tester: Add tests for closing socket before connection completes

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[BlueZ,1/2] l2cap-tester: Add tests for closing socket before connection completes"


---
Regards,
Linux Bluetooth


--===============4634514226402255558==--
