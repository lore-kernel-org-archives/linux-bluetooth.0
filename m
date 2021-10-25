Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80450C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 05:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5860360EE3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 05:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhJYFHJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 01:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhJYFHI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 01:07:08 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451FEC061745
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Oct 2021 22:04:47 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id y11so9242868qtn.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Oct 2021 22:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=tORjI5bHh9DlybG7HUHm+G70KUoBmAZ8gs30X7QR7Ks=;
        b=ZPoletQ+0dLBLzLGzyGwEEAtI+2FAIeka1o90qBLTJDL9svJK3JK/X/9i4V8Spnhkj
         BKQ9pA9oM8Tf8ggq1feCYsQtOd1alPXc4TVdbIRllVXHdI6wqUspC2Cql99HqXga+RtR
         ASLbjniRtWfHSTusZyftIs2gwLN3L9wIcAcoTmbPQquPk1bwdmPb0/SZvsmKoGpp+ccD
         ZLqgu71w6P9OqsSu9zd3EhPtVNRBdb778JCRgz/bQYBtqG5HYuENMzzssvZ/XcwD/tZL
         KK+sGeG662Nxl7ZILX0JFkOoboXCnywXREEpDb9NCPdLZUU42mYJSn7cDZSe5BhmKOfV
         TRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=tORjI5bHh9DlybG7HUHm+G70KUoBmAZ8gs30X7QR7Ks=;
        b=3Kr/8rAIcigcXJtQP7Ujx+1IoYOJHo9MpRWajYuMYENXc3svaME7XScLBM/njexeBF
         aQQ0Ux24AhUsbp+pYRjgrSw8bTf4sE4PwIATMNwQd1soLOVLk4tLrRbIx5KvwINTD5Tw
         26B0LybCqXO7XHfGaJGkyxpCLAVfrLzDvdTL/l9u0UjQHPb+/aoXswjk4iJORllSjseo
         yfk47W+x58zTQyycavnBxrOhVTuykobbTNT4YWwnljvIYLx9Y+ZYbxhk8ZnzEv62aHbv
         fRx4hY948uUihjZLPxQXjdvmluHHK22dW/L5mNijRVp9yhb41pI64i8FT+9KU6ZwSwag
         n/xg==
X-Gm-Message-State: AOAM531qpznJqX9I4UcuhIVNMkQNo/jpqOZy7a6zFBEXafdpIw+n+9HO
        DKQEqIxuBhq30/yCFRauYtsKqIHyx8emIg==
X-Google-Smtp-Source: ABdhPJy2xP8NdHx+sDRw9629H8WaqJ0C1aV3yEobqiM5riaTp/Q1jWoyGGFz9Bil+AXfnxrE1BrQvQ==
X-Received: by 2002:a05:622a:1d1:: with SMTP id t17mr15969808qtw.30.1635138286230;
        Sun, 24 Oct 2021 22:04:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.152.22])
        by smtp.gmail.com with ESMTPSA id b20sm8616152qtx.89.2021.10.24.22.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 22:04:46 -0700 (PDT)
Message-ID: <61763aee.1c69fb81.50cab.63ba@mx.google.com>
Date:   Sun, 24 Oct 2021 22:04:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2320797918841497271=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] tools/mgmt-tester: Update the expected manufacturer of emulator
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211025042743.477763-1-hj.tedd.an@gmail.com>
References: <20211025042743.477763-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2320797918841497271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=569305

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
GitLint                       PASS      0.89 seconds
Prep - Setup ELL              PASS      42.01 seconds
Build - Prep                  PASS      0.49 seconds
Build - Configure             PASS      7.87 seconds
Build - Make                  PASS      177.97 seconds
Make Check                    PASS      9.31 seconds
Make Distcheck                PASS      211.25 seconds
Build w/ext ELL - Configure   PASS      7.84 seconds
Build w/ext ELL - Make        PASS      167.81 seconds



---
Regards,
Linux Bluetooth


--===============2320797918841497271==--
