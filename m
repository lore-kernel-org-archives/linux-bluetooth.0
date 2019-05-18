Return-Path: <SRS0=UGHn=TS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB77CC04E87
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 19:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970102087E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 19:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksdN6yy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfERTGX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 May 2019 15:06:23 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:52319 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbfERTGW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 May 2019 15:06:22 -0400
Received: by mail-wm1-f42.google.com with SMTP id y3so9696252wmm.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 May 2019 12:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PmDFEOBVKjd87tIHpVoROazU3lNCjRhbPwqskXYO4wM=;
        b=ksdN6yy4HFGaKu88Xt4uJUTBodXrR+8H2yNDjKYz0x190VAAdo+9q5wpzs/CPY88bH
         dj79LP8lvdEfvC562sqcltIEwLElFTO0lsMX5QxOJ0WmBy3wly3Bea52HjOdpSKTi6ti
         YEMAXLbame6nWDlvndUExO+4yWD+uBG1L6bOBcDXc0O1k93YO5FARlp7J5IGeQqsryV3
         qmgy9u5v11lrZU2/3vj/3yKiGv64RcEfTD+CoKpV7ltLq1rrBafwIAFienm/+0Or//JN
         qhwTydfYwH92A5n9Xzy3DKeK2ZB+6GlxQmrmRtRYA26xv+Ve7Mru/gBDS0qPBDb8aACk
         VoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PmDFEOBVKjd87tIHpVoROazU3lNCjRhbPwqskXYO4wM=;
        b=gjjonvAF44FofHa6+01lHfRDo+9j1qu7OLA5VnQTD8gygHr03f/m8AnewkEkBCi8Cu
         0XKzou+h/ZqIeM6C416ox2fkw6lKUO04bY6jeZFyM3i4cCfI67CuU2qGXW6PJTjPEf0h
         LSaJwYDl6hruX4VcW2C4dYnnKIod11lKrWF2uFZxCnysEPSDYNmfLFE30PyZOrGiekNW
         fkprWBCcAihucKb+cRcppEoC+jCYelWuXIHMqzzEoQyNLWfaNmhy7/8KgPKKuLKa02yW
         K0BCKLaSuHkW5CthiyDaQ7VO5DSCEXf3aFywQX+Lyyt0nv/CHEnt9mhxKfVLPZ0X5t3v
         uXhw==
X-Gm-Message-State: APjAAAV7/CcP9SA2HZMkPbRsjzJte2g12YYz5UarZaAEuhU+g0ZT8n5b
        PqvvUw+e12YID/QRAE5eSoysXFIG
X-Google-Smtp-Source: APXvYqxJA2Ukm6otMpxl6git6pOA0DTjT6D3yW1nfC/8SMrduD5lEJvPuU+wnbcUk1ZO0XuOypGFLw==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr34620497wmj.37.1558206380362;
        Sat, 18 May 2019 12:06:20 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t66sm3880033wmf.39.2019.05.18.12.06.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 12:06:19 -0700 (PDT)
Date:   Sat, 18 May 2019 21:06:18 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: bluez A2DP socket reliability
Message-ID: <20190518190618.m7rdkthvpz4agxd2@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="psaodpszjehs5iy6"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--psaodpszjehs5iy6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello! How is L2CAP layer of bluetooth socket used for A2DP audio
transfer configured in bluez? It is reliable with big/infinite
retransmit count? Or in best-effort manner and some packets may be
dropped? And it is possible to change between these two modes for
application which uses bluez DBUS API? I'm asking because some A2DP
audio codecs are designed to deal with packet loss and for those codecs
it would be probably better to configure L2CAP socket to unreliable
mode.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--psaodpszjehs5iy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXOBXqAAKCRCL8Mk9A+RD
Uo4GAJ4z3+FdeN/as9UCloYpW++345H3EQCgyCTg77To6zGsvGBn2Qf/63XdIfs=
=X5/0
-----END PGP SIGNATURE-----

--psaodpszjehs5iy6--
