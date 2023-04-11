Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4AAC76196
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Apr 2023 08:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDKIf6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Apr 2023 04:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjDKIf5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Apr 2023 04:35:57 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CEA12D
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Apr 2023 01:35:55 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id ay36so4253787qtb.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Apr 2023 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681202154; x=1683794154;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QEMzXL8oRmAfCbZCOKW7n6ToNLv4iuOcZCYiG/XksGw=;
        b=W8cKKB0sYY7zvTeunNZRqfqKcu8TuoewlExqULfoFhRcYAAVAvy/L78QY43TbtScvn
         Bfadytsc1Q6oDboON2u294gr/wHmfk+USYPfrTD95TI8R6TAoXH4If59gPFvjVjp5VJg
         VvLsjH1KQeGWb27Qz24jnEgoQZiORs+dtZfui7czkIZA0OEEaOMgFJuIC1hX5u2+o6ud
         VP1INI4cwJkjzdAdPIViFpSZ7bBu3uukkgXtdcv0jFIZX5xIrqKk7qbBkKbu3i5egOlK
         l9mibuDI3SYq+Z+H59gaSP9h/PT7qdRv0mY+Q0tOrvYxwxmBhKnl33E6DOjWFgvT3ZH/
         tSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681202154; x=1683794154;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEMzXL8oRmAfCbZCOKW7n6ToNLv4iuOcZCYiG/XksGw=;
        b=HnVmz10dJnZKYeS02laxrMIDp4/IiHIk2zW4BBmELuWV9PFseqkDD+/xTDQBODHAM7
         8OJE8GMnmS4HpyYKgSStZxZfb0sPf5ZJ152lc8qoTGJvRh7jU2V7SThCmPwus7VyScQi
         6VSxbUn/ptT1YyV5biUAJF7xRHJLeP0pSHAzTappfxElyY8R807R9PQvUeSDS7rQyrAI
         zVh/IcQhnosNqr8SzC2LuFcbqIjP87Snc8d5+kYjAGcyEsyAqgBfIvLqQ0TEWs269rNf
         Sx/tObdh4PCmyg6OIo//FStHSqppcQFpzrDh3ouypkF/7A7gpNp5aKELYrTPUnG9DCtF
         +YUw==
X-Gm-Message-State: AAQBX9cXAbRrndktwtGyqFCH/Srqio+AXbK29ekuwFoGS9iN8c62+uLR
        8UN1el18F8MJ+rZlumkJgE5sUd7Kc7g=
X-Google-Smtp-Source: AKy350btn4GcwVoFZ3qUDMlLOfEDSa7pkenIcLtJ9I5fFJn85OY99lPQ2OsrL2MC+hUEqyOYh6jfEg==
X-Received: by 2002:a05:622a:5c6:b0:3e3:8ebe:ce2d with SMTP id d6-20020a05622a05c600b003e38ebece2dmr2297124qtb.68.1681202154251;
        Tue, 11 Apr 2023 01:35:54 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.74.36])
        by smtp.gmail.com with ESMTPSA id fp32-20020a05622a50a000b003e69d6792f6sm1697323qtb.45.2023.04.11.01.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 01:35:54 -0700 (PDT)
Message-ID: <64351bea.050a0220.e2455.5b3a@mx.google.com>
Date:   Tue, 11 Apr 2023 01:35:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2086204353239506221=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: hci_conn: remove extra line in hci_le_big_create_sync
In-Reply-To: <20230411074135.69768-2-iulia.tanasescu@nxp.com>
References: <20230411074135.69768-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2086204353239506221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=738667

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.31 seconds
CheckAllWarning               PASS      34.47 seconds
CheckSparse                   PASS      39.00 seconds
CheckSmatch                   PASS      108.99 seconds
BuildKernel32                 PASS      30.40 seconds
TestRunnerSetup               PASS      436.72 seconds
TestRunner_l2cap-tester       PASS      16.50 seconds
TestRunner_iso-tester         PASS      16.31 seconds
TestRunner_bnep-tester        PASS      5.21 seconds
TestRunner_mgmt-tester        PASS      111.36 seconds
TestRunner_rfcomm-tester      PASS      8.51 seconds
TestRunner_sco-tester         PASS      7.78 seconds
TestRunner_ioctl-tester       PASS      9.09 seconds
TestRunner_mesh-tester        PASS      6.67 seconds
TestRunner_smp-tester         PASS      7.66 seconds
TestRunner_userchan-tester    PASS      5.47 seconds
IncrementalBuild              PASS      28.69 seconds



---
Regards,
Linux Bluetooth


--===============2086204353239506221==--
