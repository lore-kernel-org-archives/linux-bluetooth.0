Return-Path: <SRS0=m/C2=4G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291B6C34026
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 10:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72F3206E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 10:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O75ejVhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgBRKpj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 05:45:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46666 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgBRKpj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 05:45:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id k29so10445213pfp.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2020 02:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F1ItWjQhF+/11m9WN4S4GXuMgCteaBNiTCdfg1bi7K4=;
        b=O75ejVhEube5w/pSVnZ7qJ1iq/TfjA1xrMP4ijuch2+BUaemE25WWcAyo31RyNW7ug
         UWaYjegniFFu4e3Cck+rTtEyMrFdmVYDhhbphK4tsy2IEhAE0HB59M5E3tSlZe+5d1fw
         ZJ3zmflgGq//MZreGZ0b8VM12FwZs5ZSR7a3AYcOAumysG9VhxKNfx8ztl3rrYuf6fxL
         MIhvjnwdGtQhvDmGF9l50gJ3wjSKtKRu2pvJEpo2eo0gu0/P3zcZvSyDFjV95n4QpFs+
         pr2oVtf4xjT3RQxtKHDMrfA6s7fS8QGLaejuuy0E5cQaWLTCT7nM4aW02ic5H/dBDSZ5
         8QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=F1ItWjQhF+/11m9WN4S4GXuMgCteaBNiTCdfg1bi7K4=;
        b=Yb08muHPsIhMtv/d2Dwe717rBaw++0wgjuvAVh1dpVDAxQ12XpPWs6qx0/P5d1SeZU
         tMqzjwEcjv5ZySjUEugGx92jqe2cGaMljouKB/CoXFoGQrvvzHDiZVgQXhjUc209ZIAl
         3doaq7EvdwvaWjn929p+O8ThA5BGF2TnkLLFZkCXiv1wGCSkpicNMzS9xVndosE3T2vf
         eQX6gl1QC5t27g3uQPYWdzmxEKdT2PUSnMzgju79hOncONYdoA8fqOTHIlIX1p5dXiTa
         iPtyJLvTsXIGOCSADWH2m7rhfKYGejN4Ie0tYdqxGfEa9Iua0jMdaNXQmjGx/Eh1UBNY
         0dTw==
X-Gm-Message-State: APjAAAUorA1JecTiO+L0z+PSoJauVAlzNXm+h6EOIIdy4DjrcVFwsQXY
        T4py0PnVO1WgdcmzrsaBdphlTTDiuT4=
X-Google-Smtp-Source: APXvYqwbITMSqLzdG/GnpjOf61NqZboMZ/B22JXdeoOxNbFdloVRTe6StXCN2mhkwaWMoPqzUiicog==
X-Received: by 2002:a62:be0a:: with SMTP id l10mr21793441pff.110.1582022738628;
        Tue, 18 Feb 2020 02:45:38 -0800 (PST)
Received: from localhost ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id w25sm3754027pfi.106.2020.02.18.02.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 02:45:37 -0800 (PST)
Date:   Tue, 18 Feb 2020 12:45:33 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_h5: Move variable into local scope
Message-ID: <20200218104533.GA46714@jhedberg-mac01.local>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20200218082858.42994-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218082858.42994-1-marcel@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Feb 18, 2020, Marcel Holtmann wrote:
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_h5.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to bluetooth-next. I went and added a short body to the commit
message as well, since I think we generally require that for kernel
commits.

Johan
