Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23C1C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Nov 2022 07:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiKEHOV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Nov 2022 03:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKEHOT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Nov 2022 03:14:19 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BAA3134C
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Nov 2022 00:14:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y203so6348258pfb.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Nov 2022 00:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WM769xgWLhWoOxgIm+wbb5sjENy5ab99vOQa0hbQqEE=;
        b=VBeeA7UZ5svHabAGR3cKpzOKW77FEqurk9KxQoaZrbv+G40ew5d2aNmtpOwnwyUTaE
         EDj+GyOsudleIPS44X0H1tIROnb8+D7tKLwBPeY6cPaA8/Ihj5uYVpY0M+Dw7wC71pWW
         uJrfbjDIcLVMMyT1CZ1y9SksWcfXupGPlnG/NmdgZ5GcDOKmoe8mhfNG70c5JqSosXda
         XIkqc/tusy1hqj+qiwi6XyE5C+D/V6zBYGjqgnpGKNrbasWBzxhmzb+FLBujpLyHiUcO
         6hKbnv31OnZBcZED/lLztubM7gnwUw3NjgRA7Xn4MHfkHp7A/JUu0b3NdWqa2UgTQyas
         OsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WM769xgWLhWoOxgIm+wbb5sjENy5ab99vOQa0hbQqEE=;
        b=WezZsHEAlFxi/sd4JhuMtj8JP0ZNY6CDQa+Beh6HSex2yTQZMjCEIxwFPSwnIuxuqi
         DXZo8P5Ag5fGqK2Sz4N8Y6Scbkq81octZ0H+lSbGmdx44p/4GmLUWKidfg6v8iCn4Ebt
         q1/kx4QGQzkYarqQCOAMxupXpZRLcvI9ZxO3LtWvc6acVLnXgVy1RF3oLt9AylZVlXHV
         IUDsp/a05SGDpoPGeWztmjPP6Ws6ebLYJ9P840s+xrZsEsmcOkoC2/iJLtrri3gMlIH9
         +mqjskaHKXHMtD/nAlYt/sSQy5b4QIXExOKVW1xPERD+j2FeuZ1jIiJheDi9+bsymIho
         KUtw==
X-Gm-Message-State: ACrzQf2kxlPrbW2vDljBiRapJMWX14rRY64dPG4ZtFmi2xroRH2a/XYQ
        uRsSkL/V7yXvVG4dOHLYWHAimGjlcg/6FQ==
X-Google-Smtp-Source: AMsMyM5enct0swMD2ak70o5fhQ98ive/F0KprqkW/8IkYHsMqq66WLlm48yulbB5gyHxGMKuTeTXtg==
X-Received: by 2002:a63:1041:0:b0:46e:c6eb:22ee with SMTP id 1-20020a631041000000b0046ec6eb22eemr33432791pgq.442.1667632456184;
        Sat, 05 Nov 2022 00:14:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.250.145])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b00186e34524e3sm922260plk.136.2022.11.05.00.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 00:14:15 -0700 (PDT)
