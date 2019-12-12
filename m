Return-Path: <SRS0=nb/8=2C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1181FC43603
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Dec 2019 19:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D445B2077B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Dec 2019 19:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICcoXaDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfLLTmk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:42:40 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38279 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbfLLTmk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Dec 2019 14:42:40 -0500
Received: by mail-oi1-f181.google.com with SMTP id b8so48275oiy.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2019 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ERSMqcibMxptl0RXbVKHjBBSQv4a0uL2b7vbDi1G/KE=;
        b=ICcoXaDH5xdecSRGNBqQ/rFMgzlp5dV64XMNUOVR6gidUIKxm4POrUqYWblMZn9nhJ
         uIT6AiF973xegdajU0yA7q+TGFhxjLH5hEsRREUxO2XfQT00rHLQ0fcrFEGcE1gDkyyW
         kOY78OFG1IVXawTYAdruJNNssK0QLpiRQJbHUgaaFtMtPfAQU52IghIfbLjRhW4h6JfB
         +2+OE49NrHiH2m5dO5lt8yKZDhDZrnQPYHSGPfkqD2t6buaC0SBDyKqKXIjU3b2fXGdl
         nI/OChlOjWtUfWJx+T1uJ7vLlA2cQb/XHmi9V/Pp6G0DdEHYNwAGemjLYJaVUWzwZvNZ
         yc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ERSMqcibMxptl0RXbVKHjBBSQv4a0uL2b7vbDi1G/KE=;
        b=U9UIgWifIKOrMoxfv7lCH5KyEomFtC2dyCuRE/VErOJpvD+A/uZ0qz0bkCVx6DKhWC
         Rbb09peMyIoie0KOmtkxurapAkypgN1McZ8vcs4GHBEpoLuTlHVNdjugDLxx5ovvwl/Y
         syzWdQQNqxt3g8UfI6wouXj/v5vD5BOlZS7osjqk4EUeKWeuYteRCdmHBPi45GACAABJ
         275UueTet1HrkwQ7vt/6BgES3Z4Qn4VYHz9Lz5E/P6EJ1uo43dt/qBh0c6ROM+GKfwUa
         hQ0CbnGZEVCAZIievdngLFxPNtiUql4e4GEVt4JM8MBF3OPlUW7LauOtqrC0rOqwmrtD
         GEPA==
X-Gm-Message-State: APjAAAVTkgzCAW2QSRZ0gV/JggA8syJaLICCnuM0MbL0HlPJyVRWDNGH
        mNJt+ZbHiEAhyES6CBf+/xap8pS3LBPRRENSIgb2eqHo
X-Google-Smtp-Source: APXvYqwxnBf993T+EkqEk1WRJHpCUUkw0itSVMvQ6O5Y1jtH0vSYyWxThigyMKEmey5Rx+5kmQxlF76qb++QHWE/uLI=
X-Received: by 2002:a54:4f8e:: with SMTP id g14mr5831567oiy.8.1576179759195;
 Thu, 12 Dec 2019 11:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20191212172944.hgt6se2qz2hpsbo2@pali>
In-Reply-To: <20191212172944.hgt6se2qz2hpsbo2@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 12 Dec 2019 21:42:27 +0200
Message-ID: <CABBYNZKCovNDcAaMMeYZgKAAq-8oz+pcs6xmS3A_Qt-28aoEbQ@mail.gmail.com>
Subject: Re: bluez: Export SDP "Remote audio volume control" item for HSP profile
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Thu, Dec 12, 2019 at 7:31 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> Hello!
>
> According to HSP 1.2 specification, section 4.7 Remote Audio Volume
> Control, Support for remote audio volume control is optional, so an
> implementation may support none, either, or both of the controls for
> microphone volume and speaker volume.
>
> According to HSP 1.2 specification, section 5.3 SDP Interoperability
> Requirements, bluetooth device with HSP profile announce via SDP "Remote
> audio volume control" field information if device itself supports volume
> control.
>
> But currently I did not found any way how to access "Remote audio volume
> control" SDP field in (pulseaudio) application as bluez does not export
> it.
>
> Can you please export this field? E.g. for HFP profile all optional
> features from SDP are passed to NewConnection() DBus method via
> fd_properties dictionary under Features key. Could you export that
> "Remote audio volume control" bit for HSP profile in Features key?
>
> And in same way, this needs to be handled also in RegisterProfile() DBus
> method.

Do you have a use case in mind?

--=20
Luiz Augusto von Dentz
