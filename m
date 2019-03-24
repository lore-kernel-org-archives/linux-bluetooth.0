Return-Path: <SRS0=QAi9=R3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6C8C43381
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Mar 2019 14:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0630222EA
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Mar 2019 14:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDLKG6y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfCXOVC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Mar 2019 10:21:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38413 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXOVC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Mar 2019 10:21:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so7210677wrm.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Mar 2019 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ngYpErWc3QzKL7pvp9OssJXM6Ug5Y/Mj+S/VhE4ebl0=;
        b=dDLKG6y7hJ/BZLZpFucZVpen9x88fM49q77Gasd+82QGLvizaX45Y8CnZTLCXsQ6Yt
         ZLhfbYn84Rq3rI5wa2chq5E3n8MoCCpUeA0f/FPvYXtxUsJDwYJxIheaPGtuBZd5KHFZ
         CHjZstg7VCJRm/G7FzXzQK7WkVM4zpy5AGzh/lKwWxVYytXWlKdVARjMmB8x0hQtK2xV
         duItgwYAeNSqv/c/nru0JVW4rwT11pLjIGv/O8M/HxmAQ66JVR0HXOoKXrSCoru3Pjsk
         NyMKJXuQ+smNObsD99aRN52DG3ESKjv7O45y6LiacA7frB4Rz2XZbevBl32a6gcOn93D
         D79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ngYpErWc3QzKL7pvp9OssJXM6Ug5Y/Mj+S/VhE4ebl0=;
        b=T2PkoSpjgaP9IDlyg+85ipE88pN90f0M01f7nmoRLxJkA2E9SBjo1vX4eR7SHrx+aQ
         Tj/ZGWSn3cip+Y7hMTmgUT2m3ZEk1llw1Ur3ayAvkpPsat/FyaNZXSTReLOKl/1w8/57
         B7ubz1MfWJsGOLXYF+XnptkLJI1M2gQmlMN1Mu41lpTtM5SBauEhBmg1UZFbn2Qs90uD
         wgPs19IO+LemU1yI28TIU+Px36A6+qaQFOEtZ13xqVTkkyY9UIYBi8NHWV8uJaryfXiU
         mc73fdVQ+p70O1chK65IYVYt52VumMWmX3Wl6+RzpFnSoGHFrF1NGKCnHSudvd6igfNU
         Qr3w==
X-Gm-Message-State: APjAAAWw1u4kVhpdCrj8K9ASA23qGY91+6ytEBDC85gzm9bmnOOilAqt
        QlUbuKFk5qnmlvZ3I4qhDEGCA8Sd
X-Google-Smtp-Source: APXvYqwzZ8pz8esOc/sTwCmcBj9Pj82Q91uDIGDZszKUdjvvDeIJuQzH+CyvjcnfdvmaKV293lAWEQ==
X-Received: by 2002:adf:a10b:: with SMTP id o11mr12125377wro.91.1553437260457;
        Sun, 24 Mar 2019 07:21:00 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id g8sm30406837wro.77.2019.03.24.07.20.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 07:20:59 -0700 (PDT)
Date:   Sun, 24 Mar 2019 15:20:58 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: bluez: install a2dp-codecs.h file
Message-ID: <20190324142058.neuunjf46lgwcrgh@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6anvhttckeshn6mt"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--6anvhttckeshn6mt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello, some projects like pulseaudio is re-using a2dp-codecs.h file. It
has own private copy of it. To simplify sharing this file between
projects, what do you think about exposing this file as part of bluez
API? That make install would install this file into system and other
projects like pulseaudio could depends on it.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--6anvhttckeshn6mt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXJeSRgAKCRCL8Mk9A+RD
Uql1AKCzkOyx8wY2FGQxR1MFShZMUVxKCwCgk+4Y1/Zm3z/WBXQp9RJPZ2BYM58=
=GVaB
-----END PGP SIGNATURE-----

--6anvhttckeshn6mt--
