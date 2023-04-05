Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E38C7619A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 12:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbjDEMAW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 08:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbjDEMAU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 08:00:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC13F9B
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 05:00:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ix20so34199912plb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Apr 2023 05:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680696018;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8FGQzJKCnOypqeOpjHAlqfLaSIGz9wlAliwwfaofiTw=;
        b=DtS/Wr7HGo2IGyIhXmQeEuYR/ecprBs1OAjHZ7vQyu2I2kypkYxtK7+pfvX+W8HiVI
         IoWB/DYt7Lzi2MjyasD3q7l2KnhbVSZoCk1d3NCbaEPL0KnC6gzf1wMcn+/voFScf6aL
         VtSaHuyeXQ0zroje1yA7VtFIrxNaKk095zz2Q4YvAI13WKIWqJ7c6wgYfcVb6leR3KDR
         fDBYz5orPWRO1VRyT/ICVnqjNK6NdslcQrcMat1o/uPzED1/cWgn70XBAClsI9b03tnW
         g8nVUfIAYrSgi9zQDeOK1A6XRj88tVmJLyQ8UiVkTiC2qI/njhVIHW27tpp0otUs/nnR
         9MmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680696018;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FGQzJKCnOypqeOpjHAlqfLaSIGz9wlAliwwfaofiTw=;
        b=63acWd6g3FJbllPyJIOCAf+Gr7GMgt0gLrY2OJroCTnBW4+aNDjNHDWPuNmZT7EbSJ
         5l4cZ6JWb9Zzv1P7HbD/D6Rjn/INU5hxzdbLaTdi2aSKJ9fzY72jvUXn9A7Md9aXZApH
         PZ+xXpqV45W+SubNFZdEFLpBayYocql+++oL1uhcPgE+eXYTygvWyB39PHgpstCw9JBs
         W027TibHgMJsUogTgEmt5bnXVh+pKMdM+xf+EWb+hotc704quMOTTT1Ba22e2gZfnnYs
         /Gm2hoDPvHMtxNeXqZs2irLu/9d42kYBxUTgqjLONfJXWlB8JojVoFjpiZUjuDwsISGA
         AfFA==
X-Gm-Message-State: AAQBX9cXgNFlrLffjUre6U3jLf2H2vW4agt6mXHaX0OmCHyx28uwTlmM
        AtA+r9Pd47UCY0xOenJdJLHkcxng0t0=
X-Google-Smtp-Source: AKy350bFhXQ1sbJfuoLSCYZHSLuIMaBqEFn12sD3oDKTEb5YYE8FrRkdd1z4o6DCe2Upmk9xIpmtAQ==
X-Received: by 2002:a17:903:706:b0:19e:65db:7ac3 with SMTP id kk6-20020a170903070600b0019e65db7ac3mr4981701plb.68.1680696017966;
        Wed, 05 Apr 2023 05:00:17 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.244.132])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090282c600b001a1abc93eabsm9943982plz.226.2023.04.05.05.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:00:17 -0700 (PDT)
Message-ID: <642d62d1.170a0220.33d86.411a@mx.google.com>
Date:   Wed, 05 Apr 2023 05:00:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9016049293572956782=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Set ISO Data Path on broadcast sink
In-Reply-To: <20230405111918.4885-2-claudia.rosu@nxp.com>
References: <20230405111918.4885-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9016049293572956782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=737161

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      37.95 seconds
CheckAllWarning               PASS      41.88 seconds
CheckSparse                   WARNING   47.39 seconds
CheckSmatch                   WARNING   130.18 seconds
BuildKernel32                 PASS      36.99 seconds
TestRunnerSetup               PASS      526.75 seconds
TestRunner_l2cap-tester       PASS      18.38 seconds
TestRunner_iso-tester         PASS      19.27 seconds
TestRunner_bnep-tester        PASS      6.19 seconds
TestRunner_mgmt-tester        PASS      122.86 seconds
TestRunner_rfcomm-tester      PASS      9.91 seconds
TestRunner_sco-tester         PASS      9.00 seconds
TestRunner_ioctl-tester       PASS      10.74 seconds
TestRunner_mesh-tester        PASS      8.00 seconds
TestRunner_smp-tester         PASS      8.99 seconds
TestRunner_userchan-tester    PASS      6.55 seconds
IncrementalBuild              PASS      34.86 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============9016049293572956782==--
