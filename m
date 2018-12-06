Return-Path: <SRS0=vk22=OP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499A7C04EB8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Dec 2018 09:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E5E20892
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Dec 2018 09:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtqAt8Sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E5E20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeLFJST (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:18:19 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:44089 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeLFJST (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Dec 2018 04:18:19 -0500
Received: by mail-lj1-f172.google.com with SMTP id k19-v6so20973395lji.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Dec 2018 01:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OQ3t84dKnQ6B/RyERUTE1tKi0/46k3d4I8jDBoO572U=;
        b=TtqAt8Sz5DX/njQbu9yqrFUbAO8WCvH/LikKREYpOurgQ7li0u2aDPKVuR4AmEh9JS
         oIbAp7jouJcWJk0+YTUvX9pt+IpNkAjK3xDxYKM6p2thSpfP8rnvhOJkbRbH1ySGbGfK
         BZmT4QPM3dOBTPkzFhWYOtgxrshOcv26d4mzkwkHttar6z57EY34tUd1NKhQfh4/LHCG
         M7HVcaX3J0PvqujIG5vflLgyIFyDcru84iF3875Kymk8WoHr+VizcxStEoEsYi9Fvq3P
         NW/qBHo6H9VSEm/LXZTd9ljhyc08xIaLLIQzXhlMNvoMOoelQac1QMvyohM8SonQBJcl
         p/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OQ3t84dKnQ6B/RyERUTE1tKi0/46k3d4I8jDBoO572U=;
        b=FRxSLDKQWQlKX6Mp2W1KaFBAy6CWVP0naLcaXu9pfI+u5n2+w+tpGBSV9qe4M1mde4
         3WD6vZuf18+fYZ1zh/OcOTTrMqFZIxb1qEVUHUFDOmUm4nMkSD+2okFMPUWA8eBoQZsM
         YD0lg0vuNwPq6oeacToIjsKRvHMmrtyEKSq77Jg9mqUAvNlklWorpg400MPLAU6P+9VQ
         fpdPduMyr4a9nNun/22C3YoSwD6XVmz4UiDSUGuueQrQsb+ldjaDx2FDnpC6SF51aZSn
         6emI4Zw9EgLmOTkagay4n7/NdAVVJELGK4pCavh9I74DlagKfLMTJW0IWTQjBNp+uut+
         OTcg==
X-Gm-Message-State: AA+aEWapsaR6c+qZayoB4FQIemtuS6XAfuGVGo6Iaq/W5a0FjFjDkBzw
        TWDpQUOj8DyFQZtXtu6M/7Q=
X-Google-Smtp-Source: AFSGD/UZrXJwa+Pr02Qwj/M1gC1GH5yunJ2K0jKVSAgJOoVM85ITZjrrSE6HdTDzRC5AeUw4Y3SOpg==
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr17335697ljb.11.1544087896909;
        Thu, 06 Dec 2018 01:18:16 -0800 (PST)
Received: from jhedberg-mac01.home (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id p77-v6sm4654092lja.0.2018.12.06.01.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 01:18:15 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: ELL changes breaking BlueZ tip?
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <E2B14DEE-C3A1-435F-AEAF-ACBE239B76B8@holtmann.org>
Date:   Thu, 6 Dec 2018 11:18:14 +0200
Cc:     Brian Gix <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Von Dentz <luiz.dentz@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A17A357-6C9F-4632-B9D2-3132EC379EF6@gmail.com>
References: <DEBB0CAA2616974FAE35E4B560B9A4375C13D7A5@ORSMSX103.amr.corp.intel.com>
 <E2B14DEE-C3A1-435F-AEAF-ACBE239B76B8@holtmann.org>
To:     Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> On 6 Dec 2018, at 10.19, Marcel Holtmann <marcel@holtmann.org> wrote:
>> I am getting significant compile errors trying to build bluez on the =
master tip today, that seem to be related to new ELL external v internal =
changes?
>>=20
>> Build environment: vanilla Fedora 28 with ELL version 0.15 installed
>>=20
>>=20
>> It starts out by complaining that there is no rule to build:
>> ell/util.c
>=20
> please re-run ./bootstrap-configure and I would urge to use the =
internal ELL following the description in README. Mind you that only =
internal ELL related files are linked and build when either =
--enable-mesh or --enable-btpclient is selected.

./bootstrap-configure && make does=E2=80=99t work for me either:

  CC       ell/util.lo
ell/util.c:27: error: "_GNU_SOURCE" redefined [-Werror]
 #define _GNU_SOURCE
=20
In file included from ell/util.c:24:
./config.h:97: note: this is the location of the previous definition
 # define _GNU_SOURCE 1


Johan=
