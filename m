Return-Path: <SRS0=Ssic=SK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A869DC282CE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 09:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783B120880
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 09:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRMG9wWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfDHJry (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:47:54 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38839 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfDHJrx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Apr 2019 05:47:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id a6so9992151oie.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2019 02:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90v9QmyHB2Ukb3VY38rQrtqE39xqK7XQuoTuIgGFdM0=;
        b=rRMG9wWR9RRyDuJHtZFQDoB8Lkki4qRRxLOTLObSyYRREFgQ25JbfXtmjnH5IEbPsn
         e6PvHMMbkVx/m3Za/HYBSz4y0BEt5pc6ZcA3PWjxtypXJGKUux5Q7iyTpYphqa1mSeNs
         6x+qPqMdYYf/G+sm6gavtKxbQhP5FLbRROeQWKI/tTVRHUc/A/oCZTntfmXRRQSs1vbG
         pKqsUsYOUF///Krd0fzxXngTEZDzSF9T+70CDYsJU6LLIoeFqSTYd3lmqC5zOwCVQpxC
         CBmSi7GRK8usfOABIReXwdASg9FjyJG64wLDLy4uKf8ZqyunorG6IcAseZy8fq2WlQaT
         5OKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90v9QmyHB2Ukb3VY38rQrtqE39xqK7XQuoTuIgGFdM0=;
        b=rsVal7ZbYDwBO8qREl1KEmhbUkwLlQrq7iijFJFz/4S47jVbMJVDhT1/h1t1EE1ojG
         bBGu0Oj7DEnu7YbNRtONkyW+UYkfLlSZ2ekdyKupnQ9ACar4JCBgnHODHuupdcBu+Dvi
         iEFDfgveqI3TTnGRuqziIT0Zb8qhfAQRkFcv8HUO4ULWz5MHunyXXF/9ESaQzVFIyLcX
         qgn3k16qdTnsMzRAh6/3qPqLEUDYvQqdo/HBXVkNQX5pl659QHGTaeJHTLdjicBZLdvt
         xToBUGMhXurY6C330Hp7wdsYWvSJbrbqQ0MWEIpIn8EKvsDzAt7CGkLaAG4etrUweGSN
         e/oQ==
X-Gm-Message-State: APjAAAVcLqpNNiesFOYea35bsL24youpWLxQXmgRal35AkJpHkETUIbb
        ofCbUGKcoEJ90kFU0BrknAHmi1+yESzscT8GnqBYHHYX
X-Google-Smtp-Source: APXvYqy0/P/CkrRMreBcshU64lTsKYlth5FF8wamTGo0L/beP+a+h/7IGNtDVuyo8ZoqHqkx87mCNIa4/Sa6e+ApOU8=
X-Received: by 2002:aca:adc8:: with SMTP id w191mr15609249oie.110.1554716873130;
 Mon, 08 Apr 2019 02:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190122134524.20509-1-luiz.dentz@gmail.com> <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali> <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
 <20190405164713.cvfciulxnby25o3g@pali> <CABBYNZJQvOODiwVcNrDPH7A+5qTM0ZmSHaZ8=+=32CeH1t482A@mail.gmail.com>
In-Reply-To: <CABBYNZJQvOODiwVcNrDPH7A+5qTM0ZmSHaZ8=+=32CeH1t482A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Apr 2019 12:47:40 +0300
Message-ID: <CABBYNZJCOnudwGi6Km=m2SWSvV8v_zz3_Pd-+-ek9H785J4BkQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Mon, Apr 8, 2019 at 12:41 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> > $ qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1 org.bluez.MediaEndpoint1.UUID
> > 0000110a-0000-1000-8000-00805f9b34fb
> >
> > $ qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep2 org.bluez.MediaEndpoint1.UUID
> > 0000110a-0000-1000-8000-00805f9b34fb

Btw, 110a is a remote source I wonder if why you were saying they were
sinks? Or you were referring to the local role?

> > So this is a clear bug.
>
> I will send a fix shortly.
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
