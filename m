Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699D4C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 14:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6EF2081B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 14:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0Qx6LJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6EF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeK2BkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:40:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33926 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbeK2BkW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 20:40:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so23753125otk.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Nov 2018 06:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQwFtxeu2vZayijynw+UoXFz4SmQZoCTW4oQH6U27XE=;
        b=j0Qx6LJf10ZDQVEtHCSU0CFfUrGzaz3VNRpq5WT3WH9KEeai/3eKLftMu09ulqWQAl
         cEXEduelnfomvY6TCStM3H8OVGSVgdJBaoQFlFdv5Gh8y0iqO4Ue1sFwE8unGi2Tkw2V
         0fClUeSDPatnnvHAe9ku7WggjbQ0L2khKYiOrFjGXzROtKrmDwNqRq1ENLyRnJP8LI5O
         fQynEosEqErBkZRagfR6hfn7mT4dXLRfVsM6JZ7kY13esRD/9ggzQL9zFRcooJVNg2V7
         WP+iZhS6mnQ0sINf6XhaEJtDYN6HC/TUR8j+tKehCjd5swN8yQdEuYEdjyD2+mGzbRxD
         l7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQwFtxeu2vZayijynw+UoXFz4SmQZoCTW4oQH6U27XE=;
        b=al7nDDZiD/TzAEW21tuwmXOWHUW0EdXCfR7MnYncrQgGG8XmSmTeD04BTEUcKLPyb5
         ERfMqlzGQUM7Wz1Rbxl4f552KQuHj8zwrDeVfnyLfwebCl4tvpOFuU6VogFjdLfe+k7+
         9iiI7JPFJXtdFjb+ud1TL5qDkEYVderFH0avj8Kl6i/F6ZY+zvojoD2nKSK3ovbONqZz
         22tNDvIFn8ru5Mjs4VaJML4j2Ui89eK+sCsQUHs1Z4u4oOUqF9eLM5WVFNY2El1UPko2
         FxMoFhZWvvvpkod7DyLck0xU9dbvtOqNS78CyklT/7eVNBUctk9OUDZBXV1tVIkzAV2Y
         vllQ==
X-Gm-Message-State: AA+aEWYlTSx56EQJqMaE+XfXapJd3PPGtVVzBJKqy6zeVBoB3De1o3dc
        w3UdBSyeSANyzkpfg1YIJ4aLXPCsJwINiPTxoso9ng==
X-Google-Smtp-Source: AFSGD/Uj17oG1Ahk9AuEtY/syD3GzqMuzRkgVcCA0Qx3l4NAVnIqG0uvNt4UsIwd2O+e1R+Xn3lOCkqrhFLZroaU1ok=
X-Received: by 2002:a05:6830:1004:: with SMTP id a4mr1798944otp.254.1543415908625;
 Wed, 28 Nov 2018 06:38:28 -0800 (PST)
MIME-Version: 1.0
References: <CABBYNZL0jgnZTYSQ+c+54_fHudK+0fg-GwS_-LUzw7gde_aMyA@mail.gmail.com>
 <20181125092012.8001-1-jengelh@inai.de> <CABBYNZ+AY6NPO68P5WJEtL_CKumTEywsuoGC4Roe4evm5mia1w@mail.gmail.com>
In-Reply-To: <CABBYNZ+AY6NPO68P5WJEtL_CKumTEywsuoGC4Roe4evm5mia1w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 28 Nov 2018 16:38:15 +0200
Message-ID: <CABBYNZKaBff5xU=9K=4D8id_dw+MNjmCRt8ugZ0k8g1x2Z=K9A@mail.gmail.com>
Subject: Re: [PATCH bluez] build system refresh (take 3)
To:     jengelh@inai.de
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jan,

On Mon, Nov 26, 2018 at 12:45 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Jan,
> On Sun, Nov 25, 2018 at 11:20 AM Jan Engelhardt <jengelh@inai.de> wrote:
> >
> >
> > The following changes since commit 9568f4439efdf5daa2f941f544d8a84a2eee5cac:
> >
> >   doc: Initial Bluetooth Mesh API (2018-11-22 11:15:45 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/jengelh/bluez
> >
> > for you to fetch changes up to 97561f245b7609e4c041b4083a7922817acc3ae7:
> >
> >   build: add missing BACKTRACE_CFLAGS (2018-11-24 20:09:10 +0100)
> >
> > ----------------------------------------------------------------
> > Jan Engelhardt (8):
> >       build: rename includedir to pkgincludedir
> >       build: change @foo@ to $(foo) in automake makefiles
> >       build: -l arguments to belong into LDADD/LIBADD not LDFLAGS
> >       build: -D/-I arguments go into CPPFLAGS
> >       build: add missing ELL_CFLAGS
> >       build: add missing UDEV_CFLAGS
> >       build: add missing ALSA_CFLAGS
> >       build: add missing BACKTRACE_CFLAGS
> >
> >  Makefile.am         | 84 +++++++++++++++++++++++++++++++++++++++++++-----------------------------------------
> >  Makefile.mesh       |  8 ++++++--
> >  Makefile.obexd      | 15 ++++++++-------
> >  Makefile.plugins    |  9 ++++++---
> >  Makefile.tools      | 66 +++++++++++++++++++++++++++++++++++-------------------------------
> >  android/Makefile.am | 41 +++++++++++++++++++++--------------------
> >  6 files changed, 119 insertions(+), 104 deletions(-)
> >
>
> Applied, thanks.

Looks like this is breaking the build if coverage is enabled (set when
lcov is available).

-- 
Luiz Augusto von Dentz
