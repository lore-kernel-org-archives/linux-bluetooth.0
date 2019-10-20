Return-Path: <SRS0=2Cj2=YN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C95CA9EA9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Oct 2019 08:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38989218BA
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Oct 2019 08:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCWXZ7gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfJTIq2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Oct 2019 04:46:28 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:36394 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJTIq2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Oct 2019 04:46:28 -0400
Received: by mail-wr1-f44.google.com with SMTP id w18so9924220wrt.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2019 01:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version;
        bh=zCdXPudc+OIAu0FoWglaKmBSWDfo7M17biPwlw49Seo=;
        b=MCWXZ7gtxtLSkMfGCTgGL/0pjG823rk09mf/Aez/NUYtUk+2pQ5HkASgL+70snnd1U
         w+LYgxlT+Gb12Ie7weD7IaDNPrU9WjJes+6JxYJV2dNNfGmSF0MTCYUTJZ4xqciC/+Fw
         wZg7jcodU74rGTXV1SUfKh0z0ccN34ofXzok2qzE6tRSJhfxHPAkGBHpT6e1arutZqyS
         BSztq0xkAAeDpg7jJVqY99s3ZDJOv1Xez1+i8RwElr+NkX0tQB190qlZaUSl9MnsyqMR
         jv8uHevDRFJrMDXDh1av1KFl6+3ZJxQqstqKFIcho55H/FMyXI0RvZTHo80mR/jRiuyo
         9ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version;
        bh=zCdXPudc+OIAu0FoWglaKmBSWDfo7M17biPwlw49Seo=;
        b=IB+9BfCmw1TR/CrJbRS649xyK2US6cziTMihmj/WJbg1i+exyxgnt7MthDhzhfkZjL
         Wz/IVRTm4CMHMMEKdMW7poYDl4s0nXBh5lvAstGCUr/igKCNUlowqvFv2R/rgBPcXQ0C
         263FkN3ELTXhzXtH4D9WYpGQ0r4MtBya1XV9qWjrzEegLTlft8pu/81ap87hOaTwjlff
         EshG3BfiLviHiSLwLDMouP+UebKS7xJ2rJZDh9gTpoN2k2f+UTIEBqTS29VDQYDe+1fX
         KAbJisPxtjU26r7dv9QoCyRaGHeBn5/a82FbYj2yiMgEChwRaovdltP2cOrcZQANL92Z
         bp3g==
X-Gm-Message-State: APjAAAXRkQFba9hTJ+Y19h5HKt0zpChnwgNvPkHr6WZFI1H3IX59WVvV
        UhZPPGx4ntl3jCMyQAxtPx73Vx3Wog==
X-Google-Smtp-Source: APXvYqwTTjie6LNThJwRJIf5UgJ59T5AhtShFQ4kQbPKBsFI1WOKxkp7FRqrhdLGevBo1FJMfeCVtQ==
X-Received: by 2002:a5d:424a:: with SMTP id s10mr9984958wrr.108.1571561185379;
        Sun, 20 Oct 2019 01:46:25 -0700 (PDT)
Received: from [10.100.0.6] ([89.131.18.179])
        by smtp.gmail.com with ESMTPSA id g5sm7968817wmg.12.2019.10.20.01.46.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 01:46:24 -0700 (PDT)
Message-ID: <19fda684fa8b3c604a2c763b7cb890e794c734d4.camel@gmail.com>
Subject: [PATCH] Missing headers for non GLIBC systems
From:   Francisco Ramos <pachoramos@gmail.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Sun, 20 Oct 2019 10:46:16 +0200
Content-Type: multipart/mixed; boundary="=-QmPEVc3zVycUVQl9gwQp"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--=-QmPEVc3zVycUVQl9gwQp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

As can be seen in downstream bug, we need to apply 0001-Include-limits.h-for-
PATH_MAX.patch to fix building in non-glibc systems
https://bugs.gentoo.org/695940

Thanks

