Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE42C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Apr 2022 02:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiDZCYO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Apr 2022 22:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiDZCYN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Apr 2022 22:24:13 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5AC42EF9
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 19:21:07 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 79so395834qkk.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 19:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kkaErCpcgc3yLmQEkb9nkb+6v/S0RUn9219j/fUD/+I=;
        b=p9Wlm8DsuC+OHOYi94/rUlIz/n0uTjRPzPGQuPQqlNRlTQzSqGZxW9t+i5kIku3VHF
         hO0y1sjzaOaDpjLUoB1p9BndOtiprgclGqbvCtss+ZPtTLi2QiLHcplw8xQ5qtsy7S4t
         Akl1PXU4oqwBTDPVSnCCb4xgVPz5ABjzVIqnERVMSEwsHZkOHvUdRkXxyCeJpy4wIhcJ
         Wp4gIAW2hFXiuZgMnkZuUniUysYRRvX4ZfVu7WMt9CsHy3aKK2ekCnrO+UV2SIWGEAsE
         /IGmATNKMcJlELmHpBQsQ8sllkUPbfzPybisauqRiZ9W7Dt2CTbX3S4tBe4EWizmpN8e
         LwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kkaErCpcgc3yLmQEkb9nkb+6v/S0RUn9219j/fUD/+I=;
        b=YfNIrjS2B+tfcnl9A8c53dVV0MTGkqiwJODqJi1nHZlpQfKds9yTXH9QT6bS1rsuSD
         T416bEIDc70Q2aj3Own6ztI47ZRMv37N4NICRKsZScWcrCrtbfKVa2F64A2P74JPAzTT
         LAzHArI6qnEnb75iXTuopyCaYaj5LFvP2x37G+NpnAkSLg/FD4O4+LmymEVKQ0+2plcA
         eUwgm5sAaYmaDgUmt3Dsn84rzZDW1rP2hZl7joN8Qsd5sxoo8QnniNSl6FIWY+Ya0p5L
         6K5l6qeIUy9vATuucCPW/uBcm5nd49h4UpJrgErtvNVgvHatCvnkxm4t3Kop2zVf0Z2y
         hOYA==
X-Gm-Message-State: AOAM532ioHAOZcXhHIvAVca8VHKxYLAFIjxCbl5Qs9T1ZGLnNZm0oz1p
        uHEWVEQbqlW2JqIb1Gdizho7MktFz37Q9A==
X-Google-Smtp-Source: ABdhPJwOw74dRL9X4Zk45tm8TvYUCWP353gHzQ0YUUTXQ8u9hYUc0xKrjklixcP2+x9hBMJ6qHOJeQ==
X-Received: by 2002:a37:2758:0:b0:69f:6e19:2dad with SMTP id n85-20020a372758000000b0069f6e192dadmr2553085qkn.122.1650939666408;
        Mon, 25 Apr 2022 19:21:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.99.146])
        by smtp.gmail.com with ESMTPSA id l16-20020ac84cd0000000b002f37aabc130sm329581qtv.34.2022.04.25.19.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 19:21:05 -0700 (PDT)
