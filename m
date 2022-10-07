Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7450C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 19:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJGT1R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 15:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJGT1C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 15:27:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3980C92590
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 12:27:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so5523535pjo.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 12:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DbgIAWudDV1oiYtoqiB1IyEboKRN8VA/cY/gukoxhLc=;
        b=Ew9LdntGtsP09Ie4JEwrniLYfF7tKJfadMprTIAFFk5VVpqXjWmlQc7wHlE3Fbon1S
         YI9ZVQW/KYNQ9uC2d4j3Mtw997m/Xthc7pQBjoeU6ObuEeTqEU+IBkwPdpYIvfLdMv96
         dBoboLGwuS0fWsTCYnZaFpFTULLKbwrm7FxNvbGzKKAkh2t0WnEdOifFDoPxtT6Lx8XK
         jIvNI8gMOt3SO8HacVCijQVN7l7FgqsQzRcKBbFaaHI/TOZpeaBe5ze/CbNXzZPujlJb
         w1pYIgjLJ/gCx0NbTy0aC6jaHVtXEd7pFRVFIHtXkP66h+2NsdpkDrzbV16fHDinF2yj
         KEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbgIAWudDV1oiYtoqiB1IyEboKRN8VA/cY/gukoxhLc=;
        b=ODxVrwT55lKTVnD+u+GW6u2+cLXl3x/P1Zwr00XQfihWPDLm4c774M0sgYlVrLq9NM
         +VankMKYOxv+Mzifh7QugJO29WK1sUCC+68YPN+bbEUfWQPtRUs0yrX99Dd9bUH7mZOZ
         f9EQrcrY63DgErzTDUACyiF3kfbu/rvQKuEsQE/RRvPqM5ei+e7o3DpZXimmdk9oTQDA
         98KizixkJ4O+8Blh5NeIofwKmIlCDCor4BTKBTXTbOaocwCLZMGmY/lL8KSEIHp6u5Og
         cXqmuin5esaoV3Z6RMH+WXxHdiIpmwIoR+4rlIsUwJJK7lsLr8dWOsaXVPNDp/7CW98u
         gYIQ==
X-Gm-Message-State: ACrzQf0FqDTJpLCkXnW8yLR7RVyQjXLXKCmNisgxyVPOGfcWEgd9o6qV
        czQuZs0TA0fg2SslbmoOIu9nfwzvwgHLYQ==
X-Google-Smtp-Source: AMsMyM6O2hT+34MCHcpF3Jp+85K2AkQPFLoYVlNjnHg1mSOR4Ffg3q7XVcdwsED2UeqqxmDz1AVzlw==
X-Received: by 2002:a17:903:1205:b0:178:ac4e:70b8 with SMTP id l5-20020a170903120500b00178ac4e70b8mr6159370plh.52.1665170820468;
        Fri, 07 Oct 2022 12:27:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.94.221.78])
        by smtp.gmail.com with ESMTPSA id ix21-20020a170902f81500b001807922f43bsm641552plb.158.2022.10.07.12.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 12:27:00 -0700 (PDT)
Message-ID: <63407d84.170a0220.9572e.154a@mx.google.com>
Date:   Fri, 07 Oct 2022 12:27:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4366674231000008007=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [v2] Bluetooth: Call HCI cmd to set random addr during MGMT call
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221007183420.797070-1-brian.gix@intel.com>
References: <20221007183420.797070-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4366674231000008007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683792

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
GitLint                       PASS      0.40 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      43.38 seconds
BuildKernel32                 PASS      39.55 seconds
Incremental Build with patchesPASS      57.32 seconds
TestRunner: Setup             PASS      645.62 seconds
TestRunner: l2cap-tester      PASS      20.75 seconds
TestRunner: iso-tester        PASS      20.53 seconds
TestRunner: bnep-tester       PASS      7.86 seconds
TestRunner: mgmt-tester       PASS      129.41 seconds
TestRunner: rfcomm-tester     PASS      12.18 seconds
TestRunner: sco-tester        PASS      11.64 seconds
TestRunner: ioctl-tester      PASS      13.13 seconds
TestRunner: mesh-tester       PASS      9.69 seconds
TestRunner: smp-tester        PASS      11.57 seconds
TestRunner: userchan-tester   PASS      8.14 seconds



---
Regards,
Linux Bluetooth


--===============4366674231000008007==--
