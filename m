Return-Path: <SRS0=h9/h=US=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67933C31E5B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F5A2187F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 16:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIuSX1k8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfFSQDY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:03:24 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:41750 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfFSQDY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jun 2019 12:03:24 -0400
Received: by mail-wr1-f43.google.com with SMTP id c2so3979094wrm.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2019 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=r4yG/ob6dMSszNPgQlvBj7Wk3E1lO3Bua5skK8fmqOA=;
        b=qIuSX1k8LIR+t+YZNBJncGR0gO7Cy8heJJPoIcsoezPuHjQQg8yfTLRVKIdWELTR60
         rk3io2LhD+zWK2ErPNnQpehkNWmtK++D+CDWqoq/Rpu3LciImKCFmIUcDRQxov5vySb9
         wEzDN2x7XWdnVzh+gLzdCtphZlW1cB/y+jSYCUqAgZ7GNyj0oYmZSsXeHD3HUfCExr9s
         0xo8GcDb2+gLKLo51ElwAfW/FwlWeX4XEkDB6esq6U5Rl3nOLmxjsialW2UoX53C8dS9
         8AUXUTxy3BEzHaI/L0A9RPfvLLMygIrvBjgsJ+1axnD4lUuSQT2QXxvVhMKorJQDjPtP
         zaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=r4yG/ob6dMSszNPgQlvBj7Wk3E1lO3Bua5skK8fmqOA=;
        b=uHiBJ9wdkR1f5K6aUaSio0uDv4LMsQw6JISc4HH5n5Wk/WWOYl2dG8pkdUgQqxiY4D
         cACqyVVKJ5RXKcFJLOPft4cz0Rs9VT4N8Bk7C3PZoYO/g1rDx7JVFAXmqNNThO31w0e0
         orrgPqU361qg3vm+fgl6vnv4uV3hAIV5scpAoIcEC5ONvK+V6znNIU4kify6w2pVvbFk
         2DyJ//WumoShOxFAvIHExhRKahJ8CUu5ulzP6kcbqISUTCTujkFyGwfWv2vAjQy7rtYe
         4PGk29mITteslOd5p0lZHvgG2GJXSh5IPwbs7Aey5C74GFH9IpEhF7mCxgfSloZUzM7E
         aGIQ==
X-Gm-Message-State: APjAAAVn5/v1tDtBo2yHLXZRH7xdJMllHfkHMc3Nukz7BzoAex+CtERR
        txoHHtEzMjcIJRzkNcjBhlqkVSZn
X-Google-Smtp-Source: APXvYqzkGpikEd8pNzPbVoxKmz20KlaHyWxZb+uYGzfTmLNm461fwqznfpVmkYXTu6hTdUDrADqTMg==
X-Received: by 2002:adf:f544:: with SMTP id j4mr16099494wrp.150.1560960202162;
        Wed, 19 Jun 2019 09:03:22 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id j18sm22669187wre.23.2019.06.19.09.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 09:03:20 -0700 (PDT)
Date:   Wed, 19 Jun 2019 18:03:20 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: bluez: avctp_connect_cb(): BT_IO_OPT_IMTU for omtu?
Message-ID: <20190619160320.kwumolq6sgetfuzf@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cmtstwqviymasn6t"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--cmtstwqviymasn6t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello, in bluez source code is function avctp_connect_cb() with
following code:

	bt_io_get(chan, &gerr,
			BT_IO_OPT_DEST, &address,
			BT_IO_OPT_IMTU, &imtu,
			BT_IO_OPT_IMTU, &omtu,
			BT_IO_OPT_INVALID);

Why is BT_IO_OPT_IMTU used for retrieving omtu? Should not be there
BT_IO_OPT_OMTU for retrieving omtu? Seems like a typo: imtu vs omtu.

Above code was introduced in commit b5666a3747 (AVCTP: Allocate memory
to hold incoming/outgoing PDUs).

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--cmtstwqviymasn6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXQpcxgAKCRCL8Mk9A+RD
Ule5AJsGqmEdaSdV0Qqjg8G3zuVkd0f6+QCgpedacxdI+BtnwkoOSHWHJJdpLjs=
=GTAs
-----END PGP SIGNATURE-----

--cmtstwqviymasn6t--
