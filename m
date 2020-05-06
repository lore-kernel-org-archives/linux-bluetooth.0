Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C06CC28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 12:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7505E206B8
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 12:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTix/zOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgEFMJQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 08:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgEFMJP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 08:09:15 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8289C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 05:09:15 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id t8so536923qvw.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 05:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:in-reply-to:references;
        bh=fRTQgUgCqxsoFTibSbO4jyiGVkvzCzo0Z2J+ZTmS43s=;
        b=RTix/zOkjdn++mrJGQlLfSGJ6WWMZswdn+54TAAtmlPb9LQJ4VdMG7LQiJRcuBxGgG
         BfJEoaajT3MLiBGQRFmlJTYVGasNgXFTaUrNDgjfoFOuhV6Ixsd3IarCOBJoYN2KCPCK
         5QrEXUPEGFTnNN8sznVoorsMlLuq33YxncU+76Vn1GQ9leV7V7ASsHumHidzX9epzFzL
         2TdGaz+mvIOmez/pS/hUeV03GydPqwh0MzXH7DvNFJQLkhrPo22ANcOlYTVrE/1/6+JY
         Bqqdr+vFS4xWZrnFzSx+GwzspVOmmDX9tkn5POMz9xAWmcL2/q3FmpSOB97+iKsbgaAu
         dqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :in-reply-to:references;
        bh=fRTQgUgCqxsoFTibSbO4jyiGVkvzCzo0Z2J+ZTmS43s=;
        b=IIM7kWcf/uoRa9f10YNnWMZD4KsCg6+7cXSjdZp+Ynun3ToUHoNoWhCRIGHOHvyMf4
         Vt3bXu1mcrWvdfQbce1rMaMapmv0X4CSWC8A9Mr2CaC2u4lMQXQ5VD+fbtxl69TBc5mT
         riEkHfTFiauP/7XEMduyazb7+8mRFhHiS37pSijBdKb98UgTBy7jxSvjdyLx4fVEG2Ks
         +j92END+DnRksQkGuqkVkARNhi41R8XOgzAsGEfsr1sLDODPXBJnTRXEOb7Pqo2CJ1Mm
         vr8mawqvD/8ncExugsoKNZHuLLpt30fdv/NTJIB451ZABta1mzwnkCH2uAwTdKQ/spDg
         teng==
X-Gm-Message-State: AGi0Puamb04hoLVZCGkUp3fAfdJ91VKhByWN3634Wt4W+a80XExqIljv
        is/tOCTj8arkPaU95PYf9i2Mv/LiJzc=
X-Google-Smtp-Source: APiQypJQFFSL1nCz1EvoKwVwf6Rcg2LMpTZccvV0QZJCJfiSu15MPU//+qKMTsEEnR682Vb45/DtKQ==
X-Received: by 2002:ad4:5633:: with SMTP id cb19mr7431786qvb.98.1588766954820;
        Wed, 06 May 2020 05:09:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.61.10])
        by smtp.gmail.com with ESMTPSA id q17sm1513321qkq.111.2020.05.06.05.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 05:09:14 -0700 (PDT)
Message-ID: <5eb2a8ea.1c69fb81.8cc5.72c2@mx.google.com>
Date:   Wed, 06 May 2020 05:09:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3985245876020170755=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v1] shared/gatt-server: Fix read multiple charc values
In-Reply-To: <20200506194332.Bluez.v1.1.I45da219fa28f72db2e11778c15cee5aad446b1c4@changeid>
References: <20200506194332.Bluez.v1.1.I45da219fa28f72db2e11778c15cee5aad446b1c4@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3985245876020170755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