Message-ID: <62675711.1c69fb81.10af4.1baf@mx.google.com>
Date:   Mon, 25 Apr 2022 19:21:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8978046420859187938=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client/player: Add transport.receive command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220426000032.622524-1-luiz.dentz@gmail.com>
References: <20220426000032.622524-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8978046420859187938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjM1NDk2CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS40NyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAxLjAwIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQyLjQ2IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuNzIgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOC42
MSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICA1LjY0IHNl
Y29uZHMKTWFrZSBDaGVjayAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDEuNTEgc2Vjb25k
cwpNYWtlIENoZWNrIHcvVmFsZ3JpbmQgICAgICAgICBGQUlMICAgICAgMTIuNzkgc2Vjb25kcwpN
YWtlIERpc3RjaGVjayAgICAgICAgICAgICAgICBGQUlMICAgICAgMzIuODggc2Vjb25kcwpCdWls
ZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgOC41MCBzZWNvbmRzCkJ1aWxkIHcv
ZXh0IEVMTCAtIE1ha2UgICAgICAgIEZBSUwgICAgICA2LjAwIHNlY29uZHMKSW5jcmVtZW50YWwg
QnVpbGQgd2l0aCBwYXRjaGVzUEFTUyAgICAgIDAuMDAgc2Vjb25kcwoKRGV0YWlscwojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIEZBSUwKRGVzYzogUnVuIGdp
dGxpbnQgd2l0aCBydWxlIGluIC5naXRsaW50Ck91dHB1dDoKW0JsdWVaXSBjbGllbnQvcGxheWVy
OiBBZGQgdHJhbnNwb3J0LnJlY2VpdmUgY29tbWFuZAo5OiBCMyBMaW5lIGNvbnRhaW5zIGhhcmQg
dGFiIGNoYXJhY3RlcnMgKFx0KTogIgkgcmVjZWl2ZSBbZmlsZW5hbWVdIgoKCiMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCAtIE1ha2UgLSBGQUlMCkRlc2M6IEJ1aWxk
IHRoZSBCbHVlWiBzb3VyY2UgdHJlZQpPdXRwdXQ6CkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNy
L2luY2x1ZGUvZmNudGwuaDozMDEsCiAgICAgICAgICAgICAgICAgZnJvbSBjbGllbnQvcGxheWVy
LmM6MjI6CkluIGZ1bmN0aW9uIOKAmG9wZW7igJksCiAgICBpbmxpbmVkIGZyb20g4oCYb3Blbl9m
aWxl4oCZIGF0IGNsaWVudC9wbGF5ZXIuYzoyNDcwOjcsCiAgICBpbmxpbmVkIGZyb20g4oCYY21k
X3JlY2VpdmVfdHJhbnNwb3J04oCZIGF0IGNsaWVudC9wbGF5ZXIuYzoyNTYxOjE3OgovdXNyL2lu
Y2x1ZGUveDg2XzY0LWxpbnV4LWdudS9iaXRzL2ZjbnRsMi5oOjUwOjQ6IGVycm9yOiBjYWxsIHRv
IOKAmF9fb3Blbl9taXNzaW5nX21vZGXigJkgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgZXJyb3I6
IG9wZW4gd2l0aCBPX0NSRUFUIG9yIE9fVE1QRklMRSBpbiBzZWNvbmQgYXJndW1lbnQgbmVlZHMg
MyBhcmd1bWVudHMKICAgNTAgfCAgICBfX29wZW5fbWlzc2luZ19tb2RlICgpOwogICAgICB8ICAg
IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KbWFrZVsxXTogKioqIFtNYWtlZmlsZTo3Mjc3OiBjbGll
bnQvcGxheWVyLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MzEwOiBhbGxdIEVycm9y
IDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBDaGVjayAtIEZB
SUwKRGVzYzogUnVuICdtYWtlIGNoZWNrJwpPdXRwdXQ6CkluIGZpbGUgaW5jbHVkZWQgZnJvbSAv
dXNyL2luY2x1ZGUvZmNudGwuaDozMDEsCiAgICAgICAgICAgICAgICAgZnJvbSBjbGllbnQvcGxh
eWVyLmM6MjI6CkluIGZ1bmN0aW9uIOKAmG9wZW7igJksCiAgICBpbmxpbmVkIGZyb20g4oCYb3Bl
bl9maWxl4oCZIGF0IGNsaWVudC9wbGF5ZXIuYzoyNDcwOjcsCiAgICBpbmxpbmVkIGZyb20g4oCY
Y21kX3JlY2VpdmVfdHJhbnNwb3J04oCZIGF0IGNsaWVudC9wbGF5ZXIuYzoyNTYxOjE3OgovdXNy
L2luY2x1ZGUveDg2XzY0LWxpbnV4LWdudS9iaXRzL2ZjbnRsMi5oOjUwOjQ6IGVycm9yOiBjYWxs
IHRvIOKAmF9fb3Blbl9taXNzaW5nX21vZGXigJkgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgZXJy
b3I6IG9wZW4gd2l0aCBPX0NSRUFUIG9yIE9fVE1QRklMRSBpbiBzZWNvbmQgYXJndW1lbnQgbmVl
ZHMgMyBhcmd1bWVudHMKICAgNTAgfCAgICBfX29wZW5fbWlzc2luZ19tb2RlICgpOwogICAgICB8
ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KbWFrZVsxXTogKioqIFtNYWtlZmlsZTo3Mjc3OiBj
bGllbnQvcGxheWVyLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZToxMTI4MzogY2hlY2td
IEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBDaGVj
ayB3L1ZhbGdyaW5kIC0gRkFJTApEZXNjOiBSdW4gJ21ha2UgY2hlY2snIHdpdGggVmFsZ3JpbmQK
T3V0cHV0OgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3Vzci9pbmNsdWRlL2ZjbnRsLmg6MzAxLAog
ICAgICAgICAgICAgICAgIGZyb20gY2xpZW50L3BsYXllci5jOjIyOgpJbiBmdW5jdGlvbiDigJhv
cGVu4oCZLAogICAgaW5saW5lZCBmcm9tIOKAmG9wZW5fZmlsZeKAmSBhdCBjbGllbnQvcGxheWVy
LmM6MjQ3MDo3LAogICAgaW5saW5lZCBmcm9tIOKAmGNtZF9yZWNlaXZlX3RyYW5zcG9ydOKAmSBh
dCBjbGllbnQvcGxheWVyLmM6MjU2MToxNzoKL3Vzci9pbmNsdWRlL3g4Nl82NC1saW51eC1nbnUv
Yml0cy9mY250bDIuaDo1MDo0OiBlcnJvcjogY2FsbCB0byDigJhfX29wZW5fbWlzc2luZ19tb2Rl
4oCZIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIGVycm9yOiBvcGVuIHdpdGggT19DUkVBVCBvciBP
X1RNUEZJTEUgaW4gc2Vjb25kIGFyZ3VtZW50IG5lZWRzIDMgYXJndW1lbnRzCiAgIDUwIHwgICAg
X19vcGVuX21pc3NpbmdfbW9kZSAoKTsKICAgICAgfCAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
Cm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6NzI3NzogY2xpZW50L3BsYXllci5vXSBFcnJvciAxCm1h
a2U6ICoqKiBbTWFrZWZpbGU6NDMxMDogYWxsXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjClRlc3Q6IE1ha2UgRGlzdGNoZWNrIC0gRkFJTApEZXNjOiBSdW4gZGlzdGNo
ZWNrIHRvIGNoZWNrIHRoZSBkaXN0cmlidXRpb24KT3V0cHV0OgpJbiBmaWxlIGluY2x1ZGVkIGZy
b20gL3Vzci9pbmNsdWRlL2ZjbnRsLmg6MzAxLAogICAgICAgICAgICAgICAgIGZyb20gLi4vLi4v
Y2xpZW50L3BsYXllci5jOjIyOgpJbiBmdW5jdGlvbiDigJhvcGVu4oCZLAogICAgaW5saW5lZCBm
cm9tIOKAmG9wZW5fZmlsZeKAmSBhdCAuLi8uLi9jbGllbnQvcGxheWVyLmM6MjQ3MDo3LAogICAg
aW5saW5lZCBmcm9tIOKAmGNtZF9yZWNlaXZlX3RyYW5zcG9ydOKAmSBhdCAuLi8uLi9jbGllbnQv
cGxheWVyLmM6MjU2MToxNzoKL3Vzci9pbmNsdWRlL3g4Nl82NC1saW51eC1nbnUvYml0cy9mY250
bDIuaDo1MDo0OiBlcnJvcjogY2FsbCB0byDigJhfX29wZW5fbWlzc2luZ19tb2Rl4oCZIGRlY2xh
cmVkIHdpdGggYXR0cmlidXRlIGVycm9yOiBvcGVuIHdpdGggT19DUkVBVCBvciBPX1RNUEZJTEUg
aW4gc2Vjb25kIGFyZ3VtZW50IG5lZWRzIDMgYXJndW1lbnRzCiAgIDUwIHwgICAgX19vcGVuX21p
c3NpbmdfbW9kZSAoKTsKICAgICAgfCAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+Cm1ha2VbMl06
ICoqKiBbTWFrZWZpbGU6NzI3NzogY2xpZW50L3BsYXllci5vXSBFcnJvciAxCm1ha2VbMV06ICoq
KiBbTWFrZWZpbGU6NDMxMDogYWxsXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTEyMDQ6
IGRpc3RjaGVja10gRXJyb3IgMQoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0
OiBCdWlsZCB3L2V4dCBFTEwgLSBNYWtlIC0gRkFJTApEZXNjOiBCdWlsZCBCbHVlWiBzb3VyY2Ug
d2l0aCAnLS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9uCk91dHB1dDoKSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS9mY250bC5oOjMwMSwKICAgICAgICAgICAgICAg
ICBmcm9tIGNsaWVudC9wbGF5ZXIuYzoyMjoKSW4gZnVuY3Rpb24g4oCYb3BlbuKAmSwKICAgIGlu
bGluZWQgZnJvbSDigJhvcGVuX2ZpbGXigJkgYXQgY2xpZW50L3BsYXllci5jOjI0NzA6NywKICAg
IGlubGluZWQgZnJvbSDigJhjbWRfcmVjZWl2ZV90cmFuc3BvcnTigJkgYXQgY2xpZW50L3BsYXll
ci5jOjI1NjE6MTc6Ci91c3IvaW5jbHVkZS94ODZfNjQtbGludXgtZ251L2JpdHMvZmNudGwyLmg6
NTA6NDogZXJyb3I6IGNhbGwgdG8g4oCYX19vcGVuX21pc3NpbmdfbW9kZeKAmSBkZWNsYXJlZCB3
aXRoIGF0dHJpYnV0ZSBlcnJvcjogb3BlbiB3aXRoIE9fQ1JFQVQgb3IgT19UTVBGSUxFIGluIHNl
Y29uZCBhcmd1bWVudCBuZWVkcyAzIGFyZ3VtZW50cwogICA1MCB8ICAgIF9fb3Blbl9taXNzaW5n
X21vZGUgKCk7CiAgICAgIHwgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fgptYWtlWzFdOiAqKiog
W01ha2VmaWxlOjcyNzc6IGNsaWVudC9wbGF5ZXIub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2Vm
aWxlOjQzMTA6IGFsbF0gRXJyb3IgMgoKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============8978046420859187938==--
