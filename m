Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D1BC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 00:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiFNAnj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 20:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbiFNAna (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 20:43:30 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AFB2FE7B
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 17:43:29 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id i25so5148610qtq.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 17:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+FQXOr0X+3EcnpC7Z4pZpMIgqSbPUR5nwGxFm0nhuZc=;
        b=LGtayl+gb4oQnCLsSpfaIoIjHJ3GJtSdfLPcy8Gj8gNRbZH+tPYjhYZG01tI92s2X5
         +wGupFa+Gb6RE3U+Pmm5n/hmNKU/XF+JxjugDnsBLped/RNv/55iEr4R2cneVZHpYP+E
         PoXkleQAs3hmaMTwTOsDPWvzJQTXwVoWYtc6XMO93dQLxZ6H+F9vvqAjKxOAXSvH6sks
         tja2+qWjF4Tuk4qbVi/TVnh9NRnlsO09NQqlGyd2V7485xYYsZVAx8bvFEV0R2+cXkNO
         RKL1V0vQDLwXpc4GVCi7wBzKL85NHzCcpNQJxi/kmEbPuxJmzq7VNXY4413cKVB4clD9
         BQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+FQXOr0X+3EcnpC7Z4pZpMIgqSbPUR5nwGxFm0nhuZc=;
        b=59cnGXzXqCE3lqF+IIweA70T9m8oP7g5BJUcZjsr2sHBal3NyR5rr2wjSrMrwHqd2d
         BJQQpLVU4LjeVHnfHslQDzphYTY4C79oQ+1KQZl0sloIJR8Lwi2gNjI++kekrhi6qRZU
         b+ZM2bPhgQEz076VdsoniXy8ePt8X3yR8M1cQ/cEr/C/tawCJvNXc5Us4HRD+u6XonHm
         JLZ1FRsv9Ejxn4zOfFj47MLNTOUzfHScRhHI6PgErlcMLw4GFIgjc88Q04Cp4+PopGik
         CvC9C/1EaHKiaVHCis+3ni07YFyaaqKlQVcXJBe6R9iQnOSxIDyjckFp3uCs9hXAmzbG
         mKaA==
X-Gm-Message-State: AOAM530U8DmICW8qPiNKSqW5jFWSoueTFqKBg//pLU6nG0dUWyk0xIm6
        j0XkgiME+2mZola3MzhBZAhpMxl5lPmcCA==
X-Google-Smtp-Source: ABdhPJwy0o7LP/QJO59PwVyUuFHveVhrRdHy3CGns+cuW2IsivtLf0uz5GwHEvrEBtWlx0lhLWrVbA==
X-Received: by 2002:a05:622a:216:b0:305:82d7:8777 with SMTP id b22-20020a05622a021600b0030582d78777mr1900419qtx.551.1655167408474;
        Mon, 13 Jun 2022 17:43:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.156.247])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a245400b006a32bf19502sm7940697qkn.60.2022.06.13.17.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 17:43:28 -0700 (PDT)
Message-ID: <62a7d9b0.1c69fb81.2d932.d487@mx.google.com>
Date:   Mon, 13 Jun 2022 17:43:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2481299614582736797=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] device: Add connectable flag to bearer state
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220613233419.177421-1-luiz.dentz@gmail.com>
References: <20220613233419.177421-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2481299614582736797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650005

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       PASS      0.97 seconds
Prep - Setup ELL              PASS      42.60 seconds
Build - Prep                  PASS      0.66 seconds
Build - Configure             PASS      8.47 seconds
Build - Make                  PASS      1391.45 seconds
Make Check                    PASS      11.87 seconds
Make Check w/Valgrind         PASS      445.83 seconds
Make Distcheck                PASS      231.66 seconds
Build w/ext ELL - Configure   PASS      8.62 seconds
Build w/ext ELL - Make        PASS      1383.55 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============2481299614582736797==--
