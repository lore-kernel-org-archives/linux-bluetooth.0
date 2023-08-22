Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4725EE4993
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 11:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjHVLEs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 07:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjHVLEs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 07:04:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE311BE
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 04:04:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc63ef9959so33790515ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 04:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692702286; x=1693307086;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5NFEU3e49in9YLcSXoCwHffZBHqIfoHPp15z0r26uPE=;
        b=ccliYp/bwCdLObD1kLyBdZoYIkMlbcdMMSH4f6EaVz1qMDefg//wjLgiU5RVFtpxiO
         WPf1j5wyYhwCkHaZQfRxpHZXrkRLrECWRUTwZcui/7a4mm7oVSp/EEy77iMxuPXic9g3
         qrMTT/E8VHP8TclrDbV0jF6qd+PraPs+QOx1Tfbt4LW500oL0vmSQvauz2c8fWEM9gu1
         oXuRj8KhG7ld1/24O+PpFslc6Shn+TY+W4iGTIDBJb6D/8g3uLu0E7d4PbjC4ayhk9p6
         XXlRHvzJ1xKLqYgCLP7RRsAMdj2r9kmJcc/vehleAUj9s1/J6/yFNEK57DdmHVv7IaPN
         e4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692702286; x=1693307086;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NFEU3e49in9YLcSXoCwHffZBHqIfoHPp15z0r26uPE=;
        b=U1g8SDHM0Ccmf4vRHqpb178vKkEkg5T2eQu6H/XUY/g1QW/YIeBW//xE+SG45efIL9
         Jc0YUpg1l+1+v1fp695n+5Jm0NYLi8Ip9arczMDj727Eeq1wsT4d/SYxM/ZXz1db6KKj
         ZFK+KHXFbL8C6QHhC19r5qICj3BltHwUreLxnma1LEKjyvU8HPURRjm+Mifck6qWgIDl
         ZWqpLeZm4t7CKNjBNWVCtHCmc9ZtCL6Q/HPI/qy0mA6QDad9bTW12dbZTTIp9LWjuNVB
         P4pbzFRn4IUfqi82A7aNbD6rkx49EAsh8cOiwXrbm1F3ZZ/qW5V+ukjYrbpSBd7bY2Bo
         SiBA==
X-Gm-Message-State: AOJu0YyfqNF2H4Arby+RT8IdA453rPijMb5bNcanqzLKktXHBK4LMJn/
        pUZ1R5MprKhu9dVl2u686yjY+qFFckg=
X-Google-Smtp-Source: AGHT+IF8zn8tcKmVmgQpa6c0t3xl724tilhFyhObY0aUsmIHky75YgYZlrfNc7uuLXyy7aBSpd59pw==
X-Received: by 2002:a17:903:120d:b0:1bc:c82:9368 with SMTP id l13-20020a170903120d00b001bc0c829368mr11280061plh.32.1692702285987;
        Tue, 22 Aug 2023 04:04:45 -0700 (PDT)
Received: from [172.17.0.2] ([104.40.36.192])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b001b9ecee459csm8802586plh.34.2023.08.22.04.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 04:04:45 -0700 (PDT)
Message-ID: <64e4964d.170a0220.2a563.05b3@mx.google.com>
Date:   Tue, 22 Aug 2023 04:04:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1323602848314675655=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Bluetooth: btusb: Fix quirks table naming
In-Reply-To: <20230822102033.1169580-1-hadess@hadess.net>
References: <20230822102033.1169580-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1323602848314675655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=778167

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      42.21 seconds
CheckAllWarning               PASS      40.29 seconds
CheckSparse                   PASS      44.94 seconds
CheckSmatch                   PASS      129.05 seconds
BuildKernel32                 PASS      34.84 seconds
TestRunnerSetup               PASS      557.30 seconds
TestRunner_l2cap-tester       PASS      33.48 seconds
TestRunner_iso-tester         PASS      77.29 seconds
TestRunner_bnep-tester        PASS      13.25 seconds
TestRunner_mgmt-tester        PASS      248.29 seconds
TestRunner_rfcomm-tester      PASS      19.17 seconds
TestRunner_sco-tester         PASS      25.49 seconds
TestRunner_ioctl-tester       PASS      24.16 seconds
TestRunner_mesh-tester        PASS      15.32 seconds
TestRunner_smp-tester         PASS      16.72 seconds
TestRunner_userchan-tester    PASS      14.04 seconds
IncrementalBuild              PASS      34.63 seconds



---
Regards,
Linux Bluetooth


--===============1323602848314675655==--
