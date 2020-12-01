Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BD0C64E7A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 22:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F144221E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 22:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgLAW5l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgLAW5k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 17:57:40 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA36EC0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 14:57:00 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id b144so3048214qkc.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 14:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=10aTagabD/p2xc9nmRbuiuoBnaGf+waUQ1mUYg5ihXE=;
        b=tMoO61ySM0DK7wreUcuwzdPHVGNL70I08WR/LV6OjFHerF0ygaZ61KPlSWSxNETiAJ
         oJfUNoMWLTc4U6LUUzcUW+fz0p+dbp5jY/S9ggTcqL4ZSe37Df6VeNtTR6AW9t7TYAxx
         sPU3oXfNyVxnwgW0SufcjLKLxnyGFscIsja8Kr2+xWNJHmjDNMq7WF4sx80tPizfWHtv
         FrsZGg6vqnrU4GF5KtN/0bpGiazviA27nRqfFePBdJiDXGHiEwppq8WZJR6EDondBpNU
         W5VSKVkfDD8ljtLNoDukxkh92VQ+slQ43/n2mogOMiYP/g8bC5iz1sK8AybIatd2t8xz
         ClSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=10aTagabD/p2xc9nmRbuiuoBnaGf+waUQ1mUYg5ihXE=;
        b=LctrhIiKoqpK4B5vqHDnu6FFiC09Nrhxdp47yyC3LCs24QjaA4SACw0xNJBVehLdZj
         pv+pQr8hwG+570xSiYOXg4z/wcCuoHkGRyjj5LmmjAQRNAapX9Crwwr+tJA2kegfEieT
         ByuRgOWa14GZiSCVdOyDPu/myBZl1E+AhvCCeRPnj5JGWxCdmsC3VE4I7odZuTsiEXRI
         JoKmPGrOHuVMQCEHvY6x21+GE1XSfbL0ieQiQvmqdhh5eP9pJHZ64rpXEOTcUBi4wIHL
         0CU3q7I0d+NF/PEWHkXNn1/snZyUkV4RV+NDKN4ON7WQcaNnuZxccvuauHZ/Lz+roNaU
         rCZQ==
X-Gm-Message-State: AOAM533KMi95n/7lfJq46wUCv1kU7m1fuivOB3+c66w0DfciA9Wl5a7R
        Mn2/fBpISap4jj2yBh4s8oHoljQadtHXEQ==
X-Google-Smtp-Source: ABdhPJy93IN/Zv6NwegmqUsVO8co32Q7S43oMuUO67YzRp4t3HbvIVJFpOXJyRO/ERc7XjDC83nOMw==
X-Received: by 2002:a37:6107:: with SMTP id v7mr5400828qkb.145.1606863419872;
        Tue, 01 Dec 2020 14:56:59 -0800 (PST)
Received: from [172.17.0.2] ([52.177.176.59])
        by smtp.gmail.com with ESMTPSA id k32sm1208884qte.59.2020.12.01.14.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 14:56:59 -0800 (PST)
Message-ID: <5fc6ca3b.1c69fb81.2d1b.61f6@mx.google.com>
Date:   Tue, 01 Dec 2020 14:56:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0997348503981158359=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] doc: Update battery API doc
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201201194021.341363-1-sonnysasaka@chromium.org>
References: <20201201194021.341363-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0997348503981158359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=394187

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
doc: Update battery API doc
3: B6 Body message is missing


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============0997348503981158359==--
