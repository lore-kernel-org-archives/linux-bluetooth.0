Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738AFEE3F2F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 14:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbjIOOo0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 10:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjIOOo0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 10:44:26 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D251FD2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 07:44:17 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3acac5d0b91so1111458b6e.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694789056; x=1695393856; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DLSgXgyilrH52P3JLI31SzBMv5gjN4oIukX6Fd41wps=;
        b=aGJHr0XPTPyoIjrh/XtIgDkj0Ao7rZCmbqCOctkRaq6NEyYpw29gmyb/u7xQ09a9gb
         fMDFg2N1zffsH39vjSycoDVCH+BITBrtbyoaQQ6lCtQzJb3u0xXozdtEJjvITmvYgUUP
         yd0B8Q5SOW5S/WcFDFAkVStvkhAb9Sx5iacOFjZXVht/haMFvEuFDIw9z9gBu0zDPwSD
         3qtjIfSMrVt+8gK5DHG4GFtfyEeRTm5QEUInMf4pPg60yUJH8QjjUil0M0RimXSW0c/Y
         0fP9URR4tpHctxY4zl/VWgotmrDbDDt/qFv6nSe9zwhu1JgtgX/zWfxpwTTv6tSTKrI8
         9Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694789056; x=1695393856;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLSgXgyilrH52P3JLI31SzBMv5gjN4oIukX6Fd41wps=;
        b=LB0IRj1brsdtUoFDhN33KYDwVdkeUUmTNgHvPNP8T1xX3l4VM3m0DpWYC8j62fj5yZ
         ILfTAeUlPbtpoIodFeHNwbqcCprXwcQ4CPtUCkqLbYCouIG5tzAvxRsg3xs3XL/6VIN2
         XG1KtZY0nkB9Kow0v5t0qRVaObkkWxj2u8lBcRYZdirr+7hlihVulmHBqLh25sYO0I5Z
         G4CW5bN+I++PH3QJz07ZM6zQZPRdDVv8/aOnzr2RMaDAUKKYa+gzhMtUcj4Aib1MdJcD
         wAGfeCgKC+/Cp24XZoG2X5NwMCRzYlNl7jqorqKzysbJ7ALN6/3V3U4C7U10TsTe7YDV
         YcYA==
X-Gm-Message-State: AOJu0Yzxeg151wVujDWKqqO+VOza/Obx5gm9PoGkZmTJCPk6UnepWshO
        +GriZ2ZzLS000ud70FUk3QGkmzppZZ0=
X-Google-Smtp-Source: AGHT+IGIniXYvJalNyYzuvZbWfMglrmoP7QXbGNk1lnR6stjtcu8iEpq7wEXhc7ASHJyNQ86Kp5g0g==
X-Received: by 2002:a54:441a:0:b0:3a9:c2d6:41ef with SMTP id k26-20020a54441a000000b003a9c2d641efmr1978018oiw.43.1694789055881;
        Fri, 15 Sep 2023 07:44:15 -0700 (PDT)
Received: from [172.17.0.2] ([23.102.140.63])
        by smtp.gmail.com with ESMTPSA id x49-20020a056830247100b006c20f55525esm317434otr.1.2023.09.15.07.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 07:44:15 -0700 (PDT)
Message-ID: <65046dbf.050a0220.8105c.1a03@mx.google.com>
Date:   Fri, 15 Sep 2023 07:44:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1435955883068510794=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: Implementation of MICP and MICS Unit Testcases
In-Reply-To: <20230915131831.119124-2-mahesh.talewad@nxp.com>
References: <20230915131831.119124-2-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1435955883068510794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9Nzg0NjAyCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS4wNCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjMwIHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI4LjY2IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDEwNTMuNTcgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTIuODUgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTQz
LjkwIHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI2OC45
MSBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzNjYuNjUg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTEyLjU5IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDg5NC4zOSBzZWNv
bmRzClNjYW5CdWlsZCAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxMTE1LjU3IHNlY29u
ZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VDaGVj
ayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sKT3V0cHV0OgoKLi90ZXN0LWRyaXZl
cjogbGluZSAxMDc6IDMxNDIwIEFib3J0ZWQgICAgICAgICAgICAgICAgIChjb3JlIGR1bXBlZCkg
IiRAIiA+ICRsb2dfZmlsZSAyPiYxCm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTE0MzM6IHRlc3Qt
c3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTE1NDE6IGNoZWNrLVRF
U1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTE5NjM6IGNoZWNrLWFtXSBFcnJv
ciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTE5NjU6IGNoZWNrXSBFcnJvciAyCiMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlRGlzdGNoZWNrIC0gRkFJTApEZXNjOiBSdW4g
Qmx1ZXogTWFrZSBEaXN0Y2hlY2sKT3V0cHV0OgoKLi4vLi4vdGVzdC1kcml2ZXI6IGxpbmUgMTA3
OiA1MzA3MyBBYm9ydGVkICAgICAgICAgICAgICAgICAoY29yZSBkdW1wZWQpICIkQCIgPiAkbG9n
X2ZpbGUgMj4mMQptYWtlWzRdOiAqKiogW01ha2VmaWxlOjExNDMzOiB0ZXN0LXN1aXRlLmxvZ10g
RXJyb3IgMQptYWtlWzNdOiAqKiogW01ha2VmaWxlOjExNTQxOiBjaGVjay1URVNUU10gRXJyb3Ig
MgptYWtlWzJdOiAqKiogW01ha2VmaWxlOjExOTYzOiBjaGVjay1hbV0gRXJyb3IgMgptYWtlWzFd
OiAqKiogW01ha2VmaWxlOjExOTY1OiBjaGVja10gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxl
OjExODg2OiBkaXN0Y2hlY2tdIEVycm9yIDEKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
ClRlc3Q6IENoZWNrVmFsZ3JpbmQgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrIHdp
dGggVmFsZ3JpbmQKT3V0cHV0OgoKdG9vbHMvbWdtdC10ZXN0ZXIuYzogSW4gZnVuY3Rpb24g4oCY
bWFpbuKAmToKdG9vbHMvbWdtdC10ZXN0ZXIuYzoxMjc2Mzo1OiBub3RlOiB2YXJpYWJsZSB0cmFj
a2luZyBzaXplIGxpbWl0IGV4Y2VlZGVkIHdpdGgg4oCYLWZ2YXItdHJhY2tpbmctYXNzaWdubWVu
dHPigJksIHJldHJ5aW5nIHdpdGhvdXQKMTI3NjMgfCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
YXJndltdKQogICAgICB8ICAgICBefn5+Ci4vdGVzdC1kcml2ZXI6IGxpbmUgMTA3OiA3MjQ5NyBB
Ym9ydGVkICAgICAgICAgICAgICAgICAoY29yZSBkdW1wZWQpICIkQCIgPiAkbG9nX2ZpbGUgMj4m
MQptYWtlWzNdOiAqKiogW01ha2VmaWxlOjExNDMzOiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3IgMQpt
YWtlWzJdOiAqKiogW01ha2VmaWxlOjExNTQxOiBjaGVjay1URVNUU10gRXJyb3IgMgptYWtlWzFd
OiAqKiogW01ha2VmaWxlOjExOTYzOiBjaGVjay1hbV0gRXJyb3IgMgptYWtlOiAqKiogW01ha2Vm
aWxlOjExOTY1OiBjaGVja10gRXJyb3IgMgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgK
Cg==

--===============1435955883068510794==--
