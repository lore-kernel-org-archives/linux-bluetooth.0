Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B61C3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 22:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B4A208C3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 22:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcPKNQVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCBWs2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:48:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35656 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBWs2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 17:48:28 -0500
Received: by mail-ot1-f68.google.com with SMTP id v10so1080279otp.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2020 14:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R+5JAWXSV8fLePoXh9S21yiOwvtDk9GvUSN+2gq8Xm4=;
        b=hcPKNQVUHMC2T3DDOolmuKncpKl3x0qa/FpWbstnEwmj9Uvz6hWwt6Etp73V5II37q
         McmAg0+7F7InpfRGtufoyl095MG+Vlr5ZEOwtC6iAQtAaNq+dptwp2mHHTYTYNQGQITB
         G08eoG0CIMlgLU+t9VkgMLqCzx0iS7QJUHAGtiN7LXnVyZJ+g6eO5s77bQNFGiAtkCRp
         r0+52I+r56Vw6UdrvEK3lQo6mTBm+X4tJXPQdFM7bEuyOX/xZNewmtAA6adqVi5P4m8s
         6/hv5+kdpd5uFVzGLQpmWsWBjzYJj876D72k0K71vbLNyupNA8Cg5YoX7RAYQT1/MaAP
         YuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R+5JAWXSV8fLePoXh9S21yiOwvtDk9GvUSN+2gq8Xm4=;
        b=oJbuOFOChNYuTYCj5uvcHdbYtOnN8UL1bsu6QtYHjertO8Hnnhr+0zUpX/0ho4Kvb8
         msqlWoEy6fLKvLDmj0OQOxC2JhTa7c6/GDf5Hu9G/5DOQ34tFXKHitVBoZ+UFnr+kYHt
         Em6uB8rhBtjFgOAYC67Fs27lzyA4Q1jjfF3SsYJ6vNqENnLWvkhSD1XmVqEPrNjJkjcQ
         4a+FV49LFsiLLQM0J1jTM2sMGpYScrRpTmUwkonj9TzHchjgeFATwZBaBNOKpjOdu8rT
         wTfHNrxrhmDX/YBUhDYc+14e7ERQjy+9aIwGnPAuF5Zd4fu/fi93fE+Tw87MImdKTqGY
         gY6Q==
X-Gm-Message-State: ANhLgQ1xDtZ/G/4KAk4vt6XDFPeFIKbxXqeyD7Ydx0hKcmsyEM4gFHZD
        gomST60wO6aNLpKWKi4n73wEFybbc5fmmzpQVizeJjgP
X-Google-Smtp-Source: ADFU+vuD3iNvzrZHsvrNLqhS5isN8P3kgAQUTsIL8sCNZz2zaAAYHjUI9Xo3e4YN6/6Hq+PyK8LyRhdZ3MqsNOphIsE=
X-Received: by 2002:a05:6830:1e86:: with SMTP id n6mr1063197otr.177.1583189307692;
 Mon, 02 Mar 2020 14:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20200228234701.14614-1-luiz.dentz@gmail.com> <9E347C8A-CD93-44DF-9B90-721518816F21@holtmann.org>
In-Reply-To: <9E347C8A-CD93-44DF-9B90-721518816F21@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 2 Mar 2020 14:48:16 -0800
Message-ID: <CABBYNZJ_+jzSVS533LLGz0VkybRCA_3X-zmu=srYfobk1V-C1g@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Userspace Bluetooth 5.2 initial support
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sat, Feb 29, 2020 at 6:49 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> > This introduces the initial support for Bluetooth 5.2 features:
> >
> > * ISO channels:
> >        + tools/isotest command line tool to run validation tests
> >
> > * L2CAP Enhanced Credit Based Flow Control Mode
> >        + tools/l2test has been update to include the new mode
>
> I prefer if we not merge these two just yet. Let this settle a bit first =
and figure out what the best userspace API is. Otherwise we are stuck with =
an API that doesn=E2=80=99t work.
>
> > * Enhanced ATT Bearer:
> >        + Client and Server support
> >        + Include all new procedures
> >        + Automaticlly detects and enables channels
> >        + Number of channels configurable via main.conf
>
> This looks ok to be merged.
>
> Regards
>
> Marcel

Applied, L2CAP changes were excluded since we still need to settle on
the userspace API.

--=20
Luiz Augusto von Dentz
