Return-Path: <SRS0=xgU7=QE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6CBC282C8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 12:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A9221738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 12:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bY7dl0IV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfA1Mwm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:52:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42969 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1Mwm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jan 2019 07:52:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id v23so14477116otk.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jan 2019 04:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9caOK/Y9ME1arUfFowe5pXFEDVKJuF/cp6kYNZuYAWw=;
        b=bY7dl0IVRk1uAnXeG+QJkiwsbclEJJpEvACruss7iC0ZxasXFMQrxar9tezr2lo2Rz
         nSiLqbLjaDq4ZaDY7BdquobYBCxm5YL0XtCdgw8YN37EVCNxThetfv28Z356MToemghh
         XcOQzSnGvLknobu4LoW3zYqRMFLvrCxyM7zi2wPKQehfHcbGDTv0YIvhQuRX50bkOA8Q
         px+ZmPJDU0aU215GP4rBF5vcL8WCLy08sSJ4BalbSBnVSyRhaxX2T3xhkAI7UfZe2gJi
         7ICE2hlRmGLMbKm7e8Wfpl2597GUcVOLrSPHwjNvNRnajMl3Awq73hYDfuWx+0epp/7s
         xzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9caOK/Y9ME1arUfFowe5pXFEDVKJuF/cp6kYNZuYAWw=;
        b=oNEAFY+KPzZFbCKHWawZmJ5hdOqbSv5u4cG75g/LzXOITBJsiVbPCZay/0GKG2lOV5
         7tvR6zX3rhfvDcQhH6Yq99zxMXZcfpdihIibT4XD/dLG/lfIZX+3xoz5P6hDwcJ29BAy
         wMFAdQxo54hB5/D/Kv230P8dTrV2l4KoDsoPseIFk4te87RYCrkKYGWtghY9OnbnTXxx
         XAPQ0YL3SZlKtGXZr/EBYep/wTeVlMr0xFzuV94IY7fe7nM17w84ZwdJ++893ieHPwS9
         V9L3yJxWIVk6r16KhZQr2FGu3nteL/3yfEp8kDLIm4gpeXjd3r+kOLeKXE7nxA3OImqx
         SERQ==
X-Gm-Message-State: AJcUukcAuXq0LMLWB7wgG2iHmk8ppMFmL6lXKLjCWEjpDnChjAUkDo/4
        AwzB4c8oJNNShCOKCa2dB8+WhbzpEDPR0XOf708=
X-Google-Smtp-Source: ALg8bN7Upp3wksJVrVQ0I44zuN/B1OAIkHwyy33tgHzchf64pud/7BKD2SeYppgDOrx3s7Lpmd0W7hF/d1kgAOlNg+k=
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr16403181otf.242.1548679961980;
 Mon, 28 Jan 2019 04:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20190127115646.5814-1-zimmermach@gmail.com> <D0326ED7-4865-4922-AC04-475FB0A9F213@holtmann.org>
In-Reply-To: <D0326ED7-4865-4922-AC04-475FB0A9F213@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 28 Jan 2019 14:52:29 +0200
Message-ID: <CABBYNZJUO4edeKfOF5LBPD3BAPsDCfBLpxqJyCnsAAt9O+7Drg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/2] Added config conversion tool
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Christian Zimmermann <zimmermach@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,
On Mon, Jan 28, 2019 at 2:24 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Christian,
>
> > Added a config conversion tool for Bluez4 config, instead of doing the conversion in adapter.c
> >
> > Christian Zimmermann (2):
> >  Renamed Bluez4 config read functions
> >  Added config converter for Bluez4 config conversion
>
> so what is the intention here. I was going to just remove any 4.x support and more to BlueZ 6.0 soon. Actually BlueZ 5.x has been release over 6 years ago. I have pretty much zero interest in carrying / maintaining anything for BlueZ 4.x support.

These are just tools for converting the config options, I guess it is
nice to keep them somewhere even if have long stop support 4.x APIs so
that if there is anyone switching from 4.x it has some means to update
the storage.

-- 
Luiz Augusto von Dentz
