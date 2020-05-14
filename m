Return-Path: <SRS0=kgXe=64=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6200C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 May 2020 17:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77CD62065D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 May 2020 17:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4vjDaxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgENRrQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 May 2020 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725965AbgENRrQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 May 2020 13:47:16 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44C4C061A0C
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2020 10:47:15 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id c12so24295133oic.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2020 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RK+vPSyT4MaOt6wYORPOotAUU865qNrGNdClhmtjoZU=;
        b=q4vjDaxfEzwVgGNfndDW6XOsRUfc++ffjf6m4zLLKUhd4panvIWBhM/sFv+mHAVMsj
         lqyfXDai5iqFaEx3pkgZTwnQkjQY18N3Na7NilO7svx4hbWxM/u3Me39Kkvi0VpRE8mE
         hKT97MqChqdMmLYeAxHQvCcXEwmIkpa5G2Eu4bTPPP/+MUcGpuJRez+ymRqO1XG2QHo3
         azqHf44YgjlEQ6hI7qoZ55qUMr92FEesqeAz4hyG+cCKpIrcKBD5k09bgykbnOoDHRm4
         C8ho5Vx5jR0ne1xiLLbSUN/sOWsIxphVFsDgsbFdijD9bzAZ7y58obrSPxrD1ztlcqE1
         vHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RK+vPSyT4MaOt6wYORPOotAUU865qNrGNdClhmtjoZU=;
        b=jEcC/kDfY8FFPJpbcWqvJwRrxT9yJFOOpx4yQSYajzUoBk+VMgv2FX9Ny8ezerjttF
         H2V9UcR67v9KTxp8aNUlMnN1EGPr1kg8YdhbrVCNZ31JzKGv+NnBBRfvsj5/f6mDaNdp
         0IYAI6MFvSw+AZQ2EgoOZDPiH+HtZBAIC+ZJA5C6yLNy/EemZ3dxroL6ECqU052QazTC
         YS+kWSdzjTrUjo34kpNCAwddWe8IWoHOdPH3UZckVzdllpC6mi1I8rABCHKxvs3ZuVz+
         9BH2tpnARCzl3DOUjycfLDFuTR/7MfsnD8Ar8iYOrmzhX/eCMugXKCbH3Jy5qVfuiUf+
         CAmQ==
X-Gm-Message-State: AGi0PuZFVc6SgqJZj4SwDE3JC0oL0ETbYjAYpkTsi3T8U1E7YTrwzjun
        pJDvABLFEgsReg1yJp45giId8Fu3iR0jQZdT+pr2Fw==
X-Google-Smtp-Source: APiQypJoR6MpNm2DC2aXtJ1C8Jgj4RSxVdcrlLwlZTdGRe9x0N9Yg2YcUe/V054gk76gIOxXKl4fYxQDa4pcdeHu1/Y=
X-Received: by 2002:aca:b5d5:: with SMTP id e204mr31998940oif.108.1589478435111;
 Thu, 14 May 2020 10:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAOVXEJL_zq0_-KTh2HEBT1VvSCCkuwdecXLaEGFquMi30oH6Eg@mail.gmail.com>
In-Reply-To: <CAOVXEJL_zq0_-KTh2HEBT1VvSCCkuwdecXLaEGFquMi30oH6Eg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 14 May 2020 10:47:03 -0700
Message-ID: <CABBYNZLVKHVbHXc5=uem1JtKa=eSBi=nc92eaKWgT-kCWj552Q@mail.gmail.com>
Subject: Re: OPP File Transfer From Settings always uses L2cap Conf as
 BASIC_MODE- OS: Ubuntu 18.04
To:     Sathish Narasimman <nsathish41@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Wed, May 13, 2020 at 12:14 AM Sathish Narasimman
<nsathish41@gmail.com> wrote:
>
> Hi
>
> In Ubuntu when trying to do OPP File transfer using Bluetooth settings
> the L2cap Configuration  uses BASIC_MODE
>
> whereas obexctl it is using ERTM_MODE mode.
>
> Once the initial connection made from obexctl.later any transfer of
> files from setting UI also used ERTM mode.
>
> How to change the MODE to ERTM for the transfer of file using settings?

Is ubuntu setting really using obexd? Or perhaps they are setting a
Channel on CreateSession which is then forcing to use RFCOMM instead
of L2CAP ERTM, when you use obexctl and don't set any Channel it will
attempt to discover the record using SDP and if there is an entry for
L2CAP channel it will use to connect using ERTM.

-- 
Luiz Augusto von Dentz
