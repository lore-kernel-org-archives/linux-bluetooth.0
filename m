Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BDBC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Feb 2023 17:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjB0RJj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 12:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0RJj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 12:09:39 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346DF1EBE6
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 09:09:38 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s41so4936463oiw.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 09:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677517777;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pmKy/E9XIJ1O5NCmWt3r1lWVpGy80yM2Is2+Lp/EyPk=;
        b=C6zOM+rrOFVK7g6BaxMqQtdcqu1qB1pS9YCVghtfG8ikCz4F//UaIMwPc4VrfT5GRq
         8qK8eDbUXcAglqjoKYhySBE1BEiUGIL9HGs9WonZ3gJox5sFKGLt7Ow0ZzHLOMbbvbIo
         CexyhjbTpg0q3rOWK+3o4Ndt3+y6oAj8M5KdaeDVtcEaKgc4aFznsmdvsgYssK6+3WSa
         8Bi/yLTnfMuZdG92gIkuf6G3c3lom/DQePEFZJOD3Set6FMtXVqSY1uxlfejVIwg/bEV
         O9o+BsfTU1o/tnyNJP2//sBV/0Z4A+BpkHcWpDoF7E3zAFyj9toY0H2XCFGxYW4296CZ
         LjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677517777;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmKy/E9XIJ1O5NCmWt3r1lWVpGy80yM2Is2+Lp/EyPk=;
        b=qIxSiICQLryYeGLOCCGF/hkE+Xg82aeLrWjfkVN43/5qfXZ5Eukpl2oLtkFVCRF3gq
         lwFub6bx/77Pv3nqlUE/8eP77emkAApPq24fUMNkWGpHTfhGJOxn8yFBGS/EXV1fbPxH
         CslOGhY4phIwArkeUKjA6I7QzSw7C4rkowBurK1RCI3H5LL1iSqHnLbw6i4yInQ4xIQ6
         M7ZoHjFMUJ/6fCoEumOFUTGhxKUQfEfGKbxi51AWOdT1YT8fbFnxcMDfAt9iyjN4ZeD8
         Q9VkT13D1FG9LTtibc6W0uLZPzi9Sac2EGJxf1YTMAYK3RvUvK+vx+ZBM2+qEOScks5W
         LK6g==
X-Gm-Message-State: AO0yUKU9iVAFiAplgJVpbml9ba6TM1mp90OscbAVXGi72Ro5+J7+u8Vf
        kh4hm6Jouf7WDbiIJMbvMBuJUvzm45NSGw==
X-Google-Smtp-Source: AK7set8ktm20UlUg70k+XxIs7d1zh8lx0c6erDwjvYTQiaELudQarAz/oYHdreva+AXnhKywuMfn7g==
X-Received: by 2002:a05:6808:282:b0:384:c52:c331 with SMTP id z2-20020a056808028200b003840c52c331mr4775248oic.10.1677517777242;
        Mon, 27 Feb 2023 09:09:37 -0800 (PST)
Received: from [172.17.0.2] ([13.65.72.209])
        by smtp.gmail.com with ESMTPSA id v132-20020acade8a000000b003646062e83bsm3319351oig.29.2023.02.27.09.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 09:09:36 -0800 (PST)
Message-ID: <63fce3d0.ca0a0220.4470a.d110@mx.google.com>
Date:   Mon, 27 Feb 2023 09:09:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2325354560107775299=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, macroalpha82@gmail.com
Subject: RE: Bluetooth: Add support for RTL8821CS
In-Reply-To: <20230227163027.130292-2-macroalpha82@gmail.com>
References: <20230227163027.130292-2-macroalpha82@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2325354560107775299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=725242

---Test result---

Test Summary:
CheckPatch                    PASS      1.66 seconds
GitLint                       PASS      0.80 seconds
SubjectPrefix                 FAIL      0.58 seconds
BuildKernel                   PASS      30.67 seconds
CheckAllWarning               PASS      34.03 seconds
CheckSparse                   WARNING   38.86 seconds
CheckSmatch                   WARNING   108.94 seconds
BuildKernel32                 PASS      30.08 seconds
TestRunnerSetup               PASS      432.95 seconds
TestRunner_l2cap-tester       PASS      15.83 seconds
TestRunner_iso-tester         PASS      16.38 seconds
TestRunner_bnep-tester        PASS      5.28 seconds
TestRunner_mgmt-tester        PASS      107.75 seconds
TestRunner_rfcomm-tester      PASS      8.54 seconds
TestRunner_sco-tester         PASS      7.86 seconds
TestRunner_ioctl-tester       PASS      9.07 seconds
TestRunner_mesh-tester        PASS      6.69 seconds
TestRunner_smp-tester         PASS      7.73 seconds
TestRunner_userchan-tester    PASS      5.60 seconds
IncrementalBuild              PASS      36.06 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============2325354560107775299==--
