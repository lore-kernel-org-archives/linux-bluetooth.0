Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FE3C77B7D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 May 2023 08:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjENIew (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 May 2023 04:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjENIeu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 May 2023 04:34:50 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218751FFA
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 May 2023 01:34:49 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-394440f483fso2363524b6e.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 May 2023 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684053288; x=1686645288;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b3aAFNpKLO4iz9cIcXz5e7dglSVFApessUAHUvrAYSQ=;
        b=A0zEMCNee2+9X1zbglPovq3l8wT0/NsDI4HUMQCukYOsyQqNC/xxitgXmhSzfaVMUm
         LXRgImS3+GqueDhnxtd4yF4e1yzJJB/FqOr80nLzZTZ51Rmp2q3mqJghMRJj/p+i3axQ
         s7e2wJlJPJv6+iNZUHhqMIdt2UeRogkyC1IVc+mHhANKsGoBBzr9hLZmsKX0vGAdoGo+
         XbweC1cRSgYiSAgZNXxR/ln86/CcHFrpL11h6A4r81TOFVwhGzBh45tmu2PjgQPmFvYV
         8D9z8QBpkKBk+T7OaPeiYcSPk4NwKtA8EIAJr06+c50sUaFX6GW3J2IDisziUThkxU/k
         O21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684053288; x=1686645288;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3aAFNpKLO4iz9cIcXz5e7dglSVFApessUAHUvrAYSQ=;
        b=b67VaN29/k9aMxC8GsVXGCuFQQ09SVkK0O7D/l1pwbJtD/51EDanrhFKSLPTyzyz7k
         WNQieCUhnCLCUWd3DMMBQYuWjGor8Cs4h22neBbzv/OxDz0E7rC/G8yO53jvyc3tY8DP
         4m2O/PWbc8x77X9t9cUh7nZNKHQIc/HmIa/OYaS+zRiNP1yHcA5smS7JJF1MSUr9cbQ6
         wCU11PMGNHf1kXoHTfFRIAHI9wVRshjkGtZG/cyfYOFtEtGS/U0F6tfZ6wusmwIFQMpC
         zUDr5uelqaG+LLr9YxSbhU1OqV+Jk5I1+MDzDPEWrSrXTRX31dcpOFL/oIDP13iDM7qP
         YFPQ==
X-Gm-Message-State: AC+VfDz6BdJgR87g1I3PdZeqVDQVDeYzUWA7thmkuRnoGKyh2BQeM1Kr
        bFQY6lJBq9rdxWsr0/UHlRMBwbB8URo=
X-Google-Smtp-Source: ACHHUZ67UAskPZQOU7f4CbFT3M/SC8ubE9DrXk+zlolB2b6gptLszX99pB/loWPfmqSQEcIQ/GPdTQ==
X-Received: by 2002:a54:4391:0:b0:395:f3ee:d191 with SMTP id u17-20020a544391000000b00395f3eed191mr1137930oiv.23.1684053288210;
        Sun, 14 May 2023 01:34:48 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.133.18])
        by smtp.gmail.com with ESMTPSA id z5-20020aca6705000000b00383ce81c186sm6088468oix.32.2023.05.14.01.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 01:34:48 -0700 (PDT)
