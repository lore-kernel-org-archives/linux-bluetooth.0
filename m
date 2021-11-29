Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B43C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Nov 2021 23:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhK2XG7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbhK2XGZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Nov 2021 18:06:25 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B3DC201453
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 13:17:38 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id i6so36957877uae.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 13:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9L3jrYI5WGPQyqtKmqjZQMYlqPQP9W8iXaJoJzfEjM=;
        b=UVdhUSD0nRbqX5rlNwyuv1JzVhVKTSNaMtsS2tbfsIBwm0J7aubQn3zwLYGI9kGiUC
         biEiQP9jDKZGzqF44huPRsmZeZEgSd07gKp8GeaIpejRCLhakMp7Y4KSGl04bRm5FOO+
         1ZAV3jQ1WQIT36mzCGBQ8nJNOGxpVheNFlGynzwzqsVWU1jVcHiGvqbpiMjG5qaZJPSd
         qF8ujTdwLo1lvyM8D1WiN3QyQKh6oAYqHNA03HHsDnnj5YCWcDkwBpc/MmFJb4DaoqAw
         pJQk5HIlqd4sPOHSufGA48y4hD9Yfi1ASDx9dvpD5VL3q8/Y73Pj5nB6EtOkO7t+PrGI
         9y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9L3jrYI5WGPQyqtKmqjZQMYlqPQP9W8iXaJoJzfEjM=;
        b=NmDr6RiEyakdvv/Tt6d5gCmuwjA6yATZSAOiJY626qt47GaSW6DpU+7Bolnk7/0HJW
         KyTZgSFZgtht8Mt0zRRNSugbSeB8Mf+EuwgH9jXjVHS7WJUc1rexz1EuKenwuuLMucAM
         TxdppR0dATBsJS4B62uleKvW+VcbeR24RheJBxNT7/rCblAEdJU/LQkkewwSHa2ruarB
         0SgeOtHREpVyGfypTrJIgFhllceXtRcOZJE5l/mUX/UMqx4INRDMEcDmvd+8Y7WE0AaX
         TXyCvDyNJwLERHdbPPK5MDRQHNzoa+++rWF8DWFl6y8GwoWRNUOrAq2EC89z4c82rK9l
         rxww==
X-Gm-Message-State: AOAM530gXFCj7yrngvuptZimAff56OqzCVPcDSHYnPtSy7iqempe4dHt
        sMemOwoEg1g5YLetJcJjRg5BGro9lao6bZ4TETEqUvfJ
X-Google-Smtp-Source: ABdhPJyr3yUhbf0Khcb5qn/h+5cwdDB5b3qk6ACVHLOUvijRVFuVlkUdAVniv14cR8UlKpjN5ybgln3GiC0bcRFeSRI=
X-Received: by 2002:a67:b103:: with SMTP id w3mr35731632vsl.84.1638220656909;
 Mon, 29 Nov 2021 13:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20211127222132.14351-1-dev.git@javispedro.com> <61a2c45c.1c69fb81.b79eb.6ab4@mx.google.com>
In-Reply-To: <61a2c45c.1c69fb81.b79eb.6ab4@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 29 Nov 2021 13:17:26 -0800
Message-ID: <CABBYNZLBvhGTni-33_zHPr4qz9byvNgo7HbTH-U4hgmNiqic_w@mail.gmail.com>
Subject: Re: gatt-client: when disconnected return default MTU for GattCharacteristic1.MTU
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     dev.git@javispedro.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Javier,

On Mon, Nov 29, 2021 at 1:14 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=586773
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.34 seconds
> GitLint                       PASS      0.93 seconds
> Prep - Setup ELL              PASS      51.78 seconds
> Build - Prep                  PASS      0.51 seconds
> Build - Configure             PASS      9.44 seconds
> Build - Make                  PASS      222.52 seconds
> Make Check                    PASS      9.90 seconds
> Make Distcheck                PASS      263.17 seconds
> Build w/ext ELL - Configure   PASS      9.56 seconds
> Build w/ext ELL - Make        PASS      209.87 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
