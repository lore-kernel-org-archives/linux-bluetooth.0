Return-Path: <SRS0=BHgP=2Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D122C2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 10:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA11222C4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 10:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5qyfkvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgADKYl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Jan 2020 05:24:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33253 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgADKYl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Jan 2020 05:24:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so44640220wrq.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Jan 2020 02:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TzPzGZq9QtcezIQTiWiyQ/ncnr3tp/crmE+Gdkf6K3k=;
        b=u5qyfkvAPRSzt/d32xThxF8rizpedhLqfiVnX6Y51Kr0OKk+zDRq1vbSJ3OmmmSvWD
         k28VIu/83Z046Ngsyg84+Zkp78Axf1AaO+18FjVeEum5nXf3fmB+HALu+ZLGWK3gvYsR
         N0sMdOP/k0oi1kJ7671vt3HbZSsn2tjyVhyiO8XqTlg2mrtAA4sTSQ8jb65rtJkc6eB1
         gDS62KHvm87prZp4TXhDWReLJM/RDp5bmR0Ud2763I1n5yV84vGUV9BEH2CwHpDqrGD0
         keNnndaPCMcxtOwTdqwB2z8n2PVTW8yncQ4Dl3WVQKlUqliZ4+5L1ZWGrEscLPBy0imq
         BseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TzPzGZq9QtcezIQTiWiyQ/ncnr3tp/crmE+Gdkf6K3k=;
        b=Xw/kYS+XdLnqLjgIYfQpPgDAV7j9AvgqKEuaCkI1QC+KfkkNVSt4OLGNI22pTvw6Gm
         xWXps0TwqLmi5Vd3tan0tf8aUKNNf21OAvgFGKIxnifu3+6X4AjYJIihOGFemDuaIdQa
         Rc6aWasl7eS0a0A5ke0aT/6VcCI4xs5+qso7QOGAoaY21bNg67G8efv3Kg/7+eA5DmuK
         O5DAD2MBOziD3YPC6i3sn/EZSxhIwaS5BVJEEZ2I3l4PPCgzjnyPr2JMCX+po1vsTdKy
         xyzn7m6nYBtNSI1QUhChu/xKP+UFTvi6IEQG1KOLRRIMNkhRYkUhvMIkpVsmE9m2Jjl2
         EDBQ==
X-Gm-Message-State: APjAAAWplDTcoP2b4gqBxh1bdHQJEWYLMTxoHS6eWNiZiQCyzZXcJPdS
        3W7dDil+Fmo2g+6v9F68ezA=
X-Google-Smtp-Source: APXvYqySdSAtOT6KlPT3CchlOzsIY4ehq7yT8d0bjnzvgKTM00GHY/0xx211thQG7zPytwmRDFiv6w==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr89588140wru.52.1578133478872;
        Sat, 04 Jan 2020 02:24:38 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r68sm14218257wmr.43.2020.01.04.02.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 02:24:37 -0800 (PST)
Date:   Sat, 4 Jan 2020 11:24:36 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: OCF_READ_LOCAL_CODECS is permitted only for root user
Message-ID: <20200104102436.bhqagqrfwupj6hkm@pali>
References: <20191228171212.56anj4d4kvjeqhms@pali>
 <45BB2908-4E16-4C74-9DB4-8BAD93B42A21@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s3jd55xdtax57j72"
Content-Disposition: inline
In-Reply-To: <45BB2908-4E16-4C74-9DB4-8BAD93B42A21@holtmann.org>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--s3jd55xdtax57j72
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 04 January 2020 10:44:52 Marcel Holtmann wrote:
> Hi Pali,
>=20
> > I wrote a simple script "sco_features.pl" which show all supported
> > codecs by local HCI bluetooth adapter. Script is available at:
> >=20
> > https://github.com/pali/hsphfpd-prototype/blob/prototype/sco_features.pl
> >=20
> > And I found out that OCF_READ_LOCAL_CODECS HCI command cannot be send by
> > non-root user. Kernel returns "Operation not permitted" error.
> >=20
> > What is reason that kernel blocks OCF_READ_LOCAL_CODECS command for
> > non-root users? Without it (audio) application does not know which
> > codecs local bluetooth adapter supports.
> >=20
> > E.g. OCF_READ_LOCAL_EXT_FEATURES or OCF_READ_VOICE_SETTING commands can
> > be send also by non-root user and kernel does not block them.
>=20
> actually the direct access to HCI commands is being removed. So we have n=
o plans to add new commands into the list since that it what the kernel is =
suppose to handle. If we wanted to expose this, then it has to be via mgmt.

Hi Marcel! Thank you for information. I have not know that this API is
"deprecated" and is going to be removed. But userspace audio
applications need to know what bluetooth adapter supports, so can you
export result of these commands to userspace? My script linked above
calls: OCF_READ_VOICE_SETTING, OCF_READ_LOCAL_COMMANDS,
OCF_READ_LOCAL_EXT_FEATURES, OCF_READ_LOCAL_CODECS

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--s3jd55xdtax57j72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhBn4gAKCRCL8Mk9A+RD
UjceAJoDVnOH7VunhYf+tGJ/Z4oyGDtVnwCfZkL3nmPfPICAiYnDD9MVE2BgAwI=
=TAum
-----END PGP SIGNATURE-----

--s3jd55xdtax57j72--
