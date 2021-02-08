Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3A6C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 19:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A2264E85
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 19:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhBHTnn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbhBHTmh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Feb 2021 14:42:37 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FE3C06178C
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Feb 2021 11:41:57 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id q4so5654539otm.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Feb 2021 11:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hm+9E42ZBsQz6FaBfVdKxvdOxpq3+IraW6cFnDC09NA=;
        b=jNJhsCa6Iws1eJjCfRwKbqAfoPMkx29gTWrEf1i84kx6j0EtouZZcUQ2FLpVKaCsKs
         BlgElZelSAvXGOLVLZhQy0iimZ4BY7DBqYtfzWUPEIaSQ1aZYdGzKGgcB3pKH/3a9cq+
         moWXxWQ5zZWop8C7Qbmh0150oPeMYgmrtYlsLigxIyJjLHHpFKwzgi76eEp10EiEAxOu
         8gLHtJUCewTme/JS0q52sQbOSBmA9JhhKAxPDWKjuDePstJh/G5iRiv1FGb54+766bAz
         eOzcQD1YQ/1z3uib2vmmXrj/7nH3/cldDsEnixgGd7zD/jvWp4H4jqbBPZAA7Ne0x25Z
         etFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hm+9E42ZBsQz6FaBfVdKxvdOxpq3+IraW6cFnDC09NA=;
        b=eUjjaYCYCf/uTy0VCo4VgsBMoT4bUACC3qRbdemqoeHjyklzqH/SkTjI6jMIEbubBJ
         K8ge9VGToi3pJoatCdcFQrBCVKeg4N2Ra2gAWO69XGOyM2ujNIyfe2PbXYZ5yfJvzOpu
         feYl8J67kdvtPxxJ+qwaqJu4r6YP+m4zVj87RUSuTDX4aU9QrYucCwqsEUoW5IqJ+yP4
         G5rIGzh06yQXGouufhdvXXgmgPxMegfRusVsqVfrQCuoA67nwLvMUad6orKgBBvHw8n3
         4s4j8m12O8DFBRxmPOhLTxCoGhbmvY0WiGaAg1OnrLKn0LyHfe6SjWzBnHszo40ydzOg
         zfDA==
X-Gm-Message-State: AOAM531HBXy5gFqSep7369PTtAppCp840gQev10I/gxvHAGc81y93Ez7
        Jg+PaqI8wBI5M/m8EjfE62gHTLRdEztoooDMb2E=
X-Google-Smtp-Source: ABdhPJw7ujFc1A3Vat1kvehxqa/VSVlfb8wTB3krINQBwTGfb3cEZDxNCRhmN2WstSND5UiR88cZHFNF0Z7asCG1sgc=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr4365495ota.44.1612813316441;
 Mon, 08 Feb 2021 11:41:56 -0800 (PST)
MIME-Version: 1.0
References: <CAFFpJBVNqKQyzKLxKd4=4fU6fwQtPvpoPhgnr3+a_KEp0Sb9mQ@mail.gmail.com>
In-Reply-To: <CAFFpJBVNqKQyzKLxKd4=4fU6fwQtPvpoPhgnr3+a_KEp0Sb9mQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Feb 2021 11:41:45 -0800
Message-ID: <CABBYNZJxSQM-Wt_qOnvxBAbEoPK6fGYVn55oKh3EAjQMJgf=LA@mail.gmail.com>
Subject: Re: How to check Bluez SPP profile version?
To:     Zohan Lin <zohanlin2@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zohan,

On Sun, Feb 7, 2021 at 7:47 PM Zohan Lin <zohanlin2@gmail.com> wrote:
>
> Hello guys,
>
> In the website https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/supported-features.txt?h=5.50
> It says BlueZ supports SPP v1.2.

This one should be updated as it comes directly from the source tree.

> In the other website http://www.bluez.org/profiles/
> It says BlueZ provides SPP v1.1 profile.
>
> Could somebody tell me how to check the right SPP version?



-- 
Luiz Augusto von Dentz
