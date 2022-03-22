Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE112C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 23:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbiCVXqC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 19:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiCVXqB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 19:46:01 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798196435
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 16:44:33 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id i65so9403788qkd.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=cWZgpzb7zc5skNRnRBE/hdg0Ba/hRi4pscC7P+Omb+A=;
        b=Kc1QuDfx8Ul9PML0ysNOnxt2vdLfB7Gggwi/QsaeDyRG5D7AaaSR2zEVY6iKTykOt5
         oJCFFy/CF6BNga22Fb7yivLbKWsw35G9Jsv87SyJ9iRnijlmtHbrFPsJ+TCigNWLjanB
         Z81n8sUdEShoBrCb8OCgjYjT2wUn1bYFD5pHL+duAIetPvoML/kX+kCg8MQG2udmareF
         +u7lGgHcJW4uxLN68eJmRbTti3O35gu4II51DzkD4poywVKY3cc7vwXp5QK29qzUjS2/
         6ggHEmSkGSRPmjXilqXOrjXrKfkjGg79TT5tWAoAtgNaUFZLfX8w9Ine8sV1+j6H5eR/
         It5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=cWZgpzb7zc5skNRnRBE/hdg0Ba/hRi4pscC7P+Omb+A=;
        b=SYLCeTLzwdAA0UOAeH/Kmp+IpALmP+Hs1edKeamDbsNKSeoVUGoyg7efe5QGUvweb+
         ZIrqyl3pO1GnKbzKrKcCJ+qw8FEWhfbcGYIjBw4iAa/SfUgvwrcAgFZMTUelwqrW3Z3N
         0VM5yV771XShefsLQ9AfYYAzXUNcCyDGkwQ7odBb5M5SfeLxSLzOPXqr3AdBhizVx5l/
         MHB4YVyILq51lJgdoG3vqBWztTMRjvMaWn6GqzKbaDf+ivfM+9y/uBzprKzu6o390d3n
         sMd4jcYdSKlvqA2roeKcWG2ebc/ZYkiW+0cEw04UGyCIfmoEOo3ZsCRw0pfyC3QFXnJN
         NYRw==
X-Gm-Message-State: AOAM530GQI6HBxecjVIISulZkfp3PfsjV9YDXM404/S0RTW6kXqGQG+E
        HEwNybG+yQiRkeFM8wDa0Y0yGP+kwXkPng==
X-Google-Smtp-Source: ABdhPJyIDlS/Er7OPkv0H43mR/tM0IRO1pPqPGlvWtVfxFS0jhDfIiAW4g/8Wl+jmRVvgLeU0yKA5w==
X-Received: by 2002:a05:620a:68a:b0:67b:3135:a9aa with SMTP id f10-20020a05620a068a00b0067b3135a9aamr16760908qkh.508.1647992672462;
        Tue, 22 Mar 2022 16:44:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.193.246])
        by smtp.gmail.com with ESMTPSA id f18-20020a05622a105200b002e1eb06ece3sm14730878qte.31.2022.03.22.16.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 16:44:32 -0700 (PDT)
Message-ID: <623a5f60.1c69fb81.99c4f.ef1f@mx.google.com>
Date:   Tue, 22 Mar 2022 16:44:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3510743376806011239=="
MIME-Version: 1.0
Subject: RE: Bluetooth: mt7921s: Fix the incorrect pointer check
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
In-Reply-To: <5d56b2a23e6e793c64ed98890329ce1beb010ce0.1647991506.git.objelf@gmail.com>
References: <5d56b2a23e6e793c64ed98890329ce1beb010ce0.1647991506.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3510743376806011239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: drivers/bluetooth/btmtksdio.c:961
error: drivers/bluetooth/btmtksdio.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3510743376806011239==--
