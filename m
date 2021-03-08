Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA6BC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 23:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF7165299
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 23:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhCHXBG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 18:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhCHXAp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 18:00:45 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1CCC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Mar 2021 15:00:44 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d11so8868274qtx.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Mar 2021 15:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TT3BGD7TMHGCyGOuOxXD+0i2CoZ1hdQwC91TD3A3nZo=;
        b=c6OCZWvIk3TxbJ8p3oow121/MTa0w2P7hCO4eINv/kO2evEhK645ovGwVQ7v5Dssbd
         1SnHlzBjMv6fZse2+EdEB6HwIrnHFpgqeO3zGwoiyk6q9+m/Xmc6pYv2VO5TZ0LpnMR0
         iYtny0mE1m+eyZ6sL5UO745Mo1x2IIAyeZvx3tCmpJP0WSgYw3qKx+ObyJnMyN/QTQ+R
         T7rxlpVabrYqVHXkhI04T/1bGM9l2HOfAeG81bBMmgl65SJUv5+jxW8nxogDYJgic0eu
         mfWOUr/0antjCp/UONIz5JFX0KEJqvbH/aiQAdF2YZihdMfTXIpPTrVkCfFj2P/yOiI3
         mjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TT3BGD7TMHGCyGOuOxXD+0i2CoZ1hdQwC91TD3A3nZo=;
        b=MpaloXkyj9a5WUVtAEapl+38BoiQcIgxbaWHYG/Wi8aFXfUSjKVVigZ/22th7QtAI/
         +E+PBrlDCmQOeZWutIgMqOaXKVaVYvW9Un29Q4NRkR9NSJ25gR1pIcF06tGkb2xYwncj
         PPko+XGoZCRFTL1axkrwzjCEQjMaGHVYn/Ubl99keBfgPIklnRYmrPDI9otMik5y5ha5
         JQF7VP5BoiHom5yBkKjMp/zONmVuDT3CK7dg8hSb4jtuathsxL7uHKvl6A7ypOq2jlHv
         w3wWiqWusFIDLmTX5AERnBeluBjt8Y/nBWKW9lEtEjUj4d39sdvqt7/+3uMypo7rEXBH
         ph+Q==
X-Gm-Message-State: AOAM530jNBili0IUJazMjSLWX/T+wDJwgfS2GiF/7/eyOySeyj2h2x74
        x32gg5dIVkXsBtV1+BigFRU0/U4LpBY=
X-Google-Smtp-Source: ABdhPJwybcVl/nVaGdmKH/H8KVnpnBMkuGcU/fCKcX1bkqm7jUIwdvuPqBFUa6zpk4s8La9f9A3RwQ==
X-Received: by 2002:ac8:4684:: with SMTP id g4mr22342400qto.388.1615244443691;
        Mon, 08 Mar 2021 15:00:43 -0800 (PST)
Received: from [172.17.0.2] ([20.36.172.238])
        by smtp.gmail.com with ESMTPSA id n5sm8691744qkp.133.2021.03.08.15.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 15:00:43 -0800 (PST)
Message-ID: <6046ac9b.1c69fb81.dabbc.6173@mx.google.com>
Date:   Mon, 08 Mar 2021 15:00:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2398802838712747869=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] monitor: Fix invalid access
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210308224228.344888-1-luiz.dentz@gmail.com>
References: <20210308224228.344888-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2398802838712747869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=444125

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============2398802838712747869==--
