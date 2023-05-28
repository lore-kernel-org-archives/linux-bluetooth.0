Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07095C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 19:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjE1T3r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 15:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjE1T3q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 15:29:46 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5674EF3
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 12:29:28 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-61cd6191a62so14355026d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685302167; x=1687894167;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf2Qh2eNXLY7KIfNoNUXCkuk09UbeiyszL1kRRBgy28=;
        b=JNJsb+Lvsei70VqKVWeIdCABP3MzY/ido21tmEm50vmvy+XVaoViWh7PYCSbWj3tbI
         mlAoboKtHPZK/ALBLNtXjHeRdPYAR+6zzzDbRTfejJ1QgmLgpCCzBRTvg5dGW1CcaIR1
         nncn5aCR1Flwnvz6v5vdeI11Mm3MQLjQTe2XBrs0n4dLzLodBl1CAiJQpIJ0su+tUa3C
         cW338BJPPrBQWNEwxODDAJ4NM7k4vTH8wOIafqvBxwLBIf3qBFwtYcGaNjWCHO0k8Ra9
         jj0fL0FzNxfh5y4toRAmRhOwvxwyHW4eqIj4fJl/k5p627R77e4tTEkzsQEpcYXIP4qH
         7ebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685302167; x=1687894167;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xf2Qh2eNXLY7KIfNoNUXCkuk09UbeiyszL1kRRBgy28=;
        b=Gz7AkwimyI8eTtLJXC5uYY4+KxdGZ+UTGOuvDdzIzN/7Ivho1GrX4BZo69mt41NS3G
         L4Xi+vE1MmT2Tl2U0TpPp89U7pkGiGMTo12wsdiNA7cCnTKhS166/Qa7gk2+iqAR00wB
         VNhscpocsfQeZItwpZTF5DaQ3uo6EGwWWeC+C41Qu3U2M08RXXj3LQuWTagcQf5XU3/E
         Z47OPlWNndsqZPmTHT7SFekW6z9e7o02y31UoZlFOuXFAIzl9FzJkjGEmzijVdjIKpUQ
         qXJ1B10V9heJKkMaxoRwEnEXetho5LAzV8UuSk3i+bYMCEoKpgmYVYbUJc5BQwhNtp1Z
         T0FA==
X-Gm-Message-State: AC+VfDxTc0omspW22mraij4vQvbzhajRnGadcjXJN+yON47tbgvRjepS
        QqQWA+X7Ou0H/qIaN5puKjGy8JVPLJI=
X-Google-Smtp-Source: ACHHUZ60T/+d72Sd2xLccIxevpBPninx0nDL6GlNAGTmB7Bpva2oUfPCg0RWrmvW8qEkle7dgGmOOA==
X-Received: by 2002:a05:6214:3001:b0:625:aa48:def6 with SMTP id ke1-20020a056214300100b00625aa48def6mr9635353qvb.54.1685302167229;
        Sun, 28 May 2023 12:29:27 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.147])
        by smtp.gmail.com with ESMTPSA id pz6-20020ad45506000000b0062618fe128esm1093199qvb.56.2023.05.28.12.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 12:29:26 -0700 (PDT)
Message-ID: <6473ab96.d40a0220.eb982.21f7@mx.google.com>
Date:   Sun, 28 May 2023 12:29:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5570795016918237784=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] shared/bap: detach io for source ASEs at QoS when disabling
In-Reply-To: <bc567c4cb647d89e2e76568583716b4e44092519.1685284537.git.pav@iki.fi>
References: <bc567c4cb647d89e2e76568583716b4e44092519.1685284537.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5570795016918237784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751683

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
GitLint                       FAIL      0.92 seconds
BuildEll                      PASS      27.52 seconds
BluezMake                     PASS      912.77 seconds
MakeCheck                     PASS      11.56 seconds
MakeDistcheck                 PASS      158.68 seconds
CheckValgrind                 PASS      259.57 seconds
CheckSmatch                   PASS      348.36 seconds
bluezmakeextell               PASS      104.18 seconds
IncrementalBuild              PASS      1530.25 seconds
ScanBuild                     PASS      1061.78 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,2/2] bap: wait for CIG to become configurable before recreating CIS

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
25: B2 Line has trailing whitespace: "    "
30: B2 Line has trailing whitespace: "    "
33: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============5570795016918237784==--