Message-ID: <63660d47.170a0220.3ccdb.1d9e@mx.google.com>
Date:   Sat, 05 Nov 2022 00:14:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0461624343494960215=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rostedt@goodmis.org
Subject: RE: timers: Use timer_shutdown*() before freeing timers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221105060156.686027537@goodmis.org>
References: <20221105060156.686027537@goodmis.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0461624343494960215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkyMzQ4CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS4yOSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjQ5IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMzUgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MzAuODYgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjUu
OTQgc2Vjb25kcwpJbmNyZW1lbnRhbCBCdWlsZCB3aXRoIHBhdGNoZXNFUlJPUiAgICAgMC4xOCBz
ZWNvbmRzClRlc3RSdW5uZXI6IFNldHVwICAgICAgICAgICAgIFBBU1MgICAgICA1OTguMTkgc2Vj
b25kcwpUZXN0UnVubmVyOiBsMmNhcC10ZXN0ZXIgICAgICBQQVNTICAgICAgMTkuMTMgc2Vjb25k
cwpUZXN0UnVubmVyOiBpc28tdGVzdGVyICAgICAgICBQQVNTICAgICAgMTguODMgc2Vjb25kcwpU
ZXN0UnVubmVyOiBibmVwLXRlc3RlciAgICAgICBQQVNTICAgICAgNy40MCBzZWNvbmRzClRlc3RS
dW5uZXI6IG1nbXQtdGVzdGVyICAgICAgIFBBU1MgICAgICAxMjEuNzkgc2Vjb25kcwpUZXN0UnVu
bmVyOiByZmNvbW0tdGVzdGVyICAgICBQQVNTICAgICAgMTIuMDQgc2Vjb25kcwpUZXN0UnVubmVy
OiBzY28tdGVzdGVyICAgICAgICBQQVNTICAgICAgMTEuMDEgc2Vjb25kcwpUZXN0UnVubmVyOiBp
b2N0bC10ZXN0ZXIgICAgICBQQVNTICAgICAgMTIuMzYgc2Vjb25kcwpUZXN0UnVubmVyOiBtZXNo
LXRlc3RlciAgICAgICBQQVNTICAgICAgOC44NCBzZWNvbmRzClRlc3RSdW5uZXI6IHNtcC10ZXN0
ZXIgICAgICAgIFBBU1MgICAgICAxMC43MSBzZWNvbmRzClRlc3RSdW5uZXI6IHVzZXJjaGFuLXRl
c3RlciAgIFBBU1MgICAgICA3LjYxIHNlY29uZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkS2VybmVsIC0gRkFJTCAtIDMwLjg2IHNlY29uZHMKQnVp
bGQgS2VybmVsIHdpdGggbWluaW1hbCBjb25maWd1cmF0aW9uIHN1cHBvcnRzIEJsdWV0b290aApk
cml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5jOiBJbiBmdW5jdGlvbiDigJhiY3NwX2Nsb3Nl4oCZ
Ogpkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5jOjc0MDoyOiBlcnJvcjogaW1wbGljaXQgZGVj
bGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYdGltZXJfc2h1dGRvd25fc3luY+KAmSBbLVdlcnJvcj1p
bXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICA3NDAgfCAgdGltZXJfc2h1dGRvd25fc3lu
YygmYmNzcC0+dGJjc3ApOwogICAgICB8ICBefn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogc29tZSB3
YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFr
ZWZpbGUuYnVpbGQ6MjQ5OiBkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5vXSBFcnJvciAxCm1h
a2VbMl06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1ha2VbMV06ICoqKiBb
c2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0NjU6IGRyaXZlcnMvYmx1ZXRvb3RoXSBFcnJvciAyCm1h
a2U6ICoqKiBbTWFrZWZpbGU6MTg1MjogZHJpdmVyc10gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZEtlcm5lbDMyIC0gRkFJTCAtIDI1Ljk0IHNlY29u
ZHMKQnVpbGQgMzJiaXQgS2VybmVsIHdpdGggbWluaW1hbCBjb25maWd1cmF0aW9uIHN1cHBvcnRz
IEJsdWV0b290aApkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5jOiBJbiBmdW5jdGlvbiDigJhi
Y3NwX2Nsb3Nl4oCZOgpkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5jOjc0MDoyOiBlcnJvcjog
aW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYdGltZXJfc2h1dGRvd25fc3luY+KA
mSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICA3NDAgfCAgdGltZXJf
c2h1dGRvd25fc3luYygmYmNzcC0+dGJjc3ApOwogICAgICB8ICBefn5+fn5+fn5+fn5+fn5+fn5+
CmNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzJdOiAqKiog
W3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjQ5OiBkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5v
XSBFcnJvciAxCm1ha2VbMl06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1h
a2VbMV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0NjU6IGRyaXZlcnMvYmx1ZXRvb3Ro
XSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTg1MjogZHJpdmVyc10gRXJyb3IgMgoKCiMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBJbmNyZW1lbnRhbCBCdWlsZCB3aXRo
IHBhdGNoZXMgLSBTS0lQUEVEIC0gMC4xOCBzZWNvbmRzCkluY3JlbWVudGFsIGJ1aWxkIHBlciBw
YXRjaCBpbiB0aGUgc2VyaWVzCmJ1aWxka2VybmVsIGZhaWxlZAoKCgotLS0KUmVnYXJkcywKTGlu
dXggQmx1ZXRvb3RoCgo=

--===============0461624343494960215==--
