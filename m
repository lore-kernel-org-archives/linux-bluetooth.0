Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0E9C4320A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 07:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFAA60F92
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 07:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244522AbhH0HvW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244517AbhH0HvS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Aug 2021 03:51:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD8DC061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Aug 2021 00:50:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y34so12566301lfa.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Aug 2021 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEY85Ldy9LDPitZfZkqXGjLXGBmYluPWPqpRCafNvS0=;
        b=ZrYUytJq+RHRAtGeWw+tki5hSjTtJBd4CF9FKs5qNpQDIDxoYLk3hIu2ldVeMl1e4Z
         n/2szt1J6eWemmzPed25A4Yibhj5p+x5kOMrMrBkBnTPDTFfa1NyNJ+meHf14DG7lPt9
         gBv6NtfaPv2Tt85zeEp7l/Zr3fffyhxdDK3mp93t+TjxhKivXaGnR6R7U4x36N0VKcFe
         ZomDpyTlFGpmjgaBLNRr7RlNaxJrLGLdObf0XHurvtDYIfp9KF4WD9VZp+81fx6QHRrA
         4nGALAHUiBUvmSYR+01Te5u5rfC8qS36/LP3t+wPuCCqF4BrXp5tl6oF+BwaLRmBOhEI
         LDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEY85Ldy9LDPitZfZkqXGjLXGBmYluPWPqpRCafNvS0=;
        b=eQ/DgMCLYj/AH9avqEacTcN5Vpl2iYiCQupI1eAh3i48qH0UJGX4iwu2lSyNPEhyY8
         C9g0iuWLCl5VdRgSFa+hA83QaqDMWPUWR2Kf8gA4au5qkv7/VoicxdOdRT47TNsZEjgg
         ZVIvEAjXfnAIZ+ka4Sv2sYBGJdRcbPCny2LnfQsx5r1MqRGlCjofG9cMV7qXJ8oeftmP
         X+WjpDItXLBpkh1dtrmdtOMHSRLydZzQXoRijl8E412579dK+K79I22p9EQ4ICf61dgL
         5IUiZmqVpYUU95Cx2BC+i21+2HiaEHDCEe5EE6EFsvCHg4O3xCmq/anXK6vUiYJlxAfC
         OF4Q==
X-Gm-Message-State: AOAM5320FlKysjGPKN+Qg4xRMRho4ySz5GJDAkq927U22n+Kej3owQAo
        GiTgf71yLt0VL/0qf/ZGdiVVIivbqC6qtIGJzu84hSEA
X-Google-Smtp-Source: ABdhPJysjO5DgqxuS0MEWmACXzrN+RGlLBk2qJFSn4X1dR50DaObzprnziP1lvYuPWbxvb72KWVJO1oi8ZGyDqKCxzc=
X-Received: by 2002:a19:6a0c:: with SMTP id u12mr5840589lfu.657.1630050628218;
 Fri, 27 Aug 2021 00:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAEwN+MAuLad-9jh0fb7-ZDN6kSGORf7Rd1HffGV4VpThkP=Rng@mail.gmail.com>
 <105cf340892caf0014eb154335784d8c46b8eb6e.camel@intel.com>
In-Reply-To: <105cf340892caf0014eb154335784d8c46b8eb6e.camel@intel.com>
From:   Raul Piper <raulpblooper@gmail.com>
Date:   Fri, 27 Aug 2021 13:20:16 +0530
Message-ID: <CAEwN+MDpQ=+XgNjTfhHn8n9mbbqSn5iVLYm1kMRVcUDMY4h9fg@mail.gmail.com>
Subject: Re: Which tool to use for Mesh Testing
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

OK , Thanks Inga,
I will not use meshctl as of now based on this information.
So currently there is no  PB-GATT support in mesh-cfg client?

Regards,
R

On Fri, Aug 27, 2021 at 12:03 PM Stotland, Inga <inga.stotland@intel.com> wrote:
>
> Hi Raul,
>
> On Tue, 2021-08-24 at 23:40 +0530, Raul Piper wrote:
> > Hello ,
> > Which tool I can use for Ble Mesh testing, meshctl or gatt-mesh or
> > any
> > other ? I followed few mails and came to know meshctl is not fit for
> > use. Please advice.
> > I want to test both PB-ADV and PB-GATT.
> > Thanks in advance !
> > Regards,
> > Rp
>
> Please use tools/mesh-cfgclient to test with PB-ADV. You can use it to
> provision and configure mesh nodes.
> There is also a python-based tool: test/test-mesh that implements
> on/off model and could be provisioned as a mesh node using mesh-
> cfgclient.
>
> As for PB-GATT, meshctl would be the tool for that, BUT it hasn't been
> updated in a long while, and I don't expect it to be functional.
>
> Regards,
> Inga
