Return-Path: <SRS0=8q+o=TD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58518C43219
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 10:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CC32075E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 10:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvgiJgj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfECKU6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 May 2019 06:20:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53002 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfECKU6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 May 2019 06:20:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id y26so1308262wma.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2019 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v71sTLSs0svhhXRmWmDulFfnRj1N1IIRzbKoob0pjPI=;
        b=UvgiJgj+oycvPHQM8+6qpcGNZCzIoeB+dMwhYSFCGRXQkVLsx1Y5bsPf0r0skFCh7X
         JFMul0YL8I6OXvM0ydNdeq6kyfzkO3VBfy/c/ym9z4vXoqizkQXuvgHTuEavmqHyBVer
         ex7/6cRBnIyMV2rF+ea2eOQQ0Z/KRULgFPRyS7ifUSWwM77sJbfe4xpAbaGyFJiemeib
         yn2rd3TYv07UYuyCTEG2XxLSgCB3jyM7sb5D/Y4f+SedyBpfqVCDMB1yhtrgUqxJanny
         8DF4WkzmMTs+naja/JjAMFC1RqcGX79Btuhwtf9vQtIaIhL3uZuE3P2OgpfuktMjP1io
         hcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v71sTLSs0svhhXRmWmDulFfnRj1N1IIRzbKoob0pjPI=;
        b=ADap+eAufiXNb+0dZyBUqidBmxQe7tNlm8Gwnpty0WItMEGAdBSD9CGEmSArCGONE7
         F23/Jz3awZvMk/qJ06oc2PMs2lG3hjohEL27yynNxXL5KCKkhD2v0CmGjtEVk4BkOWET
         KA5SY5Qi5jS7Y9eJdWVaCYQGtXUHPohy3uIjPAvUSK8LB4656FklCaK3+jtdTDZmk+Lx
         3yxffjHxzhJPMWil/llz0SchXMsrKj4di23903BZ4+piUp4YirjGMdfWc2NGK6CXA97R
         MNic/V2WE0q7ftf5XiZfkAeT0Jy7kbtAhCAgBxPdVNMhAmhQgfEXVAY1Mf8ySXRkfo07
         vNMw==
X-Gm-Message-State: APjAAAV9KeqJsWQznhIChP6kncW1R2iXvDKUGFHVZnYPou0LpvTusK0E
        FgbPxawEyqxnHK1aYiaolw1bMzbJ
X-Google-Smtp-Source: APXvYqwhED6bVaW5Nre0Ae+lomo79k0MjspPt0cgFBTySYxMeMxS/JqNeQgJ2q7Dw7o+/VpVNzOviw==
X-Received: by 2002:a1c:4b03:: with SMTP id y3mr5789539wma.113.1556878856703;
        Fri, 03 May 2019 03:20:56 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v5sm1918953wra.83.2019.05.03.03.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 03:20:56 -0700 (PDT)
Date:   Fri, 3 May 2019 12:20:55 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/2] a2dp: Store last used endpoint
Message-ID: <20190503102055.iocakqexbzw3qdqg@pali>
References: <20190424083921.15679-1-luiz.dentz@gmail.com>
 <CABBYNZLcpo_Dx3X9pmKGeqSNFDLKZAqd==6wL5qcthGiqg-EeA@mail.gmail.com>
 <20190424165721.fs7ylixjscqjmqmb@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s4ev4w5xqzz7dhfz"
Content-Disposition: inline
In-Reply-To: <20190424165721.fs7ylixjscqjmqmb@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--s4ev4w5xqzz7dhfz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And this patch has another problem. If remote device supports only one
remote endpoint with SBC codec and pulseaudio export two endpoints for
SBC codec (one low quality and one high quality) then into LastUsed
property is stored identification of remote endpoint. Not local
pulseaudio endpoint. So information if was activated low quality or high
quality is lost. I have there Nokia N900 device which has problems with
SBC at High Quality. It is unable to send any audio output in HQ.

And due to above problem, I need to use only low quality endpoint, but
because bluez does not remember which one was chosen, it seems to choose
high quality and nothing is working.

This is just example that some codecs or endpoints may be broken by
remote device, or remote device's SEP is not compatible with user
application (pulseaudio) for whatever reason.

So it is really needed to have API: "use this local endpoint for
creating new A2DP connection".

Without it we would have broken applications.

PS: A2DP SBC implementation on Nokia N900 seems to be broken, when it
sees SEP with dual channel SBC it sends nonsense SBC configuration (min
bitpool >> max bitpool) which is really not allowed by SBC UHQ in
pulseaudio. So this is one real example of existing broken
implementation which can be fixed only on client's pulseaudio side.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--s4ev4w5xqzz7dhfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXMwWBQAKCRCL8Mk9A+RD
Uj6sAJ91iQ/pTY4wtU6wR81mC1pA5RhULQCggzmpfG0nA+0/Ylup2thYcgeDGO4=
=Xd1k
-----END PGP SIGNATURE-----

--s4ev4w5xqzz7dhfz--
