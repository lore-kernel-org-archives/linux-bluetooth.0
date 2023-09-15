Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5E2CD37AC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 21:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbjIOVC7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 17:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbjIOVCk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 17:02:40 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638C71713
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 14:01:33 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7a7d7a3d975so1248283241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694811692; x=1695416492; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dIh9kDwYjry82i86Nv264/7VCoifzbguLMEw0hmH6y4=;
        b=mVf5Xf8TlVIx/PIo5BuqpzpN+vDiBtRp2k2nY4N/JuOoVZUccp+/LibFVuLhZTpDru
         Xk9tEd5LzvV0v28c0sit2pY3Vw9PnZRXo1FErdlegeGpu0NA/b8PEACQotAxR8rsLLrM
         jCD9mci++UKj5Bds+ur2oZSTIzKIDjyx/KG8Svgc1g9kPTUeorrI424Tp48/5udSXSTo
         Ne/MMfbbyQhaLS81MUa2JqJeUYz6rFV3ESNwYSIQekX99dxqPxkkOhCIohNGgHzMK5ii
         rvv69tFymVckFuO+SH0MRE7Q9Zaa0wjtD0JipgRfCTdx+46cPWEVPalcR4hA43ADAd1F
         wYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694811692; x=1695416492;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIh9kDwYjry82i86Nv264/7VCoifzbguLMEw0hmH6y4=;
        b=R+UcUgVbm1WV4fsQdf8PiVD4x8Wb7Q8KXBcb+0HrD/NrgBzY7510lY4RbrEe3Hsqj5
         IdsWW3hVkO7jbXktk+CI45jOi647hv/0Fdjq1AoBfyZ68aIOoeSjJl9Ejgk1Oawgr13N
         Gn++IecTlVUSBlg/GKeWBvGl7tQEPqqsOxFlZ1VCB1zt8w/DURRF8+8yOvPG5BrwuGTZ
         PoF39NZwpUBq+7KnNpgl3oOheUhgj0+CHIUCeDtOy2KtLRk3SqZDEXfszcni+Yrfrjqg
         IWQSSlHMvk2A1cg1YTAFMjTPqIHGdJYgCFx6vQCTkCJn23oSUIyPK5ohSNA7cNLmRKiW
         bikw==
X-Gm-Message-State: AOJu0YzewMEjSo02Skh/qmJqtLtQUNKj97MpQDZeEst7didssvu936ZM
        N/zrii5RGP53EXW5d7SqIgHYJWQdNXE=
X-Google-Smtp-Source: AGHT+IFtB22BBITQDJugOC6IAJ1tjxoh+PAji66LtDPEV5lh17Ux+WxRnaibSQDBLo+EaOwhFa3cAQ==
X-Received: by 2002:a67:fbd9:0:b0:44f:5c54:4b02 with SMTP id o25-20020a67fbd9000000b0044f5c544b02mr2618645vsr.33.1694811692318;
        Fri, 15 Sep 2023 14:01:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.8.208])
        by smtp.gmail.com with ESMTPSA id b5-20020a0cc985000000b0064bdd4239f3sm1535814qvk.126.2023.09.15.14.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:01:31 -0700 (PDT)
