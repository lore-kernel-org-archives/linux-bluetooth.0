Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6A2C388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 00:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1E521D46
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 00:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vX9hHb/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbgKKAr6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 19:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbgKKAr5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 19:47:57 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547D9C0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 16:47:56 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 199so210496qkg.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 16:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=oLRto+qDWLJa9FhjE4edpJRrOv0oDRszMESB9MnsU20=;
        b=vX9hHb/askhRfwRXOgMhqSNdPFzaI/NYquYUoNmwglUnh/2sOyqclJbmqIk2glzoR+
         JBnD/ZUeEnd65opFwqSgQH5SmHllRKPjm1drxGfzuneTt8M6MmkreY8bLSdoJgcg3eov
         Qb1qm3SGDVYScwobzHrbjDp/SVMKLFt/FQaspCKowSwqayIf5XduYGbPg3RsCevrLL2Z
         vFXsRAxq5PkwmgJVN7uWTlbPZQ869FZLKQnt8PCbbad+g2mYadEeBlErfuNnnYNqmSSi
         +8aFDET1aw8ckjl1EBNevz/s2yuFH8fEMsVviRgnjhsiVqt66SNrIL5nDV6MRtpYwIoK
         WRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=oLRto+qDWLJa9FhjE4edpJRrOv0oDRszMESB9MnsU20=;
        b=UVYHh++I9v2LR2ZIztkubEfazCYMSWhsnuaRvqXH+J4BFeNDIaOIP7WwnGH1NFfho0
         IVqnJggVI3WpL76PUWujiXKCutJ6RMRkLCSNz3NuOSs7+F1/piHs/bCfZXEBgNAtvg36
         JjLV+20ZvTzE9EEbqiu7xS1tmUDtK/t3sP82npMbTi50HU4+lB+yx/vZ/c6JRndEUp2I
         BTTEepghMIIluN4nRleO0GZoCEBmeCnjU0d8JehdBvyRW4+vkTYohSo5IdHwq9kYEhkg
         Vb4WD/DHKHMXLhRJ65S9tUa4ddxEvnk+aHpe4JyLsyOmeBHQRQ4CU22kQWl4K3oXc64v
         Qwrg==
X-Gm-Message-State: AOAM5309ui+3Cy/aYqJpMDFSkuGrJaJ3Q7dKKZWinzL4pQWLSHkzz5Tc
        H87K9X+I0wYrFvc1PWbT+bDBaW3rmG2ptQ==
X-Google-Smtp-Source: ABdhPJxE319Iofw5Xr3VmHRIEIMqRzKFqKcN5aVJ8O5DTh4EbLR5TpDs7RNt6g5SaIPMaB5p3CdA0A==
X-Received: by 2002:a37:56c3:: with SMTP id k186mr18368774qkb.232.1605055675330;
        Tue, 10 Nov 2020 16:47:55 -0800 (PST)
Received: from [172.17.0.2] ([20.36.160.110])
        by smtp.gmail.com with ESMTPSA id q11sm577821qtp.47.2020.11.10.16.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 16:47:54 -0800 (PST)
