Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3DFC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 03:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B37603E7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 03:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhG1DyE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 23:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhG1DyC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 23:54:02 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B7DC061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 20:54:00 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id d73so1624488ybc.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 20:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yLswpzYHDCXz+EWPkvScaUE1+rNjEhECzCfivl2Ptw=;
        b=jZzzMbaGj5YInVGOZapxXeJbad7wPnUbNBkqCLSySoD+ZCcAILsFniM77vTa+5i7hH
         mgKzwfMAgsL8Mr4W733q9uPr/2NrIldKZMW9dNEqrvbe44/GxbWO8auURfhn6MBftPzD
         0ZHM6DT8psSry7n9198DLKnqoxcy3xBVkGF3b7AigugMB+IwASrv3saKZSb81thvIXFV
         1hAZfGxh+ZetxdA9LlIiLrgEGK7DukSo4lwXB4KHY5j6W1Drh5/S5PYeLFu9C5DYN/vP
         xI3ObB5DfhZ1833jemNHMmslks0VwLcNuB3A4uMukGR3F5MHGbnIooShM+HJAmcTJ2R+
         9uJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yLswpzYHDCXz+EWPkvScaUE1+rNjEhECzCfivl2Ptw=;
        b=qgknxtnf1Wa5+rjByJWMz+it8XqXLznIkJ0WbgvcNTBcsbOa7oouwgXf7Nw12rO6eQ
         owIwZPPzPEiwVSktnRHA4ZD8SMgCLPO8w9HxeS4xOOeJCeg1FFLyg4jC3rUdhb+cOmrn
         xvaXd8iD980a9SxDVBQX6vkASA7qgDKlcB6wkcW6xAmZREtt1x8LHInldvRVtYaWzu3P
         qey4rKh0qJsV9EozFWch8LwHIxDQUex6cBRzV3W8zRutTVDUOdIMFu2mW5XUUXG9Yr80
         3zHHROFh8lD7Ih59aPm6dX+cVrlctrD3/NFNZ+KTqUQINBOYz7ZWwxBCsADelycEtbGQ
         KHQQ==
X-Gm-Message-State: AOAM531KUxbegiXGi1iXmT6klePgtgJHJIYV38IN1Dcbzcb1uRWATDuJ
        8LZsajrhThF65S26HAsK9WPUZ+FmRIKnYKCro+I=
X-Google-Smtp-Source: ABdhPJwsWmVLK+ROnPkRuGKBAPEH/BM1FhsiDDIntNwWifILuMTFPz8PdNobW3P8YvVNb3ntHCHItQPbEiz0bWyTgEo=
X-Received: by 2002:a25:be02:: with SMTP id h2mr36492093ybk.91.1627444439837;
 Tue, 27 Jul 2021 20:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210727195057.Bluez.v1.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
 <CABBYNZJkvaeuMJLKXueoLKq7hXBskxYSPbGujHEj72=qfF4+DQ@mail.gmail.com>
 <CAPHZWUeCGeu+gpYkfhMUKxXGMPZY0ZeKTpHDO-QcCvhwarR0dw@mail.gmail.com> <CAPHZWUc0wHLVTSFGzEYWjE-3f4JyKyXtYem+wBm11K3kxn3pQw@mail.gmail.com>
In-Reply-To: <CAPHZWUc0wHLVTSFGzEYWjE-3f4JyKyXtYem+wBm11K3kxn3pQw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Jul 2021 20:53:49 -0700
Message-ID: <CABBYNZKme8gTytB6=CBqv636t5hFy637DhaqipCRDRCei+t_Ag@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] gatt-db: fix service in range check
To:     Yun-hao Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Tue, Jul 27, 2021 at 7:51 PM Yun-hao Chung <howardchung@google.com> wrote:
>
> > > >                 if (svc_start < foreach_data->start ||
> > > >                                       svc_start > foreach_data->end)
> > > >                         return;
> After discussing with Archie, if we understand you correctly, we think
> this early return can be removed.
> Let's say the searched range is 5-9 and the service is 1-14, then we
> should consider the service is in range.
> If we want to keep the early return, svc_start > foreach_data->end is
> already checked a few lines before, so this check is redundant.

Yep, that seems we have already had the same check so Im fine dropping
the check.

-- 
Luiz Augusto von Dentz
