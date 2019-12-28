Return-Path: <SRS0=E92O=2S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DAAC2D0C6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Dec 2019 17:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA31208C4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Dec 2019 17:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+EKCkTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfL1RMQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Dec 2019 12:12:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38539 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfL1RMP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Dec 2019 12:12:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so28951698wrh.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Dec 2019 09:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AOaY7iVi9fWm05Hu74mfBoMfPdqBkYD19rHCxJnpJH4=;
        b=u+EKCkThvZIfnVQzrs7byEApwPq3bU/pRdx8qKh8umnicPOOnVe8FdISS3KNtC3aDg
         hACqGpHNCUQKQMqtLKiVy6zgs7j0gGD8BOQQ8tKjgmEjS6GGpeBtAl94VqxaDSW/iWsm
         AGm5lmxYojUA+JnrpMzsU193s/1P/FuwtYyqK8mM93uMtZe1EQ3iLrmr4DlwtizudgPk
         YY3qRn5qq0QUVjO0THo/oPi/kRhA9O0MgutKeAL+kq35ZsgYnvxT/yVS+jvP7deuGOn/
         XloTSyAS/2RvvDthaE6pHdhnI/L884+SYYIjjcGIud1DWtyvZ1t/3/0+/WpXEmiegtaq
         e7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AOaY7iVi9fWm05Hu74mfBoMfPdqBkYD19rHCxJnpJH4=;
        b=MEnXnApBfKxF6EYf0c4kQaLzi4AYsonhgveY+J+PC8oFoix5qAlYMmYGV/jROfmaaF
         1PgcHmVviAsrZgrMFJmEzD215XFSyNQXsFy7oEYqlDeZUYpgLshG3GS+cHKxsnKcbEsC
         Skz59wgNWbb8Fj3kLJU+4EOgB32NYjhqeIlA1+URD0UcspBltH42WEWTPj6OOYc9BNTN
         Jgg1b0pQEvtaSRsCVyL5DKTVjRWruavLKObG8Jk6X1A837nyK5h1rkAoVSRQtgCfkRU9
         PXiJIOh+Pk6XbatrfRMGMQRJSN1zaETy/O0zmws5E6iFmOUWN/nx6Mgo4/X0eyLAgmqS
         fNDw==
X-Gm-Message-State: APjAAAVr7sr8V5K6G4SRqLI7rd6hd35BnRAjFhvrICejXNX8jhO7qKQu
        RmH6vniROFKKJIForLgibH0Nl1ZS
X-Google-Smtp-Source: APXvYqwAv9ZI/jIeGXw6PY71Diem8GMi7eyTl+dgQ/PF3r4iqIQwSaMPD5aKv6ScxIdoVgYO3l/ErA==
X-Received: by 2002:adf:f501:: with SMTP id q1mr26261144wro.263.1577553133517;
        Sat, 28 Dec 2019 09:12:13 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a1sm14973529wmj.40.2019.12.28.09.12.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2019 09:12:12 -0800 (PST)
Date:   Sat, 28 Dec 2019 18:12:12 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: OCF_READ_LOCAL_CODECS is permitted only for root user
Message-ID: <20191228171212.56anj4d4kvjeqhms@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jlswcyicf3hldqhd"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--jlswcyicf3hldqhd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I wrote a simple script "sco_features.pl" which show all supported
codecs by local HCI bluetooth adapter. Script is available at:

https://github.com/pali/hsphfpd-prototype/blob/prototype/sco_features.pl

And I found out that OCF_READ_LOCAL_CODECS HCI command cannot be send by
non-root user. Kernel returns "Operation not permitted" error.

What is reason that kernel blocks OCF_READ_LOCAL_CODECS command for
non-root users? Without it (audio) application does not know which
codecs local bluetooth adapter supports.

E.g. OCF_READ_LOCAL_EXT_FEATURES or OCF_READ_VOICE_SETTING commands can
be send also by non-root user and kernel does not block them.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--jlswcyicf3hldqhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgeM6QAKCRCL8Mk9A+RD
UvPmAJ0aHHNlT3F3+UrCSH4kQ9MPR+BddACfVJ5m7uvD8sW7SU3NNmoNcPal65I=
=Us8J
-----END PGP SIGNATURE-----

--jlswcyicf3hldqhd--
