Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA3C32789
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 05:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbiHWFZr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 01:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbiHWFZp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 01:25:45 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132555C9C3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 22:25:45 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id f14so9550781qkm.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 22:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=upduXEjMBXDkL77KUrzynCELiK9WD6JywMQnR9QIozk=;
        b=XPbwFP0Sp+82A3pXOzY/6fMK4hLzoy+c8E4y58Y0ZKGTsHdo1tqvDz7OzZ+nlOOd7R
         eZVei5OJdpKWFYMbnrkJ545I9feZaOg6csmTrhJCjlgoCAWwFqIuD5vnzKhWzO1bKsV1
         Iqv+x26FMG/GVHNq7ayh1mFWegF8e+zSqTH9qu+ehnFMu+M/hVDPvA5onvPoD38WH+CZ
         pty3lO/bJnFgEOZyty2cPnxC/Pcyvo3i5h4x11IQtRbpsbciuJiZrzGjIIMmMwBlnu8s
         sshbc9udNvpGFzcCxrFB9/o/n1eDqg1Y7nOdt22I1xbzUOkApK22JqO1ZrrkSXvOQxkA
         eH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=upduXEjMBXDkL77KUrzynCELiK9WD6JywMQnR9QIozk=;
        b=VWTvNwWstP8+UwvsRI9iKWgyLZ0/SJMdphbfyrIfiobENq/6bmjV04MJJ6NqBZBhrZ
         X4RbOUkC/mlXK1Qr6iie6uhZbemv60DoUDkMaxKFZDxYRDPz+XVB/EJXOou4454w/B5u
         QbUgMP7Ui38oYFbnK+jA+cZmP0di80g6g3+kDigHGzsxecDP0VGdJ+qUdi5+SE6PsqaM
         isQ6a+dthuRqqaVwJhOPBKxAHu8/9aAiwCKBT67PVyDHN467sP2fKWhYc9oyc3PI9UZp
         kkl+gufhSgF1r7Nw7/cXMBmT3fPRntHqqgYrk64D8vBWXxU3BACywvFmxeyfGgH0J83Q
         t9hQ==
X-Gm-Message-State: ACgBeo1vFt27vks12LmEci8oBEui//nugJXE1fHkcn8Hr7n63LrHe8F4
        X/KLN+q5p2tVeTIyKiN+ghxJdpfo9bd6Yw==
X-Google-Smtp-Source: AA6agR7PZbWESz9E8Vo7y9Hrd4C0+0NVXBaAOLI4C217hVqyC74ITHEG1W5g+ZQRSQfEzRgvJZ0ZDQ==
X-Received: by 2002:a37:aad6:0:b0:6bb:11fc:7c58 with SMTP id t205-20020a37aad6000000b006bb11fc7c58mr14748872qke.274.1661232344105;
        Mon, 22 Aug 2022 22:25:44 -0700 (PDT)
Received: from [172.17.0.2] ([40.123.29.44])
        by smtp.gmail.com with ESMTPSA id f1-20020a05620a280100b006bbbd4ce6e1sm11679323qkp.35.2022.08.22.22.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 22:25:43 -0700 (PDT)
Message-ID: <630464d7.050a0220.369d0.b02c@mx.google.com>
Date:   Mon, 22 Aug 2022 22:25:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1914580383834932426=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Bluetooth: hci_event: Fix checking conn for le_conn_complete_evt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220823123850.1.I0cb00facc6a47efc8cee54d5d4a02fadb388e5a5@changeid>
References: <20220823123850.1.I0cb00facc6a47efc8cee54d5d4a02fadb388e5a5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1914580383834932426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=670004

---Test result---

Test Summary:
CheckPatch                    PASS      1.63 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      35.04 seconds
BuildKernel32                 PASS      30.50 seconds
Incremental Build with patchesPASS      43.10 seconds
TestRunner: Setup             PASS      490.36 seconds
TestRunner: l2cap-tester      PASS      18.29 seconds
TestRunner: bnep-tester       PASS      7.13 seconds
TestRunner: mgmt-tester       PASS      107.36 seconds
TestRunner: rfcomm-tester     PASS      10.62 seconds
TestRunner: sco-tester        PASS      10.54 seconds
TestRunner: smp-tester        PASS      10.42 seconds
TestRunner: userchan-tester   PASS      7.52 seconds



---
Regards,
Linux Bluetooth


--===============1914580383834932426==--
