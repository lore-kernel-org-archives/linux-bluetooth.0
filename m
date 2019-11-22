Return-Path: <SRS0=qr/Y=ZO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B667C432C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 22:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0632B2070E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 22:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1fGFuaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKVWIq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:08:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55553 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKVWIq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Nov 2019 17:08:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so9020418wmb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2019 14:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FklPvUWJuTfHBblFSHHRTzuYMKA2kBQhTKB36Z6vCso=;
        b=D1fGFuaG9DJ/wfKILi/IALUsuIuvCostVBHOaz4VtXftWWv8Bn5Rwpx1zdZpgJKJxz
         fJcua7qEHgmB0iQ1WpXNWm/JNuJchl4zkKUkaVjGghr1fRpR9iNZoEMjy6P9PrHQz7/t
         zZNaHn61caWeibCNEPqw4JT3vnLTkmvVXvcWwuWJJpMLAKMSnuZ+ullkEo57r+FBL7nI
         /kR+VjzRnLNcEf3xPuw4Kk12WFcpSYLLXdCdN43aI/zX7Kwn41hDTz2Dm3rxRlVxuLGi
         0VcQ62bBkaerzUnkY7aM9AexG4+mGEuCg7LSCz5xHRw4XxBEO2iHd5fV3+Wh2YFonFSC
         hRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FklPvUWJuTfHBblFSHHRTzuYMKA2kBQhTKB36Z6vCso=;
        b=o/drZszO2BEJ9v/LWNBQW+B7cYos46Fzxkp5UqlwvXhWQ2DBLzpZai0Lt99B889Q3m
         U8QQWSFaAkOWGQRBO/8MlSz9QPAW6FLCYKbqsL2AY/hSALWfyLo35F98jQSc0S2yRGzJ
         F/KyUj8e1NDOZquHJOu1qyCWGzB3QUlVWXhd9mLyRNfqSz6zSPYTLAGqJ+A8rGlT5T6D
         7qaOHKWc3Guk8VNnmzUZQmW2XR80e112vjj4I9HHCHcgPJxwAuu6jvcjFHzlBg+J5p6o
         MRQeGEHfPJjErXQZsvU7uymKolkXXskYlVHoxlh8HLXuIbIMsEmO3wq/XyZpexfej+4P
         OzQQ==
X-Gm-Message-State: APjAAAUcUvKUodEcHWd0oZ3f6rQPPMNbvSOQAceolOIYBNw/Yuek0dsv
        vFrH0S9Icta62XXkCyTxOW2LKsZ+
X-Google-Smtp-Source: APXvYqwpaILbTjUhE/WPsygIwGczBc6ZNrekHQKd9hclvGgK3XcER2MUl0lh1i6tQ6aK/TSV+7zmmg==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr18254443wmc.121.1574460523731;
        Fri, 22 Nov 2019 14:08:43 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x2sm419662wmc.3.2019.11.22.14.08.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 14:08:43 -0800 (PST)
Date:   Fri, 22 Nov 2019 23:08:42 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Bluetooth HFP 0.96 specification
Message-ID: <20191122220842.5ofrsakoyebs5wgk@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5bvni7y2zjgmogrj"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--5bvni7y2zjgmogrj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I would like to ask if somebody has specification for bluetooth HFP
profile, version 0.96 or older.

I tried to find it, but from official site version 0.95 was removed [1].
On web.archive.org is mentioned new version V0.96, in file HFP_0_96.pdf
but it was not archived.

Why I'm asking for older version? Because there are still devices which
support only HFP version 0.96 and I want to look what was changed...

So has somebody copy of that HFP_0_96.pdf file? Or access to removed
0.95 version official site?

[1] - https://www.bluetooth.com/specifications/archived-specifications/
[2] - http://web.archive.org/web/20021204225514/http://www.bluetooth.org/sp=
ecifications.htm

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--5bvni7y2zjgmogrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdhcaAAKCRCL8Mk9A+RD
UmzFAKCYSdK7iIHLxPEJmmLk/FiOIB88ZQCbBxQ/qEpqM+2PNdbGlUz2Yks5WMI=
=YAgI
-----END PGP SIGNATURE-----

--5bvni7y2zjgmogrj--
