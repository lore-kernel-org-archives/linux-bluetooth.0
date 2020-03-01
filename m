Return-Path: <SRS0=CJlv=4S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B342C3F2D4
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Mar 2020 08:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7328921D56
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Mar 2020 08:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOs+3+Mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgCAIi0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Mar 2020 03:38:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40112 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCAIi0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Mar 2020 03:38:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id t24so3833148pgj.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Mar 2020 00:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j7Icc8H9OXIphKDSZkaFmOOa+8mh1h1QtKYjalo4FjU=;
        b=ZOs+3+MkXYMpGjKMeuiy6fEGYW66CIRrndJBPokf4m0fm2ap96cCcnSgjYMmmHeuiC
         B7Z/kWR0EfRMMW/NJ9mc5++CPcZbqUau6wtWpzLH5L/X7Dc4lq365e3sTpck7aLjbRzZ
         cEyFbxJHPK9n7ialr3DNnh672sdjyOhlz3IZSqNdQj8eeRpSZibZienjud1i3H0a3tlO
         HxCr3TIGFWHglSMIlKB/ilj7B3+lDx1evWnxjA5C6fzdErnUPK1nwd+O7srw+X7Tc1GN
         ze7t0qgMhkhUzV0BXyfT0ZaK/T+Aa+wAxFcpnX6IXEQKriDUyUBETYEonZs9ulmIahUT
         9W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j7Icc8H9OXIphKDSZkaFmOOa+8mh1h1QtKYjalo4FjU=;
        b=fPywHU9ZqpprhJyOC76b+WhCsC3K/dRgFVlmL6+4S8c9lHDikeXZGWRTQ+SusCWXmN
         eiFOIAuBN5rJouX+ECOk6PdCdwS7cyCnktyQP0ZxJm7queUIBONdlOoFlqTXmAvLQLfC
         G0Y8FPLERRc8PrX37u5o7+LBPnQNqapopttJhpoTV8CGV43iq6lc9CmMHTjMWf1KPR+m
         iyt/XtrcnWEVSH8i23/UheMA3E7gKpQnmwihnjeQwEFSaC8goc4GF23Z1dtq6ByCa5xK
         Ne6TzNnogyzFGsqUqWbabjcY9wv7reszStgOrLS6saSzWxLuTBrELo56gO6JWy/s8Zsi
         hBFg==
X-Gm-Message-State: APjAAAVIxHn7aF1e01Jhf1sKyIjtNrOsowjizuQ9OG0VUnxWBM/ThSIg
        K1YUglBQ/AOx9/oF9Oe2bJ0R7Y1vlC71rA==
X-Google-Smtp-Source: APXvYqxrGjSjVi/iM3uvj5cO6QARqSgCO94D8tVu7WND6k8rcvBlz5+nywVODp6hjP5bQp3mi+GFig==
X-Received: by 2002:a63:d0b:: with SMTP id c11mr12950911pgl.296.1583051905148;
        Sun, 01 Mar 2020 00:38:25 -0800 (PST)
Received: from agalan1-mobl.ger.corp.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id a9sm16447929pfo.35.2020.03.01.00.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2020 00:38:24 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v1] bluetooth: guard against controllers sending zero'd
 events
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <14FD24FA-1455-4FE4-832B-9851D9E22780@holtmann.org>
Date:   Sun, 1 Mar 2020 10:38:20 +0200
Cc:     Alain Michaud <alainm@chromium.org>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A417E313-0ABE-46D6-92CD-434DDCC2D573@gmail.com>
References: <20200228205146.161229-1-alainm@chromium.org>
 <788439D3-E0CC-4CBA-99C2-0B9C3703B23D@holtmann.org>
 <C59D3CDE-0EA8-4839-A34E-5ADA1BDE4949@gmail.com>
 <14FD24FA-1455-4FE4-832B-9851D9E22780@holtmann.org>
To:     Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On 1. Mar 2020, at 4.44, Marcel Holtmann <marcel@holtmann.org> wrote:
>>> Why are you bothering to check for event here. Do we have requests =
set with hci_req.event =3D=3D 0?
>>=20
>> If I remember right, most requests are like that. req.event is only =
used then the request completes in something else than a command =
complete/status.
>=20
> so what do we do then if we get an event =3D=3D 0 from the controller? =
Just bail out early? It seems kind pointless to keep processing it.

Yeah, that=E2=80=99s what I=E2=80=99d do. Bail out early, but log a =
warning.

Johan=
