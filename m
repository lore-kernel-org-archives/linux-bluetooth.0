Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B9DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jan 2021 22:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EBB520795
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Jan 2021 22:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbhABWqo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Jan 2021 17:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbhABWqo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Jan 2021 17:46:44 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D604C061573
        for <linux-bluetooth@vger.kernel.org>; Sat,  2 Jan 2021 14:46:03 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 143so20449083qke.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 Jan 2021 14:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+NA7ai4KcjUw3z18AXq00GNPYWhixT2gsQ5QAnzcnxM=;
        b=UCE83YG5IX/MA9WbPP5WXs+hirfJNQYgoqzCxzxu+cD0iS4l1xiX+3yIDK9wYzabuf
         lkqjKlmCjqvviRRXcDlFGP4ld3naooOTYMkf6k16SiwW4pF5za/0GgZUf8Wiv0LzHfq6
         VKBC+aWZDkMQqeG3Ix0fKAzJFKpOaPeMgyktLV/gJYkEFmmi6MrIxYR2oB9hdZkF51Z9
         5+V3NpNLNIJK+lKAHaCVTsuLGsdIETLmgOgMwRzzicAEKTJ19NaLkw/jQIOe7deyaW48
         RaoWdqYLzBcuOctFyftyc2BT7uTBzNojqbJCJV9aqmXxyXD+jdNb1jg0DLLNVlUYHB0P
         ukdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+NA7ai4KcjUw3z18AXq00GNPYWhixT2gsQ5QAnzcnxM=;
        b=LUav5Mw99dpbRbor8C6HwQ5rdASu0pcM14xvzQU9lt3LqgfAjSVSzz7/Cb4WwXtDpt
         2jPCiA9hQBRg6uR70zmZqtp2elwlGKjbvrn+QuSkk5AWsdRAAJ9RKzTaZJO8k/2e55Ab
         wOW+VHCR9VOty1uNdljlNf+kCrLojfd3fApXpeFtOL1a2pDQw07qBD4J7UkhLCcr690X
         Hs/89WzGAu+FnfSSkWpHxihovBEau3d9YDSCcv30YirsvABd5S5MWkWlAlWM0Cq7A7Q0
         BilCfrConMTJ+dhVFidOSXdDwkc3WHetPG2Oq00pNsR+1mKmU0R0JqITTrjBVtnrE5cK
         lZdQ==
X-Gm-Message-State: AOAM533e4UozwoQUOlWsFZZclX7+3YNX6LP7g+0or20yXs8vn1ODnjEr
        5UjjDbhZi8w4JAkTz1wIgdpttZaxqzSiFg==
X-Google-Smtp-Source: ABdhPJymDFHcF3oZ0n24MuKF7/aaJRt0/xpnsu0f5W+kavrmifQ1nmW4OwrHnDdWOLiA/4MmCT5DiA==
X-Received: by 2002:a37:4815:: with SMTP id v21mr25514012qka.130.1609627562780;
        Sat, 02 Jan 2021 14:46:02 -0800 (PST)
Received: from [172.17.0.2] ([20.190.241.100])
        by smtp.gmail.com with ESMTPSA id d3sm20288641qka.36.2021.01.02.14.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 14:46:02 -0800 (PST)
Message-ID: <5ff0f7aa.1c69fb81.33c2a.16f3@mx.google.com>
Date:   Sat, 02 Jan 2021 14:46:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6871431860864402207=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mike@mnmoran.org
Subject: RE: [BlueZ] mesh: Update AppKeys on transition to Phase 0
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210102222755.71019-1-mike@mnmoran.org>
References: <20210102222755.71019-1-mike@mnmoran.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6871431860864402207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=408205

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============6871431860864402207==--
