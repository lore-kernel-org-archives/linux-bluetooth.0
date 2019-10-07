Return-Path: <SRS0=J5Bo=YA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6CFC47404
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Oct 2019 19:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926BF20684
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Oct 2019 19:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVAKBv3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfJGTai (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:30:38 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:37489 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGTah (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Oct 2019 15:30:37 -0400
Received: by mail-wm1-f42.google.com with SMTP id f22so684082wmc.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Oct 2019 12:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=p4zJFZcZnCIaVILh33EeJOJOk2/HxEd8RWQMDWjd8Jw=;
        b=iVAKBv3zzGGuuNdqkakqvsGqeedjlpF++RlpcZ2nDZpdBTH3WaiQm+iaUohAbDXJK0
         T7qrlBJTpTkveNjWLcMQbB1lrAMDCXr6RRO1eF8LSwysoS3rPA0buwn+1JS7FZCO0VqU
         cCiwZpitTiVhpgQ9DJMWJ92s1JbY0i3GPGroblR0rpNUtI9T0lj3Otk2WpctyTKAM2r0
         Z4bq5YbyXYUqqhNOw2ZjdJ1kGNgg3yYGNTgEw88mPI0gYaSMsmjiyP8IavwEFbEW6bOO
         Op+ugaAYzPH/FEj+ty5ueBaW1Ka5Ko0iYi3RnQj7FANV5wAqwbRAX3uRSmEadFefXcyQ
         X37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=p4zJFZcZnCIaVILh33EeJOJOk2/HxEd8RWQMDWjd8Jw=;
        b=cwjRhfYkjfzPL+CbLcwhAztasdByUbTDcpZHtegp0EpQEZujEvF36UQoZ2VAxWYHYs
         cudhO5wmTOQQYCb1RM40BVcnL8DPpjJ3+IoBlpmm1U8APUJGLYW6jiUlIEc1VAtI9fm1
         E3jky7aiTsvJz7/BlH6AGLBDTtB7hV16IatRxL4lx8bKKC60D0SNcpTkmg0cVEu3mUa6
         1di0BHESO4PIwfjwgwa/caJ2pu0Fk7QsoU+06Rr5dhAz9+0o+/pT70AlpzaMJwI4oB0X
         lNS4wxiHo6aIlJgFVK6x53OO8FqhHg5VH+Gu9Q/V9C+croCDV8qs+h7bVPUtYSTyW7b+
         XXnQ==
X-Gm-Message-State: APjAAAW0jbqAEB5j3bV/kcotJ644kXjfW+c8kFwR0Vw1w3S9AMxGOlQ2
        GEbwLQMlB8N3O4Av1JVTQg7VAKWFUtNmRe8dmZkrT9cr
X-Google-Smtp-Source: APXvYqwZG3TCuLtTwZ0DXEXCpnydIDRUsfZiLTe1TtSDFUCqb6V4wRwuKE4ETXHHqW6UH4xnkH3YqoahvNVRgvHaxN4=
X-Received: by 2002:a1c:99cd:: with SMTP id b196mr608231wme.83.1570476635679;
 Mon, 07 Oct 2019 12:30:35 -0700 (PDT)
MIME-Version: 1.0
From:   yayfortrees <yayfortrees@gmail.com>
Date:   Mon, 7 Oct 2019 13:30:25 -0600
Message-ID: <CAJ0=ZJ2rjxM0WmA72J5VCcUZ01q7dH+jxJi7btGzayZWHe7S1Q@mail.gmail.com>
Subject: Bluez stopped connecting A2DP sink
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I recently upgraded bluez to 5.51 from 5.50 and my headphones stopped
using the A2DP sink during autoconnect. The headphones instead go to
HSP/HFP mode and the A2DP sink is disabled in pavucontrol/pactl. The
A2DP sink will only work when the device is initially paired.

This had worked flawlessly for years. I was able to track down the
regression to this patch:
https://www.spinics.net/lists/linux-bluetooth/msg76180.html ([PATCH
BlueZ] policy: Add logic to connect a Sink). If I apply the patch to
5.50, my headphones no longer connect to the A2DP sink, if I remove it
the problem goes away.

Not sure what else I should include to help track this down. The
headphones I'm using are Beats Wireless (Solo Bluetooth).

The only relevant log entry I see with the patch applied is:
a2dp-sink profile connect failed for 34:DF:2A:0D:F8:C2: Device or resource busy

Let me know if any other information is needed.
Thanks.
