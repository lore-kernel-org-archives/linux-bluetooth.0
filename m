Return-Path: <SRS0=9nD+=7R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED9CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 16:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9951206DC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 16:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeP0gQ/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgFDQcD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgFDQcC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 12:32:02 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C552DC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 09:32:02 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id m67so5615294oif.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqlUv/b/vad905Aa/Kkly4INORIYqysdENhSBNRH/0g=;
        b=jeP0gQ/AF00r7nbfcvwO2ZGA3Qr+f8ae4ua/Ez/Mo9jU8TXxReh9HZ5xzUeOF1tW8F
         k1s0gGQ9HzghtaKOcOQSoLg4b6Mq/8gT1nalPjNsE8SmL+dq7Av+e1EWNBerd5OO9a6g
         3s0B0HXnZOPHG3tf8cZ03bsZYchLnUTmxY80XiPE2yrOCQUZk/Vura/6rW60lKZ7v/j9
         rMsV6MRhW0ZPDc3LeXQqEsHVBzOs3ykvbYEtMOMW1A7vFeogwHAdeUlLorV5h34IUHcC
         UXOVfagV15Mrwn68FWElBoJVpNRBSUQDDfHpyDnPcfntwToeqdmPqMVq9p7EuKMHeBjU
         zeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqlUv/b/vad905Aa/Kkly4INORIYqysdENhSBNRH/0g=;
        b=A5JXdV/RjF3Mz+8n46etc4/3E2bGEdz7LZG/1hk34vrAvXFh1N8rOw3ArGZ2r5b98J
         NiIhvtv2yDZNow1ML8DYhwqqGAAUEBcdjNd8ZYHDwdG0kFJhZaBBqN/dxtUpHjPjXm6D
         XrfauSrRhgnwjT5/Q1VR2zY2izH4kSD4cSRhMOZ6Qv/5EdMm5rzEpzcErEjrJJ+/uIcv
         WFfTDZE/CfvQo+pATdDDvkf4Xc8fPhJ2lkLZKsvh2S8bcEy7XKpurceGECegsreOlgUR
         0Csjj6LedqVy3ti86HDRmboe2wwgNPViEmITR8OSKaW8jYISXBBiwmmN292W5Wdooa8p
         124Q==
X-Gm-Message-State: AOAM530Dw2Av1g5Ooy5KtuF7uaa5XUgGIc6XeRDrLWg5pTyvm2wH+9D2
        7duosTSZW8SJVNEuqib8fQ6hTFmrTADwtUf8nICIkw==
X-Google-Smtp-Source: ABdhPJzQL6mkLAVebYdCXJYJLPgc77nTfGJhXZmOq4yc2CSo9qGxlEnCfDZY58dOHgQH0Tsh3PZhx9MrIj13ZBIrvqA=
X-Received: by 2002:aca:b5d5:: with SMTP id e204mr3795923oif.108.1591288322082;
 Thu, 04 Jun 2020 09:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <674bf480e2064b2f2a687d14e43db237a1288a57.camel@omprussia.ru>
In-Reply-To: <674bf480e2064b2f2a687d14e43db237a1288a57.camel@omprussia.ru>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Jun 2020 09:31:47 -0700
Message-ID: <CABBYNZK64Nq=Ak_=Ja6fC72vWKz3d-DswQ37fc64u_s3+LTz1A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] gobex: Fix segfault caused by interrupted transfer
To:     Denis Grigorev <d.grigorev@omprussia.ru>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Denis,

Looks like you have sent an empty patch.

On Thu, Jun 4, 2020 at 9:14 AM Denis Grigorev <d.grigorev@omprussia.ru> wrote:
>
>


-- 
Luiz Augusto von Dentz