--=-QmPEVc3zVycUVQl9gwQp
Content-Disposition: attachment; filename="0001-Include-limits.h-for-PATH_MAX.patch"
Content-Type: text/x-patch; name="0001-Include-limits.h-for-PATH_MAX.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAyMDEyOGM1Yzk1ZmJhZTkzYzlmZDk5NmQ1YWQyNTg0Y2Y2YWQ4MDMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb3J5IFByYXR0IDxhbmFyY2h5QGdlbnRvby5vcmc+CkRhdGU6
IE1vbiwgMzAgU2VwIDIwMTkgMTg6MzU6NTYgLTA1MDAKU3ViamVjdDogW1BBVENIXSBJbmNsdWRl
IGxpbWl0cy5oIGZvciBQQVRIX01BWAoKU2lnbmVkLW9mZi1ieTogSm9yeSBQcmF0dCA8YW5hcmNo
eUBnZW50b28ub3JnPgotLS0KIG1lc2gva2V5cmluZy5jICAgICAgICAgIHwgMSArCiBtZXNoL21l
c2gtY29uZmlnLWpzb24uYyB8IDEgKwogbWVzaC9ub2RlLmMgICAgICAgICAgICAgfCAxICsKIG1l
c2gvdXRpbC5jICAgICAgICAgICAgIHwgMSArCiA0IGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL21lc2gva2V5cmluZy5jIGIvbWVzaC9rZXlyaW5nLmMKaW5kZXgg
M2E3ZjkyZi4uOWZhN2Q2YiAxMDA2NDQKLS0tIGEvbWVzaC9rZXlyaW5nLmMKKysrIGIvbWVzaC9r
ZXlyaW5nLmMKQEAgLTI0LDYgKzI0LDcgQEAKICNkZWZpbmUgX0dOVV9TT1VSQ0UKICNpbmNsdWRl
IDxmY250bC5oPgogI2luY2x1ZGUgPGRpcmVudC5oPgorI2luY2x1ZGUgPGxpbWl0cy5oPgogI2lu
Y2x1ZGUgPHN0ZGlvLmg+CiAjaW5jbHVkZSA8dW5pc3RkLmg+CiAjaW5jbHVkZSA8ZGlyZW50Lmg+
CmRpZmYgLS1naXQgYS9tZXNoL21lc2gtY29uZmlnLWpzb24uYyBiL21lc2gvbWVzaC1jb25maWct
anNvbi5jCmluZGV4IGNhZmEyZmQuLjc0Y2E0OTUgMTAwNjQ0Ci0tLSBhL21lc2gvbWVzaC1jb25m
aWctanNvbi5jCisrKyBiL21lc2gvbWVzaC1jb25maWctanNvbi5jCkBAIC0yNyw2ICsyNyw3IEBA
CiAjaW5jbHVkZSA8ZmNudGwuaD4KICNpbmNsdWRlIDxmdHcuaD4KICNpbmNsdWRlIDxsaWJnZW4u
aD4KKyNpbmNsdWRlIDxsaW1pdHMuaD4KICNpbmNsdWRlIDxzdGRpby5oPgogI2luY2x1ZGUgPHN0
cmluZy5oPgogI2luY2x1ZGUgPHVuaXN0ZC5oPgpkaWZmIC0tZ2l0IGEvbWVzaC9ub2RlLmMgYi9t
ZXNoL25vZGUuYwppbmRleCBiNjgyNGY1Li4xNWRjYjk3IDEwMDY0NAotLS0gYS9tZXNoL25vZGUu
YworKysgYi9tZXNoL25vZGUuYwpAQCAtMjMsNiArMjMsNyBAQAogCiAjZGVmaW5lIF9HTlVfU09V
UkNFCiAjaW5jbHVkZSA8ZGlyZW50Lmg+CisjaW5jbHVkZSA8bGltaXRzLmg+CiAjaW5jbHVkZSA8
c3RkaW8uaD4KICNpbmNsdWRlIDxzeXMvdGltZS5oPgogCmRpZmYgLS1naXQgYS9tZXNoL3V0aWwu
YyBiL21lc2gvdXRpbC5jCmluZGV4IDE0NTViZGUuLjk4NmJhNGIgMTAwNjQ0Ci0tLSBhL21lc2gv
dXRpbC5jCisrKyBiL21lc2gvdXRpbC5jCkBAIC0yNSw2ICsyNSw3IEBACiAjaW5jbHVkZSA8ZGly
ZW50Lmg+CiAjaW5jbHVkZSA8ZnR3Lmg+CiAjaW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNsdWRlIDxs
aW1pdHMuaD4KICNpbmNsdWRlIDx0aW1lLmg+CiAjaW5jbHVkZSA8c3lzL3RpbWUuaD4KIAotLSAK
Mi4yMy4wCgo=


--=-QmPEVc3zVycUVQl9gwQp--

