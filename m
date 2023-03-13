Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B1CC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 15:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCMPdO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 11:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCMPdM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 11:33:12 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9B111640
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 08:33:11 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id h7so7128802ila.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678721590;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nplReKHcNkwh6DwNm8gCM3kKPsmgx9uAmmfbPNbkSOk=;
        b=pYykhQZwCYhTvGhenfITKLJFZxvwBSPvuwqcwOi2W/KmHlO8eDia+cCRcnqFYlpu3F
         /cuq6lOgv3Y5ts+eWHbvk/AnDif8wPMt9Bh5Y23utvA+/jZnTPJl7iVekK/FzRiu5xIL
         18BkpFd/kVXVeKzlCaPf0fpV27L7Xcr+tX0MehFxcjuV2oW06BWTAc+FzyJXkBV0kTGI
         cLDDi5uT0Nax5s+NqFdCtvgqy3OYeRir7Euq/EioIWUafDA7zr0Agkcn9PInAK/4H9Hs
         vx8trXQrdZJTjzCQwOoCD/DpQYoDXkFafvGeUDrsOjNLG4fknGgurRPd4U5wBnP6CXvt
         PdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721590;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nplReKHcNkwh6DwNm8gCM3kKPsmgx9uAmmfbPNbkSOk=;
        b=1n4QOnJk6eKMXovAL+6zIL2qJRGkSzjTFcHIz5nXizTerQC7U8JukCDYumB+jt+pfw
         wJpcJiyi2BzmECmxOg6iMDBy/zfg+BOajQLYVvwDCJG0LyyPgRY89hivyUAcxdNBKYP9
         L+NpZKVL/91kf7DftIDTvDU1KNExSjF/JA3jcqcSJZsJlgXEWdPZmgJF8rKWihlp1yH9
         uI1PF0hMk2SN7qvyLfCf2QvXqgtwNLdbzq1zWpI3NM4xzvZcigLdaJOl2bm9Q/PQo+sT
         1TUxbfUYN7cbexdWSTxNus2VwWN2t7tvZ8suo6f2mt/js8U0YQ33jZCevCXqk/g+I3p/
         vl4A==
X-Gm-Message-State: AO0yUKWNPKushCKjgQbi4Yl8JeXp+deeOz6lIkx5w15u5XlSezl+3zr4
        mX4piN0cBSl/3tKtWcMndRkia58+vVE=
X-Google-Smtp-Source: AK7set8TZE4GNWa85+a31ehktUY+DhBoLPS+h2vjgp8vOuRhr0yYZpPu8BNuyxY8MGAdRjtTUO+mBA==
X-Received: by 2002:a92:c7d4:0:b0:314:5aa:94b4 with SMTP id g20-20020a92c7d4000000b0031405aa94b4mr119018ilk.7.1678721590182;
        Mon, 13 Mar 2023 08:33:10 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.242.99])
        by smtp.gmail.com with ESMTPSA id h9-20020a92d089000000b003179ae2fb8fsm55614ilh.2.2023.03.13.08.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 08:33:10 -0700 (PDT)
Message-ID: <640f4236.920a0220.e4088.033c@mx.google.com>
Date:   Mon, 13 Mar 2023 08:33:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7974655174732123950=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Add support to reset bluetooth via ACPI DSM
In-Reply-To: <20230313151549.15791-1-kiran.k@intel.com>
References: <20230313151549.15791-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7974655174732123950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=729488

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.68 seconds
CheckAllWarning               PASS      35.22 seconds
CheckSparse                   PASS      38.86 seconds
CheckSmatch                   PASS      108.73 seconds
BuildKernel32                 PASS      30.72 seconds
TestRunnerSetup               PASS      440.17 seconds
TestRunner_l2cap-tester       PASS      17.12 seconds
TestRunner_iso-tester         PASS      16.62 seconds
TestRunner_bnep-tester        PASS      5.35 seconds
TestRunner_mgmt-tester        PASS      107.79 seconds
TestRunner_rfcomm-tester      PASS      8.54 seconds
TestRunner_sco-tester         PASS      7.85 seconds
TestRunner_ioctl-tester       PASS      9.34 seconds
TestRunner_mesh-tester        PASS      6.87 seconds
TestRunner_smp-tester         PASS      7.85 seconds
TestRunner_userchan-tester    PASS      5.59 seconds
IncrementalBuild              PASS      28.02 seconds



---
Regards,
Linux Bluetooth


--===============7974655174732123950==--
