Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9E3E92FDD
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Oct 2023 03:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjJFDlv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 23:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJFDlu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 23:41:50 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569DBDB
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 20:41:49 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57ddde51033so1409647eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Oct 2023 20:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696563708; x=1697168508; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x5PKnJ6SJ80ERdpb1KU3VPvPDdzFDBmPNet6R0JTnfY=;
        b=BY+uqR4nTNvyycAAhwE+7NCW4evmIf+2jiPHAHI+Za5rrWO0iFTypYtF+1CC/Jh9pt
         wHzX3K6qhfaMn09Ff2+e+LhRZ9p3Bt8qenQaqsfNHOsdXyGE+bAksUwtrrWb9ULkZcgi
         2Pd4hChbZItgBcz/ly+n5Axei//2uc3/O3U9QDnezZIMYb88fJ8tYasRP5vlk19OI6r3
         iEO5qpGaNszBet6sWFfbJSZtHJY9sY02p+ahySIbG4IpdrdkPz637Wh+UzmPtNDeUzJH
         Ee+2ojp7AERWM+5yX73YiXTick0t3A/ZB5iCmzkIk7SVN8L2imd++Ci81oxH4BONIKAK
         di8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696563708; x=1697168508;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5PKnJ6SJ80ERdpb1KU3VPvPDdzFDBmPNet6R0JTnfY=;
        b=AyFcN/9Sfqx6ty6xRDwkb58jpOd8aLwuzO+HImLTOopRecoWwmbAyQIaJFv9ETLOA+
         GjaHWnECeK8XMqe8Poo/HEgTx/wFqXxfQx1JrwmQUcNPvfaOPVRU0sR0HFobNFxolWGx
         2gkgGpTNkmNilMcZP+Kpye16THdcsGg9/QYNL8tCH4V2LPboQQ+Z1cjzz96o1fSLYn2Y
         1rqKaBcFsWuLLAy4cdcAzxcHSys0faWabbaNZzZcDfhJLCXLjQGJ732xM/eEOBEtAr5q
         dPQJ/vutmjzZa/Uatt7pXrYbhIIx+1mG1kMfHDmDJibdux5ncSR09cBxE8zaJHcfK+Ta
         7qVA==
X-Gm-Message-State: AOJu0Yym3BpvOvTv575Qd1nCGnp6sPUamKLiKmwNRhTwnoUJ48MERjZB
        P8bqYH0UiXUq4ue3FfNQ16LhqFsn1ic=
X-Google-Smtp-Source: AGHT+IEb6l5WF64h4iq7o5mwx1jhd3t7hrCsjZ+bbSc/0N2aw2VenYk6yDT7/xAxwFny7dQprm9ZEQ==
X-Received: by 2002:a05:6870:2195:b0:1dd:611e:d404 with SMTP id l21-20020a056870219500b001dd611ed404mr1844635oae.21.1696563708415;
        Thu, 05 Oct 2023 20:41:48 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.72.40])
        by smtp.gmail.com with ESMTPSA id j7-20020a9d7d87000000b006c631df1690sm464196otn.69.2023.10.05.20.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 20:41:48 -0700 (PDT)
Message-ID: <651f81fc.9d0a0220.eb0b6.327a@mx.google.com>
Date:   Thu, 05 Oct 2023 20:41:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8882432307865597290=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btrtl: Ignore error return for hci_devcd_register()
In-Reply-To: <20231006024707.413349-1-max.chou@realtek.com>
References: <20231006024707.413349-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8882432307865597290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=790472

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      40.12 seconds
CheckAllWarning               PASS      45.09 seconds
CheckSparse                   PASS      55.18 seconds
CheckSmatch                   PASS      137.56 seconds
BuildKernel32                 PASS      39.90 seconds
TestRunnerSetup               PASS      604.57 seconds
TestRunner_l2cap-tester       PASS      35.76 seconds
TestRunner_iso-tester         PASS      64.91 seconds
TestRunner_bnep-tester        PASS      12.59 seconds
TestRunner_mgmt-tester        PASS      256.81 seconds
TestRunner_rfcomm-tester      PASS      18.53 seconds
TestRunner_sco-tester         PASS      21.77 seconds
TestRunner_ioctl-tester       PASS      21.13 seconds
TestRunner_mesh-tester        PASS      15.45 seconds
TestRunner_smp-tester         PASS      16.27 seconds
TestRunner_userchan-tester    PASS      13.01 seconds
IncrementalBuild              PASS      36.47 seconds



---
Regards,
Linux Bluetooth


--===============8882432307865597290==--
