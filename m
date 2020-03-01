Return-Path: <SRS0=CJlv=4S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC836C3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Mar 2020 06:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9319521D56
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Mar 2020 06:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5Y/JdSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCAGq7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Mar 2020 01:46:59 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40377 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCAGq6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Mar 2020 01:46:58 -0500
Received: by mail-ot1-f43.google.com with SMTP id x19so1826280otp.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Feb 2020 22:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Hm9tjczIkXblNXcfENkvYBm7CmOG6HZ6SgO4DUwYWk=;
        b=O5Y/JdSkiUVQUHrI0vYClmp+i2ge0PrfHtXW4ESWqXcO/PfvOJvrXBnZ2z4Rcj9B90
         4cfi9swG1+ga7vf3sLVa877FxZwW3ZRR5oGKAOLe+Io7Uk4gi4wLC5U6n+5y6uABtP6k
         EE676rluZw4oNzIpOKInAoJ9c21Wht/BYOZULzZf8KAn3mbVnFiw1OgVXzPj8x/mgwFf
         zESAB1CG5B/rkzNV5o6L4Ky5D07MoGtdoWM7Gp+FzHvL9YN89mJhGPLH4BOcOjRQ2d5n
         OnD/wjjJWEB93Hhog659l8dLYTDOOuKLARQhj5k+06oeOGatJP2XiJLbJJPQh2ErwES/
         IejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Hm9tjczIkXblNXcfENkvYBm7CmOG6HZ6SgO4DUwYWk=;
        b=olqQXwEQo9DwPsyaQVvGnP2MgyE8sINVIi0PoBvX0m3lGc6OPmwdBXPnt2TckbuQJe
         nFugsjiI6s+0AhAomz65dXaOUrrJeTvCMKVEYTAEoDowTq+5C5KXs9mJWRoq/IRAtg/X
         hpVIYxmmp6noodI0QxZLO9WmhdYFuwzv2+/mzegCKMQLnKCzzae/vSybxdZbs9DUkeym
         xnmt5O8Bx7IlktO9lup7yNDMz3kn1X6gRvg6qqZE2VvyXaA4wwLyWgeIUVQaVjl3J6ta
         NnGwR2yV/0k20sWTFFKjVP1+6mQ4wZSfMkcvl4YpNYgtIN1LcUZpaBbQMEMTLY9XOe9D
         gkfg==
X-Gm-Message-State: APjAAAWDvrv0Amo7BvpxpCKzj6MRDFi4jPRjNF82ybN383ivQXCaKBFD
        xGYctcTy3QHVeNzvC1NJvOZn6P3Hmd9WUTp2pFs=
X-Google-Smtp-Source: APXvYqywRp5NNuke/PqcvluS2Moup3IvEyYpGgxXJ8s3FZ+fCqlQLap2t5yFAKUz2e5azttrYnGve/FqdJ3sqGie0yA=
X-Received: by 2002:a05:6830:1690:: with SMTP id k16mr9610608otr.79.1583045218091;
 Sat, 29 Feb 2020 22:46:58 -0800 (PST)
MIME-Version: 1.0
References: <CAO1O6sdGJeAKTHBVyDSUa7-Hp_ULYmfOHJEbb6=-B6xuPHvffQ@mail.gmail.com>
In-Reply-To: <CAO1O6sdGJeAKTHBVyDSUa7-Hp_ULYmfOHJEbb6=-B6xuPHvffQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 29 Feb 2020 22:46:46 -0800
Message-ID: <CABBYNZKtxPmTUn2fw9-dy1V9M_Pb996O6VmHkg4NrAr-=t+-4A@mail.gmail.com>
Subject: Re: Get negotiated ATT MTU?
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Emil,

On Sat, Feb 29, 2020 at 2:13 AM Emil Lenngren <emil.lenngren@gmail.com> wrote:
>
> Hi. I have a feature request that the negotiated ATT MTU should be
> exposed as a property in the org.bluez.Device1 interface.
>
> For some applications it's good to know or required how much data that
> can be written / read / notified in each packet, and it's not always
> desired or possible to use AcquireNotify / AcquireWrite.

We already negotiate a fairly big MTU maximum by default, and you can
just use AcquireWrite/AcquireNotify just to discover it and the close
the fd immediately, so I suppose we cover much of what the feature is,
except perhaps if the application requires something bellow the
default MTU bluetoothd but that can be a problem if other application
would start requiring their own MTU as well, so even if we introduce a
Property that would have to be read-only but there may be races if the
application start writing/reading too fast or the remote end do
trigger its own exchange for some reason.

-- 
Luiz Augusto von Dentz
