Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003D9C2BB40
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Dec 2020 10:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F8722D2C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Dec 2020 10:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgLFKxA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Dec 2020 05:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgLFKxA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Dec 2020 05:53:00 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3908CC0613D1
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Dec 2020 02:52:20 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a16so15259402ejj.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Dec 2020 02:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tX4ce9kCnKul0pbnQ/7dkpkYwkrZzrKSsi/R5LEeq0Q=;
        b=p7nWi4llvTVCQgIHy9ka7WGxwo6z4cyG6zUWi5E7+K/akmcWpFNne7PByhRxcWrdwW
         8nc/PcuBgDysGpX8cIUHt43ehEgdwumgU3oIzK0dbdWE7GKDMJSagQaSd9qzgAVuwVF6
         BIbudS3OLO3qofDXNxYez4xCNYHZnCOMdf9ubjGtycYIapdOwSYi8CbPP75TQwZ6tq41
         eKddg2U4Lg8Rjsjx64Js7+iXfq6ALc0THN39dpGEm0eywGJPr83WrP6SdDUvngzZ3A7Y
         a8k6totYvX/Wlb59tVmYMCg4vjk/Muehsy4vuwz5MncmDgVVsgfRLxX75nxDp/TAnxDj
         IYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tX4ce9kCnKul0pbnQ/7dkpkYwkrZzrKSsi/R5LEeq0Q=;
        b=VNc00xA1x1IOB8pCwa3igi6kmVfRTr0Z/PSPZUMs3KfZmkC/CMjaGy5iA32u5vz6FW
         uFy4PkMgDIYMvgPGGGYtUjf1gaB4jN9ED+6DrYEzIDYuWR5BKG5zqmNekfCD+IE97p36
         MD7aY/tkcKtheIMb2PwAZblhsdHZtZ2kG8BUAvI/LAMtNtPSyOPIcLtHpjF1GMjQpdMB
         YWxckinC7kSxILangftwphP8fFCfTHz+ySd0bN9olaJwqWS2I8UKO56WfuxA+HMYyJRJ
         P+KvKDyxWYLhcRbmkqVW2yeaxQSmFb+RXdX5t+MTPBKQrMA3mukLjazg803kgH7iCBQg
         1fPg==
X-Gm-Message-State: AOAM531f5belC/LeOw+rw7bTW5dZNzARnjYY7OmdkSdyg0cSwQ+PPgpI
        3mREosPcbAQ+FfIdBATHxuEAwH6/Oym358Kuo6Vt6sTSTLjDEmu1
X-Google-Smtp-Source: ABdhPJwht51M/8EKY6yV1/gYwk0JpdduBaMWVrxxYEkCYAvrX1vCKuKkjjK/Pec26bu7ejupf2v8MeIjcqcpiFvU6Oc=
X-Received: by 2002:a17:906:b0c5:: with SMTP id bk5mr14572307ejb.217.1607251938927;
 Sun, 06 Dec 2020 02:52:18 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?15nXqdeo15DXnCDXpNeT15nXk9eU?= <isfedida@gmail.com>
Date:   Sun, 6 Dec 2020 12:52:06 +0200
Message-ID: <CAAheq97o1T5OQRPyvt97PVYh2g2doJ6K7qv2zTao-bhti=KLEA@mail.gmail.com>
Subject: Bluetooth physical/radio layer information
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello.
I'm a student at Ben Gurion University.
In my project I want to access the low level bluetooth stack, the
physical layer, for example FFT information.
I would like to ask how can I do it with BlueZ or if you can refer me
to other relevant open source projects.
