Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC295C4363A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9234D246CD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzh+ug+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgJ1Vp7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgJ1Vpu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 17:45:50 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD94C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:45:50 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 140so471574qko.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:autocrypt:subject:message-id:date:user-agent:mime-version;
        bh=QhF/l8K4YgtBILJEAFqzCpjHuXa8uBGlzWobBoe+kJA=;
        b=nzh+ug+mVYGHyHA5NwELsbkvKywZ7vdYoS2RCph18tLwk1wA8+QjqEPSZWipFH6Z4k
         drx1q6JJ52DBAqIcSSCDiNeulFRa+s3BiyrsHHtxMyS9Sk3IycqWBUcfP6Mdio4pq5aA
         Jz1boaxCbhCLMszLCouGWsgRe3r8Ll6yRgYuboQ/eNihXw5bUKGV2811tIJ2Z/wORoM2
         kM86oSVsUxUooUhFoW1sj2XqzUFXbd+P9vR1lmN2PhXGxZRUSi8S6CGQsn2Zh3TFd844
         in6As7z7nct8+t08jbNjSc74kR/yNlCBb/a8kHROReoW9YbaiFj6XtaQBQVPaOfp/ILk
         YXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:autocrypt:subject:message-id:date
         :user-agent:mime-version;
        bh=QhF/l8K4YgtBILJEAFqzCpjHuXa8uBGlzWobBoe+kJA=;
        b=bVMTuz17zObJWhgeLJlFMVavz2AjktgzsuPjuKZo+ABhhgMcCQqPnUN+i32j8/fKDX
         V0O7pS1ghmG0hZ8CYOBeUbxeZmOmhM47tVxaI33tG4P8kwuey0ws7ZYCJ9w3APQVogpr
         UkAGbtg9VdNLdGaWkemCybBDamGu10/FOkjUj1WAp04b+KmRpN+dk3N+FNzC3k3lpPiV
         rhynzx5C3ty+6nRybtyHUlraRypU62fJvYyS9BH4qkOibWfLQiuAgSRqW9+lewO/hUG7
         SprNjZv0NT1A8w621Gvxov1+GfdRUIP5HwYdA8E8/WI3l61XJ2dstfYiufiJeHLYEoOw
         5yQQ==
X-Gm-Message-State: AOAM5315IeXkxPa8KMxiqweSDUcSz7wL138vvVes8IvJ8rztfrpSfgJq
        elipn/SPbPot+wLGm2WhKWJs5eT8wlMKVg==
X-Google-Smtp-Source: ABdhPJzvwJ98FygkPG06bSrI7izItvl/EjaRrFdhUcsRSgVPer6oyniApzguDtzcPMaU+7phP9PXmg==
X-Received: by 2002:a05:620a:1265:: with SMTP id b5mr7712459qkl.27.1603902579659;
        Wed, 28 Oct 2020 09:29:39 -0700 (PDT)
Received: from [10.249.129.62] (nat-216-240-30-11.netapp.com. [216.240.30.11])
        by smtp.gmail.com with ESMTPSA id n3sm3051993qta.10.2020.10.28.09.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 09:29:38 -0700 (PDT)
To:     127.joschi@gmail.com, linux-bluetooth@vger.kernel.org,
        pali@kernel.org
