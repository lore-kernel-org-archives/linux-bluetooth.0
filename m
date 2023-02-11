Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A85CC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 21:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBKViD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 16:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBKViC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 16:38:02 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E328D11674
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 13:38:01 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id q13so9991503qtx.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 13:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N323LhmidLgR5WKA7JmuQStBGKhsvILi7BlOV/qFXwg=;
        b=Q50Ya/Z5lQ8mYWw1IlRlByQsTNB76u7PBejGV9JJuGiG2NZmiCJZBv7dJhSM/gfmAg
         Oys0pSUXhip3SGzrNi/2/kRlacBI0WmnBZNOp6KMaefaSzKBhB/6hzWlVy9FKKXoXG42
         SI1OTYWXgC++0TcqvqYmFkHCqsKesJNVa2YAAHNGp0bMgSlf/sG/lfvSw4teX4Wlbmsa
         EIhAP/ka+sosfNK+NzuVS1gZeaLq8XVhz9EN1RM9c9CVAq0w+9u+vm0JTG7V1gMGdiL/
         2pOT57SjKZDbtPc9eSbt8pSmSNgwRU0l28unKmDRnaKtWTNdgWcEXFc+jys2vMlPSFEW
         dj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N323LhmidLgR5WKA7JmuQStBGKhsvILi7BlOV/qFXwg=;
        b=r9zUAKei1zwhLBBQIB33aI6jZVc7aN0IjvwLAM2p1xjgDJIZRAQhkV30d/9obqiChO
         S9sm0OJMOOxOhrRu9VQkNPUFAFrNLla3CbJvwvDfSCQfJC6gB8/djwotU71c+90Bz8Xq
         nYOzYYL4sCkyWN1wb5BdT10mvnTqpLbBIU0WpDFvZVT9M1ETj784HDlzDZBFTk5FD2Mf
         QmyxkiXE4qZqFNibLeLblR+zMt6ll+7YArVaM+hzp0RSkieZIUZWmAqa/l1VYjhlOx4B
         9/8MptYhIP0iAAlNrM+IMgRrQVVujphLc6dHysKL6Si+kUZSkZau13DwDBUswMG79TmF
         cZXQ==
X-Gm-Message-State: AO0yUKUebsiAycah9iZ3d6oIBARPzktOS6fxzrGAb9Nfz1i8gxcqI+ru
        bxieGJm233XMoWvdIkbG/kik5Rwh9tM=
X-Google-Smtp-Source: AK7set+/0E5SNJLD7+UM7GB07j1sFZ5ahn//KylB3dM7e5eaGgDtBBhkfJuNgUwNNX9u63dvTEWSGg==
X-Received: by 2002:ac8:5e11:0:b0:3b9:a4c8:d57a with SMTP id h17-20020ac85e11000000b003b9a4c8d57amr33990469qtx.32.1676151480931;
        Sat, 11 Feb 2023 13:38:00 -0800 (PST)
Received: from [172.17.0.2] ([104.45.203.177])
        by smtp.gmail.com with ESMTPSA id v129-20020a372f87000000b0070495934152sm6432979qkh.48.2023.02.11.13.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 13:38:00 -0800 (PST)
Message-ID: <63e80ab8.370a0220.1658b.468a@mx.google.com>
Date:   Sat, 11 Feb 2023 13:38:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4878927935278798844=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/2] shared/bap: fix local endpoint state to be per-client
In-Reply-To: <a0b0c0b71c0bbf0e200fd01619901bc5fa00e531.1676145318.git.pav@iki.fi>
References: <a0b0c0b71c0bbf0e200fd01619901bc5fa00e531.1676145318.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4878927935278798844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=721007

---Test result---

Test Summary:
CheckPatch                    PASS      1.20 seconds
GitLint                       FAIL      0.99 seconds
BuildEll                      PASS      32.90 seconds
BluezMake                     PASS      1023.32 seconds
MakeCheck                     PASS      12.94 seconds
MakeDistcheck                 PASS      183.68 seconds
CheckValgrind                 PASS      298.03 seconds
CheckSmatch                   PASS      394.87 seconds
bluezmakeextell               PASS      119.38 seconds
IncrementalBuild              PASS      1661.75 seconds
ScanBuild                     PASS      1231.11 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/2] shared/bap: fix local endpoint state to be per-client

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
22: B2 Line has trailing whitespace: "    "
24: B2 Line has trailing whitespace: "    "
27: B2 Line has trailing whitespace: "    "
29: B2 Line has trailing whitespace: "    "
30: B1 Line exceeds max length (109>80): "    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e000008d20 ep:0x603000042f70 -> id:1 state:0"
31: B1 Line exceeds max length (109>80): "    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e000008d20 ep:0x603000043330 -> id:2 state:0"
32: B1 Line exceeds max length (109>80): "    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e000008d20 ep:0x6030000436c0 -> id:3 state:0"
33: B1 Line exceeds max length (109>80): "    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e000008d20 ep:0x603000043a50 -> id:4 state:0"
34: B2 Line has trailing whitespace: "    "
36: B2 Line has trailing whitespace: "    "
37: B1 Line exceeds max length (109>80): "    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e0000095e0 ep:0x603000042f70 -> id:1 state:4"
38: B1 Line exceeds max length (109>80): "    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e0000095e0 ep:0x603000043330 -> id:2 state:0"
39: B1 Line exceeds max length (109>80): "    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e0000095e0 ep:0x6030000436c0 -> id:3 state:4"
40: B1 Line exceeds max length (109>80): "    bluetoothd[139699]: src/shared/bap.c:ascs_ase_read() bap:0x60e0000095e0 ep:0x603000043a50 -> id:4 state:0"
41: B2 Line has trailing whitespace: "    "
43: B2 Line has trailing whitespace: "    "
52: B2 Line has trailing whitespace: "    "
56: B2 Line has trailing whitespace: "    "
60: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============4878927935278798844==--
