Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6DBC433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Mar 2021 08:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D69C64F6C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Mar 2021 08:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCSIxx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Mar 2021 04:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhCSIx3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Mar 2021 04:53:29 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC96C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Mar 2021 01:53:29 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y2so3732271qtw.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Mar 2021 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=e89gkE1NFRK82Icn08X6vSs8pKQ8MDQsPPEheq3LSzU=;
        b=Tvxs5PrOKaKa6LEReh4FQVPcR6oK+4FMXsILq2LIcHuneXB2PIOsBBb0t/Hf/ceFR7
         JGQNrOP9vaaPAE9yDl+/9FMbTt0E5JD2Qj8bIB8CFK9C5vtiYRX6G4HpVzCWVCNW+KfR
         DNiU+w3Yru4mH5VK0uJxn7ThWSGej3Xu3hFXTAJ1QDDg6HYVXv4HDHDqH2OwBVQ/2cSK
         M9SWe1DeSFYxEoz8xCgTD0LzsCgftuQ6EyMhnVMqJQ53fQzEiGxsFAANZ/awZ9G818WS
         Wa+xXO/ay4LOvyKszltZvhHI2KtB7edXpO1AywuTjnXXvGnjWabWs/kbD2AAfczY9eod
         B5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=e89gkE1NFRK82Icn08X6vSs8pKQ8MDQsPPEheq3LSzU=;
        b=aoOBJm0RZ7bb6KPy3wD1Qc4qRcV0FGIs14Ub9YUtc1U1rK+EQjC65x/d7NN3OaUVeR
         C6RML5DBxiN9WUzHwamA0P996PaBiLOH+H0ogKPyIPcJUVwDLuE7PqA/wvtnS4M4rHxj
         O/thanwgw8IYlyUpHw3Ub5Hf7TPxGmdWj3kQAOD+C2fpsVw9F9p0ZGfrjfgr+au9Xivq
         l06XXldcH0SfwKvlfwxtBjNba/nXkpmBiLtP6x+CYGsROwO2UoCPt7gB54uUcXAe2pjY
         TVOTsjGzQOdRBhXKJa38WRaH6b0stwglaa0QpK6O9e2PLHepPLkShV+iJo0/wnj5D5IN
         26vA==
X-Gm-Message-State: AOAM5333I4K0DspEQH/u8/BURcWwH2hrJayqmISmOHwwGMaXaPFQKT8D
        MbTT1J1ajJt920UmX4g6pmt+KMvxsGc7Sg==
X-Google-Smtp-Source: ABdhPJzf3e8SRLS4k6DiJEl8L5I1Zd+NwkN2ksFn5yyW9T0cUzqdfvEiD34RzuKE+ucAR2t0EXqAeg==
X-Received: by 2002:ac8:4c90:: with SMTP id j16mr7320398qtv.223.1616144008277;
        Fri, 19 Mar 2021 01:53:28 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.130.133])
        by smtp.gmail.com with ESMTPSA id a14sm3227750qtw.80.2021.03.19.01.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:53:28 -0700 (PDT)
Message-ID: <60546688.1c69fb81.93578.32b8@mx.google.com>
Date:   Fri, 19 Mar 2021 01:53:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0347499730313991658=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v2,1/2] adv_monitor: split rssi_parameters into its own struct
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210319155542.Bluez.v2.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
References: <20210319155542.Bluez.v2.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0347499730313991658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=451387

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============0347499730313991658==--
