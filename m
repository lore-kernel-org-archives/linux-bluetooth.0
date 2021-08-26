Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B551EC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 05:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88965610C8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 05:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbhHZFRh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Aug 2021 01:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhHZFRg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Aug 2021 01:17:36 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E505C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 22:16:50 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id s16so2017117ilo.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 22:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oR2xLitZhI9DLS26jjoWWb4bI+/7VHYuEshTxW/fARE=;
        b=Vi1syzG1IeFc0SO9VwxVMmzfghHLb5nJy+GrqYBJ+z9a7vSZhVZ5IvGX8UqeDCbKaL
         p86GtHgYx698d4BWAnyEck6Z4nuFtuw8Lgj30vd49JI0aXgfbK8Iw1dHzz+2NmmFha4g
         NYeadqbm1+2l5vJ85xHabeE4qkYNyynAx/+j1D/hSH4y5Be19Jc3JthBMIXaJxY9HeAR
         91k7Can337wvaF+AqxPFhGcLBqyn6IfYs8yh/QgExv1rXFoawTcNFY331+yJc+gjTLbr
         h/g/6KtB5rPFdnahYGmP6LolK8aYtTlkWuEe3GBxFu3pjIpL/xBlI5vp/QgMqEsnwcNY
         3eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oR2xLitZhI9DLS26jjoWWb4bI+/7VHYuEshTxW/fARE=;
        b=O9jYn5RDjOt5iXopC/BXr2t2tpRBPvpIcbqd50hixsRassbdGuD+1ZmMyYs+r2if60
         fc677OdY3RLE60xn5B3fWWkEzq/UZqBDQYSqHUb8zIpZCVNgaiwRJkrbiiCE+K5fFI56
         TSeYUKwM0y4QTMcvC62W4tRuMKeaB/W35Nnz86i5ADmwrLEdbIFawvZhlQZMO3TloKf8
         mgK/49rTZgZBGBwNkM4tSIf/CH8zXyReHTxg4d1M54wVmeampt+P/3BE3UyJ69sOKwQO
         ftXRABk+nVEYABa76coSqqctclZfYCzhDXh2ZRYa8GqnGpE2dIycdF0pImdwcwuuqRlM
         cZIw==
X-Gm-Message-State: AOAM53303z0ClDXSOMoRqdJEU6TtbRJnPhPCCzJLW4Xr3UWEIPW7vPia
        igX3pJzb/O/KbVAsaDHuRzZXZXdbyi+uZhdwwCyzEa59
X-Google-Smtp-Source: ABdhPJwbrxd0Dxu6zGErETE/VM2lK3zOGrBqIAVvl3q17bQQhJ1bQkCo2aTXSk2JAi7Hi8DLFtxg/ObdZf8hbWofbyE=
X-Received: by 2002:a05:6e02:1b07:: with SMTP id i7mr1527608ilv.94.1629955009414;
 Wed, 25 Aug 2021 22:16:49 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?0J3QtdC60YLQviDQrw==?= <nektoya3214@gmail.com>
Date:   Thu, 26 Aug 2021 08:16:37 +0300
Message-ID: <CACWFqxK4o+xvxG08FsJuBGf9sJihf7c+G2xRCW6v2Y1vRP-sKQ@mail.gmail.com>
Subject: L2CAP receive buffer overflow
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I am trying to send PC as wireless speaker with support for LDAC audio
codec. I used bluealsa with libldacdec fork (this one:
github.com/anonymix007/libldacdec) and it actually produced some sound
(but not for a long time), and it shows "Dropping L2CAP data: receive
buffer overflow" error in logs. Just as fork author, I modified kernel
(see issue: github.com/Arkq/bluez-alsa/issues/482) to check if it will
work and it indeed worked.


This is how it looks like now:


        if (chan->imtu < skb->len) {

            BT_ERR("Dropping L2CAP data: receive buffer overflow -
chan->imtu: %d, skb->len: %d", chan->imtu, skb->len);

            //goto drop;

        }

And the error it prints:

Dropping L2CAP data: receive buffer overflow - chan->imtu: 672, skb->len: 673


I'm on LMDE 4 with kernel 5.10 (now modified 5.10.46 version), Android
device I am using is OnePlus 7 Pro (Android 11, latest OS update)


I can suggest increasing buffer size a bit to fix this issue.
