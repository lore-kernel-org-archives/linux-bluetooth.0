Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C5ACD6E77
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 15:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346931AbjJKPEi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjJKPEh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 11:04:37 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51255A7
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 08:04:36 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4197bb0a0d9so41688851cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697036675; x=1697641475; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=95qfm6NwSxSjjMrQY2mPvbXpzggVV9kNQCYJOSoWFQ0=;
        b=hwTthvxbqoQ33R+J1MBBv8NyGJjPTm+TMmLa9BvgHZYvKoS58r9jdYwnuftQEJmrVY
         cOer0YAUOsMP48wXeAMv2gmQRB4XnnsTtjNnoXmmqesGiYKrMT3qZq0T2XnJavyruw7X
         GhPLAqjyg/VEtjN/Acxwfaia0wOcOqpDPn23J7zFj8XuA8MWDXfR21hlFItM7Y7SPgQd
         Dy6kGAcHWPv675sVTy70Cu6hxTeGLCZmCdPk8u0740MqKLJ9MuKqDAvL+bEjfO5Z58xd
         xp75n+ea5imuJpWA5BQ3AzjgoZBtMDO50wNrh9K0dLl+M4g1v0cZBgyNKanpIBBgsQER
         6kZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697036675; x=1697641475;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95qfm6NwSxSjjMrQY2mPvbXpzggVV9kNQCYJOSoWFQ0=;
        b=D3JmyS6K3oTwAgHwbRM66zYwx+u/bhnXJ7mISYeIiw7/zCgvhdWRVEmLICSD+R61C+
         aBe7oMizr2C/FXo69OscqeAv6R0fJUt5EJpbc7eDtQM7aPROtw09N/8pnqat/WHla+GW
         GWQtkVnKCjR5r2bX0A3BfamTKRumqShtyeEAV983fMjzpAR8kxUhGqiLghcGmqJ00L4w
         INTmNQegMbMpjCWcBOKFS2Pu2tHGBdAVUY/KzZVXWQZ5GlTt+7L+UVdPR3EF2+qVaiWn
         blzzFAZH9RhVUOcoxTnQjYLhtCsMUiti0soma0uhZwwEhC3+JmMkbLE5JYc82hT0CxTz
         4XlQ==
X-Gm-Message-State: AOJu0Yw+2TjvwRp5ccBocMlDKpEVXvxka0gvjbtFqDsSD6DFM18LwKVK
        BMDZ1WezNUdaCCt69BnjGsiE3oFYxPQ=
X-Google-Smtp-Source: AGHT+IFaQEX78cHgCc2JOE8i7ep9KZNvXSNU9+kPLJtVCOTPG35qldi8IVF6GT9MtJcdfvB/9Ok8Eg==
X-Received: by 2002:a05:622a:1827:b0:401:e2bb:e423 with SMTP id t39-20020a05622a182700b00401e2bbe423mr24635117qtc.55.1697036675127;
        Wed, 11 Oct 2023 08:04:35 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.221])
        by smtp.gmail.com with ESMTPSA id r8-20020ac87948000000b004196d75d79csm5398178qtt.46.2023.10.11.08.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:04:34 -0700 (PDT)
Message-ID: <6526b982.c80a0220.c1432.75e8@mx.google.com>
Date:   Wed, 11 Oct 2023 08:04:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2670392548908984420=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Miscellaneous fixes
In-Reply-To: <20231011142408.5529-2-iulia.tanasescu@nxp.com>
References: <20231011142408.5529-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2670392548908984420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=792216

---Test result---

Test Summary:
CheckPatch                    PASS      2.30 seconds
GitLint                       PASS      0.69 seconds
SubjectPrefix                 FAIL      0.52 seconds
BuildKernel                   PASS      35.13 seconds
CheckAllWarning               PASS      37.87 seconds
CheckSparse                   WARNING   43.98 seconds
CheckSmatch                   WARNING   117.50 seconds
BuildKernel32                 PASS      33.37 seconds
TestRunnerSetup               PASS      527.59 seconds
TestRunner_l2cap-tester       PASS      31.69 seconds
TestRunner_iso-tester         PASS      53.51 seconds
TestRunner_bnep-tester        PASS      10.76 seconds
TestRunner_mgmt-tester        PASS      225.36 seconds
TestRunner_rfcomm-tester      PASS      16.41 seconds
TestRunner_sco-tester         PASS      19.81 seconds
TestRunner_ioctl-tester       PASS      18.60 seconds
TestRunner_mesh-tester        PASS      13.77 seconds
TestRunner_smp-tester         PASS      14.66 seconds
TestRunner_userchan-tester    PASS      11.51 seconds
IncrementalBuild              PASS      61.87 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
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


--===============2670392548908984420==--
