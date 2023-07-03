Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002EAC001B1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Jul 2023 15:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjGCPKc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Jul 2023 11:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjGCPKb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Jul 2023 11:10:31 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F81FAD
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jul 2023 08:10:30 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-400aaafa491so41572441cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jul 2023 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688397029; x=1690989029;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C/lwKUsk08xGjh2ib8dNSESBO6FaTfTef0IapdiJWxA=;
        b=SmjuM+ztQee36G20xzJBWClnE9OxmrrhEsj1GO6VYWEA6Hc5uHIFlk2Mv2XzzZdPLH
         Ln6R6/FnSs7gkL+BMSEFfuHB5Mn50ODmClfvUZ6qg7qnyJ615V/LrI8GLKQFBhxHceVg
         580u9kv9AYJGoSgisT1clQ5RHmrCFoH3gYkj5sYPGEuhvfgWhT6MFakbTEBoJlXE/xCT
         v5OPCX0Qp0cmqM+7oz6zT03+qg+YcxWAQAKn0l0mrz6xjgrSwHQst+kc9uZB/39fq9KU
         WDhgtxxLzn5+bsqgAeVdCvbLceo5DnbFO90Xs9gj157/E+40msHRyPbuktfbUyaXCb+V
         e5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688397029; x=1690989029;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/lwKUsk08xGjh2ib8dNSESBO6FaTfTef0IapdiJWxA=;
        b=RG2pTqTeKeK1HeyNpX3x70dpxzMXKu47ZDzLJyOsQN6xBWKnQpmNjRbXI1VXU9ERUi
         r3SJrvybSR25i1GoQnc5LcM43R1SDjG/X9x9NGDMyGyED7rrQQ/cglypfEHQT35tWQ0T
         UTnuXgh62qp0iOPP+uU1MKOCyo57G5A6t9qMzq4DLB/0rO4lylW9yWZAYFM2x7B+fb3t
         yz19C0PcRtOM530fmCSxYPL+Qu4Ic4bcQvb/Zm+BbncDtT7PBbrjxLwED5PK0VfPNtxz
         R8cyX3+ccKIVNYMqoOmH8ON6r0MenvF34HB5jx5BSs8lVLtcv/oVK08aeCGR80PNPxC1
         i35A==
X-Gm-Message-State: AC+VfDxNVeCjMe8Oc5KqINqcYbJutH4cCxU+nGxo0YFiKwP1MdjDmC33
        /pswECMCucx+CA5X/jcL089tYCcTM8k=
X-Google-Smtp-Source: ACHHUZ7gx12GNoaVsRFXyqNClW4tH8W0LqC4OMPfMuzE3yceq4b8hTlJ4NYH1/qpaP95P079PwSGCQ==
X-Received: by 2002:a05:622a:14cd:b0:403:270f:a4a3 with SMTP id u13-20020a05622a14cd00b00403270fa4a3mr13269636qtx.50.1688397029379;
        Mon, 03 Jul 2023 08:10:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.214.53])
        by smtp.gmail.com with ESMTPSA id gd14-20020a05622a5c0e00b00401df7e52e9sm9314529qtb.79.2023.07.03.08.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 08:10:29 -0700 (PDT)
Message-ID: <64a2e4e5.050a0220.b9559.7bc6@mx.google.com>
Date:   Mon, 03 Jul 2023 08:10:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7167345886425891518=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: monitor: Add decoding support for Sync Receiver events
In-Reply-To: <20230703134341.13312-2-claudia.rosu@nxp.com>
References: <20230703134341.13312-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7167345886425891518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=762038

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       FAIL      0.56 seconds
BuildEll                      PASS      26.60 seconds
BluezMake                     PASS      791.65 seconds
MakeCheck                     PASS      12.01 seconds
MakeDistcheck                 PASS      155.99 seconds
CheckValgrind                 PASS      250.96 seconds
CheckSmatch                   WARNING   338.29 seconds
bluezmakeextell               PASS      101.81 seconds
IncrementalBuild              PASS      654.72 seconds
ScanBuild                     WARNING   1016.91 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/1] monitor: Add decoding support for Sync Receiver events

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
3: B2 Line has trailing whitespace: "This commit adds decoding support for PA Sync Established, "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3552:52: warning: array of flexible structuresmonitor/bt.h:3540:40: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
monitor/packet.c:12370:2: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
        memcpy(tx, tv, sizeof(*tv));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============7167345886425891518==--
