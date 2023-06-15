Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA79EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jun 2023 21:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjFOVN3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFOVN2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Jun 2023 17:13:28 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABC8295A
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jun 2023 14:13:24 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666683eb028so150122b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jun 2023 14:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686863603; x=1689455603;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K+3zSwiCS38xrXP5q7Mx9y5+t8I0YCgtmSZggKB2kdE=;
        b=Y+/GCp7j2Ex57sY1u1dCNWk60eJBS2LwRe6bTD4VMMIoa7ypXsj0fAHpgy1WVmhz+6
         TgsoHE41Ndke5zungTCnfLoC+hRaWoutkqKvL7d7L9q6fR7OnDW9mpCb15fqHwDlnzXu
         BJkGM1dcGCCEr7oCXrtZlbBh7Qwq3cXjDFvejJKOlyiqLBbeeCiedgryL6KTr0L4um+m
         uVb+vAC01TA3YSulLYEFezveGKPMHHzPVmAnHWFCwtVnN7TcSGGp7IWhWemW4rUbcDOo
         cYWmyEIWgVwQxnoQw6n5b8hcqAgt/OqRr0rtvogNckuHBFgjblNClN0DXB61rCuWHyLP
         tArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686863603; x=1689455603;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+3zSwiCS38xrXP5q7Mx9y5+t8I0YCgtmSZggKB2kdE=;
        b=Yo+/mkUC1Aem6wzIt0eqp1oSYoEjNmSMoqx0dgwxZxPjUuOM9HnMvY9UVNCAQ8Nbmq
         MQYM3wd5oAaoYaHzfVuuGAXzXjVZgPwQDD4+xLjKaOAS02O9zNB/E3Zm5WL59s3juo1Y
         bPfI05rv7U3iMqftlxk879CwQJCl92O3Gx4ytFqTrae1D78oeYPJC9pBtG6puAz4QEse
         wDAT/13JJSIMF5hPyTUunWyWOEtoskRCj7KLuLMlTqAdWFZLl9dV4vCeqPRJbL6u7SEY
         IYXidK5aCLCJeVeP/Fwv1NbYOQtkdI6UiKFf8+csOOTzP7C9LHlb4LRZbkmzLh+tAhe6
         psbQ==
X-Gm-Message-State: AC+VfDyE8Ex4NGX5WLmtzIbLBqw7Z2JGLpQgsptcrDE5SA4m7k5iSdZ8
        BaQywe2TIPoaJRWgBc+Xq0PLr/WAyr0=
X-Google-Smtp-Source: ACHHUZ5dGSMcmnrfhRdoe2TGkbqeWLofuWy5O+jXvBoI420Tp27YwYwXiQXuVILtihFSPZzTHjQRlg==
X-Received: by 2002:a05:6a00:c8b:b0:654:492b:d55e with SMTP id a11-20020a056a000c8b00b00654492bd55emr258051pfv.18.1686863603147;
        Thu, 15 Jun 2023 14:13:23 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.161.25])
        by smtp.gmail.com with ESMTPSA id a21-20020aa78655000000b0066642f95be3sm3367790pfo.56.2023.06.15.14.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 14:13:21 -0700 (PDT)
Message-ID: <648b7ef1.a70a0220.78028.7e6c@mx.google.com>
Date:   Thu, 15 Jun 2023 14:13:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4243105941149560138=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] mgmt-tester: Add a regression test hitting hci_sync bug
In-Reply-To: <482831b8629d9f4f98ef88c769371a03a872d1b7.1686859345.git.pav@iki.fi>
References: <482831b8629d9f4f98ef88c769371a03a872d1b7.1686859345.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4243105941149560138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=757622

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      27.33 seconds
BluezMake                     PASS      866.65 seconds
MakeCheck                     PASS      12.34 seconds
MakeDistcheck                 PASS      157.73 seconds
CheckValgrind                 PASS      256.24 seconds
CheckSmatch                   PASS      337.11 seconds
bluezmakeextell               PASS      100.92 seconds
IncrementalBuild              PASS      699.94 seconds
ScanBuild                     PASS      1061.65 seconds



---
Regards,
Linux Bluetooth


--===============4243105941149560138==--