Message-ID: <64609d28.ca0a0220.a2c28.2166@mx.google.com>
Date:   Sun, 14 May 2023 01:34:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3415228691816271308=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rudi@heitbaum.com
Subject: RE: Bluetooth: btrtl: Add support for RTL8822BS
In-Reply-To: <20230514074731.70614-2-rudi@heitbaum.com>
References: <20230514074731.70614-2-rudi@heitbaum.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3415228691816271308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NzQ3MzE4CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMi4wNCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjg5IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgRkFJTCAg
ICAgIDAuNjAgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MzIuNTAgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBXQVJOSU5HICAgMzUu
NjIgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgNDAuODcg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMTEwLjI3IHNl
Y29uZHMKQnVpbGRLZXJuZWwzMiAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDMxLjgzIHNlY29u
ZHMKVGVzdFJ1bm5lclNldHVwICAgICAgICAgICAgICAgUEFTUyAgICAgIDQ1Ny40NyBzZWNvbmRz
ClRlc3RSdW5uZXJfbDJjYXAtdGVzdGVyICAgICAgIFBBU1MgICAgICAxNy4yMiBzZWNvbmRzClRl
c3RSdW5uZXJfaXNvLXRlc3RlciAgICAgICAgIFBBU1MgICAgICAyMS44NCBzZWNvbmRzClRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA1LjY3IHNlY29uZHMKVGVzdFJ1bm5l
cl9tZ210LXRlc3RlciAgICAgICAgUEFTUyAgICAgIDExNy41NyBzZWNvbmRzClRlc3RSdW5uZXJf
cmZjb21tLXRlc3RlciAgICAgIFBBU1MgICAgICA5LjExIHNlY29uZHMKVGVzdFJ1bm5lcl9zY28t
dGVzdGVyICAgICAgICAgUEFTUyAgICAgIDguNDEgc2Vjb25kcwpUZXN0UnVubmVyX2lvY3RsLXRl
c3RlciAgICAgICBQQVNTICAgICAgOS44OCBzZWNvbmRzClRlc3RSdW5uZXJfbWVzaC10ZXN0ZXIg
ICAgICAgIFBBU1MgICAgICA3LjIwIHNlY29uZHMKVGVzdFJ1bm5lcl9zbXAtdGVzdGVyICAgICAg
ICAgUEFTUyAgICAgIDguMzEgc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFuLXRlc3RlciAgICBQ
QVNTICAgICAgNi4wMiBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAgICAgICAgIFBBU1Mg
ICAgICAzOS41OSBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwpUZXN0OiBTdWJqZWN0UHJlZml4IC0gRkFJTApEZXNjOiBDaGVjayBzdWJqZWN0IGNvbnRhaW5z
ICJCbHVldG9vdGgiIHByZWZpeApPdXRwdXQ6CiJCbHVldG9vdGg6ICIgcHJlZml4IGlzIG5vdCBz
cGVjaWZpZWQgaW4gdGhlIHN1YmplY3QKIkJsdWV0b290aDogIiBwcmVmaXggaXMgbm90IHNwZWNp
ZmllZCBpbiB0aGUgc3ViamVjdAojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDog
Q2hlY2tBbGxXYXJuaW5nIC0gV0FSTklORwpEZXNjOiBSdW4gbGludXgga2VybmVsIHdpdGggYWxs
IHdhcm5pbmcgZW5hYmxlZApPdXRwdXQ6CmRyaXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmM6IEluIGZ1
bmN0aW9uIOKAmGJ0cnRsX3NldF9xdWlya3PigJk6ZHJpdmVycy9ibHVldG9vdGgvYnRydGwuYzox
MTk0OjM6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2ggWy1XaW1wbGlj
aXQtZmFsbHRocm91Z2g9XSAxMTk0IHwgICBzZXRfYml0KEhDSV9RVUlSS19CUk9LRU5fTE9DQUxf
RVhUX0ZFQVRVUkVTX1BBR0VfMiwgJmhkZXYtPnF1aXJrcyk7ICAgICAgfCAgIF5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fmRy
aXZlcnMvYmx1ZXRvb3RoL2J0cnRsLmM6MTE5NToyOiBub3RlOiBoZXJlIDExOTUgfCAgZGVmYXVs
dDogICAgICB8ICBefn5+fn5+CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBD
aGVja1NwYXJzZSAtIFdBUk5JTkcKRGVzYzogUnVuIHNwYXJzZSB0b29sIHdpdGggbGludXgga2Vy
bmVsCk91dHB1dDoKZHJpdmVycy9ibHVldG9vdGgvYnRydGwuYzogSW4gZnVuY3Rpb24g4oCYYnRy
dGxfc2V0X3F1aXJrc+KAmTpkcml2ZXJzL2JsdWV0b290aC9idHJ0bC5jOjExOTQ6Mzogd2Fybmlu
ZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3Vn
aD1dZHJpdmVycy9ibHVldG9vdGgvYnRydGwuYzoxMTk1OjI6IG5vdGU6IGhlcmUKIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrU21hdGNoIC0gV0FSTklORwpEZXNjOiBS
dW4gc21hdGNoIHRvb2wgd2l0aCBzb3VyY2UKT3V0cHV0Ogpkcml2ZXJzL2JsdWV0b290aC9idHJ0
bC5jOiBJbiBmdW5jdGlvbiDigJhidHJ0bF9zZXRfcXVpcmtz4oCZOmRyaXZlcnMvYmx1ZXRvb3Ro
L2J0cnRsLmM6MTE5NDozOiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdo
IFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV1kcml2ZXJzL2JsdWV0b290aC9idHJ0bC5jOjExOTU6
Mjogbm90ZTogaGVyZQoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============3415228691816271308==--
