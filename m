Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE24C388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 01:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3278222384
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 01:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXIxzDfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgJ1Bik (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Oct 2020 21:38:40 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:37005 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1833051AbgJ0XpK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Oct 2020 19:45:10 -0400
Received: by mail-il1-f176.google.com with SMTP id y17so3111418ilg.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2020 16:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=m1UUkXijJnMnnzKxKP14uscpRaaYLhLlNmTV4ZdWBwA=;
        b=VXIxzDfA3n949Ibl7Q36hiiXDqJleh9Elmdu7S6BkP5h4xD5NopjiMul1F5nto8Xwe
         54YYkaMGnjTcCIQL1bCIDPQOx7a0sc75v24VKXF2zdXmKE5dQ81xKll7q+b2FgrgUmV3
         kDbk+9qskMd3hccitumIzlRoPzuA7A1igttF0DBGjQPX/JUQuI1mPJJLA5WMG7FlwzR9
         t+y9DXAVgC4UzdNC1TFwxkPldX0Dy5uGVp+2NBY+motPs4g0yVSL7AC67xSQz11VrSoN
         WWbzYJTtveGEMiVE7XEEzyvwU7e93w0spXaLQfhG7rK558nSz7Zai7Pyg8ouTKDncjNC
         eMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=m1UUkXijJnMnnzKxKP14uscpRaaYLhLlNmTV4ZdWBwA=;
        b=mVucpFNYEA880+h1LD5wUnx76lp/tMAMSnI8ZeCHbo+qB7GdpnqQ1Fd+L6V2ewMvpx
         JHMq7MicxcZjI214LGiyzNgOSemSL9TctJkW/8J4JvRK6fHmcaoe10GNyS5ofAyuNnjF
         srzJYoHd+q6IJYQUAyD0656vuUusCs9sD6DsNE+DO+CmQelcRM2sLx+2mIILMqk8IPIn
         yAiS3dMli7QgvzcTZazsUwsfZ8kkPZSr4NyjcjcmyetC/bnf8un2olMdMkMUE+Mem221
         kQGcwnjDdlB5iNdrIVGt+XrSMy65egNigVKWwpiL/ZHsS1vLIFkxpdrIFIPhQBMbnf02
         H3Mw==
X-Gm-Message-State: AOAM531IvE5yYa1H2L8aatsdyFfpT09JSsaYtvCFBZ1GHRqxDZyp2dhH
        DDvagsj/RIAPXXNEphQwSMY=
X-Google-Smtp-Source: ABdhPJz5C6Gvfz5ehFxcOLkpoJSuZdKwTfp+4wUNy8LHiQzxrpxw8Nbz429BWvhiGxgBdA4RzMee7w==
X-Received: by 2002:a92:cd45:: with SMTP id v5mr4165998ilq.204.1603842308972;
        Tue, 27 Oct 2020 16:45:08 -0700 (PDT)
Received: from ?IPv6:2600:8803:7a80:18d6:b565:bd24:38d9:9e2a? ([2600:8803:7a80:18d6:b565:bd24:38d9:9e2a])
        by smtp.gmail.com with ESMTPSA id u1sm1811578ili.55.2020.10.27.16.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 16:45:07 -0700 (PDT)
To:     127.joschi@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, pali@kernel.org
References: <f40ad39dad23c813441a3082550ad44f85671f2d.camel@gmail.com>
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
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
Message-ID: <265f2b10-8a1a-8165-04f9-58024a89d4fc@gmail.com>
Date:   Tue, 27 Oct 2020 18:45:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <f40ad39dad23c813441a3082550ad44f85671f2d.camel@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2tbz2irKAEOexHQezuPxUu8z8hGscDWbt"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2tbz2irKAEOexHQezuPxUu8z8hGscDWbt
Content-Type: multipart/mixed; boundary="QULVkOlBN4vLbcQV5oLQAuL9xZGYGRt6J";
 protected-headers="v1"
From: Paul Stejskal <paul.stejskal@gmail.com>
To: 127.joschi@gmail.com
Cc: linux-bluetooth@vger.kernel.org, pali@kernel.org
Message-ID: <265f2b10-8a1a-8165-04f9-58024a89d4fc@gmail.com>
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
References: <f40ad39dad23c813441a3082550ad44f85671f2d.camel@gmail.com>
In-Reply-To: <f40ad39dad23c813441a3082550ad44f85671f2d.camel@gmail.com>

--QULVkOlBN4vLbcQV5oLQAuL9xZGYGRt6J
Content-Type: multipart/mixed;
 boundary="------------92270295635D1914519BF705"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------92270295635D1914519BF705
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

> I hope this can be pushed forward. Would make me (and many other) users=

> so happy to finally get wireless headphones working better!

I agree. What is needed to push this forward?

Thank you.

Paul


--------------92270295635D1914519BF705
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

--------------92270295635D1914519BF705--

--QULVkOlBN4vLbcQV5oLQAuL9xZGYGRt6J--

--2tbz2irKAEOexHQezuPxUu8z8hGscDWbt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSeomWGZkV1wklXX/aFaSJvQ5LRyAUCX5ixAgUDAAAAAAAKCRCFaSJvQ5LRyPo3
AP4tCn5vzANzM4utHHANPcLiv9CjHVBq8XU63r97CLHYrAEA9RU8EUh16LttkPDj5vkT6bG94dB9
It+NbbDlDIJJKQk=
=ckKM
-----END PGP SIGNATURE-----

--2tbz2irKAEOexHQezuPxUu8z8hGscDWbt--
