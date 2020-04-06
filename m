Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B967FC2BA1E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B442206F8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bshg.com header.i=@bshg.com header.b="cOJztw+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgDFSFT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:05:19 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:37246 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgDFSFT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 14:05:19 -0400
X-Greylist: delayed 29184 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2020 14:05:18 EDT
Received: from fe0vm1649.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 48wz3K0DTRz1XLm4D;
        Mon,  6 Apr 2020 20:05:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bshg.com;
        s=key3-intmail; t=1586196317;
        bh=tF3Iaog7iytoGaxAknjdxA+N7vcyg4dkRoAgB/KBIfc=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=cOJztw+g1Jac2Rp+vFohzZdTBrlJCns1KsgowkUrklVcV9TVIk+qVTeeGm1djGC9A
         IuO5nKh8ZRiP3IX5QAIZY1uEOul/nnaoA+Cr6X78UiAU2JJo8uHjaeOR+/cnmLddAG
         /QzBkz0zbEk+7MIQfpB/1oV+vUgemhlQKdnbvNGY=
Received: from fe0vm1740.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1649.rbesz01.com (Postfix) with ESMTPS id 48wz3J6x5fz1Jf;
        Mon,  6 Apr 2020 20:05:16 +0200 (CEST)
X-AuditID: 0a3aad14-035ff70000000c3a-a8-5e8b6f5cb0e6
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1740.rbesz01.com (SMG Outbound) with SMTP id 8C.04.03130.C5F6B8E5; Mon,  6 Apr 2020 20:05:16 +0200 (CEST)
Received: from SI0SWIEXHC01.bsh.corp.bshg.com (si0swiexhc01.bsh.corp.bshg.com [10.49.76.137])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 48wz3J59YFz6CjZP1;
        Mon,  6 Apr 2020 20:05:16 +0200 (CEST)
