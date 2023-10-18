Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD273CDB482
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 16:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjJRQM4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 12:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjJRQMz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 12:12:55 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1EB94
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 09:12:53 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d134a019cso44416816d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697645572; x=1698250372; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jiA0HRYuVClQfQj8FyxURFHWHfq1nA6pb+GPhamUHCI=;
        b=T/sr03HzlNRohf/pLrmJ6gZkM1ccO4jrxhjktIK4XwWKSmczZ5J9+16PvrBSzz2y8G
         kHDx42wMmLtuI251ECsILoKUtEpWn5wX+R5atDSTJhrV/QbsuMc/CnLDwQJJyIFqhNVT
         TZwZ/tVROYK+Y3DI0gE9r+KLU+E7e1hRm52L1sBDhVmr3aahyiN9WYahHV1wQfTILlZl
         aU4taeKtdXloHX/xmu4qlvifeLN0yFwQdycTH2tcVEFKYKinpfan2v/5vjwET0fkjdJi
         YEWC993BuTGHLGe0rwbzw9d4nODIXU6N5xITtJ/HjfYLI2DhNHuUqlX9W1yfSq73y+9w
         uG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697645572; x=1698250372;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiA0HRYuVClQfQj8FyxURFHWHfq1nA6pb+GPhamUHCI=;
        b=OyD6dNBxUB/DxB5H0GSIFYjX4NCGSAbjnesXhyrocgQn4FhravG0zoykd8dyNHWy4S
         JhbBeIvU+PbAkC+YKcfit4yR0u3XV8QcxtmAN71A/OKts8wkZH+KNTX88ll0E7maCsmg
         i7vK2hyrkjgLYcfrLHBHHOsQckj9JccmHnddGQhvmx2R1EGDlSUni8bd+tIQKIY8UfrM
         LgGFvEdqDfPuo/eXJ7dQt8OwzdigUuyYRH5q/H/OTt4jRswnYSZXSFN6xZ2YU5hHpDEO
         S6yXnlDSFfPl4qwwMT0FvkrelZnT4JvLr/yApJkjl59S79w/3RT3SV7C0+4B89w9a7Gu
         eo4A==
X-Gm-Message-State: AOJu0YwEuG93hU/MG7RiIBSc1i7wqYJFz8CeI3qHX+HOICJq1l8ieIDO
        B0QwzjQYm/B/hyD2+Sm0l1jUGqjwHT8=
X-Google-Smtp-Source: AGHT+IF/oDEQN/7xZKJqnZOuNoT/u4fdjqDbM5nro6ImKaVVCH+ewanBLojHcZZgpYrPbTlGHZj8MQ==
X-Received: by 2002:a0c:f38a:0:b0:66d:b73:d6f4 with SMTP id i10-20020a0cf38a000000b0066d0b73d6f4mr4800008qvk.51.1697645572378;
        Wed, 18 Oct 2023 09:12:52 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.123.255])
        by smtp.gmail.com with ESMTPSA id po10-20020a05620a384a00b00767d6ec578csm67176qkn.20.2023.10.18.09.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 09:12:51 -0700 (PDT)
Message-ID: <65300403.050a0220.caae7.09f2@mx.google.com>
Date:   Wed, 18 Oct 2023 09:12:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8762297292429676202=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: btio: Allow binding a bcast listener before accept
In-Reply-To: <20231018143912.12284-2-iulia.tanasescu@nxp.com>
References: <20231018143912.12284-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8762297292429676202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794363

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      27.53 seconds
BluezMake                     PASS      789.64 seconds
MakeCheck                     PASS      11.80 seconds
MakeDistcheck                 PASS      173.62 seconds
CheckValgrind                 PASS      267.62 seconds
CheckSmatch                   PASS      357.61 seconds
bluezmakeextell               PASS      115.04 seconds
IncrementalBuild              PASS      684.20 seconds
ScanBuild                     WARNING   1047.51 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
btio/btio.c:1851:4: warning: Potential leak of memory pointed to by 'addr'
                        ERROR_FAILED(err, "bind", errno);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
btio/btio.c:41:3: note: expanded from macro 'ERROR_FAILED'
                g_set_error(gerr, BT_IO_ERROR, err, \
                ^~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============8762297292429676202==--
