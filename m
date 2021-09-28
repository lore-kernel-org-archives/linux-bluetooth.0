Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B47C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 02:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B08961156
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 02:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbhI1CdT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbhI1CdT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 22:33:19 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA7AC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 19:31:40 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 72so39026542qkk.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 19:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hgXeUvY3FreIWoSqOi5C0NGyXT3IP9LX4NZoZTbxmC0=;
        b=EtCj2raLk0rFsmoNJGHuLe5vGQwSYxTlag42hfh8f7LVTzZ1pOBWJ8Z7O2K1Hu2A/G
         cbUJvDWOemZkk4LDFH/VO5v1MCmHb3NpUKV9sKV6tL0v8SSzuVjJ7fL78dk0WW9gMCOo
         XX1D15M/3YLWITQbq1iQYP9ByhN0C8fSpKMkdkhjCc/F6763bE9A4MCI04tz01OdEKmL
         AKdcMIwAByyCxsk4XeKt8HfyBOUkmXfz4wvw+cWj0OZFV7K9tB9iqlWgJtf+0fyvoWdX
         0ZplbgGNMCk5Dq9P2I5dgF2aMr3VRTzgNonxR7OJpiadHZMIvf/C2BYdDx4pcoiXb+ob
         6+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hgXeUvY3FreIWoSqOi5C0NGyXT3IP9LX4NZoZTbxmC0=;
        b=SWKBoEykDIewVvjvhJPEG2+xQkdteo0P/RZpk5hIkSdCYpvJzRM2/lerOxjDBsRklh
         yvjGbYzeqcHfD1aewCurBD2ch+fUATL3wXcMl+nFEjtWr+JOlREy05K5KR7xzrcnOGZk
         OfWcFnfv8XibJ2AoWfdspuuKAqB1VQerY3pVWj/6YeDto12xvx+vMy1hmD7OJSzi0Xj/
         G/wilXBrrYNoPHXUFGU+lkXCXPZu/2GozH8FyO7q3mMBLJPzqTvu8r6BYnEaaNtCyVIS
         G0AwGmtb6f/HbjwX+hnBTbHaM1f/TKTiNPISS5+gSvPULKrLEjWK07XS0c6G5gcSoTog
         x+Bg==
X-Gm-Message-State: AOAM530oT5lfMw0S+jNIoiTjtr2hmxmWpEB7T5wMWxLi7cw8ukMK+W9g
        BKMmSFPg3XDa1hLm2YGZGCfb641HvsPv/w==
X-Google-Smtp-Source: ABdhPJzxLPMInVFpAYmDu3RDsiyP7zcKX9TAE1NbTNl/hlhiHyuGlO0XZtJCvX4x8nx2Pd0ZLw3HQQ==
X-Received: by 2002:a37:6146:: with SMTP id v67mr3290284qkb.242.1632796299864;
        Mon, 27 Sep 2021 19:31:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.72.210])
        by smtp.gmail.com with ESMTPSA id d24sm13635732qka.7.2021.09.27.19.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:31:39 -0700 (PDT)
Message-ID: <61527e8b.1c69fb81.91cdb.2376@mx.google.com>
Date:   Mon, 27 Sep 2021 19:31:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4046227887275867592=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] tools/mgmt-tester: Add suspend/resume test cases
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210928013820.288289-1-hj.tedd.an@gmail.com>
References: <20210928013820.288289-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4046227887275867592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=553871

---Test result---

Test Summary:
CheckPatch                    PASS      1.83 seconds
GitLint                       PASS      1.01 seconds
Prep - Setup ELL              PASS      56.08 seconds
Build - Prep                  PASS      0.54 seconds
Build - Configure             PASS      10.62 seconds
Build - Make                  PASS      247.73 seconds
Make Check                    PASS      9.78 seconds
Make Distcheck                PASS      280.72 seconds
Build w/ext ELL - Configure   PASS      9.92 seconds
Build w/ext ELL - Make        PASS      222.60 seconds



---
Regards,
Linux Bluetooth


--===============4046227887275867592==--
