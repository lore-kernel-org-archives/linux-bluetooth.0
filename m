Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB263C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Oct 2023 08:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjJ3IS5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 04:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjJ3IS4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 04:18:56 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B8CAB
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 01:18:53 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-35743e88193so16285795ab.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 01:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698653933; x=1699258733; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DcOEu1JM48tm0l+chcuIMknRDqQbR3aHX7kGaT7TLN8=;
        b=TGZUNTTojxCs61S/VeHqrfQGzGFGSI2kXCquerjfpU7m9xotgF4dtyL+Lw52WcLiw3
         9EGKA4b40l8LzlPLTRv5aVYDp1ES0b2nBTNKlPXUlMDB4tD7dba1DHHEw32jrOXRYJiN
         COJy4DpQ4o+7Gnxj7QLVqqH4puWXfzmpAPqaKibRCQBD7jUes7UhZh3rd3NoZ09w8PbO
         uZwtU+s6Tn/Rq08B/OQGLAnu7l8r7xT9ls1rPtZFHIpNfGW2CCWCo42cqjfhsSZLzwdz
         O0DONUWZGPyc14dGsiaoEb3BDQTRZj442pB3v37zMv/QzxAHEO262inyigPRxsQ0OVGD
         VdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698653933; x=1699258733;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcOEu1JM48tm0l+chcuIMknRDqQbR3aHX7kGaT7TLN8=;
        b=E6bZY/2qNuZdPrHiOFYRXaSKdzDF+fqvtWmAnkS4aVx1lIlRKFmAEpz+t6Qk9yMKKh
         tAnhI7dJPVJ7mr1hbGO7tr8BZ/b5vWsxXR76SP//l+xPcYcAryqiMzZwYUJTsw78lnbt
         1PTQb0fjEPVkmIn2MK+ZkIuXfl8UjS5dIH7/qRx5Jy7SzCjqfLb+8YJDWaZoqLyDSMe2
         FLLemsUw4fJjq6LNX4joE8BTGTaNJkcGsaxIG9YQgmB/JADA0x6rnR6ODhXSCibO5ReG
         bJ3dscknAwws52u8wQqjB+YKc853k5U+vVK8tInwa/AQHKFeeX+XyDXgkpiZognxs+xS
         1xOw==
X-Gm-Message-State: AOJu0YxZxgjKLXp7RtrJ47dRNMqML6lTTSjxgUIbu4CvSJSbvXRXCTt7
        L2GiBrsVTZjYMi296h2Qx+jN9mQd6s4=
X-Google-Smtp-Source: AGHT+IFFT3c5r4S2lqV/cDhriUBBk/uPzqry8yiipIsK/IxIKCYSVKsLXvksyL+LA76p+0AnELyNNQ==
X-Received: by 2002:a05:6e02:1d9d:b0:357:fa1b:48d with SMTP id h29-20020a056e021d9d00b00357fa1b048dmr11177668ila.25.1698653933050;
        Mon, 30 Oct 2023 01:18:53 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.243.87])
        by smtp.gmail.com with ESMTPSA id v2-20020a927a02000000b0034bae80711dsm2177561ilc.82.2023.10.30.01.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 01:18:52 -0700 (PDT)
Message-ID: <653f66ec.920a0220.f1f4.4398@mx.google.com>
Date:   Mon, 30 Oct 2023 01:18:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5511217971681812630=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, juerg.haefliger@canonical.com
Subject: RE: [v2] shared/shell: Fix --init-script commandline option
In-Reply-To: <20231030065341.8998-1-juerg.haefliger@canonical.com>
References: <20231030065341.8998-1-juerg.haefliger@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5511217971681812630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=797481

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      29.61 seconds
BluezMake                     PASS      951.63 seconds
MakeCheck                     PASS      13.17 seconds
MakeDistcheck                 PASS      184.63 seconds
CheckValgrind                 PASS      282.56 seconds
CheckSmatch                   WARNING   379.14 seconds
bluezmakeextell               PASS      121.60 seconds
IncrementalBuild              PASS      785.02 seconds
ScanBuild                     PASS      1164.83 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):


---
Regards,
Linux Bluetooth


--===============5511217971681812630==--
