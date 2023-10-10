Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB53DCD8CAC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 17:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjJJR3F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 13:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjJJR3E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 13:29:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2576DF0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 10:28:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c735473d1aso40382105ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696958917; x=1697563717; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8/g71ltqaw4u7QMp39vtKMiB3trNVFBvBtFB1bk43RA=;
        b=BKmDA/Pcet4z+b55y49dOJsCJWzo3sb+wDGMONIbkIdIRilDGkIzLRaTg5g0o7qf6Q
         /yqnGmsMBYwA8g7T5y/BpmcBQGJBcLDXtTcxgN+XldX42CiXWWfknZY0DKjIXPFUgrtl
         boH3Ml8ilx9i3zBmWA/cMaazYu2Ae+ZV5ChLZcjBKNbpG0wurBXUZMH5CL/kgQo8t52J
         ycfmQl1U0/cQ3DsoFuYsjT/ZJ6L0UByTFNnlGkmsRaUawjtD7TqhWor8hmQ3sfNWnsIg
         bodqdhq/NmZMUBpLNWmYiaUVNqSuMQmkcU4qVcS38uasjMG5YJF+a8PylayKvRZE0AlG
         UEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696958917; x=1697563717;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/g71ltqaw4u7QMp39vtKMiB3trNVFBvBtFB1bk43RA=;
        b=FBXt10Nn6WIVX2XOiM+IIPR11HSC3LdhRnIN2BJxAZeUEgA5CxoJW82NBNgRiqkai1
         1b4oZQ510OWK9BWL/AzcKLN0X4/XSkOqq6tfwE4ScVHXIzUYFNurCKlDkrb+r2ThYcsO
         xGE39S9RvnM6x778EB6uJWx/J3SoTa1sWL3pONTN23Bm75JSc3pDqbhSx6JCwjc7YjmJ
         MnjSRBxLPYkwskzjW9wTaM5dOZsDvK+IVF70+KChNvLh7svN50NDNSDkuVG7xgHkV/St
         TEPj9QQ2xJ+M9GI/ssdSbnbuVB9SLu37UstODhtvEcc5AIjC8GL0o6lb23ksojItU5XZ
         Sl0w==
X-Gm-Message-State: AOJu0YxGJ7PJjUnKYCzL+9PvlyTDRYeae/7qozzgm7CYiTHDHPBiSUYD
        8s9o8gzlVZw/9cxqiFt6JlqLgPYZNWk=
X-Google-Smtp-Source: AGHT+IGycYe2E4HdgI/F+V/WBfroNdhvPssqFprMt7Ap5LET6KwM96/UYmFTRegMYuixfIL/NC+34w==
X-Received: by 2002:a17:903:41c3:b0:1c7:362f:18d5 with SMTP id u3-20020a17090341c300b001c7362f18d5mr20855978ple.18.1696958917294;
        Tue, 10 Oct 2023 10:28:37 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.4.60])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001c75a07f62esm12078243plb.34.2023.10.10.10.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 10:28:36 -0700 (PDT)
Message-ID: <652589c4.170a0220.ed996.05e3@mx.google.com>
Date:   Tue, 10 Oct 2023 10:28:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5241598440816218261=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: test-bass: Add unit tests for the SPE suite
In-Reply-To: <20231010153855.13825-2-iulia.tanasescu@nxp.com>
References: <20231010153855.13825-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5241598440816218261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=791853

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      32.78 seconds
BluezMake                     PASS      1005.82 seconds
MakeCheck                     PASS      13.36 seconds
MakeDistcheck                 PASS      191.75 seconds
CheckValgrind                 PASS      309.55 seconds
CheckSmatch                   PASS      409.34 seconds
bluezmakeextell               PASS      126.04 seconds
IncrementalBuild              PASS      824.50 seconds
ScanBuild                     PASS      1298.06 seconds



---
Regards,
Linux Bluetooth


--===============5241598440816218261==--
