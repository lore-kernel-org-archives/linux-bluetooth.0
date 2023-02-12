Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8C4C636D3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Feb 2023 20:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBLUFn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Feb 2023 15:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBLUFl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Feb 2023 15:05:41 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922D7B74E
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 12:05:40 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-16debd2786aso3235925fac.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 12:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zymqkrP9gaEie4TfNUM+l2cBjOA8/NlWoozNB27Mxt8=;
        b=W4kJQ+Ov9cyxRUDBhWu2JGlzThEGjBqkRroq60+X3ye/KhfzEMRF5+GMCm/GwWgG1P
         +DfE5Vyq0qpICvmgKERV/SE6czeoGLXFPzf3vy62eg+sSCV92Z5gAHN9w5kAUX6neEX1
         xHmqvJa+4wUsoON4ma6miDdlM8gTVywYpOH3qNi9BNxLPBJ00EBOfIfspJwgxInJR7GP
         cbRmlJoZI6XNxWzwx4azaE5kGhhDO4YQBOogmRxyCxmrWlF953JHBLb3fuebG0IZAc9R
         4yFTuZDGkxO245Z6oWhAoVzZjm7LxkO6EzZdyCZV0V3D2fO6ESRopeX31EqAqRSlyj1t
         JKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zymqkrP9gaEie4TfNUM+l2cBjOA8/NlWoozNB27Mxt8=;
        b=FJhrvZYiE4rHtBUf/c/JYLNhwh62gHZxOFPw/72wrvV04qe4450bAMS3+TZrmhu0vn
         i1lq+nY7UnSY2K+HOzc8jvHXT7RgEgpmHZT8k+G71yESxdbgcCdjptEayvY+T3PDvy3q
         LrD2U8eX959uSh2GIRNCSGXFBu9CE3BGagv9YEZ1hzD9kQ6J1MEvhIZzH9JKej8IF6/9
         OMpikji7ANDDCrbTRQgcB6K/aXEVuOEjuZtu5L5fJn4RjBvyL7EGs/NsbwEeibYRlMqN
         ddo6UMFSIyo2hryq1s+l4FYQ4z8DVMI1cCbbw6IjnT2DQOlSt3qBdF3XhPJAXX+GXPpD
         2nRg==
X-Gm-Message-State: AO0yUKV1fsJ91fT8t1iiZIOrnuWO4tKMB6eQiv3H6tT4tYc37AQKkd2U
        hmU3Ns4NQxy+U0eqyFaaIxfHYr6DpQI=
X-Google-Smtp-Source: AK7set8gKiNcI69qc/opyk9LrUcqWXlNQaenXqfy75xKU64690jWfnsVshfb0gEVNYDLC5m0pJ+EOA==
X-Received: by 2002:a05:6871:5ca:b0:16d:e8a1:297d with SMTP id v10-20020a05687105ca00b0016de8a1297dmr2661288oan.28.1676232339700;
        Sun, 12 Feb 2023 12:05:39 -0800 (PST)
Received: from [172.17.0.2] ([70.37.167.32])
        by smtp.gmail.com with ESMTPSA id y10-20020a056830208a00b0068bcf7995aesm4467525otq.64.2023.02.12.12.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 12:05:39 -0800 (PST)
Message-ID: <63e94693.050a0220.bf91f.1965@mx.google.com>
Date:   Sun, 12 Feb 2023 12:05:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8901636127386742878=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/bap: wait for GATT client ready before ASCS/PACS discovery
In-Reply-To: <98ccef96a4b719599c0fb1d085c7239a12d2ed8c.1676226143.git.pav@iki.fi>
References: <98ccef96a4b719599c0fb1d085c7239a12d2ed8c.1676226143.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8901636127386742878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=721100

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       FAIL      0.53 seconds
BuildEll                      PASS      26.40 seconds
BluezMake                     PASS      787.59 seconds
MakeCheck                     PASS      11.08 seconds
MakeDistcheck                 PASS      147.95 seconds
CheckValgrind                 PASS      241.21 seconds
CheckSmatch                   PASS      319.48 seconds
bluezmakeextell               PASS      95.77 seconds
IncrementalBuild              PASS      604.62 seconds
ScanBuild                     PASS      954.53 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] shared/bap: wait for GATT client ready before ASCS/PACS discovery

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
17: B2 Line has trailing whitespace: "    "
60: B1 Line exceeds max length (132>80): "    [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1"
61: B1 Line exceeds max length (132>80): "    [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0"
67: B2 Line has trailing whitespace: "    "
73: B2 Line has trailing whitespace: "    "
75: B2 Line has trailing whitespace: "    "
101: B1 Line exceeds max length (132>80): "    [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1"
102: B1 Line exceeds max length (132>80): "    [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0"
104: B2 Line has trailing whitespace: "    "
106: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============8901636127386742878==--
