Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB60E732DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 14:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjI1OhH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjI1OhF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 10:37:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0EDF9
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 07:37:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690d2441b95so9963798b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695911821; x=1696516621; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zrU+HX31od04wR/b4Jpk0uYQfP+wb+GkzBjFuYDzCT0=;
        b=LLaqOTqiEFYiNV8iL1N0sSCUo916mNBfnLMDTkrLpAkPJ5JgVz6cVpCH4lw79dibNp
         mH+smQw8xqfqyjhFZFCHJazSmJQq+cqMaT1/CCIEhFiqhYNu7pLtl5pqBJJI2WOktRIW
         OYWXnJ75SYAQJRArSb0/2cRaqXAUcHRBkai1NePS6ZGe6LIipb7fp5mDgSY7ZuGEZtXH
         0D6W1iFJKA3aMAhZFQVDsSooWhqbcF/5u3t1j+fxOD+T4m2zgIt7n+BArdH2c7s/3rU7
         1lFo3/bCyx3ahe2yBC3Doguq1fNz67/rk/jGiVeKZcBT3ojjqvjL6T1YLmvpd8BaaEe+
         Co6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695911821; x=1696516621;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrU+HX31od04wR/b4Jpk0uYQfP+wb+GkzBjFuYDzCT0=;
        b=XwsMMB1N0DwtdZiy3I4Xie2CVJ/IqD37ji3S777Wiki9c1MWZX91T5zjgm7IzjFJHv
         YtAHK01YLBTgHvFWHjWFAGLCZzYrYmyr5DsiAjtjTJf4Iw/mL7MUoSwMX7lsLm+qofBI
         uSLXAGb/68DptqCqSxbrIa9bTnqW9xegdvYKuvBTlXQYN+RAhkP3gGg5m2EjDubYXgvf
         8eosBSohnroLnYcU7xSovvXyfxnScVi9o2SbdkUZNXCcXaPeZPA7vs/jYCEo6YLQh/dP
         msSYAOSDheFYNsf+zggiR3LBMshhHdmzAm/QnPGeasZjvNIPefO3farh6wUoBVMesjdg
         IG2A==
X-Gm-Message-State: AOJu0YzJSkMoGnnR3U1RT1yVWS6FgsdNKAygsGMAYiJrJ9K4/LPKr/71
        BFSJCsVifooY74uo0XoozBzxriAxy1M=
X-Google-Smtp-Source: AGHT+IGbgtEM5VzvmPqUsIElLtywEy/E85gcGZuCf3V7a5UKIwhg2Onx5zf4+D9+YEyfxvVRSbOKNw==
X-Received: by 2002:a05:6a00:488e:b0:692:6417:728a with SMTP id dk14-20020a056a00488e00b006926417728amr2220614pfb.14.1695911821396;
        Thu, 28 Sep 2023 07:37:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.79.74])
        by smtp.gmail.com with ESMTPSA id do17-20020a056a004a1100b00692b0d413c8sm11014352pfb.197.2023.09.28.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 07:37:01 -0700 (PDT)
Message-ID: <65158f8d.050a0220.9b989.8bab@mx.google.com>
Date:   Thu, 28 Sep 2023 07:37:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3807104614511106023=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, a.bokowy@samsung.com
Subject: RE: Bluetooth: MGMT: Synchronize scan start and LE Meta events
In-Reply-To: <20230928134506.130545-1-a.bokowy@samsung.com>
References: <20230928134506.130545-1-a.bokowy@samsung.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3807104614511106023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788539

---Test result---

Test Summary:
CheckPatch                    PASS      1.39 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      33.64 seconds
CheckAllWarning               PASS      36.99 seconds
CheckSparse                   PASS      42.11 seconds
CheckSmatch                   PASS      116.32 seconds
BuildKernel32                 PASS      32.69 seconds
TestRunnerSetup               PASS      492.39 seconds
TestRunner_l2cap-tester       PASS      31.92 seconds
TestRunner_iso-tester         PASS      53.94 seconds
TestRunner_bnep-tester        PASS      9.85 seconds
TestRunner_mgmt-tester        PASS      214.21 seconds
TestRunner_rfcomm-tester      PASS      15.19 seconds
TestRunner_sco-tester         PASS      18.47 seconds
TestRunner_ioctl-tester       PASS      17.18 seconds
TestRunner_mesh-tester        PASS      12.62 seconds
TestRunner_smp-tester         PASS      13.45 seconds
TestRunner_userchan-tester    PASS      10.45 seconds
IncrementalBuild              PASS      30.58 seconds



---
Regards,
Linux Bluetooth


--===============3807104614511106023==--