ClRoaXMgaXMgYXV0b21hdGVkIGVtYWlsIGFuZCBwbGVhc2UgZG8gbm90IHJlcGx5IHRvIHRoaXMg
ZW1haWwhCgpEZWFyIHN1Ym1pdHRlciwKClRoYW5rIHlvdSBmb3Igc3VibWl0dGluZyB0aGUgcGF0
Y2hlcyB0byB0aGUgbGludXggYmx1ZXRvb3RoIG1haWxpbmcgbGlzdC4KV2hpbGUgd2UgYXJlIHBy
ZXBhcmluZyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaGVzLCB3ZSBmb3VuZCB0aGUgZm9sbG93aW5n
Cmlzc3VlL3dhcm5pbmcuCgoKVGVzdCBSZXN1bHQ6CkNoZWNrYnVpbGQgRmFpbGVkCgpQYXRjaCBT
ZXJpZXM6CltCbHVleix2MV0gc2hhcmVkL2dhdHQtc2VydmVyOiBGaXggcmVhZCBtdWx0aXBsZSBj
aGFyYyB2YWx1ZXMKCgpPdXRwdXRzOgphcjogYHUnIG1vZGlmaWVyIGlnbm9yZWQgc2luY2UgYEQn
IGlzIHRoZSBkZWZhdWx0IChzZWUgYFUnKQpzcmMvc2hhcmVkL2dhdHQtc2VydmVyLmM6IEluIGZ1
bmN0aW9uIOKAmHJlYWRfbXVsdGlwbGVfY29tcGxldGVfY2LigJk6CnNyYy9zaGFyZWQvZ2F0dC1z
ZXJ2ZXIuYzo0MjoyNDogZXJyb3I6IGNvbXBhcmlzb24gb2YgdW5zaWduZWQgZXhwcmVzc2lvbiA8
IDAgaXMgYWx3YXlzIGZhbHNlIFstV2Vycm9yPXR5cGUtbGltaXRzXQogICA0MiB8ICNkZWZpbmUg
TUFYKGEsIGIpICgoYSkgPiAoYikgPyAoYSkgOiAoYikpCiAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICBeCnNyYy9zaGFyZWQvZ2F0dC1zZXJ2ZXIuYzo0NjoyNzogbm90ZTogaW4gZGVmaW5p
dGlvbiBvZiBtYWNybyDigJhNSU7igJkKICAgNDYgfCAjZGVmaW5lIE1JTihhLCBiKSAoKGEpIDwg
KGIpID8gKGEpIDogKGIpKQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgXgpzcmMv
c2hhcmVkL2dhdHQtc2VydmVyLmM6MTA2NToxMzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3Jv
IOKAmE1BWOKAmQogMTA2NSB8ICAgIE1JTihsZW4sIE1BWCgwLCBkYXRhLT5tdHUgLSBkYXRhLT5s
ZW5ndGggLSAzKSkgOgogICAgICB8ICAgICAgICAgICAgIF5+fgpzcmMvc2hhcmVkL2dhdHQtc2Vy
dmVyLmM6NDI6MjQ6IGVycm9yOiBjb21wYXJpc29uIG9mIHVuc2lnbmVkIGV4cHJlc3Npb24gPCAw
IGlzIGFsd2F5cyBmYWxzZSBbLVdlcnJvcj10eXBlLWxpbWl0c10KICAgNDIgfCAjZGVmaW5lIE1B
WChhLCBiKSAoKGEpID4gKGIpID8gKGEpIDogKGIpKQogICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgXgpzcmMvc2hhcmVkL2dhdHQtc2VydmVyLmM6NDY6Mzk6IG5vdGU6IGluIGRlZmluaXRp
b24gb2YgbWFjcm8g4oCYTUlO4oCZCiAgIDQ2IHwgI2RlZmluZSBNSU4oYSwgYikgKChhKSA8IChi
KSA/IChhKSA6IChiKSkKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF4Kc3JjL3NoYXJlZC9nYXR0LXNlcnZlci5jOjEwNjU6MTM6IG5vdGU6IGluIGV4cGFuc2lv
biBvZiBtYWNybyDigJhNQVjigJkKIDEwNjUgfCAgICBNSU4obGVuLCBNQVgoMCwgZGF0YS0+bXR1
IC0gZGF0YS0+bGVuZ3RoIC0gMykpIDoKICAgICAgfCAgICAgICAgICAgICBefn4KY2MxOiBhbGwg
d2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo2
ODA3OiBzcmMvc2hhcmVkL2dhdHQtc2VydmVyLmxvXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZp
bGU6NDAxMDogYWxsXSBFcnJvciAyCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgK

--===============3985245876020170755==--
