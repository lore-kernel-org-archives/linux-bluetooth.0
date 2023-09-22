Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3218CD4F49
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Sep 2023 10:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjIVKGD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Sep 2023 06:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjIVKGD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Sep 2023 06:06:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26B98F
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 03:05:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c328b53aeaso17045455ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 03:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orcam.com; s=google; t=1695377156; x=1695981956; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9J33lH94QtvPkB+U8Op8ioYJqL6rZGiBxLVupCpDATM=;
        b=HXbxAjU/r/H1jkLHmpNbdsmtDTL0GQPENCGUf2GfuKtdl9f/6c58r+O1gQsYTpog5L
         dVxbTWz7hGRKeoiaSxjAX7dc7SbNSfCT7+ms7JLNOnu0SxUJkZkFH/kBcdTFR+XYoIPN
         coXFs0AkCVITzGnG4qYE+PSDmqeek9lkTpnEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695377156; x=1695981956;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9J33lH94QtvPkB+U8Op8ioYJqL6rZGiBxLVupCpDATM=;
        b=R2Dv61BJywTQ3gfpUcBUS6R2QYQRPqsDiXT9O6nhmWBOKsqKy393zvFvPSJ5BiYBXu
         zDu/tiO677N3c1RGEHsLePJmKJuXzwFWE6c1+rEYlb4MX7VJIGkZxwFho/gJZHl9H/Uu
         Egh2ibQKvcHil1meBB8HK4ExKKKMyiDUkj8kwXO/8GPue19/yxSdtd/OplIEh+NO70te
         BW5f/0/o07nHxFULzR3OrVnZbCsP01tFmdMgIqmYBUBFr1fRzGrq/B/Ng2TGo/Pet5MA
         ghrgwT+uZLquVGpPp8RqHsUgURPZPmkQ8AJKFvH9UHkAhHjHnj/vYtaVN0fBpG3Lh3To
         l4gA==
X-Gm-Message-State: AOJu0YxSnY5upXw7qjUlojrDf6rHAPLdt3qdpp14svf6wG9H62EqBf+/
        ZP27CgWbg2Dv2OFb0aAO1Ad3N9jYLrBVhqnFVPVQ3vrfNsYS37r/ibQ=
X-Google-Smtp-Source: AGHT+IEAIM7MmInwc29GRUxIswq/gX7qGT8Doy1FhOJ5qQvKr38oqV0EcXTxo86olbHsLZoaxWRZVCNmp9z+st5GNcU=
X-Received: by 2002:a17:90a:4f0b:b0:267:ffcf:e9e3 with SMTP id
 p11-20020a17090a4f0b00b00267ffcfe9e3mr7981235pjh.46.1695377156087; Fri, 22
 Sep 2023 03:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAB+bgRZvEeGhuqBQ0cf5sFggQZNQ+dsFB4V1HCMGw6JHsDJVMg@mail.gmail.com>
In-Reply-To: <CAB+bgRZvEeGhuqBQ0cf5sFggQZNQ+dsFB4V1HCMGw6JHsDJVMg@mail.gmail.com>
From:   Ordit Gross <ordit.gross@orcam.com>
Date:   Fri, 22 Sep 2023 13:05:45 +0300
Message-ID: <CAB+bgRbEEB2Hv9uw3LOAGsMKRg2tKW7T+W=T9X1LGcaTBhhSnQ@mail.gmail.com>
Subject: Re: running gatt over classic server
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hi,
any chance someone can give me a hint?
thanks!


On Thu, Sep 14, 2023 at 8:13=E2=80=AFPM Ordit Gross <ordit.gross@orcam.com>=
 wrote:
>
> hi,
> I'm trying to run btgatt-server over bluetooth classic.
> I've configured in mgmt: le off, connectable on, discoverable on.
> ./btgatt-server -r
> I attempt to connect via ios bluetooth settings.
> The test does not detect connection being done (even though hci show a
> successful connection) and looking in hcidump I see discovery of gatt
> and gap only and not of heart rate service.
>
> I'm probably missing something very basic..
> Can you please help?
>
> ** running the python test works well, namely heart-rate service is seen.
> ** using bluez v5.64
>
> thanks in advance!