From:   Paul Stejskal <paul.stejskal@gmail.com>
Autocrypt: addr=paul.stejskal@gmail.com; keydata=
 xjMEX15YFxYJKwYBBAHaRw8BAQdABjSNJJDYxDa/ApivdnlfMyMjlDnvR353l2V5he2rnujN
 J1BhdWwgU3RlanNrYWwgPHBhdWwuc3RlanNrYWxAZ21haWwuY29tPsKRBBMWCAA5FiEEnqJl
 hmZFdcJJV1/2hWkib0OS0cgFAl9eWBcFCQWjmoACGwMFCwkIBwIGFQgJCgsCBRYCAwEAAAoJ
 EIVpIm9DktHIPBsBANmmVDp482hUgvKAxoA+2sd8CbBTKVy4WVqIvKYgDlGNAQDrne3K1d5I
 02PXnNtNZg1XTq6BduMirAZBK9swyFwQAs44BF9eWBcSCisGAQQBl1UBBQEBB0AzSdJMtq8K
 EAOCr8+e7X2atwJOh7oEBF+8PkUYvzuUMgMBCAfCfgQYFggAJhYhBJ6iZYZmRXXCSVdf9oVp
 Im9DktHIBQJfXlgXBQkFo5qAAhsMAAoJEIVpIm9DktHIE7oA/1MgJMALdF2JMjUokDc2WZAe
 9x25D06HLh+QECZ8uXtzAQC5Vy9Cjxc8rw7Ld1ui1Ls8/Kq46LrjIsG6X+StjxszCA==
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
Message-ID: <0a520235-f1be-2b51-b047-4960f58e0715@gmail.com>
Date:   Wed, 28 Oct 2020 11:29:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0XRFGi4Ros8IVoGuCFhFPMlOGoq9AV4IZ"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0XRFGi4Ros8IVoGuCFhFPMlOGoq9AV4IZ
Content-Type: multipart/mixed; boundary="ms9rO4b1d7oR0WkelR0nUoWrU8JgOyJin";
 protected-headers="v1"
From: Paul Stejskal <paul.stejskal@gmail.com>
To: 127.joschi@gmail.com, linux-bluetooth@vger.kernel.org, pali@kernel.org
Message-ID: <0a520235-f1be-2b51-b047-4960f58e0715@gmail.com>
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters

--ms9rO4b1d7oR0WkelR0nUoWrU8JgOyJin
Content-Type: multipart/mixed;
 boundary="------------D93D5E93196F7165B7E2AFFB"

This is a multi-part message in MIME format.
--------------D93D5E93196F7165B7E2AFFB
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: quoted-printable

What can we do to get this published?


--------------D93D5E93196F7165B7E2AFFB
Content-Type: application/pgp-keys;
 name="OpenPGP_0x8569226F4392D1C8.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0x8569226F4392D1C8.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEX15YFxYJKwYBBAHaRw8BAQdABjSNJJDYxDa/ApivdnlfMyMjlDnvR353l2V5he2rnujNJ=
1Bh
dWwgU3RlanNrYWwgPHBhdWwuc3RlanNrYWxAZ21haWwuY29tPsKRBBMWCAA5FiEEnqJlhmZFd=
cJJ
V1/2hWkib0OS0cgFAl9eWBcFCQWjmoACGwMFCwkIBwIGFQgJCgsCBRYCAwEAAAoJEIVpIm9Dk=
tHI
PBsBANmmVDp482hUgvKAxoA+2sd8CbBTKVy4WVqIvKYgDlGNAQDrne3K1d5I02PXnNtNZg1XT=
q6B
duMirAZBK9swyFwQAs44BF9eWBcSCisGAQQBl1UBBQEBB0AzSdJMtq8KEAOCr8+e7X2atwJOh=
7oE
BF+8PkUYvzuUMgMBCAfCfgQYFggAJhYhBJ6iZYZmRXXCSVdf9oVpIm9DktHIBQJfXlgXBQkFo=
5qA
AhsMAAoJEIVpIm9DktHIE7oA/1MgJMALdF2JMjUokDc2WZAe9x25D06HLh+QECZ8uXtzAQC5V=
y9C
jxc8rw7Ld1ui1Ls8/Kq46LrjIsG6X+StjxszCA=3D=3D
=3D9569
-----END PGP PUBLIC KEY BLOCK-----

--------------D93D5E93196F7165B7E2AFFB--

--ms9rO4b1d7oR0WkelR0nUoWrU8JgOyJin--

--0XRFGi4Ros8IVoGuCFhFPMlOGoq9AV4IZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSeomWGZkV1wklXX/aFaSJvQ5LRyAUCX5mccQUDAAAAAAAKCRCFaSJvQ5LRyNLZ
AQDgchp5iElPb7+NSJlVpZw4CSEXedIw6B9g/+McpCd/lwD+OvPit+AvXwAEiKMlDCqSmwX3YeUt
TYCfX0is8qmtqg0=
=j4we
-----END PGP SIGNATURE-----

--0XRFGi4Ros8IVoGuCFhFPMlOGoq9AV4IZ--
