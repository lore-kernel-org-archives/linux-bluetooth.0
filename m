Return-Path: <SRS0=pLxO=6S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61F5C3A5A9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 16:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1DC206A4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 16:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgEDQME convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 May 2020 12:12:04 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgEDQME (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 May 2020 12:12:04 -0400
Received: from Exchange.peiker-holding.de ([82.119.189.130]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mzz6s-1jBTLb21Bu-00x1b6; Mon, 04 May 2020 18:12:01 +0200
Received: from Exchange.peiker-holding.de (10.0.1.22) by
 Exchange.peiker-holding.de (10.0.1.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1779.2; Mon, 4 May 2020 18:12:01 +0200
Received: from Exchange.peiker-holding.de ([fe80::c542:7a03:7df7:6d42]) by
 Exchange.peiker-holding.de ([fe80::c542:7a03:7df7:6d42%13]) with mapi id
 15.01.1779.002; Mon, 4 May 2020 18:12:01 +0200
From:   "CEE Forostyan, Konstantin" <Konstantin.Forostyan@peiker-cee.de>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: [PATCH] Bluetooth: L2CAP: Fix errors during
 L2CAP_CREDIT_BASED_CONNECTION_REQ (0x17)
Thread-Topic: [PATCH] Bluetooth: L2CAP: Fix errors during
 L2CAP_CREDIT_BASED_CONNECTION_REQ (0x17)
Thread-Index: AQHWHkYRSCKhloHlV0Kvhytr6OLHO6iQNiiAgAfn+/o=
Date:   Mon, 4 May 2020 16:12:01 +0000
Message-ID: <4233257d2fb24d0293c221d4bab65a2d@peiker-cee.de>
References: <77b02337bc404dea9fa88a286c091b83@peiker-cee.de>
 <08f0a119cfa0481fbf49d7fde47a08fc@bshg.com>
 <cc33f16c2e164328b8248fc3967ebed5@peiker-cee.de>
 <2723effa610a46a8a9343be31bcffc71@peiker-cee.de>,<CABBYNZ+eXJJSoQ7CGj9canfQ1eHDMzEKcY6o9GBKzAaErQs6LQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+eXJJSoQ7CGj9canfQ1eHDMzEKcY6o9GBKzAaErQs6LQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.112.11]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Provags-ID: V03:K1:c5Sc0zmvvXYD7VYnNFU/8n4OI50eGsUKy6xq7zcpF8GipYoHA3B
 MbZZIV+caTCyxrOod/trF2sptxyJkXHpy9SMq5LeVMc+xw1fjvJNHXqzfF6l1BPoq9hfbaG
 +fcm+7Yp/KcvFrkrE5jkGcnMvxzgmDIVqxk7QQrulb0vLsoWeTegseU4FquX1rQeVLdBt2r
 JjYCKJ/jSKTEC4Gi7x3Ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EU+UK7fWg50=:bsbBwhyRgN6LTjI+LmkiXi
 Cfz1BT8+HYbjcOJWm43k1fZ/sa96JbUUlUlSeWpp37u9aZJ8THL11CujWpnR5b9je607BGWFo
 10ruvm+Q1w5AfjmJvq3b0cL0OUWvAWuhSG+6IJwLTirfmi4w5vz9M3NaqjcQ6++TVFZ3DpvWI
 KOJjhhAjvuxXnhvpZ5Eor2SswCfR4kdVkhDnLMeB+HIaikuM+tq0efpeSG00ynzCohrhgH/aK
 jVyAQv+hMeK5n1GJ5IffR6dK1b1ebCQs+YXPPoLywkiUEHOmJwkxyvyKqiBJsTIoU2Nq90wV9
 hsgG3M983YBcB0012aNBySREYiHVB/3mHGNcCF+4xSKzV1v/0Kk6Td66fQBA6V2pnNNaxO2jm
 MsTUcWI7l4/BVIB0vcdRHYic3jHPAQm0d6rJHUEKCrmPkiSNb4AzQWWTiP2LRYaY6W0lp+Vkt
 rw8PkYAkX6yi6EYGsL8Sn0TLXDe6W6sSlwV8sD3hCx/1UW1SeJnSYnYwR7SjeFwrVMgvsmFC2
 B4wbP0fBhmPkw0RR7a9I5RnlYGNsu3/IIdTFEJZHxc3ltQYKoIPV4/+JBBULHIzeZEA13gMo1
 0xyP6fb9vs3zCwf8DP2+TT4pVvZeyt/GWPmhzLZ7wm5FDKM1Xt3chJ1IBLiEwnbQ+Sp4ETgF+
 3O+YnsVX5hkNV9T8C35rZo3+dN4M65tFftjlcAoqd2UWglwuiJYS8N57mEo6sXG7xT+9D1Aw3
 Ue/Zw9jFCCofNI+KHCtcywE1BKPRkRS/xadVcF8uICAYofox/Xbs3DHSw1SDt5oXffDv5jawr
 THqYMykiT+UrvdqTP4wjrYA4IQuzfo275JQZyJ1dV+njLsMu9C8t1UsFk2FDaFAK2Is/LZ4rR
 obw7ffUXnrYCY1CRr8vw==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Sorry for delay with the answer, I had a day off last Friday.

> so please send them as proper patches
I did this in a sepatare email, hopefully it is correct. This is my first time submitting a kernel patch.

> please ensure l2cap-tester is working.
Unfortunately I didn't find a way to even integrate l2cap-tester into our embedded platform, so I couldn't make any tests with it. Is it a separate tool or something that is integrated into test-runner tool? If yes, the test-runner requires qemu that we don't have.

Best regards,
Konstantin


Von: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Gesendet: Mittwoch, 29. April 2020 19:17
An: CEE Forostyan, Konstantin
Cc: linux-bluetooth@vger.kernel.org
Betreff: Re: [PATCH] Bluetooth: L2CAP: Fix errors during L2CAP_CREDIT_BASED_CONNECTION_REQ (0x17)
    
Hi Konstantin,

On Wed, Apr 29, 2020 at 9:52 AM CEE Forostyan, Konstantin
<Konstantin.Forostyan@peiker-cee.de> wrote:
>
> Hi All,
>
> During Bluetooth qualification tests I found out that Bluetooth stack responds with an error to a correct L2CAP_CREDIT_BASED_CONNECTION_REQ. Please review the 2 bugfixes I made in kernel in order to correct this problem.
>
> Best regards
> Konstantin
>
>
> --- a/net/bluetooth/l2cap_core.c        2020-04-28 18:19:10.481887583 +0200
> +++ b/net/bluetooth/l2cap_core.c        2020-04-28 18:21:41.000000000 +0200
> @@ -5817,7 +5817,7 @@
>         if (!enable_ecred)
>                 return -EINVAL;
>
> -       if (cmd_len < sizeof(*req) || cmd_len - sizeof(*req) % sizeof(u16)) {
> +       if (cmd_len < sizeof(*req) || (cmd_len - sizeof(*req)) % sizeof(u16)) {
>                 result = L2CAP_CR_LE_INVALID_PARAMS;
>                 goto response;
>         }
> @@ -5855,7 +5855,7 @@
>         }
>
>         result = L2CAP_CR_LE_SUCCESS;
> -       cmd_len -= sizeof(req);
> +       cmd_len -= sizeof(*req);
>         num_scid = cmd_len / sizeof(u16);
>
>         for (i = 0; i < num_scid; i++) {

Weird that I didn't run into this when creating the test for
l2cap-tester, they look correct though so please send them as proper
patches so we can apply to bluetooth-next, also please ensure
l2cap-tester is working.

-- 
Luiz Augusto von Dentz

    
