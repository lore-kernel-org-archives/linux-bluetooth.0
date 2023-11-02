Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDBBC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Nov 2023 10:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345983AbjKBKDT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Nov 2023 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345944AbjKBKDS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Nov 2023 06:03:18 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAD0112
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Nov 2023 03:03:15 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41b7ec4cceeso3781371cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Nov 2023 03:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698919394; x=1699524194; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OtNOSrsolg1s5+juMPmzm/MYka0dWDEGGvbkcYKlFf8=;
        b=kr30wx7UQ/7cv8T+0IvRR82xZ3TsVIqnjw6l94ujjMZ9Ar1TF3WmcCleN/gyb2Mv8o
         bmWedgcfm20gLOroJzteTOVvVXB1etz7TgMexBh+wicUA1najfllF3jsA6VT+adT/bPY
         4kVJndj9JFpJQCclozo/uVdkEwGU9sd4ticgLuMxSoCLsbclUp3etqvlBXchWMcstZkH
         OBq9pCWoGqj1Z512oAX7uF+OS3PlusvQieARpDi7Y7kEWPUUtdCg7gtGyVEjUXn5+22L
         /7qbYW2eOpcnKP0RWaJ+Da4ZjQRs7IfQL25sUplJsDVqaC5FAbhi/CO+OceaReIHYLMP
         iJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698919394; x=1699524194;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtNOSrsolg1s5+juMPmzm/MYka0dWDEGGvbkcYKlFf8=;
        b=KnI4M4MM88oGnJ69LAnqSQBSJ6sXBBYiBp+ivu3FLAMdGKMCqEvJjVoUKY654pXI3y
         auDR/YeugVQX8KqYJ24XgMiZXVzavlrOogw6yim0hioR7TkBpgSAZ0RgQkM9Za7XzVQN
         2Fi5S6AdXA56ZQkveNuL4vw6J8L53MQ4yhc6b5WnINDGHSQ3vpjzlI5AkLwwZRSQN3oz
         l1PGe4gEA5s1PL0y+zjdtIQD9/nZ3fQpLN5APA34it92IY3+yakWtiUc5e+TXYUAmcQn
         zFhEfgLhAKiztjKiV5rbPcuoTi2SiLa0V6ads0jIEDEq4hWwhemHyG/+4arDI0tZ0vqI
         Tn8w==
X-Gm-Message-State: AOJu0YxymJdc/d6S2j1QXkQ9jX7NRCc3L/UrqlTNR2URUnGAWqcgotMd
        I77AV7m/YLTO7EVaJB6G4x1TXQBhKKE=
X-Google-Smtp-Source: AGHT+IE6++E0w7bUuyU8nEfPX0UXaNfKW96EQGxe+ireIVq6QSBFN6wXJpFBi0OkCqlMlD/3WuUTSg==
X-Received: by 2002:a05:622a:100e:b0:418:4e7:b82c with SMTP id d14-20020a05622a100e00b0041804e7b82cmr18891319qte.57.1698919394574;
        Thu, 02 Nov 2023 03:03:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.44.141])
        by smtp.gmail.com with ESMTPSA id ck14-20020a05622a230e00b00403ff38d855sm2160793qtb.4.2023.11.02.03.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:03:14 -0700 (PDT)
Message-ID: <654373e2.050a0220.6d8dc.af42@mx.google.com>
Date:   Thu, 02 Nov 2023 03:03:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2320778681868352789=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix logical error when enter active mode
In-Reply-To: <1698917302-28018-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1698917302-28018-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2320778681868352789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=798359

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      35.71 seconds
CheckAllWarning               PASS      38.60 seconds
CheckSparse                   PASS      44.43 seconds
CheckSmatch                   PASS      117.98 seconds
BuildKernel32                 PASS      34.32 seconds
TestRunnerSetup               PASS      534.12 seconds
TestRunner_l2cap-tester       PASS      31.30 seconds
TestRunner_iso-tester         PASS      54.92 seconds
TestRunner_bnep-tester        PASS      10.59 seconds
TestRunner_mgmt-tester        PASS      219.08 seconds
TestRunner_rfcomm-tester      PASS      16.41 seconds
TestRunner_sco-tester         PASS      19.58 seconds
TestRunner_ioctl-tester       PASS      18.43 seconds
TestRunner_mesh-tester        PASS      14.08 seconds
TestRunner_smp-tester         PASS      14.42 seconds
TestRunner_userchan-tester    PASS      11.14 seconds
IncrementalBuild              PASS      33.39 seconds



---
Regards,
Linux Bluetooth


--===============2320778681868352789==--
