Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED322C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF06A60C4A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 20:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhJYUW7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbhJYUWx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 16:22:53 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40535C110F19
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 12:56:30 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w2so11433100qtn.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wtLf+a+gjsTq7JFoteR95k+b0pQrmPhGsVs8UVzqfxQ=;
        b=qXMW2VnPCkmtVToyocGIFSgHq5AtI9F/UN3lNsNX5cn67OSQYvVjweZ1frAOZfX3Sg
         7wOKqQhvU0oNcbyCxMq/aMHcZuhxk2usOcG/o5oDKhQbWiWEajJ4OOYFVAGlY3qt6grt
         gO3xLyyZOkeUORbo1pxju4bq89GEOD+GL81I/kOy8sGtqAVrCtc8mtHmcpf2GfBKr/8j
         JOjvu7lWVKk/fd/WWz7fnI/K5n6NH6n7fnvtXDDlYrhMgJUVYF6e5QhEp0vuxGS1/Nwh
         STLRL7RwQQKB8F8YhUPpGbOOtZKHx6gLOWefII1Pa/YHPPk8Dpa2LT8LCB3mfBTk0nN4
         6zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wtLf+a+gjsTq7JFoteR95k+b0pQrmPhGsVs8UVzqfxQ=;
        b=Y5tRAhuOISQCBD6T+frMPpkUqXCTCiwhT34wj5MXIy5iR7RWL0L7MC62554iDx55WT
         QPrH0KUWrPNJ9jRrXB2HqYDN0fmuF76cfOGIyZg3bu/xn7nmH1I9yNTl6oFjKl0iI45d
         ZMfnWQW6reiNrkTmghBAXwDbsgUs7BEYFfRcFmszGunAWEVGZzuFslxoZnQuUjrx80dW
         xX4MBp4idF093xGDJLjUy6Uo6FGyRk/zNOLAryY96gC8MnmlfJceQWSrHlAEsDEQFQet
         dNvst9/bNDzOiAU79bGPrFPA1rS3fDIG4c6RKinvBq/8v7FkSqMyu7uLbqamoAz8tnf+
         jlig==
X-Gm-Message-State: AOAM530RcwcU/Jyj/CKZ/pEh+Bfr33EofyyTHEn6AM8nZ8saMgJERuLo
        RyGVgOoNlP/cUDgXNZOwjV18L/Z4xseeXA==
X-Google-Smtp-Source: ABdhPJzZU5bbNFnhlTdwKzo5fGLhlo1/4Uq8Grzcnyqp1aOkAN9R6UAfFtkHHV/2obVHpHFAGWHYag==
X-Received: by 2002:ac8:7d83:: with SMTP id c3mr20528978qtd.383.1635191789342;
        Mon, 25 Oct 2021 12:56:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.182.200])
        by smtp.gmail.com with ESMTPSA id f42sm9833472qtb.7.2021.10.25.12.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 12:56:29 -0700 (PDT)
Message-ID: <61770bed.1c69fb81.de7a4.f25b@mx.google.com>
Date:   Mon, 25 Oct 2021 12:56:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3157757155192592699=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: Add Advertisement Monitor Device Found/Lost events
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211025121343.BlueZ.v4.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
References: <20211025121343.BlueZ.v4.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3157757155192592699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=569881

---Test result---

Test Summary:
CheckPatch                    PASS      4.39 seconds
GitLint                       PASS      2.90 seconds
Prep - Setup ELL              PASS      52.11 seconds
Build - Prep                  PASS      0.54 seconds
Build - Configure             PASS      9.39 seconds
Build - Make                  PASS      225.67 seconds
Make Check                    PASS      9.84 seconds
Make Distcheck                PASS      266.48 seconds
Build w/ext ELL - Configure   PASS      9.65 seconds
Build w/ext ELL - Make        PASS      214.45 seconds



---
Regards,
Linux Bluetooth


--===============3157757155192592699==--
