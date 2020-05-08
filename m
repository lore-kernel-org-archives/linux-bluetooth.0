Return-Path: <SRS0=6WQ0=6W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D24DC38A2A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 23:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 460D62173E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 23:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXMOK6+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgEHX73 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 May 2020 19:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727778AbgEHX73 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 May 2020 19:59:29 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB48C061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2020 16:59:28 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id i14so2573704qka.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2020 16:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=52+VESulDx9V3tUQK+T7uYVRpFDzyP6aBuSc4GDRPU4=;
        b=tXMOK6+YTJMfpWTaE9vVlU8+uYaXOrqVbXkClDBGbvG5BiCOlYAjRuueCtZauJ0BJM
         WTyEmlsiPMccfVAOrZX4RKl8fvNNoJU2aRwOHgnab+j4KJhN8zhSsSVBbYjxmHGWkiGn
         VTF1D75aD7gPFRjoXtGcgmlw6Z3UW7s3iMkRn/a45JbeV2SH0cX8QLXPfmiRJohuGTu7
         xucgrGHOk/5qqmh9w9ZRB6wVxhlc0rBWO0XPdCh9nX+EQMnle7LmjQ5z2DcKSbCLpN60
         VhNI0Au29mdfp8/shYQDCd1/ru3A2MD8R0i/WNtxJt+hGuWYoWMy8A8oH0IqqUhEDjtU
         HlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=52+VESulDx9V3tUQK+T7uYVRpFDzyP6aBuSc4GDRPU4=;
        b=mVuBT2feL/za7Ktd5C437lnhERCEQWkzKgfOV92Uirs/+/E4cD4XDxYnCGeya8eRu5
         6ZRPQJjsYk4EXftexxJKK268oSBkk9A1uIc6yUtalhHSd1Mrh0Cj7CHE45+BMgWD276/
         dHGDJuXnBdSAgkEyzJAFaEfXM61VedJYQbZYS9axt2nlM1i9VZzlBY+vjTUY9AFsSiRn
         JtR+2sq+tw7kiB6uZttDSbhabD3JcReUMDa485KAhL6u+O1QVkdxRzpFgDAguscUNsp1
         msHVZQNk7ExtYLIcx/8GmMXspQN2vAqXy2wT30kLOSVRWGjEHdfkHX9IAAkmjoPXMXYJ
         C1ZA==
X-Gm-Message-State: AGi0PuYpx8sf+GLxvOCZk4/D3M0vzeXJ1XFtd2y2gpC6AEdopqZldxhR
        V4dBOgz6ya6mnNaMXKVTvDUbG5PK/ohVa/JE6/RkoH15
X-Google-Smtp-Source: APiQypIYwxJycBU0iaCzQuB1JeQINyen+RkeAgga9SO1LhMTO02z3ik+hDgO7ED0X8ioJTz/yPXzBzL26509n98H8pU=
X-Received: by 2002:a37:a9d6:: with SMTP id s205mr5274761qke.380.1588982367055;
 Fri, 08 May 2020 16:59:27 -0700 (PDT)
MIME-Version: 1.0
From:   Hasan Ibraheem <hasantiny@gmail.com>
Date:   Fri, 8 May 2020 19:59:15 -0400
Message-ID: <CACUAwCSSev-ZJkfecxu2oYiQPkuDZamay6BzsF2Jr1HfcFXzgg@mail.gmail.com>
Subject: Ability to manually send LMP packets using BlueZ
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi everyone,

I'm trying to find out if it is possible to send an LMP_max_slot_req
request to a connected bluetooth device.

I'm working on a program that acts as a proxy for a bluetooth
controller. Instead of the bluetooth controller connecting to the
usual device, it connects to my laptop and then my laptop connects to
the usual device.

I am able to capture L2CAP data and forward it to the host easily.
Looking at wireshark and btmon, I'm receiving a "Max slots changed"
HCI event from the device, but I want to send the same event over to
the controller. After a lot of research, I know very little about
bluetooth so this was all knew to me, I found the LMP_max_slot_req
that I would need to send to the controller in order to forward this
behaviour.

I looked through the bluez lib folder source and wasn't able to find
anything on sending lmp packets, so I figured I'd ask here.

Thank you,
Hasan
