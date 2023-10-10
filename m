Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44703CD68E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 02:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441848AbjJJC0M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 22:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378796AbjJJC0L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 22:26:11 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C6AA7
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 19:26:10 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77432add7caso297587585a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 19:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696904769; x=1697509569; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ahaOyyuk9B8UJytux7L3k7HiwgKUX5JT/mTM+EXP6vg=;
        b=ADnj1XLQTa5Q00X2mzdP6TBq1S/nZcAyjyZPD3qnwQjls7k/vX+DRugM0RdpG6PgsK
         Ad11KHj2aMguPkVrDHjrTxOtYrHTqU3bw22ldJBzxTdWV0ORCowsJEZUFyorKZuZPKLF
         2mvnMhosvh9NoIvsZ4sheHmuS3S176/N1Yp7qMm/Nfu7iI/1ZZFGpOWWAzzUbceMiQMj
         Av8C6S+Scll2x9nEJl2MJ5IyjuG+rpw+QAXcw8lJEjVMqG/wlaydHSNoWCxAro2X17le
         j/Q/hOMvX0TbWig8b2NFJ4Onprr8pDvHCZnWGmeLTLJ2rDB3QybaIqpxnYRfNU53w77K
         e7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696904769; x=1697509569;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahaOyyuk9B8UJytux7L3k7HiwgKUX5JT/mTM+EXP6vg=;
        b=bxFqYvJv9IpZphQbRaOWXCnz+U5s/xFiE8YuFPk3pnOPfT/Qyq3nZlI89xO5nIjPKn
         pOlshcSSGSHke0qHPkKIbQ05LIe91ZmIDhkTzqvNZ3ZWQdzyC9mdosaZLleg7e507ABD
         a2dDqbMAyii1ogdivjXzCpZBfX7+X5qyA+kihHfkMI4/wuH+ap6mRpUA+synZ2ouIzQp
         UcNKwoAve0Dayh1DfFb7B9G4MO/5W0+ginwuYgn0XQRaAiBlD+FB9OYEwEVMN6isTh1p
         bRY8FzWy1VMIXJXuIz48P4JCiJ+Xdi8xXAjGsLpZSY6nZLODr/pdHqLBYZ66lc78tOeb
         u8/A==
X-Gm-Message-State: AOJu0YyUHFToHmiKaC3RmGM2krsGNoDs1L2vDnbeKFUswNSnQkk6E0D6
        E5fjZXZV5MEcwbPNWkl7cfrbhfRwsbw=
X-Google-Smtp-Source: AGHT+IHQBoo+NoMRm/vCKTz3Onrh96TI973lEOagfgSvWDfXDXYk1uHl7QktT/nkYjmsJCnDoIiSIw==
X-Received: by 2002:a0c:dd90:0:b0:65b:177b:a430 with SMTP id v16-20020a0cdd90000000b0065b177ba430mr16886397qvk.47.1696904768909;
        Mon, 09 Oct 2023 19:26:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.124.94])
        by smtp.gmail.com with ESMTPSA id v9-20020a0cdd89000000b0064c1b27bf2dsm4281912qvk.140.2023.10.09.19.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 19:26:08 -0700 (PDT)
Message-ID: <6524b640.0c0a0220.1ecad.1227@mx.google.com>
Date:   Mon, 09 Oct 2023 19:26:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5033564976008541973=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,01/11] doc/adapter-api: Rename to org.bluez.Adapter.rst
In-Reply-To: <20231009232933.500652-1-luiz.dentz@gmail.com>
References: <20231009232933.500652-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5033564976008541973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=791597

---Test result---

Test Summary:
CheckPatch                    PASS      5.17 seconds
GitLint                       FAIL      3.88 seconds
BuildEll                      PASS      28.05 seconds
BluezMake                     PASS      786.38 seconds
MakeCheck                     PASS      11.55 seconds
MakeDistcheck                 PASS      165.95 seconds
CheckValgrind                 PASS      260.49 seconds
CheckSmatch                   PASS      353.50 seconds
bluezmakeextell               PASS      108.82 seconds
IncrementalBuild              PASS      7338.07 seconds
ScanBuild                     PASS      1045.91 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,10/11] doc/advertisement-monitor-api: Rename to org.bluez.AdvertisementMonitor*.rst

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[v2,10/11] doc/advertisement-monitor-api: Rename to org.bluez.AdvertisementMonitor*.rst"


---
Regards,
Linux Bluetooth


--===============5033564976008541973==--
