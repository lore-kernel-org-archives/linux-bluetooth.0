Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B129C77B75
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 May 2023 21:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjEVVtH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 May 2023 17:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjEVVsq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 May 2023 17:48:46 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54077133
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 14:48:41 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d18d772bdso5875141b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684792120; x=1687384120;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A75u9xtzVnwtyb63Z4MqKzIh6elW7S6nWHOPMie9nJU=;
        b=A3aOGgG4UC9hCMMdNPNZsCCoiRzkF/8xL75bcoLoPMIlAEVQdNzSScQh/LFbQbY9+9
         BcPryKj7mWqaOfn1OOxsiLy9lQLYAEvVynv1CIGp9nEYDk2D8A4DjTuI1e7enBsTBE4j
         8+HEFGVguWKQ8D7h2kbxI5HqywQ80S0qYFu/rA0lSuHSsVyiPDMT6E3PTkQRxVCmdO8i
         b20Fx44jZRJdwZMJB7B3AMAGraEgZ2ZrZvKejuE5KUDgMdO6ES5JVV2WlI5zAGmd67nk
         hyBDYK5U4dYs4QUX5oRAZCKQ2R53umSPNFz/v4uv+YEhMkK9UsJAfEYj4pWeFEIJveDI
         GOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684792120; x=1687384120;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A75u9xtzVnwtyb63Z4MqKzIh6elW7S6nWHOPMie9nJU=;
        b=IWqDxATWvjNp9ZpQVwGZZJXKIuUwl/wlMC06bUA+EHiSMmpmJrOzAiVyQWCFCjbjDQ
         zftaS/l3RkEm0jRN/HdIXV738Dhd20TEXrOLtMXPE46re9Mw6dN6UQzds6uLbwjCmyb5
         RJv/J5xjSM/ZtiRmA/Lc+fUr+xTMEajqvAg50U/qs+Ten5YypTCpy959YNlj+uqZJQK+
         rKK2/W7hCJEmNokn7N0a5f7pz0uRl56TvS3d7ujINIefIgV5JZWfcsoEAjEoRL4oo9bB
         MW5ABbNcSi46dA1+FrzPdUddbIN+/nO8+1udGJl1kUyENgACQYTwG5nLfc/LpnSWE1UQ
         X96g==
X-Gm-Message-State: AC+VfDyDs6Jyttj5d+dEf7HNzh2SNFahX7eOZczHoX5aVwGuDdrdPSYD
        j3hiuHT+J4TQW/0ltIUGZN5dU7n8r5k=
X-Google-Smtp-Source: ACHHUZ7HAXUya5wmO2IuUqz+S5jwIZrfCt9QzV+IniXEgpzcciGS3K3mIYAtw6SawfFu/IfW8+oepQ==
X-Received: by 2002:a05:6a20:8421:b0:10b:5305:6a11 with SMTP id c33-20020a056a20842100b0010b53056a11mr6586109pzd.52.1684792120480;
        Mon, 22 May 2023 14:48:40 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.36.243])
        by smtp.gmail.com with ESMTPSA id 26-20020aa7925a000000b0062e0515f020sm4486886pfp.162.2023.05.22.14.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 14:48:40 -0700 (PDT)
Message-ID: <646be338.a70a0220.bf547.7f97@mx.google.com>
Date:   Mon, 22 May 2023 14:48:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5074032927024958961=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2,1/2] Bluetooth: ISO: consider right CIS when removing CIG at cleanup
In-Reply-To: <2bf70b0560375b50180518968abd8c4dfcce7f34.1684788145.git.pav@iki.fi>
References: <2bf70b0560375b50180518968abd8c4dfcce7f34.1684788145.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5074032927024958961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=749935

---Test result---

Test Summary:
CheckPatch                    PASS      1.23 seconds
GitLint                       FAIL      0.83 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      42.43 seconds
CheckAllWarning               PASS      47.20 seconds
CheckSparse                   PASS      53.66 seconds
CheckSmatch                   PASS      141.21 seconds
BuildKernel32                 PASS      39.84 seconds
TestRunnerSetup               PASS      572.92 seconds
TestRunner_l2cap-tester       PASS      19.08 seconds
TestRunner_iso-tester         PASS      25.65 seconds
TestRunner_bnep-tester        PASS      6.73 seconds
TestRunner_mgmt-tester        PASS      143.08 seconds
TestRunner_rfcomm-tester      PASS      11.26 seconds
TestRunner_sco-tester         PASS      10.24 seconds
TestRunner_ioctl-tester       PASS      11.53 seconds
TestRunner_mesh-tester        PASS      8.35 seconds
TestRunner_smp-tester         PASS      9.87 seconds
TestRunner_userchan-tester    PASS      6.99 seconds
IncrementalBuild              FAIL      0.94 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,2/2] Bluetooth: ISO: fix CIG auto-allocation to select configurable CIG

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
16: B2 Line has trailing whitespace: "    "
21: B2 Line has trailing whitespace: "    "
23: B2 Line has trailing whitespace: "    "
24: B1 Line exceeds max length (83>80): "    ISO Connect2 CIG auto/auto Seq - Success             Passed       0.148 seconds"
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

error: patch failed: net/bluetooth/hci_conn.c:950
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


---
Regards,
Linux Bluetooth


--===============5074032927024958961==--
