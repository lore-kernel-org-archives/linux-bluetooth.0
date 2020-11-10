Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB8FC388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 04:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14743206D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 04:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="np4xo6tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgKJEq4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 23:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgKJEqz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 23:46:55 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D731C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2020 20:46:55 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id n132so9243937qke.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2020 20:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CT7WnIj18FCDHiYiu0DnKXVCSPJlN4sH1/SzGENKCDE=;
        b=np4xo6tbHtzt8+KfdGSiSSMNjJa7zxmLlutWEjjoyD6iDbv9S6TqfOckO918ppMYir
         RqvgrLCaw1CEfYLKR1+Onrix9EvD0rJrnPPCeA1iNMLnHWZXL9MOtCHy0+ES7+dkfzet
         36AnxEd2H7890XpTnE8vDnGjCVINFLCXs4j/RSdAWGOpEsKG+LQdJHplQ8QWQLfWVVV+
         8YS+ULWux3ZbtF8MQ4ko2oqEd9jZvfKa97Xq842YSfXxiKUVpCjuaQUqJwEPlTJrPDr9
         +jsqTKolHpdd4M8UI4KRb99IGKRvIDA440/k02zEBrFsyhgQ9kDWNFhObWU2iFf5kGqt
         QDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CT7WnIj18FCDHiYiu0DnKXVCSPJlN4sH1/SzGENKCDE=;
        b=F9BP512Xjmj9LXMWBcDlbRee+odEd+KHR69iajs34ZxQdUX91qgmH1r+7YQSWC2JYM
         C3HA+08aL0UDpEDleCXZ3HRAfzB4S0Ed/ruVuLH9c50GHJbKx58lhlSm8dok7pB6IrJ0
         7U/RL6Nu51dwzt1oKFKPcgsDduijsSTgWIaS41HyBqwtmMNDOAq4z0C25THcXdnWpfM6
         ff89rbRLay0QL031M4AjL2R5HwgGDaEQxQx2MvhH9pxUhHo18tSCXG7+fvEWKjlrNRzq
         JVIoyBINBvbF4afhJDFr4QqA+bwqCvzgJ0dYjEm3AgOKcr+X+4lr5iOQAHv8UR49yxse
         tOrQ==
X-Gm-Message-State: AOAM530KVurjcGLwdOqOIV2uJQoYaWVgwVei58BAqab4a95dgCiH0K19
        NXrXxRDG2adxICCQnZIyKtXOcLKLAS4=
X-Google-Smtp-Source: ABdhPJxLDvU7Djm4TFrUIUY+MQlg7VLOHSHlDHWbTnFEEPoSnOvlvr6O+b2NZN9/45LNrA9RXzCexA==
X-Received: by 2002:a37:aad2:: with SMTP id t201mr16635886qke.61.1604983614530;
        Mon, 09 Nov 2020 20:46:54 -0800 (PST)
Received: from [172.17.0.2] ([20.190.218.178])
        by smtp.gmail.com with ESMTPSA id e186sm7681622qkd.117.2020.11.09.20.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 20:46:54 -0800 (PST)
Message-ID: <5faa1b3e.1c69fb81.a4daf.0c5b@mx.google.com>
Date:   Mon, 09 Nov 2020 20:46:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1066988491033698832=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: Fix memory leak and NULL pointer dereference
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201110042127.71045-1-inga.stotland@intel.com>
References: <20201110042127.71045-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1066988491033698832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=380861

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


--===============1066988491033698832==--
