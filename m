Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F9AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 14:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiKVOfA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiKVOex (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 09:34:53 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42062AE16
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 06:34:52 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g62so14521789pfb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 06:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HZlu6be2IgFDn4h8g7DTpZauPsunSAgUr7tCJoCoqlg=;
        b=TYbCTR3Mf141uCD7HveLyaUcJvIzh6GO2FtbNhRNWmg/1tEjcq/clh159FVlyqMCsG
         i6appJfI+XMgMVqyaZvoLQYaPYHAh1wpv2dlMZCNZBg4iSrSWxkfp6ruyJBFXzll+LQN
         k4qtoJe/6QaQ+TESjqVnmsqNUQ/+ACrPaPw4QC+XmVrFdiTYnHRvkHlUuwG7XB3oHo0u
         aVchdQ0C/CfY9x8O21ur2Vm35cF51yD0SbZXVhFVWx2Y+FJ1B25ATKON5XdyXwNzsDrB
         CnkLGWlWMwMckGQ5gbLS1nDIlmT9yknw8u6wlSSHXtJTZhLWj+Nx2CFG5nxqnJxEOqZs
         YaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZlu6be2IgFDn4h8g7DTpZauPsunSAgUr7tCJoCoqlg=;
        b=SsWbg6J0/8k0li2WczyZ2jlOn0ATdR1wb6ZvLO7miLiJ8E8dYLOD+Zz1E2BR9Sv/3s
         X1924a9e6QsmhMwpvUvSg+kNDn9i5QxCz9amLUhq3jf5PXK46OLC5r/du4iwObXP6Apk
         DCmshY7BaifgzhoC4gQKUhNtDZr5sjZaqqPfv01bAZhtK77Yclw8h9HI1U+HaR3cfcrL
         c9TEdQKmhnqatqyRTSrbkqTajtfWFiKvf4G0Vk4JbCPSlEofaYD3+FDrZaJ5i8B2+TQt
         N0EcdenRO0uiYRqyrZa7MZiCdEW9/1YBpWIeIj7e97bGhML7jgJGyrQxEy/Q9kHvIRtd
         LEWA==
X-Gm-Message-State: ANoB5pmJtVMe35KpM1MhG/Mp9JPJKcktSC6+fxsznX6zeczZYEAzeMH+
        ocTdeCO6bsknn66OPm3UJQ/IHOlcVXY=
X-Google-Smtp-Source: AA0mqf7MBbYWza5j0CBnEhx3/WwyamE+ISzYl0j3HHwYyoLC5tvmupAp/sFhh/ZwgCpdu5EGgkI0Aw==
X-Received: by 2002:a65:594e:0:b0:46f:f911:eee with SMTP id g14-20020a65594e000000b0046ff9110eeemr4321692pgu.432.1669127691740;
        Tue, 22 Nov 2022 06:34:51 -0800 (PST)
Received: from [172.17.0.2] ([20.237.213.65])
        by smtp.gmail.com with ESMTPSA id y185-20020a6232c2000000b0056ddd2b5e9bsm10737447pfy.41.2022.11.22.06.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:34:51 -0800 (PST)
Message-ID: <637cde0b.620a0220.82b2d.0dc7@mx.google.com>
Date:   Tue, 22 Nov 2022 06:34:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2992039303489546795=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dimitri.ledkov@canonical.com
Subject: RE: [v5] Bluetooth: btintel: Correctly declare all module firmware files
In-Reply-To: <20221122140222.1541731-1-dimitri.ledkov@canonical.com>
References: <20221122140222.1541731-1-dimitri.ledkov@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2992039303489546795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=698114

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       FAIL      0.61 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      46.92 seconds
BuildKernel32                 PASS      43.17 seconds
TestRunnerSetup               PASS      584.95 seconds
TestRunner_l2cap-tester       PASS      19.88 seconds
TestRunner_iso-tester         PASS      21.58 seconds
TestRunner_bnep-tester        PASS      7.21 seconds
TestRunner_mgmt-tester        PASS      140.75 seconds
TestRunner_rfcomm-tester      PASS      12.20 seconds
TestRunner_sco-tester         PASS      11.33 seconds
TestRunner_ioctl-tester       PASS      13.48 seconds
TestRunner_mesh-tester        PASS      9.50 seconds
TestRunner_smp-tester         PASS      11.12 seconds
TestRunner_userchan-tester    PASS      7.51 seconds
IncrementalBuild              PASS      44.08 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5] Bluetooth: btintel: Correctly declare all module firmware files

23: B2 Line has trailing whitespace: "    "
27: B2 Line has trailing whitespace: "    "
31: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============2992039303489546795==--
