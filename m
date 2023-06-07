Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB312C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 06:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbjFGG7F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 02:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbjFGG7D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 02:59:03 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B01F1BD2
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jun 2023 23:59:01 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6261616efd2so54158526d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jun 2023 23:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686121140; x=1688713140;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KnkV50qy85ZrkCB6j62OhFodkULvQeKiYt0qifb36C4=;
        b=W1eUNOnFkSqx8aQhqH5K9pV3aJx5x9vqBFr1pVfadajC22i9YG7/rJ8qCkRtognq1S
         NlI5zPmNVL1A87lJFLu4nyPFfz/Wugu1BccOOi5l/XTCEV+7K/X+L8klw5GkIndbyj7P
         RzDhvCR4Wb+Lk44KoMIVO0SCUYNDQQb9rkWOLkTC2ZFfUTj0GF5E4ozVVyEN2PlGH9N2
         zbzxKXHNixP/UUqN7XraWb+epDHeMCPckb1ko1x0U6AyIyKb9tmuXy+JNMdM7C4HDnSO
         Z/SAdjfNG/6utIphxVBlxc6dEAN+ZscSzPq5HJNThvv1i3JhYdPJSbPEAn4AOMGMdDSY
         1o2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686121140; x=1688713140;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnkV50qy85ZrkCB6j62OhFodkULvQeKiYt0qifb36C4=;
        b=hv9Hr1pZrJWadkzHJxD6sX92TICIf7v+c5jik/DnAjW4msk+r2SQgKlDD4sN918MUW
         QpcACwpLaX0SXyrP7PK+h+mhV8bbpnf56/XERmw8FBWtdz0J/xed0TlLZ7PBIe/6DlTH
         L6f+i521DM4KqeYVvhQwDM4YBwGrffIixnoGOKtzog4ZpfS/oSEnkhaXMoIYyT3rdbwY
         XcZD9lI2Kax0XHqjICLDLNGtGxU7i84aFZHfLsQSuNiPdfYAWqCqYtJCifklVGD6TR50
         kOKQN3P9l7i/USUpzkvlvAbC7WRuVRdvHLCkS6oPmsSbGJsaTLZoVfsZkzD+R4G+2n3j
         96/A==
X-Gm-Message-State: AC+VfDwCV3fwMYhEqV1qXzqGfLOWybiLjEC3agYRrdhL9XA2J1OMokmC
        kjIWvr+dJhZ68DEYGH0mKUZDajPugtk=
X-Google-Smtp-Source: ACHHUZ4ynp97dCoxjoVnHHxC9xvbrtVmXxalWguYYlEvEotiFPnPL3xsTAHRfqwSY9h0J+IwKkLEsQ==
X-Received: by 2002:a05:6214:c65:b0:61d:be1e:7c47 with SMTP id t5-20020a0562140c6500b0061dbe1e7c47mr2065008qvj.11.1686121140022;
        Tue, 06 Jun 2023 23:59:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.13.23])
        by smtp.gmail.com with ESMTPSA id w17-20020a0cf711000000b0062824b0517fsm5872725qvn.67.2023.06.06.23.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 23:58:59 -0700 (PDT)
Message-ID: <64802ab3.0c0a0220.f7dc9.0cc1@mx.google.com>
Date:   Tue, 06 Jun 2023 23:58:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7974840039200479344=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_saluvala@quicinc.com
Subject: RE: [v3,1/2] Bluetooth: hci_qca: Add qcom devcoredump sysfs support
In-Reply-To: <1686119276-10756-1-git-send-email-quic_saluvala@quicinc.com>
References: <1686119276-10756-1-git-send-email-quic_saluvala@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7974840039200479344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=754732

---Test result---

Test Summary:
CheckPatch                    PASS      1.52 seconds
GitLint                       PASS      0.70 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      33.83 seconds
CheckAllWarning               PASS      37.45 seconds
CheckSparse                   PASS      42.66 seconds
CheckSmatch                   PASS      115.22 seconds
BuildKernel32                 PASS      33.10 seconds
TestRunnerSetup               PASS      469.77 seconds
TestRunner_l2cap-tester       PASS      17.95 seconds
TestRunner_iso-tester         PASS      24.89 seconds
TestRunner_bnep-tester        PASS      6.01 seconds
TestRunner_mgmt-tester        PASS      120.00 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         PASS      8.73 seconds
TestRunner_ioctl-tester       PASS      10.22 seconds
TestRunner_mesh-tester        PASS      7.54 seconds
TestRunner_smp-tester         PASS      8.63 seconds
TestRunner_userchan-tester    PASS      6.28 seconds
IncrementalBuild              PASS      36.46 seconds



---
Regards,
Linux Bluetooth


--===============7974840039200479344==--
