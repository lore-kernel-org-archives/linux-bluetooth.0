Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5932BC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 20:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8EB2072F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 20:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu2qShe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgC0U4X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:56:23 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36406 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgC0U4X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 16:56:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id l23so11260101otf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 13:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMyNO5BtLJ9NbE7qfM7oMuRmX3UBuU3nLLGaLMjLoDo=;
        b=iu2qShe28cxZKfVdM70ywLGKUP5XAad+sd+A1U4IjA6UalL9/myDxTlBHToLiZkjr6
         1Ts2Y6qp+X2EyZqpB03OcAHl2HVvGKO6KEYdPgw6afzqZL/miaKrlpCzw2fdZwGtcUZx
         UKu8BbUUWriRiR9yhn5FZXfjLwtG0oFkzo095mcVsYtclnm/pgDeN4vUB6VTOrtweZZt
         BIIzBfHEbYzRXCjoJaVLCC0vycDpDZsHpM2SE4kD9e644GwZNu4QWDvTGyY0OmlcmK1C
         5sGnfar8HPemiBfxddVAwDpxiPMh5c2pljz0AW2ti3El5K9mPO/Yuw5+h3zJQVx0m9gx
         sfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMyNO5BtLJ9NbE7qfM7oMuRmX3UBuU3nLLGaLMjLoDo=;
        b=uG0+IgPDpGkLZbEilB5OSuYczMD8xkVvhBx/1fbe1yy1pj0zuae323Ap3NuCtz6GzB
         7IPNIqx+3hsr8Gr8lIm+Q+w1DXHOkql5rLTKaq4DruCmgpCVXhsuEvGz7C5FKIcO3llt
         1VuNdNWHCnY2KBsgApyiFR4pcXjbHIqZhSJpMuIonbPwkkEw1wDAMIV3/fJdbrspXDog
         qswGnsFbe2kEFrgTCPcDRRGonhkt7An+b4/eBaS88kfBl/pHITmANE+htjfFKcEOM+Lr
         Fo3mqlkKfHDgfUHZhqlHt/jD7788xHd+iikT0AK2aazq2wmNNWAOnyUcXL+tRjMPZqqF
         dlEQ==
X-Gm-Message-State: ANhLgQ13+8RVEBfarMvM0dm7e9jYe2MXvooATIYmoP6rmkGqH6kXLkyg
        v+IXHxey3zCgV6r2EOIxTalpkiH252TRAKzLDiceBA==
X-Google-Smtp-Source: ADFU+vu3lnFUsYru7nU2AE27xvhFc9ICWe2opS1eQCzEmUUHVqLQDweYlzVRScfaOGHQcBRG1j8HZnMdL2hrtPoIGDo=
X-Received: by 2002:a4a:2cc6:: with SMTP id o189mr1166328ooo.20.1585342582590;
 Fri, 27 Mar 2020 13:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200327150353.32468-1-alainm@chromium.org>
In-Reply-To: <20200327150353.32468-1-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 27 Mar 2020 13:56:09 -0700
Message-ID: <CABBYNZKUAkGREkZMGYKMSQt=WVGB0=5cb5z6ggUZYF=UYe+cDQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] monitor:Adding missing settings descriptions in btmon.
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Fri, Mar 27, 2020 at 8:08 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This change adds the missing settings descriptions from btmon.
> ---
>
>  monitor/control.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor/control.c b/monitor/control.c
> index 1e9054db3..6dfefd05f 100644
> --- a/monitor/control.c
> +++ b/monitor/control.c
> @@ -200,7 +200,7 @@ static const char *settings_str[] = {
>         "powered", "connectable", "fast-connectable", "discoverable",
>         "bondable", "link-security", "ssp", "br/edr", "hs", "le",
>         "advertising", "secure-conn", "debug-keys", "privacy",
> -       "configuration", "static-addr",
> +       "configuration", "static-addr", "phy", "wbs"
>  };
>
>  static void mgmt_new_settings(uint16_t len, const void *buf)
> --
> 2.25.1.696.g5e7596f4ac-goog
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
