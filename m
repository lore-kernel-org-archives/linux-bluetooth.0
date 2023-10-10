Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581DACD80BD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 12:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjJJMWd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjJJMWc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 08:22:32 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9239299
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 05:22:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so4144549b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 05:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696940550; x=1697545350; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jVT8YyyitU0JajiF+T85jc+wIiOq7LOmj1uHdryqfAg=;
        b=jJRZIIVbahluSgk/fuJkLVe2oA8QEMu/UE9JIOVzgsBNf1jkllH+OyN3rw4WtX8I6l
         7BXthGn+/UYvHY0mGsuVXYCbSTaF/QYBDK5R11vwfYSjo04OlbJzQSRM15f2XJaDxcJr
         nbMY30+i3wiouQdmPtlKkr4HvpzQyB2lF7z/Jcf684QiKf/LLCkSKemJB+EmaTCoWpzf
         MgXekrJjlDb/hjvCAl2DH55CVq6vHBYnHU/FAP2YVvgavL/K74iEwOWHmRWBdKEkIscz
         k5TPLD7V2oRTjTThZ+kbF0mjgoqHQBAAp7/8v3DPx3nYGPov5aVY3h4vjfy/JRKxpeRa
         JsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696940550; x=1697545350;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVT8YyyitU0JajiF+T85jc+wIiOq7LOmj1uHdryqfAg=;
        b=QBG9f+rFwEamdIde0MSnUC8ea4XK9CdYriSWfYBmNJNRpDeiYOG6M6NzlEznuHxqfV
         OKwyqX4MRrol7TBO0ebdi5pW2scEQz1OAzO9OGme25GQdJIJwEOVtRC+3f5TSRZvGtDD
         XION0SpeUID+sRecpKn1hr0a9PuBjs6E2c8eKFXl9yFUjHfXDMumoNLgcCAZdAc4ZlQK
         Tgx1qPtt5fGE9LgMFfzF8v554Iv/gC7SWhyC3OZ/IRGjD9a07ZNU0o88J+tam+enwCeG
         DQVBlH29EGnO0U086oNxsmTxY5eIFHFEADdF8l7FGaQlAbuREPC/lEXgoFBE2lo7KIXW
         dThQ==
X-Gm-Message-State: AOJu0YylfYpUoC99p5m202OYiuZiWEiQIPgL7AlhregYWXMYKzO9avSu
        soV5RI+qFN8LeeIZmYdJmEur9Uz+pFI=
X-Google-Smtp-Source: AGHT+IH/B12HYZzHPlyonTBCyZMOlKSx1qYV8Zmkz1gdwVhrP3Hs1Q6IHtlZ1mS8fzbmVIyNWjAscg==
X-Received: by 2002:a05:6a00:2e84:b0:690:3a0f:4164 with SMTP id fd4-20020a056a002e8400b006903a0f4164mr19492654pfb.19.1696940549773;
        Tue, 10 Oct 2023 05:22:29 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.61.37])
        by smtp.gmail.com with ESMTPSA id b12-20020a63930c000000b0059d34fb9ccasm575611pge.2.2023.10.10.05.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:22:29 -0700 (PDT)
Message-ID: <65254205.630a0220.6a484.0dc3@mx.google.com>
Date:   Tue, 10 Oct 2023 05:22:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7133387784075030955=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: VOCS Unit Test case implementation
In-Reply-To: <20231010110549.14302-2-mahesh.talewad@nxp.com>
References: <20231010110549.14302-2-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7133387784075030955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=791738

---Test result---

Test Summary:
CheckPatch                    PASS      2.29 seconds
GitLint                       FAIL      0.65 seconds
BuildEll                      PASS      33.38 seconds
BluezMake                     PASS      978.90 seconds
MakeCheck                     PASS      13.52 seconds
MakeDistcheck                 PASS      198.53 seconds
CheckValgrind                 PASS      318.53 seconds
CheckSmatch                   PASS      419.86 seconds
bluezmakeextell               PASS      135.59 seconds
IncrementalBuild              PASS      828.10 seconds
ScanBuild                     PASS      1269.57 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/1] unit/test-vcp.c: VOCS unit test case implementation

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B3 Line contains hard tab characters (\t): "	VOCS.TS.p1.pdf"


---
Regards,
Linux Bluetooth


--===============7133387784075030955==--
