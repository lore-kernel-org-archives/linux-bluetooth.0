Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA7FC63777
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 10:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1DD4212CC
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Nov 2020 10:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB01HnW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgKVK5o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Nov 2020 05:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbgKVK5n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Nov 2020 05:57:43 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B39AC0613CF
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2020 02:57:43 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id k8so2480247ilr.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2020 02:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=X+oAHiED3EqxBS4hJ3dAv6kV8uKh0SiSRJOiDAx52tk=;
        b=KB01HnW3Xqqhuql1fzy4qsYogBkFuOfnsqmSdc5a7BEqqmdAgHYUWkGfuxbkK+nkWI
         q6PFo4+I4MojxHqSIhV1o3cX7J1AbsD6HrbTi1PTlGMtE/QwrDb0h9cbaTYnfQTzOveF
         3ZkYsTSGGFiGfix5gars7gPatpA5fInC3WUKzO6oQF3fxFUhxqj3+ayNDHs24Cg8MdCD
         F2wzB29231JLb1iGx1pcbHiamgW7FCsA2kSy+m0/iFDx/bjvK55U+cTquJp66N5Z5+m9
         eMGKzCQInPq31DqtmZXvgezXIblDH4drcsF96UE8bduR/E6Hc3csnoO7dbpB9nZIP8MC
         4eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=X+oAHiED3EqxBS4hJ3dAv6kV8uKh0SiSRJOiDAx52tk=;
        b=f1RyhhGS6oyjDUmBUApH+MoxgbTw1hU4WB7NBaIUDhvsXB7KeXSEb0YL+vNmyINDmz
         ObtrGKmgqlF8NvLL2f86H1XONJ695BHjetLqS0+aiMZtDBSl7Tg0ArFIkcGvKahxaA6t
         jchso9xY85kcrb20hk5fI1hQDk291CVVE8hb7rZUDQPyF90iUNEoeB+lliNxBSjep2uh
         EQ8JlZPUExWNwlmFnHb4LNRBmfxgtTBcMexgP0hN4Ad2rXde7vD2OaQo8xAjuRnTzroS
         iK6sY01qkqRpdhO6uLzmi39Q9g8WeqY4gHaYAw3ZZlQQACy3ecu/tqkTImBjk9t/8O1M
         sAcw==
X-Gm-Message-State: AOAM531dVg+VN/d3cwXZ9LXyemONGCuFyxssYBDeA5YJDZHk0FlnfKXQ
        kvHLGYBHLczZdB+90dDBWwmA0EPqWcw=
X-Google-Smtp-Source: ABdhPJwEohibNNU9k6Ks7Znn/BvJQH/2BPcLjLeFCngbOxqtu3qpkwusiziFYp8M0er16ziKpF+XZQ==
X-Received: by 2002:a05:6e02:e8c:: with SMTP id t12mr7130147ilj.302.1606042662653;
        Sun, 22 Nov 2020 02:57:42 -0800 (PST)
Received: from [172.17.0.2] ([20.36.196.114])
        by smtp.gmail.com with ESMTPSA id s16sm5647202ilp.43.2020.11.22.02.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 02:57:42 -0800 (PST)
Message-ID: <5fba4426.1c69fb81.a3572.30e5@mx.google.com>
Date:   Sun, 22 Nov 2020 02:57:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8937711951317612544=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: Bluetooth: hci_h5: Add OBDA0623 ACPI HID
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201122103323.26116-1-hdegoede@redhat.com>
References: <20201122103323.26116-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8937711951317612544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=389063

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============8937711951317612544==--