Message-ID: <5fab34ba.1c69fb81.ff410.3013@mx.google.com>
Date:   Tue, 10 Nov 2020 16:47:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3625078104966636215=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: Battery Provider API
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201111003720.1727-2-sonnysasaka@chromium.org>
References: <20201111003720.1727-2-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3625078104966636215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MzgxNjAxCgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBGQUlMCk91dHB1dDoKYmF0dGVyeTogQWRkIHRoZSBpbnRlcm5hbCBCYXR0ZXJ5IEFQ
SQpFUlJPUjpJTklUSUFMSVNFRF9TVEFUSUM6IGRvIG5vdCBpbml0aWFsaXNlIHN0YXRpY3MgdG8g
TlVMTAojNzA6IEZJTEU6IHNyYy9iYXR0ZXJ5LmM6Mzc6CitzdGF0aWMgc3RydWN0IHF1ZXVlICpi
YXR0ZXJpZXMgPSBOVUxMOwoKRVJST1I6T1BFTl9CUkFDRTogb3BlbiBicmFjZSAneycgZm9sbG93
aW5nIGZ1bmN0aW9uIGRlZmluaXRpb25zIGdvIG9uIHRoZSBuZXh0IGxpbmUKIzcyOiBGSUxFOiBz
cmMvYmF0dGVyeS5jOjM5Ogorc3RhdGljIHZvaWQgYmF0dGVyeV9hZGQoc3RydWN0IGJ0ZF9iYXR0
ZXJ5ICpiYXR0ZXJ5KSB7CgpFUlJPUjpPUEVOX0JSQUNFOiBvcGVuIGJyYWNlICd7JyBmb2xsb3dp
bmcgZnVuY3Rpb24gZGVmaW5pdGlvbnMgZ28gb24gdGhlIG5leHQgbGluZQojNzk6IEZJTEU6IHNy
Yy9iYXR0ZXJ5LmM6NDY6CitzdGF0aWMgdm9pZCBiYXR0ZXJ5X3JlbW92ZShzdHJ1Y3QgYnRkX2Jh
dHRlcnkgKmJhdHRlcnkpIHsKCi0gdG90YWw6IDMgZXJyb3JzLCAwIHdhcm5pbmdzLCAyMTIgbGlu
ZXMgY2hlY2tlZAoKTk9URTogRm9yIHNvbWUgb2YgdGhlIHJlcG9ydGVkIGRlZmVjdHMsIGNoZWNr
cGF0Y2ggbWF5IGJlIGFibGUgdG8KICAgICAgbWVjaGFuaWNhbGx5IGNvbnZlcnQgdG8gdGhlIHR5
cGljYWwgc3R5bGUgdXNpbmcgLS1maXggb3IgLS1maXgtaW5wbGFjZS4KCiJbUEFUQ0hdIGJhdHRl
cnk6IEFkZCB0aGUgaW50ZXJuYWwgQmF0dGVyeSBBUEkiIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4KCk5PVEU6IElnbm9yZWQgbWVzc2FnZSB0eXBlczogQ09NTUlUX01FU1NBR0Ug
Q09NUExFWF9NQUNSTyBDT05TVF9TVFJVQ1QgRklMRV9QQVRIX0NIQU5HRVMgTUlTU0lOR19TSUdO
X09GRiBQUkVGRVJfUEFDS0VEIFNQTElUX1NUUklORyBTU0NBTkZfVE9fS1NUUlRPCgpOT1RFOiBJ
ZiBhbnkgb2YgdGhlIGVycm9ycyBhcmUgZmFsc2UgcG9zaXRpdmVzLCBwbGVhc2UgcmVwb3J0CiAg
ICAgIHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZSBDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKdGVzdDogQWRkIHRlc3QgYXBwIGZvciBCYXR0ZXJ5IFByb3ZpZGVyIEFQSQpFUlJPUjpFWEVD
VVRFX1BFUk1JU1NJT05TOiBkbyBub3Qgc2V0IGV4ZWN1dGUgcGVybWlzc2lvbnMgZm9yIHNvdXJj
ZSBmaWxlcwojMTI6IEZJTEU6IHRlc3QvZXhhbXBsZS1iYXR0ZXJ5LXByb3ZpZGVyCgotIHRvdGFs
OiAxIGVycm9ycywgMCB3YXJuaW5ncywgMjMwIGxpbmVzIGNoZWNrZWQKCk5PVEU6IEZvciBzb21l
IG9mIHRoZSByZXBvcnRlZCBkZWZlY3RzLCBjaGVja3BhdGNoIG1heSBiZSBhYmxlIHRvCiAgICAg
IG1lY2hhbmljYWxseSBjb252ZXJ0IHRvIHRoZSB0eXBpY2FsIHN0eWxlIHVzaW5nIC0tZml4IG9y
IC0tZml4LWlucGxhY2UuCgoiW1BBVENIXSB0ZXN0OiBBZGQgdGVzdCBhcHAgZm9yIEJhdHRlcnkg
UHJvdmlkZXIgQVBJIiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuCgpOT1RFOiBJ
Z25vcmVkIG1lc3NhZ2UgdHlwZXM6IENPTU1JVF9NRVNTQUdFIENPTVBMRVhfTUFDUk8gQ09OU1Rf
U1RSVUNUIEZJTEVfUEFUSF9DSEFOR0VTIE1JU1NJTkdfU0lHTl9PRkYgUFJFRkVSX1BBQ0tFRCBT
UExJVF9TVFJJTkcgU1NDQU5GX1RPX0tTVFJUTwoKTk9URTogSWYgYW55IG9mIHRoZSBlcnJvcnMg
YXJlIGZhbHNlIHBvc2l0aXZlcywgcGxlYXNlIHJlcG9ydAogICAgICB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUgQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tHaXRMaW50IC0gUEFTUwoKIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrQnVpbGQgLSBGQUlMCk91dHB1dDoKYXI6IGB1JyBt
b2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1
JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6
IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykK
YXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBV
JykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2Vl
IGBVJykKc3JjL2JhdHRlcnkuYzoxNTY6MjE6IGVycm9yOiBubyBwcmV2aW91cyBkZWNsYXJhdGlv
biBmb3Ig4oCYYnRkX2JhdHRlcnlfcmVnaXN0ZXLigJkgWy1XZXJyb3I9bWlzc2luZy1kZWNsYXJh
dGlvbnNdCiAgMTU2IHwgc3RydWN0IGJ0ZF9iYXR0ZXJ5ICpidGRfYmF0dGVyeV9yZWdpc3Rlcihj
b25zdCBjaGFyICpwYXRoLCBjb25zdCBjaGFyICpzb3VyY2UsCiAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fgpzcmMvYmF0dGVyeS5jOjE5Mzo2OiBlcnJvcjog
bm8gcHJldmlvdXMgZGVjbGFyYXRpb24gZm9yIOKAmGJ0ZF9iYXR0ZXJ5X3VucmVnaXN0ZXLigJkg
Wy1XZXJyb3I9bWlzc2luZy1kZWNsYXJhdGlvbnNdCiAgMTkzIHwgYm9vbCBidGRfYmF0dGVyeV91
bnJlZ2lzdGVyKHN0cnVjdCBidGRfYmF0dGVyeSAqYmF0dGVyeSkKICAgICAgfCAgICAgIF5+fn5+
fn5+fn5+fn5+fn5+fn5+fn4Kc3JjL2JhdHRlcnkuYzoyMTc6NjogZXJyb3I6IG5vIHByZXZpb3Vz
IGRlY2xhcmF0aW9uIGZvciDigJhidGRfYmF0dGVyeV91cGRhdGXigJkgWy1XZXJyb3I9bWlzc2lu
Zy1kZWNsYXJhdGlvbnNdCiAgMjE3IHwgYm9vbCBidGRfYmF0dGVyeV91cGRhdGUoc3RydWN0IGJ0
ZF9iYXR0ZXJ5ICpiYXR0ZXJ5LCB1aW50OF90IHBlcmNlbnRhZ2UpCiAgICAgIHwgICAgICBefn5+
fn5+fn5+fn5+fn5+fn4Kc3JjL2JhdHRlcnkuYzogSW4gZnVuY3Rpb24g4oCYcmVnaXN0ZXJfYmF0
dGVyeV9wcm92aWRlcuKAmToKc3JjL2JhdHRlcnkuYzo0NjM6MjogZXJyb3I6IElTTyBDOTAgZm9y
YmlkcyBtaXhlZCBkZWNsYXJhdGlvbnMgYW5kIGNvZGUgWy1XZXJyb3I9ZGVjbGFyYXRpb24tYWZ0
ZXItc3RhdGVtZW50XQogIDQ2MyB8ICBzdHJ1Y3QgYmF0dGVyeV9wcm92aWRlciAqcHJvdmlkZXIg
PQogICAgICB8ICBefn5+fn4Kc3JjL2JhdHRlcnkuYzogQXQgdG9wIGxldmVsOgpzcmMvYmF0dGVy
eS5jOjUyODo2OiBlcnJvcjogbm8gcHJldmlvdXMgZGVjbGFyYXRpb24gZm9yIOKAmG1hbmFnZXJf
ZnJlZeKAmSBbLVdlcnJvcj1taXNzaW5nLWRlY2xhcmF0aW9uc10KICA1MjggfCB2b2lkIG1hbmFn
ZXJfZnJlZShzdHJ1Y3QgYnRkX2JhdHRlcnlfcHJvdmlkZXJfbWFuYWdlciAqbWFuYWdlcikKICAg
ICAgfCAgICAgIF5+fn5+fn5+fn5+fgpzcmMvYmF0dGVyeS5jOjU0MToxOiBlcnJvcjogbm8gcHJl
dmlvdXMgZGVjbGFyYXRpb24gZm9yIOKAmGJ0ZF9iYXR0ZXJ5X3Byb3ZpZGVyX21hbmFnZXJfY3Jl
YXRl4oCZIFstV2Vycm9yPW1pc3NpbmctZGVjbGFyYXRpb25zXQogIDU0MSB8IGJ0ZF9iYXR0ZXJ5
X3Byb3ZpZGVyX21hbmFnZXJfY3JlYXRlKHN0cnVjdCBidGRfYWRhcHRlciAqYWRhcHRlcikKICAg
ICAgfCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpzcmMvYmF0dGVyeS5jOjU2
Nzo2OiBlcnJvcjogbm8gcHJldmlvdXMgZGVjbGFyYXRpb24gZm9yIOKAmGJ0ZF9iYXR0ZXJ5X3By
b3ZpZGVyX21hbmFnZXJfZGVzdHJveeKAmSBbLVdlcnJvcj1taXNzaW5nLWRlY2xhcmF0aW9uc10K
ICA1NjcgfCB2b2lkIGJ0ZF9iYXR0ZXJ5X3Byb3ZpZGVyX21hbmFnZXJfZGVzdHJveSgKICAgICAg
fCAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJu
aW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjkyODA6
IHNyYy9ibHVldG9vdGhkLWJhdHRlcnkub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQw
MjM6IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBN
YWtlQ2hlY2sgLSBTS0lQUEVECk91dHB1dDoKY2hlY2tidWlsZCBub3Qgc3VjY2VzcwoKCgotLS0K
UmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============3625078104966636215==--
