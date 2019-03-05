Return-Path: <SRS0=u2q6=RI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF6BC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 23:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEA920652
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 23:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9B/K/hW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfCEXZS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:25:18 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35960 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEXZS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Mar 2019 18:25:18 -0500
Received: by mail-wm1-f41.google.com with SMTP id j125so4181568wmj.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Mar 2019 15:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7vtRAHymVFHwp4//wGLjruUGbkOSd4HJEb6pBo+d/bE=;
        b=O9B/K/hWKJoQrZUdhu4sLhoAVstg2lJRCMb7kY0Fc/i2/PIEej/GUgeMStHcly/fCt
         nPdTeOzDxeTi2E1OVYVyVqfZy4mShS2ATtfCvYgleasgqBr4CZJRC3JsWEkMll480+3G
         nYbEmFTV2U7Xh95j/k+20vF0866G7089BFbTTEOYa033rMnjcw7DNzM6YHbIvMYpbEMG
         Ib07iS/jjNs9zfjsG/Bhz/IG7xWSEHqVE0E/jEhbZ8xI5RnwDEIkSiuDJ1ThKc92+AYw
         mX2TY0is3gFl6Z/FefhcdEbK20IGEdvCP1mVPD6nihzDIV9TelZayCfU7KzRF7L74Ni4
         bdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7vtRAHymVFHwp4//wGLjruUGbkOSd4HJEb6pBo+d/bE=;
        b=X0EM3ER92Hf9Nj0jRwC5+0VB8fwxU+z/M87SwjC+INeIRwEVS42M79MIqkX41sodB0
         SnIrwpXtuIldqyXGtMZ0UYSp/95jF+SmkMnRGp/qxthqFVftr6O4QStNw+/h0iPgKKjn
         Gpex+nOz8mnS+PUTMBT14nV+1SbOq5iScRNNHH+dy+/+Re1u2l+RMvkbDfYE4BBYB8VT
         /sGwWPkqVeSf21ULoyAhexDU7v+wNXDheD6itUlw2WsZcKJjhwHV+nIOixOvdlxZ95Do
         hi+Cgha/56/iBBo8XH3In4944lA9moItIMVkMb01l4M33qGlaBapVV41Blo+QuT3mSKR
         W0EQ==
X-Gm-Message-State: APjAAAU1cL/sdTwO5atC153Mj2RemTtp5cESzhUlckt2sEI7KgiLASYC
        HXV2zceLpFgzfodp7QoScewHXIocPX6AaY1/Mm7vrxzA
X-Google-Smtp-Source: APXvYqxSRbFIkHRaGNw8IELA0ww8NHKJ3rmPOo/N1Ty93F39p9KSDEMoqWnieNPxtwjUuhgYOLwyYKDhf8YflblDnh4=
X-Received: by 2002:a1c:a004:: with SMTP id j4mr478167wme.143.1551828316321;
 Tue, 05 Mar 2019 15:25:16 -0800 (PST)
MIME-Version: 1.0
From:   Yaroslav Isakov <yaroslav.isakov@gmail.com>
Date:   Wed, 6 Mar 2019 00:25:05 +0100
Message-ID: <CADS+iDUDv=Keo6661q3dY8C5=f+fZtfCe5gdPutO-psc9Pe0UQ@mail.gmail.com>
Subject: Strange SCO problem
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello! I'm currently trying to modify pulseaudio to be able to use HFP
profile with mSBC codec on native backend, but found that, while
working de-jure, real sound is completely ruined, so I can barely hear
what is sent over SCO link. I've tried two different Intel adapters
(included in 8260 and 8265 chipset) and KillerWifi (ath10k driver), on
two different PCs with two different headsets, results are mostly the
same, the only difference is that on ath10k words are more or less
distinguishable.

I've even tested with pulse just for profile setup, and SCO is sent
via modified scotest from bluez, which sends some test sound, manually
encoded via sbcenc (with added h2, of course). I've tried also msbc
branch from bluez-alsa, same result.

I'm sure that every time socket is connected with setsockopt(fd,
SOL_BLUETOOTH, BT_VOICE, &voice, sizeof(voice));

I've also tried with this patch
https://www.spinics.net/lists/linux-bluetooth/msg76982.html, with no
luck.

Any ideas?
