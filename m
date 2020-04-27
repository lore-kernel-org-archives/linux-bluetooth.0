Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF2EC54FCB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F501206D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 14:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g6JearYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgD0Ow0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727022AbgD0OwY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 10:52:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041C1C0610D5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 07:52:24 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so17911661ljl.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HiuwX6Amee9Np3hMGda+eXixQJE+AkRQUWW6xVHi2N0=;
        b=g6JearYkKoH9lyC78eSS/IuGzJX0u04oHwVmJx0MB24XMFEEIbxZYUlcWiJAunZu9y
         m0tWZGaEW2q2F3hXHYuEMRSzzyJw4sa/uLP9oR63QbYPOObvfjgxeWGRyFER94v3gw0q
         PMxT6rAnS3n5Wf+TSnfa8fbKlkof1o1gew4G0Bt95JzcLlLDSk1CHW9HWC/pdQ02uwyD
         G+X4tnKaWc3SRdMCYz4Ub0PeGYAW3oo1nBpB0eA+YqyP8rPy6jBEBsyVTbbFgKsrt81f
         6r3IGygJkIOUMogTgqq95sOQxc3FvPpCZCOEtWUfYxP5CXrORaBKtrfxa0xsFALesnaP
         OpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HiuwX6Amee9Np3hMGda+eXixQJE+AkRQUWW6xVHi2N0=;
        b=D1O8cYd4HSX0Zkrn8RDbsiTCkfsUlFE4+SaUylUfJ2EbbuHwkvmlFR9LgmrdEqdm08
         ayMNcSvKtLoNRWEcfZkGt1u4Z+439fPHUXdFrzmKr7dXZ98PSi7XJROYwWa2Z3KRcBJx
         7VbNtuBaNSU4LIjFKLoWLMXMPTJ7RlEp44Vr9g1T8SI+deSz61mej4A1O92H3Kc0iO0f
         pxqHFV4ReToUI2ouxVdLtTUams4o/7OyxxVrMZeNB+nmyiC3dftPW9c6/t3s9zpB/PF6
         xyIySKcI4ya/T34iUrbwaObi6beS8gU+Zw02RIy/KOpu0LaE/7rltJFoHPabfF1yXq66
         Zkgg==
X-Gm-Message-State: AGi0PubcSqjXYYx7BpnwN8R3boKYB5NjvM1RMai+ZOOhuVDIIRnPR8Qe
        +oxdzuvOMgHKlP3kdojLjgf57594osRad+r2I1Qa/JdG
X-Google-Smtp-Source: APiQypJkw846wlmp3/ZVJaEiAXyK5P5+oPepTRoujkpIMaufeU8Yqw4hgbr0YKWfxoznvpPKeH03H4txvYijAzUqQ60=
X-Received: by 2002:a05:651c:1131:: with SMTP id e17mr15395593ljo.79.1587999142327;
 Mon, 27 Apr 2020 07:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200423144328.82478-1-alainm@chromium.org>
In-Reply-To: <20200423144328.82478-1-alainm@chromium.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Mon, 27 Apr 2020 10:52:10 -0400
Message-ID: <CALWDO_WpaTwuidrz-tk0AP2wsZ9fnWvTa8LGvpmSxZN9jOhd1Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] bluetooth:Adding driver and quirk defs for
 multi-role LE
To:     Alain Michaud <alainm@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Friendly ping on these series.


On Thu, Apr 23, 2020 at 10:43 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This series adds BTUSB and quirk support for the driver to confirm that
> the reported LE_states can be trusted.  The quirk will be used to
> gradually roll out the feature to supported controllers without
> affecting the stability of other controllers.  If all controllers FWs
> are fixed or else validated, we can consider removing the quirk over
> time.
>
>
> Alain Michaud (3):
>   bluetooth:Adding driver and quirk defs for multi-role LE
>   bluetooth:allow scatternet connections if supported.
>   bluetooth:btusb: Adding support for LE scatternet to Jfp and ThP
>
>  drivers/bluetooth/btusb.c   | 11 ++++++++---
>  include/net/bluetooth/hci.h |  9 +++++++++
>  net/bluetooth/hci_event.c   |  4 +++-
>  3 files changed, 20 insertions(+), 4 deletions(-)
>
> --
> 2.26.1.301.g55bc3eb7cb9-goog
>
