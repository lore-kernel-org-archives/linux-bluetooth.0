Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC6AC4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 22:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48DE823CD4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 22:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbgLIWBv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 17:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388362AbgLIWBv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 17:01:51 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B953C0613D6
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Dec 2020 14:01:11 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id w79so2918366qkb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Dec 2020 14:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=H21DBpCPIuKW9rfza9WuY/SZnuc1RQaI4XSuVeSWHaM=;
        b=mP3SdsLRskBOCW8fiJaa9BR3spnGYg7PKmWKD8Z+xulS4LLAdSBPxAm4i3Kakpnutm
         E4ldJcL0PfCAcvYgzw7LHGZHuTgmTGcAOgGRKabvyRSeVF49RcVJCEKzpALeJ5GzGzph
         85eSSOgR/h80pDensVcXb6PQ6YZqi56sNb9xlaaICiYrE4OP0OUVTPb6C2+D8/Zpq1fA
         25hKjlc2sEn/y3bApTEJ0J7KKWSDQjvA0P8Kpj0mydCE9DLgfKL+/HnuJUBeZkZf8vSs
         C3o7JNWgSmM7Zu+ewJq+BymwEDYMbepyhq1sxO5+QWHU+BMoQc1OSDylP/+zVHLDmlqI
         UmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=H21DBpCPIuKW9rfza9WuY/SZnuc1RQaI4XSuVeSWHaM=;
        b=K7Qi8E5Hk3QHhfaTp/OVZYQSHQVnYRQhDArX8EYa6utAufoSWSKO0HuotYeVJflddn
         z9IYuBxQV43M3GuwYU+k9Asgo1VRX9Sf20nyMQ1vFx8tg/+Wx8uXKTIKVKb3k3nPejxH
         QrwiN+dcT+YcmeyXC7rYZx5KI/zj+xIG/LJtxs0uf5+tgBEMPorYoX1JbzKxDngnl9IF
         EmmizE8IyKsTZb6RXiAbzRyW6m716lwdam1xq0IhN+WBtOfi4C5/hvARBs/rCuTTmTli
         lMTwh9YsvvyileQvvzN7zM+I1AIQe4NrXtnX06p/XAfCBOO5o+bz35Tni8ZEJ1ITWU7u
         HJnw==
X-Gm-Message-State: AOAM531ZOW3NqRN4VRiGCQ4EapWpzVIh3iJu/Bb2UzvxYs91+foIw2MG
        sSXoUYNG8AKwFFWaXCcEr05onxmaIM2GPg==
X-Google-Smtp-Source: ABdhPJwQ5BFHIWs/uZuqka2fzZdhVORMT1yo80SJRIwK8b/ks0BpddA3Q0U+PrmaHxKEAveRXMTPhA==
X-Received: by 2002:a37:8ec6:: with SMTP id q189mr5505123qkd.123.1607551270200;
        Wed, 09 Dec 2020 14:01:10 -0800 (PST)
Received: from [172.17.0.2] ([13.77.94.226])
        by smtp.gmail.com with ESMTPSA id 187sm2225680qki.38.2020.12.09.14.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 14:01:09 -0800 (PST)
Message-ID: <5fd14925.1c69fb81.ccf99.d23e@mx.google.com>
Date:   Wed, 09 Dec 2020 14:01:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1171133294452574414=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [v2] Bluetooth: Cancel Inquiry before Create Connection
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201209213514.99326-1-sonnysasaka@chromium.org>
References: <20201209213514.99326-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1171133294452574414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=399287

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============1171133294452574414==--
