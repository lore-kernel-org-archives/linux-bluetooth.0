Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC78C7EE26
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 May 2023 19:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjEST6A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 May 2023 15:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjEST57 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 May 2023 15:57:59 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CDC10F9
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 12:57:26 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7703344e058so13940439f.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 May 2023 12:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684526228; x=1687118228;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L8M7IHSK2aM3ZF2ZUpAGzm76dr6/0iIMTcaUQJvLkS0=;
        b=ilHPBvrp1z39cCJjL24TL2Cy3ib6SAHrQH3iQnqpQY+s8i/1mtKS5Jb7V630a2suMW
         INMeyYcXyVb/6udLd5zM7rXR20bn68ugEZKaGt3R5wzEAjK6l2vOzMgnjWFKQz3mqbwE
         NkMxn5u5jU4NiWu76dtibvXzrTsGz1iOe37RL0i4YMMBCFGldYK6pYUN8lPR1eiOsKFm
         2Z0cKaHwATdRMMxDMfwRJ6XmD4hzT0JjnZfKXWeyCchD0nn3z97vq/s4Q3p3dBdBpBQV
         nxveQglrM7AyNOi4fVCC6vjkGqB02DU0ckPFnK1n9HxRjIOKeJoroDO/EAGYuiDEA4WN
         5wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684526228; x=1687118228;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8M7IHSK2aM3ZF2ZUpAGzm76dr6/0iIMTcaUQJvLkS0=;
        b=hoCby3eL6yMgCq8gl2RckVcW0eN1bbPlB6hY7kAmq5k9GinOW3YysF5oulPHVmrGxH
         3OTmHllvAtqD9qZvYsSpGiPn4N+ZlyuZxf3xBuvMbeCKTo/8Q3gN7cvXoxsDuVAB6dBz
         hjkTXlaI7UgwUsWapl6rsbIucbTtqLy+4C51Z6ApKV7iEkEsofaEbfhkGQkI2xW/Ofkb
         mAz0dGbkyxL8I95AkKolNK2CYPjAOanJ4pDWoA+STxp54nyRc4OzDhbA7Vyd8CYNWCEF
         pp9ApeMdZGwP2pT7nTwhEauqtrgqNbk/SQuv9RRBOg4N8UVlGpgcSm6pSZE1hsVNd1mg
         xbCw==
X-Gm-Message-State: AC+VfDzQ9jyinBZA/OLpyvyqD/Ecqb+gHcTS/uCJb+DCzvV791RJTjIf
        FURincc0d96fnBxT2xjXVezLY+yUoCA=
X-Google-Smtp-Source: ACHHUZ7wQu+KSJYg1EADtC2KM6LPvN1KLktrDvLjinPjIxGHNCIEKD12GtmVAXFrjvfmaHEvwdjIGQ==
X-Received: by 2002:a92:d684:0:b0:338:b798:75a0 with SMTP id p4-20020a92d684000000b00338b79875a0mr997114iln.19.1684526227799;
        Fri, 19 May 2023 12:57:07 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.13.183])
        by smtp.gmail.com with ESMTPSA id dl6-20020a056638278600b004166c24e30dsm1345149jab.32.2023.05.19.12.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:57:07 -0700 (PDT)
Message-ID: <6467d493.050a0220.46a06.1d14@mx.google.com>
Date:   Fri, 19 May 2023 12:57:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0247429413546175439=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: RE: bluetooth: Add device 0bda:b85e to device tables
In-Reply-To: <20230519192256.1334-1-Larry.Finger@lwfinger.net>
References: <20230519192256.1334-1-Larry.Finger@lwfinger.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0247429413546175439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=749362

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 FAIL      0.34 seconds
BuildKernel                   PASS      32.52 seconds
CheckAllWarning               PASS      35.17 seconds
CheckSparse                   PASS      40.08 seconds
CheckSmatch                   PASS      109.86 seconds
BuildKernel32                 PASS      32.82 seconds
TestRunnerSetup               PASS      444.06 seconds
TestRunner_l2cap-tester       PASS      17.20 seconds
TestRunner_iso-tester         PASS      21.84 seconds
TestRunner_bnep-tester        PASS      5.77 seconds
TestRunner_mgmt-tester        PASS      117.70 seconds
TestRunner_rfcomm-tester      PASS      8.98 seconds
TestRunner_sco-tester         PASS      8.39 seconds
TestRunner_ioctl-tester       PASS      9.65 seconds
TestRunner_mesh-tester        PASS      7.13 seconds
TestRunner_smp-tester         PASS      8.23 seconds
TestRunner_userchan-tester    PASS      5.94 seconds
IncrementalBuild              PASS      29.39 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============0247429413546175439==--
