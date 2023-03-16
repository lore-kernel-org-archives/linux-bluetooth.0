Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C0EC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 07:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCPH7n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 03:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCPH7l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 03:59:41 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F63311FC
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 00:59:30 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id bi17so771089oib.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 00:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678953569;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcCkDU7HjWF5t+edLP0eHsDbq4ljrEbHdhUDzo/xyAE=;
        b=SkwKEGfZKydSuS7dhhFLpSOMrXh1EB2KLwRqPWIibj7fuNUx8OZDTg7DmA/qyWX6jQ
         ImNMeA0fO4NgZl9aV/+TthzAjAMKqs5LsubxbryyQxo4amXYsgUuaMR5T0tiDnFiBp/K
         +jvC0A9R2r7PK/EgCLoinZXBLseU4iRWCgRJhqkj6NZboTM0eonOebLee7sxyxc9Y0fX
         r7LPuQbiq1Q/zdeo3g9yuhh+s/zQR7/CdnNriaUmUSkGFQ3zQw3oFVhwDY2BaOhx5/wQ
         rdyUYHKfyYBc4zYhyeCqEGGE8JIEq85PP4QdwzZ4zJ8RDl+XylAK5lgC33OS0divprsN
         V8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678953569;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcCkDU7HjWF5t+edLP0eHsDbq4ljrEbHdhUDzo/xyAE=;
        b=w39VwQVGCZDy6LLmn4E/qghRFb/W3WLEIjxGrtCi7/0lgdaMJer8vIC2m07jqnXNNp
         f0SMlbOTUshz+eZjaUHHnQ6UU7YjFgYv4AB7dltkVnb8LaBkI4xxDDlpMkCNZp+8kIXO
         tPkrr2IWE9fFQ9Fzddkxk4RxRxvOzRvw9j9K9PsRKCW4SbhoPlTdChZglNd6BitnjFjr
         1LzzWqpNMUxlkQkmnT+LjEwv7eL0CoHq6aJIWnpvaTZyIquQqGJA0NU6lgxoVTgSZ/wF
         FTptQT6E02Wx8s4WUBqbNUYsw8Sq9I0/yz/ou0cR/CgZJ5LJrGB+tuPrfVeDW7rkQ2CU
         I+8Q==
X-Gm-Message-State: AO0yUKW4rmfQuCrM+sc/ChfgZavJ/njdeg4WYBZLF19JtIyxHMj1Gr9J
        3T11zhT67wGyScJO6rOc053tvTLk+/k=
X-Google-Smtp-Source: AK7set/6vRgtNQLO1OsfZt3Aci5wGocnD0ANmOavlAgc29FwIU1M6DGDRLbj84N5NWE/GQrbwgwSJw==
X-Received: by 2002:a05:6808:484:b0:384:f4c:7ee2 with SMTP id z4-20020a056808048400b003840f4c7ee2mr2112905oid.30.1678953569407;
        Thu, 16 Mar 2023 00:59:29 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.189.33])
        by smtp.gmail.com with ESMTPSA id i3-20020a056808030300b00383ece4c29bsm48409oie.6.2023.03.16.00.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 00:59:29 -0700 (PDT)
Message-ID: <6412cc61.050a0220.6c387.01eb@mx.google.com>
Date:   Thu, 16 Mar 2023 00:59:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4390189539202373093=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [v1] Bluetooth: mgmt: Fix MGMT add advmon with RSSI command
In-Reply-To: <20230316151018.v1.1.I9113bb4f444afc2c5cb19d1e96569e01ddbd8939@changeid>
References: <20230316151018.v1.1.I9113bb4f444afc2c5cb19d1e96569e01ddbd8939@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4390189539202373093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730613

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      36.41 seconds
CheckAllWarning               PASS      39.52 seconds
CheckSparse                   PASS      44.58 seconds
CheckSmatch                   PASS      120.18 seconds
BuildKernel32                 PASS      35.12 seconds
TestRunnerSetup               PASS      502.67 seconds
TestRunner_l2cap-tester       PASS      18.73 seconds
TestRunner_iso-tester         PASS      20.16 seconds
TestRunner_bnep-tester        PASS      6.33 seconds
TestRunner_mgmt-tester        PASS      125.29 seconds
TestRunner_rfcomm-tester      PASS      10.05 seconds
TestRunner_sco-tester         PASS      9.41 seconds
TestRunner_ioctl-tester       PASS      11.05 seconds
TestRunner_mesh-tester        PASS      8.12 seconds
TestRunner_smp-tester         PASS      9.13 seconds
TestRunner_userchan-tester    PASS      6.71 seconds
IncrementalBuild              PASS      33.29 seconds



---
Regards,
Linux Bluetooth


--===============4390189539202373093==--
