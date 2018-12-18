Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5929EC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 14:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2528121850
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 14:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqCq2i9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeLROui (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:50:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40554 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLROui (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 09:50:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so16194081wrt.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Dec 2018 06:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hZWmzV34HLvL3UIv8VW+OCuSuWZohMPYZe2FaBUoZFg=;
        b=qqCq2i9ZjcYwXrmGMFPeGyE6ozfiO32/xOp+Z+oo51m28MFk6LDX/39IVTpqyYSlCo
         HufdODWiYKIAd/2vjPyss/6tEXsg/vaKI3l7LJgliFky9DvO/1UhgRddqu6SOIP74t7F
         g4U0BkR1S/kO9Q2W2uE+4ahC3q7zG/y15HsPijCJE32bmU/RzuOAuMyEyxvjYW7pUmWh
         xycHUW1ki/my23Uc9aYGKdVY3Cy4WRSMvimvO+S6BLuLJ87a9cCl/qCY3igFh9YH/u7D
         VN8dBVVuibiTrrKrMZiCGbHwlBHwABBvuqvn4FuQMcRbUxibAVuL6tvS9M8kfmqAOVZN
         ORzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hZWmzV34HLvL3UIv8VW+OCuSuWZohMPYZe2FaBUoZFg=;
        b=HyUV46Pzl5xBQO0FqFMZDwaYMvVBTxxue0W3+VzFnZyUF7lN2VbRcFh3/Mv9lqI2vI
         56ox6rLmo1xOL6ESKU64UX4WpSXd+WO7krci3a8qugeV3SzPiKRPsM2ptRUne0TLvaLX
         PiOrB2EhoF4wsITSFcwRbXJE4C33TwnM94g+3FsfD+V0ai+X8m2XUMY4n5PCY1GQG/O8
         x8Yt0ZgDGBBvZfbQLk0gfO2JHu5+BVZv8BdaZkVpgE+rvhbNL1u/ooa0p1VhsMF42On1
         W9iA0u8/mug6lrUpLyXKlZVXfEvYMooOQrD403gLMgoUFQ0s1Udn0OeiBeEyFh5gDscc
         DSpQ==
X-Gm-Message-State: AA+aEWZdjYvqhBSEgoeiRAox/5KQ4kMqriJfeav1zGptqPyvUH4G/Meu
        jVo4b+ohAllY9NPspznQnkY9LW5WPQY=
X-Google-Smtp-Source: AFSGD/W637FC58A/PgEfKb7Y2ZD3vYjpUjft4dctZWKMBezpv0UsIyK3v8E44oxpzbzpvXYHyvQLmQ==
X-Received: by 2002:adf:9205:: with SMTP id 5mr5488327wrj.189.1545144635948;
        Tue, 18 Dec 2018 06:50:35 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n15sm3214134wrt.21.2018.12.18.06.50.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 06:50:34 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:50:33 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Bluez has fully broken profiles/audio/a2dp-codecs.h file for big
 endian
Message-ID: <20181218145033.itlwcfraxsusafb3@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y7ncv4bwoypndujv"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--y7ncv4bwoypndujv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I spotted that bluez has file profiles/audio/a2dp-codecs.h in its git
repository with some #if __BYTE_ORDER =3D=3D checks, including #ifdef for
big endian systems.

But this file is fully broken for big endian systems. For example, there
is following structure which is same for both little and big endian
systems:

  typedef struct {
  	uint32_t vendor_id;
  	uint16_t codec_id;
  } __attribute__ ((packed)) a2dp_vendor_codec_t;

Which is valid only for little endian systems, as those definitions are
bound to little endian ordering -- not to host ordering.

Next there is a2dp_mpeg_t. It has different definition for little endian
and big endian systems.

little endian:

  typedef struct {
  	uint8_t channel_mode:4;
  	uint8_t crc:1;
  	uint8_t layer:3;
  	uint8_t frequency:6;
  	uint8_t mpf:1;
  	uint8_t rfa:1;
  	uint16_t bitrate;
  } __attribute__ ((packed)) a2dp_mpeg_t;

big endian:

  typedef struct {
  	uint8_t layer:3;
  	uint8_t crc:1;
  	uint8_t channel_mode:4;
  	uint8_t rfa:1;
  	uint8_t mpf:1;
  	uint8_t frequency:6;
  	uint16_t bitrate;
  } __attribute__ ((packed)) a2dp_mpeg_t;

But as you can see, bitrate on big endian definition is incorrect. It
is still in little endian. Proper way would be to define bitrate as
"uint8_t bitrate[2];" or as "uint8_t bitrate_lo; uint8_t bitrate_hi".

So basically this file a2dp-codecs.h is not compatible with big endian
systems, even there are "#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN" branches.

If you are not going to support big endian systems, I suggest you to
drop all those "#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN" parts as people
think that existence of these macros means that code is supported on big
endian systems.

It is better throw an error that big endian is broken as trying to
produce non-working binaries.

Moreover, some people started copying this a2dp-codecs.h file to other
projects which just leads to copy+paste of broken code.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--y7ncv4bwoypndujv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXBkJNgAKCRCL8Mk9A+RD
UsdbAKCse9ktTz3le8ey5o2byPoGvJ6YvACZARJSfKggTjzyzARoWgrGN+8Ej7k=
=x5GM
-----END PGP SIGNATURE-----

--y7ncv4bwoypndujv--