Received: from SI0SWIEXMB4B.bsh.corp.bshg.com (10.49.76.136) by
 SI0SWIEXHC01.bsh.corp.bshg.com (10.49.76.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 6 Apr 2020 20:05:16 +0200
Received: from SI0SWIEXMB4B.bsh.corp.bshg.com (10.49.76.136) by
 SI0SWIEXMB4B.bsh.corp.bshg.com (10.49.76.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1913.5; Mon, 6 Apr 2020 20:05:16 +0200
Received: from SI0SWIEXMB4B.bsh.corp.bshg.com ([fe80::69c4:2636:172d:d682]) by
 SI0SWIEXMB4B.bsh.corp.bshg.com ([fe80::69c4:2636:172d:d682%6]) with mapi id
 15.01.1913.010; Mon, 6 Apr 2020 20:05:16 +0200
From:   "Schachschal, Maximilian (GED-SDD2)" 
        <Maximilian.Schachschal@bshg.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "Klein, Thorsten (BSH)" <kleinkastel@googlemail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ] ManufacturerData field added to ScanResponse
Thread-Topic: [PATCH BlueZ] ManufacturerData field added to ScanResponse
Thread-Index: AQHWCYsUqipTvfs5XUKhwcpS7AIZe6hnzLqAgAQRMrCAAFZ2AIAAL8oA
Date:   Mon, 6 Apr 2020 18:05:16 +0000
Message-ID: <f329b0bcfbf84f6f8d65378903d4a4a9@bshg.com>
References: <1585899591-14623-1-git-send-email-thorsten.klein@bshg.com>
 <1585899591-14623-2-git-send-email-thorsten.klein@bshg.com>
 <CABBYNZLOjT7bp=M+P1QDLh2pAB0rBwjnbG5zvfaVKh_ZqQkMkQ@mail.gmail.com>
 <93524ce444664fcebf6fcdc51ac0416f@bshg.com>
 <CABBYNZJzNX1pJQsM5BKRoTNvtJqUaPrC4CqGHwbHQLxKQrM3CQ@mail.gmail.com>
In-Reply-To: <CABBYNZJzNX1pJQsM5BKRoTNvtJqUaPrC4CqGHwbHQLxKQrM3CQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.49.87.32]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-Brightmail-Tracker: H4sIAAAAAAAAA22TeVBbVRTGuXmBvMQ+5xGScgiF2uDYoVUgUoWByuDYKeC002ptmdFKScwD
        ImQxgQooEuyiYRtQsCEsstZCoSLIlpZQUizQllbHKTCWsoyFAVpbkE1l0YSEkj/8585933d/
        5zv33Hk4xu7EebhEFk8pZcI4vgOLzgqoc3vpuDwjwmesSuB/pT0b+Rf1Z2P+43N59sFYaJvu
        PiN0POdrRuhcg/th7F3WXjEVJzlJKb2DIlkxI5WvK2boictDo5gajdLTERMHcg+Uzo2jdMTC
        2aSWBv+ezbQ3G2yyD0Hj2F6LkUaD2tXLNMvHCoKa6TorYjp18369gxlxIA/ATFc+Ix3hOIcU
        wOLPx80yRqZCxrmzyLx3IkOgLW1+/TiHDIWqM78wLPv9MN98k25G6eTzcE13yCwTpB9MNLXT
        LVGdNJg1rK6zTPItKL10db0mIt2gvv4OZslyhoaJJXvL1UiovGLRgeTC1O9rVn073Br+zcGc
        hZGe8L3e24LugLyMMYYl1xF6Cx5YJxQI3zWOohzkorNJ0G3SOhtaZ0OXInoN4kZRPielAr89
        Pl5KEaVK9hF4fSCXNiDLW3JaUW/mjJcR0XBkRK/gND6XcIjOiGA/K5KLk2KEqpgTyoQ4SsXn
        EamPNO+znZ7KqgSRVKJSSeQyIwIc43MIXpYmgk2IhUnJlFJuwYzIFafznQku65MINhktjKdi
        KUpBKTfcQBznA7EqNQU6KqloKjFKEhe/YfPdCGRnZ8feauvYxtJwphH54ltM2dtkphKESiGU
        qiTRVtzFgrM31E30BjqK50wVl2N4508lprWruMq0Djxpr8LYdJlcRvGciQVzU6SZjUmQPe2J
        t4041my6JtfG2Kw7jYYQjvhOhMLczhbTf7PZDRBq8wAdreIm9PIFE0MaMPjSgENRuQHB0K0f
        GDA5fIcJg9oaR+i5MO4EmZo8Lqx82+sKJcY0d7i3tOYOmX1/esBkdqkndCy3CaBr8a4vzFzs
        DgFtoeYgLPw4/A48qsg/AXOF3ZGw3DIohsdjl6JAmzv0IUwuF0sh96tFKQzNahXw16hBAZMl
        SwnQVrSWCIaJlWwEJXN3cxF8/kdHPoJ7mTM6NG2aNs007X7R+rTjhfH/M22runlBnppGaY4g
        fW58WM8pVyHzTHeZS7Wn6uN+rkfQgcQXJ4r6bzO5aUyPrNcedLL3EUJDzu6Lq3+/90+N+9Up
        XdPBchfhbMH+lLFghnHCu792eCT3kDhVe81O8yR2a4XfmyyOMTgKmo86qD8bKCjMHzjP+TW8
        bJ9m+ouKqBTvYVbSR6eD1HnXix92ZD/0P3csbNmp2z6ibs2nuWdxlRviRX6DeeQe3u37RuPO
        WifNzrI06anW1tFdDGFKeGRpVkt1wTRXn2OvF++oOP9cy+OAwLVnboh4S17zr16vrIIYTcb8
        CyI/l+0jl9vDsOS3Vxc+hSMSvYAT0HQ61sPfDksbVJ/qC6++refTVTFCwS5MqRL+B1hSieNU
        BQAA
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPiBBZmFpayB3ZSBjYW4ganVzdCB0cnkgdG8gYXBwZW5kIHRvIGFkIGluc3Rh
bmNlIGlmIHRoYXQgZmFpbHMgdGhlbiBwcm9jZWVkIHRvDQo+IGFkZCB0byBzZCBpbnN0YW5jZSBh
ZnRlciBjaGVja2luZyBpZiB0aGUgaW5zdGFuY2UgaXMgZGlzY292ZXJhYmxlLCBzbyB0aGlzIG1p
Z2h0DQo+IG5vdCBldmVuIG5lZWQgYSBjaGFuZ2UgdG8gYnRfYWQgaXRzZWxmLCBidXQgcGVyaGFw
cyBidF9hZCBkb24ndCBhY3R1YWxseQ0KPiBpbmRpY2F0ZSBpZiBhIHByb3BlciBlcnJvciBmb3Ig
bm8gc3BhY2UgYnV0IHdlIHNob3VsZCBiZSBhZGQgYSBzcGVjaWZpYyByZXR1cg0KPiBmb3IgdGhh
dC4NCg0KQnV0IHdoZXJlIHRvIHN0b3JlIHRoZSBkYXRhIHRoZW4/IElzIHRoZXJlIGEgd2F5IHRv
IG1vdmUgaXQgZnJvbSBjbGllbnQtPmRhdGEgdG8gY2xpZW50LT5zY2FuPw0KDQpCUiwNCk1heA0K
