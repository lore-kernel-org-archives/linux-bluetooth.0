Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000D4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 06:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21592074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 06:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="G5ldyWIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgFPGPC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPGPC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 02:15:02 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3D1C05BD43
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 23:15:01 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so3416469lfb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 23:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q84GbCemWyn75zAJEOD8J0ltbhJtSbOIkwcNNVM7eQo=;
        b=G5ldyWINTpBmEyAoTfYlXp161wQYwDywE5IgC+iVnqgWTiPVWo3S+H+W2boPoMAuck
         WrMFBf8u0OcI2lZGlu1V9qv541faao3u6+tG/y7yvuf0Q892xObR1PELZmn6zoC3rDT9
         OgZ/ZToeRFNKQ55LVUeO7VJ3vq5+48U/W/MW6/V4vhHG1vz4BjQRbB6pE+D54coKCEX4
         Zl3rZUp47hSUDbrwWg9ckTpTGME8yaEUKSzR2qBlktnc5H/LbCRfnfMv/3SydVYY/D+R
         DSKmm5QwpW1aopHEj6xQEm4YOjSQN5OWaDn7UujSOix2eOQWuDnsH45Ifoq1IQ9GoCJs
         sxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q84GbCemWyn75zAJEOD8J0ltbhJtSbOIkwcNNVM7eQo=;
        b=fSIuiSbxPo98RWWwY+PwgMqeHr+kjgiCWvj28NNHUP4xKI4XalYAP1SjtArLd6SNUr
         4nqVXrMZC8A0ATTg/sxcgM07gibnQcb/ohZJlqyDo6H/1J3V2KNsolj5dX9vvsONG1zu
         OQob2fNGYHJ5ry917EuY98ON09YIG33//SSKWEkbTyj5vTnHH4Qr91Gx6wFzmNrzsQ4Y
         6uSAr1jJVKfdFPZQ1C1JjQuxns3T5MCRO+oNqzi1cEzkMObhniqgrSMCfK+6ovWfaGBz
         4sm7S/DZ0orVXBaDxt2h37yIdOf3GgAyuEeI1UkDghEU0nCCEus+U+c9ACvVLUD8mfn0
         GVBA==
X-Gm-Message-State: AOAM532BVbrNP/WramL3TLwhlCVZ82QYVgwZilpxF9CXucYnop2+izgm
        u+elklhyc/YZPi0QKuYaRUQaaYpnWgcbxGgZWn8EHQ==
X-Google-Smtp-Source: ABdhPJw8yHdsjXL2dYmtZCE2kMU16mzdmzWLX0AIz+tW9bPzQCAdfxc58aceq+h8BHrdXw+Pgu2DotCRsWPmyGrQ4c8=
X-Received: by 2002:a19:c1d1:: with SMTP id r200mr116494lff.102.1592288100302;
 Mon, 15 Jun 2020 23:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200615212806.BlueZ.v1.1.I8328c620402620c9aadc149614bb279e42a9db4f@changeid>
In-Reply-To: <20200615212806.BlueZ.v1.1.I8328c620402620c9aadc149614bb279e42a9db4f@changeid>
From:   "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date:   Mon, 15 Jun 2020 23:14:49 -0700
Message-ID: <CACumGOJuBW+F9KsFJrtFCTErQj8u6jrR+3rTi8t4xuG6ow7gsQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] lib: Correct the name of Add Advertisement
 Patterns Monitor Command opcode
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Mon, Jun 15, 2020 at 9:28 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
>  lib/mgmt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index f44f2465d..bb31156ab 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -673,7 +673,7 @@ struct mgmt_adv_pattern {
>         uint8_t value[31];
>  } __packed;
>
> -#define MGMT_OP_ADD_ADV_MONITOR                        0x0052
> +#define MGMT_OP_ADD_ADV_PATTERNS_MONITOR       0x0052
>  struct mgmt_cp_add_adv_monitor {
>         uint8_t pattern_count;
>         struct mgmt_adv_pattern patterns[0];
> --
> 2.26.2


The name already contains PATTERNS:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt#n3499
