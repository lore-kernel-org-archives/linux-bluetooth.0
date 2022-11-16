Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65722C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 20:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiKPUhI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 15:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiKPUgu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 15:36:50 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E5865E76
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 12:36:38 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j4so31507256lfk.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 12:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7tULxVKJQMfb6Tjn3OMHf70EXBhebQxNY4lrSZ8lok=;
        b=agJ3OVY+8ilMTjOefFWRp775EClULw06EL5xQtX8z2bRk5LAWro8nk/+bwfHf7i0Hg
         wNqu9oK4jXFidaSBMRp4yOcVAZBmhKiVSy2jWhr3lPD26+BWKDc2V8csDVdwwF5mzFoc
         +IfJlIX2wae+Cn8sR0o/J/DaAeFHesVweRAmy8e114s6lz6LFsE+gSErEqrQgVkn2P8Z
         V618WkbbG9QkZ+BLN+xYGeVfb/jfSYsRqADrV6aqDfe29/KspWVwo7Kw41ZWEEoLWK7v
         n7rCGK7oBripJqtg6ZeL2jq0VANH8fiiqxEw8b7BorPg8mx4tUiTQg7Bq+PGb7qo8Wer
         nk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7tULxVKJQMfb6Tjn3OMHf70EXBhebQxNY4lrSZ8lok=;
        b=QJ41pIPdF6i8KQHFP2wmjhwK1oDwLV5KFp3NptJv+UY8sMsCwHP5HWcFE2Wr2IeIN9
         FeJ4M/fuWAwVEBeHPw3A0MYxb4eAcnSWJzCbA5WRVC4d72PCCyUIM28j/tdRdWjxCStV
         h+gaCg07CQaihgjoRjCIwQjaHUmw/9EV81co9YkH5pxixsJWh9InYHe/DapdUP3XV61O
         0aoqZU9Ro7WMdty2vIG8/vK9G1FzLyikDfwCl/80xgLseyDQy4jV7ANca7Ew/uNy4HqB
         JMHm28t34hgSJvgBhfAmRO5ca9szrnkW43B/ITUZTpXmJcqtlF6/RktmVLNfpiRd6UTi
         w4LA==
X-Gm-Message-State: ANoB5plogN8vbbxvydkwGkkoe03brKihKrwl9iggzxqhNOq7buFeZ8Zb
        67+14+qrDVw+imjaG7rkCY9drWgREvpn7Pm8eRVAY88S
X-Google-Smtp-Source: AA0mqf5qbr1WxJEAcLL7VDsGkhXPy7zK3Cs34e9V8x2nFwY1cUPgsURZeLCgM9SNTWjBzkap2N4IwkZgbQ8epAfy+5E=
X-Received: by 2002:ac2:4d58:0:b0:4a2:efc:a882 with SMTP id
 24-20020ac24d58000000b004a20efca882mr8701414lfp.198.1668630996741; Wed, 16
 Nov 2022 12:36:36 -0800 (PST)
MIME-Version: 1.0
References: <010701848111d140-5dd1752f-c89a-47a1-9472-2e5a5a8a740a-000000@eu-central-1.amazonses.com>
In-Reply-To: <010701848111d140-5dd1752f-c89a-47a1-9472-2e5a5a8a740a-000000@eu-central-1.amazonses.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Nov 2022 12:36:24 -0800
Message-ID: <CABBYNZJaS8fTuXBm7hEvA_3jYqCpcjBdHbR6f2Zz-zBZF4TEvw@mail.gmail.com>
Subject: Re: Bluez <> Pebble smartwatch
To:     Florian Leeber <florian@ubports.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Florian,

On Wed, Nov 16, 2022 at 7:38 AM Florian Leeber <florian@ubports.com> wrote:
>
> Hello All,
>
> does anyone have any experience pairing a Pebble smartwatch with Bluez?
> It was working kinda well in an Bluez 5.41, but now with 5.53 to which
> we are upgrading in Ubuntu Touch the pairing process is unsucessful. As
> I do not own the device debugging is difficult, but some users try now
> to get a btmon trace.

Getting the traces is essential to discover why it is failing, we also
need the information of the kernel version as well.

-- 
Luiz Augusto von Dentz
