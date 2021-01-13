Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AE6C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD6C233F8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbhAMJmv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbhAMJmu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 04:42:50 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6E5C061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:42:10 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e22so2816735iom.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 01:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ekkoYOc7tXjuOI0fs7ETYo6avkm2R4lE6S6AMrmqvqc=;
        b=Sfvw5YeWGDWlWLMNsQn9pdSHrI7C3zWCm6aJMV0yCRb1z3YS+B94jg4gFN3gHUEXhV
         66jdEhsqGYE1omMZ3zsoObhxcBR6/wy5IQMop/thtaUaRp7+GDKcYa/w03/R4UoHG9vB
         oNutFETW12yfl68KotEzjtfJe/EtmzpG5fl5Q0BCo3dzJpV1kk9DZQ+6lcLHlmMQ3ixH
         7rkhZJMD8nOHSjUTzdIOr/JS3Ass9ktQGKWalxWiGg00KnaGYJP+Jjw93LNyhtUiggSR
         dMcBA11uMWKwl8V5Kudr8g9e1aTHEoH9c1731BZ+oy4qXSUllzFDHNDSSiGy9EaJ3faF
         Y1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ekkoYOc7tXjuOI0fs7ETYo6avkm2R4lE6S6AMrmqvqc=;
        b=Fui06tEtbtWXYcDyNvv/TXOIg9+FyUi7xTnU3xtjM6fey1a+vzf4OJM7pjlcnoKC8u
         RzjTdMAPzdcKnbAIooifv6AwZbAO3UwmeyIyZ1imM049m4xMdtwn7cddC2Kg2CMSQ49y
         ekGGGs0ilzIrwfxAGdMT/3hIgOrEVSIiyOG9/fXb0zVrasRhkDpp6MaHlcu+c8TWu4st
         f1Qfi68Tr3f8lpBTHY4VKySO+tM/XNtfe9Jr08eVboLYbl5nQKUim1FL6HJ55KT5g7dh
         wNK6PUfjm+f8mrMaFMBthk1p4qNpiuFgMa0fFbmEcz4+1Dyfc/MF+1t3prhBQkL6kvi6
         oNiQ==
X-Gm-Message-State: AOAM5319BjyjEjK1hKtsFCFzxz81AbwF64byUfyC0jHyF8g9Muzud03h
        Tf4HJHH8boqFZ8Z5syN2nE/WWuRyD+8=
X-Google-Smtp-Source: ABdhPJxp13xLYX0GC46PSRpbzg6KpL0m8eRla+xWSGlu+BAKRdroNHRSkfct6faUVfhFEiHq6bYVGw==
X-Received: by 2002:a92:79c7:: with SMTP id u190mr1600039ilc.140.1610530929786;
        Wed, 13 Jan 2021 01:42:09 -0800 (PST)
Received: from [172.17.0.2] ([40.84.33.254])
        by smtp.gmail.com with ESMTPSA id v3sm1196871ilj.28.2021.01.13.01.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 01:42:09 -0800 (PST)
Message-ID: <5ffec071.1c69fb81.93726.6671@mx.google.com>
Date:   Wed, 13 Jan 2021 01:42:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3171742559967833551=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Support advertising monitor add pattern with RSSI opcode
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210113172337.Bluez.v1.1.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
References: <20210113172337.Bluez.v1.1.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3171742559967833551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=413687

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode.
1: T3 Title has trailing punctuation (.): "lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode."


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============3171742559967833551==--