Message-ID: <6504c62b.0c0a0220.16f0d.7989@mx.google.com>
Date:   Fri, 15 Sep 2023 14:01:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5061811148148072791=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_codec: Fix leaking content of local_codecs
In-Reply-To: <20230915202447.3521406-1-luiz.dentz@gmail.com>
References: <20230915202447.3521406-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5061811148148072791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9Nzg0ODIyCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC45MSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjM3IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTQgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MzMuNDggc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBXQVJOSU5HICAgMzYu
Nzcgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgNDEuOTgg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMTE2LjM2IHNl
Y29uZHMKQnVpbGRLZXJuZWwzMiAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDMyLjM5IHNlY29u
ZHMKVGVzdFJ1bm5lclNldHVwICAgICAgICAgICAgICAgUEFTUyAgICAgIDQ5Mi41MiBzZWNvbmRz
ClRlc3RSdW5uZXJfbDJjYXAtdGVzdGVyICAgICAgIFBBU1MgICAgICAyOS45MyBzZWNvbmRzClRl
c3RSdW5uZXJfaXNvLXRlc3RlciAgICAgICAgIFBBU1MgICAgICA0OS42NCBzZWNvbmRzClRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA5Ljg4IHNlY29uZHMKVGVzdFJ1bm5l
cl9tZ210LXRlc3RlciAgICAgICAgUEFTUyAgICAgIDIyNS43OSBzZWNvbmRzClRlc3RSdW5uZXJf
cmZjb21tLXRlc3RlciAgICAgIFBBU1MgICAgICAxNS4xNSBzZWNvbmRzClRlc3RSdW5uZXJfc2Nv
LXRlc3RlciAgICAgICAgIFBBU1MgICAgICAxOC43MyBzZWNvbmRzClRlc3RSdW5uZXJfaW9jdGwt
dGVzdGVyICAgICAgIFBBU1MgICAgICAxNi43MSBzZWNvbmRzClRlc3RSdW5uZXJfbWVzaC10ZXN0
ZXIgICAgICAgIFBBU1MgICAgICAxMi41OSBzZWNvbmRzClRlc3RSdW5uZXJfc21wLXRlc3RlciAg
ICAgICAgIFBBU1MgICAgICAxMy40OCBzZWNvbmRzClRlc3RSdW5uZXJfdXNlcmNoYW4tdGVzdGVy
ICAgIFBBU1MgICAgICAxMC4zNiBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAgICAgICAg
IFBBU1MgICAgICAzMC41NCBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIwpUZXN0OiBDaGVja0FsbFdhcm5pbmcgLSBXQVJOSU5HCkRlc2M6IFJ1biBsaW51eCBr
ZXJuZWwgd2l0aCBhbGwgd2FybmluZyBlbmFibGVkCk91dHB1dDoKbmV0L2JsdWV0b290aC9oY2lf
Y29yZS5jOiBJbiBmdW5jdGlvbiDigJhoY2lfcmVnaXN0ZXJfZGV24oCZOm5ldC9ibHVldG9vdGgv
aGNpX2NvcmUuYzoyNjIwOjQ3OiB3YXJuaW5nOiDigJglZOKAmSBkaXJlY3RpdmUgb3V0cHV0IG1h
eSBiZSB0cnVuY2F0ZWQgd3JpdGluZyBiZXR3ZWVuIDEgYW5kIDEwIGJ5dGVzIGludG8gYSByZWdp
b24gb2Ygc2l6ZSA1IFstV2Zvcm1hdC10cnVuY2F0aW9uPV0gMjYyMCB8ICBzbnByaW50ZihoZGV2
LT5uYW1lLCBzaXplb2YoaGRldi0+bmFtZSksICJoY2klZCIsIGlkKTsgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefm5ldC9ibHVldG9vdGgvaGNp
X2NvcmUuYzoyNjIwOjQzOiBub3RlOiBkaXJlY3RpdmUgYXJndW1lbnQgaW4gdGhlIHJhbmdlIFsw
LCAyMTQ3NDgzNjQ3XSAyNjIwIHwgIHNucHJpbnRmKGhkZXYtPm5hbWUsIHNpemVvZihoZGV2LT5u
YW1lKSwgImhjaSVkIiwgaWQpOyAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXn5+fn5+fm5ldC9ibHVldG9vdGgvaGNpX2NvcmUuYzoyNjIwOjI6IG5vdGU6
IOKAmHNucHJpbnRm4oCZIG91dHB1dCBiZXR3ZWVuIDUgYW5kIDE0IGJ5dGVzIGludG8gYSBkZXN0
aW5hdGlvbiBvZiBzaXplIDggMjYyMCB8ICBzbnByaW50ZihoZGV2LT5uYW1lLCBzaXplb2YoaGRl
di0+bmFtZSksICJoY2klZCIsIGlkKTsgICAgICB8ICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMKVGVzdDogQ2hlY2tTcGFyc2UgLSBXQVJOSU5HCkRlc2M6IFJ1biBzcGFyc2UgdG9vbCB3aXRo
IGxpbnV4IGtlcm5lbApPdXRwdXQ6Cm5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6IG5vdGU6IGlu
IGluY2x1ZGVkIGZpbGUgKHRocm91Z2ggaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmgp
OgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tTbWF0Y2ggLSBXQVJO
SU5HCkRlc2M6IFJ1biBzbWF0Y2ggdG9vbCB3aXRoIHNvdXJjZQpPdXRwdXQ6Cm5ldC9ibHVldG9v
dGgvaGNpX2V2ZW50LmM6IG5vdGU6IGluIGluY2x1ZGVkIGZpbGUgKHRocm91Z2ggaW5jbHVkZS9u
ZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmgpOgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgK
Cg==

--===============5061811148148072791==--
