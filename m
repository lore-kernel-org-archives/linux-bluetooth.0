Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A67C636D4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Feb 2023 22:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjBMWbU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 17:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBMWbS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 17:31:18 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25D31F907
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 14:31:03 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id y19so16395943ljq.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 14:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=34oadJWa/GBaIatu0bciMwTd2Yf+uALs12o2ugv7mgA=;
        b=VxcSBPO/0HcV+T14I5xx35/7MMj7SU74wuRpVskS6CpsW6zH0czRxVGgQRyj/6H0bl
         6Y2lhnf2Uhk9h4f8ZGm+nPEIyjez8oAe7LcmXPyIzObMruTkNRtJx8hBMGBMQa5o4zxN
         2uFUU1sW8iZlWKhiTOX5071vcII/SMsfwxPnclM3f4IwQ2+yIdOYrnSqZfEPuOgi+2cR
         RDFYZ4JLZ1R0xYNsvrQG8nZMoPRs2S/lJP/XNtT6fk2o65PHEMo1E9XDPW7CU9LQptx8
         lKwmy516SYDaBYT5RgCAQOBHB/DmufvGuNegWoNRC2vyRtqQVHxTT8kYMF36ayTLIfQE
         9mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34oadJWa/GBaIatu0bciMwTd2Yf+uALs12o2ugv7mgA=;
        b=5OrtgfOZKKJiVzam2wbD6E2hQ7vz75Y0qv3KPw1Vi/vZoTErjD54nMWzVZDuFMwNom
         tzqOlA6uS0ONsEfA4HFKXTsmj2k+WVbBM+S0RK+bxQv//NQd/JDzDBkDGQR9/SP2yDAl
         dylWpsdfqm/3iUHfyilzoqUihPtyGitJj02uvWbyU5/BZPuQXayrB+uFCQ9B1RXHVx5r
         vRG+N4Fdehxx2FIlpatGZ/jQpnowYbEWXWHIEGRxGIKvT1CUUIVhqmPIl+aPo7N+crMh
         DIdrKDqdYQPta+d3t0qf/154htJ7TgErJLa/uvpeF2DbXN8NYyZQKk5Rs+hsF/HU6lSm
         epqA==
X-Gm-Message-State: AO0yUKWJ/Nv5EIYIOHPwo24aSfd5jBDknoDSqYBD2kLlmoBtyvMkZoKX
        JBQmaYaV97pRN3ciRJEvsK8CCWCyeXlGAWnAfkdfYEoM
X-Google-Smtp-Source: AK7set+ZfhTdTD+E7YoilZpMl4SyiM1rOoitwtPmmD5ZasaUzy+ONPLTUsZ6ahFSPeB02YkqoStdcYCx7HlgqNH4l1c=
X-Received: by 2002:a2e:3a05:0:b0:293:4a79:8171 with SMTP id
 h5-20020a2e3a05000000b002934a798171mr6224lja.88.1676327462310; Mon, 13 Feb
 2023 14:31:02 -0800 (PST)
MIME-Version: 1.0
References: <3df45c4a6737b249b519d4c6128e2eb783198abc.1676112710.git.pav@iki.fi>
 <167632681737.28787.7790111416073990674.git-patchwork-notify@kernel.org>
In-Reply-To: <167632681737.28787.7790111416073990674.git-patchwork-notify@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Feb 2023 14:30:50 -0800
Message-ID: <CABBYNZJ48nMUwYS2UC0ShAMH5xbH3zsWRcuXcSOwDcFzwJojFg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/9] doc: remove unimplemented Quality Report
 from MGMT settings
To:     patchwork-bot+bluetooth@kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Feb 13, 2023 at 2:21 PM <patchwork-bot+bluetooth@kernel.org> wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Sat, 11 Feb 2023 10:53:45 +0000 you wrote:
> > The Set Quality Report command was removed in
> > commit 0454e2d09570 ("mgmt: Add support for Mesh in the kernel"),
> > but the settings bit was not removed. It's also not implemented on
> > kernel side, so remove it now.
> > ---
> >
> > Notes:
> >     v2: split to two commits
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,v2,1/9] doc: remove unimplemented Quality Report from MGMT settings
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3e2e3aa73904
>   - [BlueZ,v2,2/9] doc: add MGMT setting for CIS features
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=97ad0ecbfdd4
>   - [BlueZ,v2,3/9] lib: Add defines for MGMT setting bits for CIS feature support
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c35d32b19989
>   - [BlueZ,v2,4/9] monitor: add MGMT setting bit names for CIS feature support
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0f2f7a8fe270
>   - [BlueZ,v2,5/9] tools/btmgmt: add MGMT setting bit names for CIS feature support
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f131929b832
>   - [BlueZ,v2,6/9] adapter: add function for checking adapter features, add CIS features
>     (no matching commit)
>   - [BlueZ,v2,7/9] media: Check adapter CIS support to add BAP in SupportedUUIDs
>     (no matching commit)
>   - [BlueZ,v2,8/9] shared/bap: support client-only case
>     (no matching commit)
>   - [BlueZ,v2,9/9] bap: handle adapters that are not CIS Central / Peripheral capable
>     (no matching commit)
>
> You are awesome, thank you!

Note that I did change some of the commits, for instance I went with
btd_adapter_has_settings so we can use the MGMT defines directly,
instead of creating a new enum.

-- 
Luiz Augusto von Dentz
