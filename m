Return-Path: <SRS0=+1pe=TT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDF4C04AB4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 May 2019 16:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72318206BF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 May 2019 16:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx6osoyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfESQ6T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 May 2019 12:58:19 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:46690 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfESQ6T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 May 2019 12:58:19 -0400
Received: by mail-oi1-f169.google.com with SMTP id 203so8336090oid.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 May 2019 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t/Impq8TAZgC4yrRHs5a3/4LCbs73c5N3feMcgCFyVc=;
        b=Jx6osoyTq01891lUthn6rLzGakJVIYQFXGOMF/qBgmRacnvlt03TGdK4IZvptmWDj2
         AYk9LoIcmDgNwHY+nQhz36q4AAH20eOXBCM5YJ7fxkvnY9G8JNPz9UsuK/TDg69KS7LP
         SZwJy9wzpYENy5m6E232zO9SyfDLQ+CVLBwhEiYwO7AiRRn7ifuTy6m1uhdLritHJsWP
         /ixM+BnIY6Ab3Jv1EdHOFHOACr5Xw2bkYlP8C2zJ19LD/xMkf4tUi+dS8WXbs0h0e9mF
         94yT1duDkGF1EylUaMkrrPRhJGjwYOecDxoGRO9FntuxygEes6+JmQvWL9JUWWlpCRjI
         GFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t/Impq8TAZgC4yrRHs5a3/4LCbs73c5N3feMcgCFyVc=;
        b=Lc7QHJnXLPy3IYFio5XTKDf9eUpsco5lKd1EEhbyCDsWRo7V8WBUA8OPrlmMEY/duz
         CCBqcyjtqYbBv6x8zDQSPZFlvmlBVYhv12jUdjsoOXxFGJEp+Oi0cyDmseg/CUjvjKMb
         AoCo8DJkHk0Ro7Xu/iV1Zknug42sYMfcaSVTO4QFPwdk0p/7+Z3TxDyXazBjDfgr6BX1
         nz3cCgdjde7G3YbKp/hnELSqY42RwQrEQAcVZa5xJ7Nuyskj3ZPelwYCtzq1ZwpLh+mc
         PYB0qy6HF4vNvVBWZ9Vkd6m/6p4iyBm/24zJ7O/HPBBtTFMuoo6zl75qJ3XQYzYjv13z
         SYRw==
X-Gm-Message-State: APjAAAVZx45AhSbz9M7lwfOHCJhM+prDjSYw2QqOMaAtyJys7t9BxZs7
        5FxUA49AYi5uq8SwX3P/miuXA6RIrXat67rzbYYVuWZ08gE=
X-Google-Smtp-Source: APXvYqz51oq62DLYLcQQIpLKvay49NoP5Pfylet+qsusz2qQe/7OxeTLWo1d3D6+9wk1+PD8XwNn0YMYmG5FNZCNewo=
X-Received: by 2002:aca:5189:: with SMTP id f131mr546084oib.8.1558253601155;
 Sun, 19 May 2019 01:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190518190618.m7rdkthvpz4agxd2@pali>
In-Reply-To: <20190518190618.m7rdkthvpz4agxd2@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 19 May 2019 11:13:09 +0300
Message-ID: <CABBYNZ+8YX-zBnUaYKLX2=OdJ-GUQ4y4V0EhGsN+uecKEpFBeA@mail.gmail.com>
Subject: Re: bluez A2DP socket reliability
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sat, May 18, 2019 at 11:12 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> Hello! How is L2CAP layer of bluetooth socket used for A2DP audio
> transfer configured in bluez? It is reliable with big/infinite
> retransmit count? Or in best-effort manner and some packets may be
> dropped? And it is possible to change between these two modes for
> application which uses bluez DBUS API? I'm asking because some A2DP
> audio codecs are designed to deal with packet loss and for those codecs
> it would be probably better to configure L2CAP socket to unreliable
> mode.

We don't use ERTM with AVDTP, both signaling and transport sockets are
using basic mode which don't support retransmissions, there the
concept of flush timeout which iirc we don't currently it.


--=20
Luiz Augusto von Dentz
