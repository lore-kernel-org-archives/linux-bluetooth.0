Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EA8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 18:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiI2SZw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 14:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbiI2SZs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 14:25:48 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8155213EE87
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 11:25:47 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so5907435pjb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=PeFiZj+/ijV7x7hn93BVwW5e8x24Tc7Ws8gBhotH2lU=;
        b=cJTyp6cQrtzx+MfQCPxc7mo0kijX4D9pUdNfiNfgRaZ6W6IeKqbYBSy+fDGZBm1jIa
         PZ1BTvl7rWbns+zb2JX0AagE2eRpgUtcHIdpDwXZeDX0GxYjUbtAjAkvsIU67g+kkCgR
         4gckI/USXv0YiWyzDJI1wLNxHrF0FluXcJ107YkElqgWHzTwDofp/OVsyn/PSGvWYHBV
         HaFS75OtM4dzZB94fun+bdRXm5W7IB7eOqp0JGW6VuLCTf4hdONS6R0T77JNJ9kOHc2n
         9M35O97RgFYCK43XZX/q5er4iWKJkoNUhhhGdocULoenF4P5V9YhBaA7R+O3xzLQm6pb
         HrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=PeFiZj+/ijV7x7hn93BVwW5e8x24Tc7Ws8gBhotH2lU=;
        b=QGJbb13auIav4DrTDp0cGIMIu+e81a81SyCZmwKD1tVvxf85zxi0Ef1F39yRaEJ8Uz
         DrLYOS22iO1FFqRX/C/wCacdpn5Nh8jTxa5r3r5mYXhBadx2xNexNPu9l8D9k9m6tQ6Q
         mTOQMsj5T2gFa1W55z/N05OBGQTR+QdAYs3Glj3+jXd00ZAfIF07xVcnTpadvGzY2BRk
         N0ZiiHfZSkrGukUJY2tU5iV+HMYo2owhkVBFhIXKFLCngZjwNK9DSbr9cVRSRacL0/wA
         +PN9BRjo4OVzBp/1Wlb+q943x7LyzlmI6ZXhTJAKtV72BhH8Kb0I+8/bRRKmdHk3ZDj1
         6Y+A==
X-Gm-Message-State: ACrzQf1uoQiTHkye4TdezJF55KT0FtUj/UbpA52neUov0hUQ+BYxIBx/
        TE5oHoU5zGeYcz0ozp6DOcRvvXyniU0=
X-Google-Smtp-Source: AMsMyM4+e92s0416TsZQcfhTIfetpk3g1bLR1NHathfVF27MNUc8ZxnWhAIEuXKOTM5wg2PgD06GyA==
X-Received: by 2002:a17:902:6b04:b0:17a:15a:1229 with SMTP id o4-20020a1709026b0400b0017a015a1229mr4493281plk.24.1664475946758;
        Thu, 29 Sep 2022 11:25:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.68.120])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902da8400b00174ce512262sm187811plx.182.2022.09.29.11.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:25:46 -0700 (PDT)
Message-ID: <6335e32a.170a0220.7cf4.0a7d@mx.google.com>
Date:   Thu, 29 Sep 2022 11:25:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7637052347469364539=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [v2] Bluetooth: doc: test patch - DO NOT MERGE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220928045348.210835-1-hj.tedd.an@gmail.com>
References: <20220928045348.210835-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7637052347469364539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=681300

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.34 seconds
BuildKernel                   PASS      40.72 seconds
BuildKernel32                 PASS      36.60 seconds
Incremental Build with patchesPASS      52.59 seconds
TestRunner: Setup             PASS      610.12 seconds
TestRunner: l2cap-tester      PASS      19.11 seconds
TestRunner: iso-tester        PASS      19.06 seconds
TestRunner: bnep-tester       PASS      7.55 seconds
TestRunner: mgmt-tester       PASS      118.26 seconds
TestRunner: rfcomm-tester     PASS      11.64 seconds
TestRunner: sco-tester        PASS      10.96 seconds
TestRunner: ioctl-tester      PASS      12.48 seconds
TestRunner: smp-tester        PASS      10.84 seconds
TestRunner: userchan-tester   PASS      7.62 seconds



---
Regards,
Linux Bluetooth


--===============7637052347469364539==--
