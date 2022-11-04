Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C4CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Nov 2022 07:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiKDHTE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Nov 2022 03:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKDHTC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Nov 2022 03:19:02 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC30BDF51
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Nov 2022 00:19:00 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h21so2611485qtu.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Nov 2022 00:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d05apTYQPX93h+5o8UjNgN1HvTG7A4Bhv8AiCqoUoIw=;
        b=ChuGPtdnwzcPeoGf/KQ8xy8yWEKshm8SjZZCyW0Wv5p6ipSNjCN5aI99sEQ1qgpoIS
         OTp9aTDw28lgi9K3rkow5pP8ICPzDpP0VQCo67y7X1Kbx2dcdOV37lBcFV6jIGqo7ZuJ
         EUvafNTLlbuzqj2f7lLPluKA5G6L5XebKuPnlKKQnDsF1GwT90TmEJrfWpeAk3dRvwUM
         OKDexyyrGCLDU/XyJ7HXuFC82XJVOJ4CeVrJ3z7fvB5Y/vhlvD09O06UHKSNxWFGx/A9
         nf8bA8OaM+H53zuALEvISS3GxyBFoqj7l4GX/VXo8sZrtFyK/mfl37JzAmyoRPH5zuF3
         8ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d05apTYQPX93h+5o8UjNgN1HvTG7A4Bhv8AiCqoUoIw=;
        b=tcQgr4MvH76g0nUb3pZxrPKb8xb/tvZPZhEbeRe8Btx5467bOHh+BH4RVCgbRgmipv
         85/2S36qHsWmRVpVe8lgM+LLTaVykJpGfbxf43xOuCjKNCr96wiUw7KhaDEjSse9BPpD
         YGH2lgLaQLA6mJxE2WvWNwc2b40Ia8FEQIIeYw8Hhy3dQMuo8fZyrTMlG6be/O6HPE/f
         wAVFHVRNqmN5AvrbHh9hTUrluUTG1fpuRRY5zgjAJtjvH5BrKovl5rZRGIWjCbB1iPk6
         aYVvX29G1y7PqUWSsiAfpactus8KLYjHLTDM1xVjmUUZqQ+HrlgT6hzkQ8mE/WkIg9cY
         ST7A==
X-Gm-Message-State: ACrzQf0qKiPuJW6d8DbWlVrE2KtSWrkGrhtpWHkS9gSIYp5XwmJJQUcx
        bD7vX+Wo1y34R93hj/WiaF+2HYoZFq4zjw==
X-Google-Smtp-Source: AMsMyM6sZ6siXWq1PRSlLT3BJq9N84Vi6HftwUvNjwTCypNV/WtU+68Hz3fKNbuOSTwMKijmA9iQKw==
X-Received: by 2002:a05:622a:83:b0:39c:fa14:efeb with SMTP id o3-20020a05622a008300b0039cfa14efebmr27958624qtw.643.1667546339724;
        Fri, 04 Nov 2022 00:18:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.173.135.241])
        by smtp.gmail.com with ESMTPSA id cd5-20020a05622a418500b0035d08c1da35sm1990229qtb.45.2022.11.04.00.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 00:18:59 -0700 (PDT)
Message-ID: <6364bce3.050a0220.fdcd3.78cd@mx.google.com>
Date:   Fri, 04 Nov 2022 00:18:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6130580885999727404=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rostedt@goodmis.org
Subject: RE: timers: Use timer_shutdown*() before freeing timers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221104054913.358784408@goodmis.org>
References: <20221104054913.358784408@goodmis.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6130580885999727404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkxOTQ0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMi40MyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAxLjEyIHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuOTQgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MzAuNzQgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjYu
Njkgc2Vjb25kcwpJbmNyZW1lbnRhbCBCdWlsZCB3aXRoIHBhdGNoZXNFUlJPUiAgICAgMC40NCBz
ZWNvbmRzClRlc3RSdW5uZXI6IFNldHVwICAgICAgICAgICAgIFBBU1MgICAgICA2MTAuODUgc2Vj
b25kcwpUZXN0UnVubmVyOiBsMmNhcC10ZXN0ZXIgICAgICBQQVNTICAgICAgMTkuNTkgc2Vjb25k
cwpUZXN0UnVubmVyOiBpc28tdGVzdGVyICAgICAgICBQQVNTICAgICAgMTkuNTEgc2Vjb25kcwpU
ZXN0UnVubmVyOiBibmVwLXRlc3RlciAgICAgICBQQVNTICAgICAgNy44MSBzZWNvbmRzClRlc3RS
dW5uZXI6IG1nbXQtdGVzdGVyICAgICAgIFBBU1MgICAgICAxMjIuMDEgc2Vjb25kcwpUZXN0UnVu
bmVyOiByZmNvbW0tdGVzdGVyICAgICBQQVNTICAgICAgMTIuMTQgc2Vjb25kcwpUZXN0UnVubmVy
OiBzY28tdGVzdGVyICAgICAgICBQQVNTICAgICAgMTEuMzMgc2Vjb25kcwpUZXN0UnVubmVyOiBp
b2N0bC10ZXN0ZXIgICAgICBQQVNTICAgICAgMTMuMDcgc2Vjb25kcwpUZXN0UnVubmVyOiBtZXNo
LXRlc3RlciAgICAgICBQQVNTICAgICAgOS4zOSBzZWNvbmRzClRlc3RSdW5uZXI6IHNtcC10ZXN0
ZXIgICAgICAgIFBBU1MgICAgICAxMS4zMCBzZWNvbmRzClRlc3RSdW5uZXI6IHVzZXJjaGFuLXRl
c3RlciAgIFBBU1MgICAgICA4LjExIHNlY29uZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkS2VybmVsIC0gRkFJTCAtIDMwLjc0IHNlY29uZHMKQnVp
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
IyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZEtlcm5lbDMyIC0gRkFJTCAtIDI2LjY5IHNlY29u
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
IHBhdGNoZXMgLSBTS0lQUEVEIC0gMC40NCBzZWNvbmRzCkluY3JlbWVudGFsIGJ1aWxkIHBlciBw
YXRjaCBpbiB0aGUgc2VyaWVzCmJ1aWxka2VybmVsIGZhaWxlZAoKCgotLS0KUmVnYXJkcywKTGlu
dXggQmx1ZXRvb3RoCgo=

--===============6130580885999727404==--
