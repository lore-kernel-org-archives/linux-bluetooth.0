Return-Path: <SRS0=kgXe=64=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1827CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 May 2020 03:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAF0205CB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 May 2020 03:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKSbvEDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgENDNJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 23:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgENDNJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 23:13:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB87C061A0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 20:13:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 8so1327673lfp.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2020 20:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=p9UTelGbn3Cl5jJ35S9aI89Fh+kXcqw8cw3krYo7N7c=;
        b=tKSbvEDSeiaYnVAJzLCFRnd2pVLKdLzKM76FgbhS5qA5qrbv92AVIqo5Q7IodCllHE
         DUujAiJv0hlwhHQaDQ6Ljn7wACBzAPDHi3DHBfyvezKB5vFiCSns6ZL3+WeQ9E1ujWxL
         33bvrm48RJ9CCKV8Gk4qaIC85nMPDjttVJHWWcjvijwFgKn1yPXos1xJLjs248KEImaa
         iyJN7abFV5GWGk6RJZoHxva9gkYmtTXOv0gQATJ+C5SQuEmlVau356oFO9BNq3JRcj8f
         y7Po+PzWvSd2cnW+n0tO+dV6GrhGhYAVRVegE3pWcINfozV9KSw0g4DgPAFwZJn8cxyt
         vBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=p9UTelGbn3Cl5jJ35S9aI89Fh+kXcqw8cw3krYo7N7c=;
        b=X4yQrmQyqFmejQ7zBmwHtaaFSPucoKftaaKBYEw6fH19O9WxC30FCdb2vM8FWu0D/H
         y3klQfAwOfps/kRLk0JVmKrCoomisG/4uGR4MG4KJdXexQp0ch9SvuFgBl+1fbHbkmYR
         vKXcCmiF6LVD3HOzm8QB6ckAVBV2zFiDJwBlronZbyXHkitcl4qHA9OmVNdm4FMFZLFW
         koOfGLlat1phG5mPgC1fl5HS6QCRMzxrfO6S/CR2jqQ8AAYRD87zQPoZm+cOWtC4Rlfa
         QizeArZ10x+IvUVWjLvKnHrKauC4GelbxZkNmXX8UFkwtYjgvUwtnRnKXKqeFBKxwxb5
         K6AQ==
X-Gm-Message-State: AOAM530Nr50lzhNDh1n864l6z5P7vnETIzHmgrnf2lU66nNwTxRiylpJ
        3Fgb6GjSAjw2/q0tpxiS12wTLyLIX1ZGWsPKKxVuKg==
X-Google-Smtp-Source: ABdhPJxTh6zMkhd/hGGhjFzKPAxoU7kdXKKi25ybT03VM8gbJXf6pTat9gA3ftN1iN2MGKQpzLZOF5Q5PgZIdN/IJNM=
X-Received: by 2002:ac2:53bb:: with SMTP id j27mr1694734lfh.106.1589425984152;
 Wed, 13 May 2020 20:13:04 -0700 (PDT)
MIME-Version: 1.0
From:   Andrew Fuller <mactalla.obair@gmail.com>
Date:   Wed, 13 May 2020 20:12:53 -0700
Message-ID: <CAB5wbS_qrzTc9uummR6Z50gXxJCfCTT+G6COaukJ-3CHk1N6hw@mail.gmail.com>
Subject: Re: Intel AX200 not receiving SCO data
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update for posterity:

I found a newer firmware from the upstream git repo and that resolved
the SCO troubles.
