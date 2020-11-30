Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F653C5519F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 08:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC9520719
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 08:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYlTszV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgK3IEE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 03:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgK3IEE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 03:04:04 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35071C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 00:03:18 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z136so10836875iof.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 00:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aQCdUmgMY9H1wD9Kfpo0icURwqwXsgsMuDCjtGN7i2c=;
        b=uYlTszV/MbRyVgwRoDk6Ucli29SdoS2esnQDIpM79DOqvqfoNuwxgFNCqnDMU7UzNc
         Euv6Ju2eQh6xjpCGTJTPRQ7D9DZSwKfg4DmKKi/6tOlroXMeRvGXnPEtRgRcav55irLL
         69BICwIqi0789RgmWAa8VJERUp9jgZ+CfhyU6MMPDhsOhn6Cbd4uGDaGJhOn4QaCyWa7
         d0JN8nvsI5srLQW63nBqFI4qGO6n3RtJDwxIFMMoABA9H3Uk2Tj1X+YfZ4v7TA20T1Kp
         gHAhHJY4qv525z7foPJ8+1VYa3jj4tNN5s1DmENJYyk55vo7Hs0kzgCEHLKUYe4ZNwTn
         aRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aQCdUmgMY9H1wD9Kfpo0icURwqwXsgsMuDCjtGN7i2c=;
        b=jLTcn3BfYFwlu120UzWUG6voLspqM0qMQah5uEpEmq8t0CcrTxwJ/zOslLZogGxXss
         nNXE7cAyKR4c1YA7n+vLUbe97LmqBzsTzMIudzqJJUTlUIAV39t74M31r5W4ycW3VlHL
         d8m2CKr9eGrQEbkcNXZu9KvApyPx9Q8/U0OJj2IQttE60W3e/kwUBmJpOn+2bVjzU+Fl
         D83AkGjLguqZ5RQWmdNOV6tvtWA4kTK5lmUkPDbUY0lXZbeyGTFqQZmqmWeYUNqin+1j
         vfX0R8Bbx4pw1uxZ/e79zR7+EgUba+KXGNXH4EvN/gk0fnbFje8P6EG3TVGoF8dxlr5G
         eTzQ==
X-Gm-Message-State: AOAM532Me+uXgzFvAWg90gvzLWNjOgR+MFe9+xP4/neWRT/3vtw6E2nN
        fa9vgEo+3ETwsaj422GhQPBKnA51Fco=
X-Google-Smtp-Source: ABdhPJxaao/CnjKrP4hdrvxCPn3fN/9dB1PT8H/9CXtwHqHXvCmT/LgTCPGsyce3rBbsjeUp1d5KLQ==
X-Received: by 2002:a05:6638:526:: with SMTP id j6mr7313592jar.1.1606723396889;
        Mon, 30 Nov 2020 00:03:16 -0800 (PST)
Received: from [172.17.0.2] ([40.75.89.216])
        by smtp.gmail.com with ESMTPSA id q25sm11109581ili.34.2020.11.30.00.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 00:03:16 -0800 (PST)
Message-ID: <5fc4a744.1c69fb81.1b7f4.4ea0@mx.google.com>
Date:   Mon, 30 Nov 2020 00:03:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0762749573607725182=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, peter.tsao@mediatek.com
Subject: RE: MTK mt7921 driver upstream
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201130071655.31515-1-peter.tsao@mediatek.com>
References: <20201130071655.31515-1-peter.tsao@mediatek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0762749573607725182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=393043

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
MTK mt7921 driver upstream
WARNING: Missing commit description - Add an appropriate one

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#9: 
new file mode 100644

total: 0 errors, 2 warnings, 12491 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] MTK mt7921 driver upstream" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============0762749573607725182==--
