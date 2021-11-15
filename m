Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1445C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB43961BE6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhKOKAB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 05:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbhKOJ76 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 04:59:58 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E15C061746
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:57:00 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id b17so10911650qvl.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=99EidxN3jE4n+d+jqtJuZ2mA3KIpdVvenFr2dK8Hrdw=;
        b=UovhdNaSuQyqLAOEvEUJnmcxXOpVKS+Sbs/i/XXUnTuj/JudLirxdyXZGN+cJ19aZv
         QHlRKQss9dwaPVeBOcYyva9aTFfMLG5x8hVckQYsiRDOvsQ3ZpcDo6otxdOLaPuKFaM3
         pqj72NEbJ1ex7Xn8hYOl3zEE01cyTu2UlAxWCxcnRm/glY8ITtVLU6VROaod/U13rDCm
         sJNKY5rKgTTok442H7xpKr2+skLz4nukcGoZBRWv18kOnlKj0MFvhQ1oqZPijZGf4jMc
         50wTkyQ4XOkf4MBr/sIH4b51L+s+xxhbNvjP6S/Id5CV/IahRiszQExV0lYuOYK6dAeG
         rk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=99EidxN3jE4n+d+jqtJuZ2mA3KIpdVvenFr2dK8Hrdw=;
        b=GO9jTMk7CSrPeNCiVTp7w3kV5vlYA9+Hz4SAQXFgDtty8e9pjF0bIVXzzB6oujAO3L
         cMSFj1H7DbTXxBVGAITn4YlxggFkDbC9S6kRflI8/vEI5eMEmGhr5CGonkyyLrChpJIo
         asW8MAIwNW1mEK8qeyh3aYh3YPB+UfjuJA9hHbPlEDkBg4/9OFTV4N0Q/Xw8dvrDuTuY
         m1Eob07JBq4NiFBX/AjcKdlKCpXrA9130tyu2N5JyoccX8DUEKtaf6XPBVmuipA+0s76
         o+RYCm+tTqaB6648Y9Ljm5HU4oFfTQ34oSVYh7j1ZisX6natc5q79a0vQkW+ryCpIDHq
         YaOg==
X-Gm-Message-State: AOAM532t4QEIMGW1gAsOSfm19JZVuoswBSRlDbQ2A+hDVNh6QNW4LLG4
        MyAdvy2wn1WQ3J5E9UvVWaEfKcC/qKwQfg==
X-Google-Smtp-Source: ABdhPJxQWIyq/m6bbqVTHZw61y4ZFX6oyGJAIFqrWiumuVmdQtQ6yYmqMOY/gKNBEt+Ersu7bshVNw==
X-Received: by 2002:a05:6214:d0e:: with SMTP id 14mr35623269qvh.26.1636970219997;
        Mon, 15 Nov 2021 01:56:59 -0800 (PST)
Received: from [172.17.0.2] ([20.122.100.225])
        by smtp.gmail.com with ESMTPSA id r4sm7011047qtu.21.2021.11.15.01.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 01:56:59 -0800 (PST)
Message-ID: <61922eeb.1c69fb81.ed0e7.85a3@mx.google.com>
Date:   Mon, 15 Nov 2021 01:56:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3522758955419197361=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v3,1/3] Listen and process remote name resolving failure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211115172714.Bluez.v3.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
References: <20211115172714.Bluez.v3.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3522758955419197361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=580017

---Test result---

Test Summary:
CheckPatch                    PASS      4.30 seconds
GitLint                       FAIL      2.78 seconds
Prep - Setup ELL              PASS      42.35 seconds
Build - Prep                  PASS      0.46 seconds
Build - Configure             PASS      7.87 seconds
Build - Make                  PASS      179.42 seconds
Make Check                    PASS      9.71 seconds
Make Distcheck                PASS      220.26 seconds
Build w/ext ELL - Configure   PASS      8.00 seconds
Build w/ext ELL - Make        PASS      170.25 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[Bluez,v3,1/3] Listen and process remote name resolving failure
12: B1 Line exceeds max length (121>80): "https://patchwork.kernel.org/project/bluetooth/patch/20211028191805.1.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid/"




---
Regards,
Linux Bluetooth


--===============3522758955419197361==--
