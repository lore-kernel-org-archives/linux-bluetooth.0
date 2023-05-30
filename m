Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DC6C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 13:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjE3Nhn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 09:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjE3Nhm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 09:37:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D264C5
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 06:37:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d2a87b9daso3271176b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685453858; x=1688045858;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rVfqKN0/p/zaB0mAPKF2NcvXb6m7yV3OurJk3A2pkBQ=;
        b=ey/KKkboYLjQclWrLoF7Dr8rcPDW7AdVwoBwAAH3KV7exvSnncNXrWEDuJfBJZS1wS
         w6suab20UQnmE8FBXyDUyCTN41JGNyzcbzCneoHeL7g80Q5C2Kt25CA5f5QSC3IQuACb
         J5RFSymOJaFggKndFwvLEaoNDBPeBAzx3i4ivei7BL3Ozg1bWkfPmdmpvMKVyLR5yyRF
         GnMfjKj4A8RrEnrltbGHEZVJa8MTcHT0x8WVWXfsfe6G9rf4dkuiNE7lwdth5JAqSTXc
         62P/DUPgf2H6NQ9NZNVXFpJs62ia0U/qLKaAvon9hoo5kMa00VZGG6JvTMEP1+ssQsql
         XYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685453858; x=1688045858;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVfqKN0/p/zaB0mAPKF2NcvXb6m7yV3OurJk3A2pkBQ=;
        b=TAb8GhYg0WhFLUmoTEd7pelCuuu4z5q+UEOczlqbqU0KwOyeUY0iR6K7z2hgxyJ/N+
         NqEI2ic9cZntR8+F3DOYQDcedxwAxUv0/ozMsxLAw3URLbiADzSNAOAxXqX/tkzw4pVn
         3CWT5DweiYQKrps1RuvJJuY+YYth3py4BKTmPSPCaBrbwJcJ2qKf+Ofs0APsx+0DgKH9
         QMyOHZCp9n0GAYh6jO2E9CUlo5QMliFCvfdPV0xnUf760/wktq0swmiYkMZTWnB+Ug/9
         M/nArd+oApSQLi3kY1ETihWQ8+KatzF9YM6E9TIVcucBLoSDyLfhPRpjUmACNFCFr+4M
         qiFw==
X-Gm-Message-State: AC+VfDyOZozQn+swPTmTGmk21Oq2kxdXWwX9gjYWg7yhOKPkxMxvRYJA
        /G2N6mgH0sM3GKWN24HCpyXOvDweZNY=
X-Google-Smtp-Source: ACHHUZ5aRI3bQjM4+pjqd/GOUBZdbX8qhFWxYbZgTbLQHxfxOObuVISwfzKQmOOftCNZXMRHOIsu4A==
X-Received: by 2002:a05:6a00:1812:b0:64f:31b7:43ef with SMTP id y18-20020a056a00181200b0064f31b743efmr3215415pfa.10.1685453858493;
        Tue, 30 May 2023 06:37:38 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.36.82])
        by smtp.gmail.com with ESMTPSA id x4-20020aa79184000000b00640df8c536csm1727082pfa.12.2023.05.30.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:37:38 -0700 (PDT)
Message-ID: <6475fc22.a70a0220.cbaff.33d4@mx.google.com>
Date:   Tue, 30 May 2023 06:37:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7583483406286622141=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: Hardening against CVE-2023-2002
In-Reply-To: <20230530131740.269890-2-dragos.panait@windriver.com>
References: <20230530131740.269890-2-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7583483406286622141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:968
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7583483406286622141==--
