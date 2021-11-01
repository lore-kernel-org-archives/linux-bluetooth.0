Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2CCC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 06:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137CC6108D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 06:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhKAGKI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 02:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhKAGKB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 02:10:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A332C079780
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Oct 2021 23:06:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t24-20020a252d18000000b005c225ae9e16so6681078ybt.15
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Oct 2021 23:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3WCSek+fSEuef/uAOlirtzAUfYn/NYrk6+zSO/47qkE=;
        b=OoG9kmaMhdvHBx91i8jiyLz+pmrxktc88yu0taQm2sgIB8lT1dmPAQOVWiwqk487kq
         K3KvzsPHbS3YjjcSPrWmqyeFg0YXK5p1F5VOrambLeL8dwIEnZtWAJUZEMGxDCYuUdr5
         t5tLHxi0OXhE3eQivkl7NKhGxlREJ7V0AWBrpPInpfLhHrqIJ7MbS3+cZdFeqURq/ofS
         ObxruVTbpcmtYRWB4opsaOShSd7eAiIu7F8aBcTTP7k36LN2QxSwN9v2kGcExbDnHH5u
         /WkKCDW4Lx8Wg+DJlvnZVaqd5fUxqZwWegNQQqSEJrqpY/pgf/8zXEhLVgMfPBtboWgO
         a0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3WCSek+fSEuef/uAOlirtzAUfYn/NYrk6+zSO/47qkE=;
        b=IzkU2UjMMC28U+0E2sFjzzHL7YXj7MSKO1ba6XvkDrz11iKpHa5ekoNdC5MvRHEFj1
         BdpP/91MN85wLQ90Jayw8/AZThFvqwAZcOsztBLb/iB6eJd7uEcHtBLPZfj9trMlUVdv
         n4ZmbjK62otMcoviDUNe9Z2ZHvP7SCJLVyNhKExs6Piv4SXqcHhKZ+q+o+qXJ/0p3U8n
         A3gafR2d/Kg489rwwzIHNKMT+s1aspbZMPrugbaxWy8CnHRtRYknibBAGTNeWhtpNfy9
         xHJGWBCnIvFi4Embt3KS46nAfeJGRVKa8joL6Th2jb1CMT7L9SXfHlqmvupELlyDe7xn
         73hg==
X-Gm-Message-State: AOAM531pkL6bFhb54flpWu6ppEI7HWL/i4tACoDRK9gjaFj2m9Nw+0Qo
        KDF7nmbvdO7KmpW8PAThTvtXE6ACQ9bHHPZ3lJjsXgcRRO0h4wkeZGWO2INZJzKq12l0+OuRKdE
        +qhAxrU2b2Dl/WKNA7zskPKSaC86ivOOUqNfLQ3B/TwGVNbfm0AzdQp+2m2/osXLjJBJCC9HQu1
        QN
X-Google-Smtp-Source: ABdhPJw+ihWwEiFZGremkPLCEWzHOJ9qjSuOcu+kjNeaHdpSd8Jv2HpaZeyGxuJ/OpMX9sBlyu1rzu0o+jln
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:93ab:332e:48e3:1733])
 (user=apusaka job=sendgmr) by 2002:a25:c344:: with SMTP id
 t65mr27729922ybf.340.1635746802640; Sun, 31 Oct 2021 23:06:42 -0700 (PDT)
Date:   Mon,  1 Nov 2021 14:06:25 +0800
In-Reply-To: <20211101140544.Bluez.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
Message-Id: <20211101140544.Bluez.2.I1e75e215e52ece8017840d4df309c4ba4ac84510@changeid>
Mime-Version: 1.0
References: <20211101140544.Bluez.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [Bluez PATCH 2/3] doc: Add PeripheralLongTermKey for storing LTK
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Update doc to reflect update in adapter.c.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 doc/settings-storage.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 1d96cd66d9..3c637c3521 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -314,9 +314,9 @@ Long term key) related to a remote device.
   Rand			Integer		Randomizer
 
 
-[SlaveLongTermKey] group contains:
+[PeripheralLongTermKey] group contains:
 
-  Same as the [LongTermKey] group, except for slave keys.
+  Same as the [LongTermKey] group, except for peripheral keys.
 
 
 [ConnectionParameters] group contains:
-- 
2.33.1.1089.g2158813163f-goog

