Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353F0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 10:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245229AbiDAK6o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbiDAK6n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 06:58:43 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA2726B3A7
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 03:56:52 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id kd21so1717681qvb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Apr 2022 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3u3UkIrULAjFis4PNI4mZ33XaiYtNg2gZLXI54QAa5A=;
        b=XNvD6YCx3orMelG30ylkKXdXAtxzpS37iqxACnq2RSr9dvsk4tmSueDLIpwCQaeEa2
         0UGJBCLm189gpvfU48lh2MlYPuerT8f7jgHp/xqG3lBrAvvLqYQksdPsJxuAPxHzsmyO
         3DnecayyetCATZ3PLaDO8vbF5oaEswSHQFQe+vw5vSW42JCZIltcXuGljLyoOchY7GNb
         JT9HODV1rf51Q+5ekp/Okl7jQQLXIEicVpNjO76RH+sE5gE6nexwEKZt2Ap3qDnTOxJ+
         r+sgIWAeE8KarWbhAPO5oV0S6K+x4ZoVHwWCjBniZLTxL5TWQT4TqmuiIb5euc0FRln1
         iI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3u3UkIrULAjFis4PNI4mZ33XaiYtNg2gZLXI54QAa5A=;
        b=40+CzSeh/ZJB2GxzNVG7+uOYGyf7Dej/GlfEayZanf1EEwTL/IEKEPDl1Lh9S/k5kj
         gpyLcQ3AO4OE7ZiEhdqHLrKbCCADtch223dze9hRiSq8IbbK3H+/YwtQ2b5ZOtXySt5z
         66vNpgXuAtyV/FsFsCEWjySg4NsKdhOERtDTKt/9JSKee9UJs4tULz3/LB7GtJYHPDB8
         6TaXaQ7gn1ODJ/lCeQpDH91W0w22H0Pnq1JDvecT7C53xU3f/djVbMsMQPI32ufjQVH0
         p95LdCxmSvyExwtdO2ioaJw9XZp9dhcgXj7WN694/kaml+BW2nCqtezt74xmTrjKD5M4
         xOlw==
X-Gm-Message-State: AOAM533Y2MkFZj8CB+M1w3Cs5aAqQDa/4TEAOvHmEVT4SMJR7YM3MVa0
        UTzO1gXuQi4Il3vBU3KzdM0mnATJURk/Pg==
X-Google-Smtp-Source: ABdhPJw2SQHCzX44+UMZmr4CFTQvvaGIYnwYjg1Ill4sxr7Bxzmeqil5IXtMj5nMCnI9/0NQgWkQBw==
X-Received: by 2002:a05:6214:52:b0:440:f824:a7f3 with SMTP id c18-20020a056214005200b00440f824a7f3mr7325367qvr.125.1648810610944;
        Fri, 01 Apr 2022 03:56:50 -0700 (PDT)
Received: from [172.17.0.2] ([13.77.99.186])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a148700b002eba7850c57sm185115qtx.21.2022.04.01.03.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 03:56:50 -0700 (PDT)
Message-ID: <6246da72.1c69fb81.40b5e.0cb8@mx.google.com>
Date:   Fri, 01 Apr 2022 03:56:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4503370693048809402=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, i.kamaletdinov@omp.ru
Subject: RE: v2 Fix bugs found by SVACE static analisys tool
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220401102757.3960551-2-i.kamaletdinov@omp.ru>
References: <20220401102757.3960551-2-i.kamaletdinov@omp.ru>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4503370693048809402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjI4MTUwCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMTAuMjQgc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBQ
QVNTICAgICAgNy4wNyBzZWNvbmRzClByZXAgLSBTZXR1cCBFTEwgICAgICAgICAgICAgIFBBU1Mg
ICAgICA1NC4wNiBzZWNvbmRzCkJ1aWxkIC0gUHJlcCAgICAgICAgICAgICAgICAgIFBBU1MgICAg
ICAwLjgwIHNlY29uZHMKQnVpbGQgLSBDb25maWd1cmUgICAgICAgICAgICAgUEFTUyAgICAgIDEw
LjQ0IHNlY29uZHMKQnVpbGQgLSBNYWtlICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDQ1Ljcw
IHNlY29uZHMKTWFrZSBDaGVjayAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDEzLjA5IHNl
Y29uZHMKTWFrZSBDaGVjayB3L1ZhbGdyaW5kICAgICAgICAgRkFJTCAgICAgIDQzLjU2IHNlY29u
ZHMKTWFrZSBEaXN0Y2hlY2sgICAgICAgICAgICAgICAgUEFTUyAgICAgIDI4MC4yNSBzZWNvbmRz
CkJ1aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAgIFBBU1MgICAgICAxMC4zNCBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIEZBSUwgICAgICA0NS4yNiBzZWNvbmRzCkluY3Jl
bWVudGFsIEJ1aWxkIHdpdGggcGF0Y2hlc0ZBSUwgICAgICA1Ny41OCBzZWNvbmRzCgpEZXRhaWxz
CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCAtIE1ha2UgLSBGQUlM
CkRlc2M6IEJ1aWxkIHRoZSBCbHVlWiBzb3VyY2UgdHJlZQpPdXRwdXQ6Cm1vbml0b3IvcGFja2V0
LmM6IEluIGZ1bmN0aW9uIOKAmHByaW50X2xlX3N0YXRlc+KAmToKbW9uaXRvci9wYWNrZXQuYzoy
ODQ0OjE4OiBlcnJvcjogY29tcGFyaXNvbiBvZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9mIGRpZmZl
cmVudCBzaWduZWRuZXNzOiDigJhzaXplX3TigJkge2FrYSDigJhsb25nIHVuc2lnbmVkIGludOKA
mX0gYW5kIOKAmGludOKAmSBbLVdlcnJvcj1zaWduLWNvbXBhcmVdCiAyODQ0IHwgICAgZm9yIChu
ID0gMTsgbiA8IG51bTsgbisrKQogICAgICB8ICAgICAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3
YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjcy
Nzc6IG1vbml0b3IvcGFja2V0Lm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MzEwOiBh
bGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBD
aGVjayAtIEZBSUwKRGVzYzogUnVuICdtYWtlIGNoZWNrJwpPdXRwdXQ6Cm1vbml0b3IvcGFja2V0
LmM6IEluIGZ1bmN0aW9uIOKAmHByaW50X2xlX3N0YXRlc+KAmToKbW9uaXRvci9wYWNrZXQuYzoy
ODQ0OjE4OiBlcnJvcjogY29tcGFyaXNvbiBvZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9mIGRpZmZl
cmVudCBzaWduZWRuZXNzOiDigJhzaXplX3TigJkge2FrYSDigJhsb25nIHVuc2lnbmVkIGludOKA
mX0gYW5kIOKAmGludOKAmSBbLVdlcnJvcj1zaWduLWNvbXBhcmVdCiAyODQ0IHwgICAgZm9yIChu
ID0gMTsgbiA8IG51bTsgbisrKQogICAgICB8ICAgICAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3
YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjcy
Nzc6IG1vbml0b3IvcGFja2V0Lm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZToxMTI4Mzog
Y2hlY2tdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFr
ZSBDaGVjayB3L1ZhbGdyaW5kIC0gRkFJTApEZXNjOiBSdW4gJ21ha2UgY2hlY2snIHdpdGggVmFs
Z3JpbmQKT3V0cHV0Ogptb25pdG9yL3BhY2tldC5jOiBJbiBmdW5jdGlvbiDigJhwcmludF9sZV9z
dGF0ZXPigJk6Cm1vbml0b3IvcGFja2V0LmM6Mjg0NDoxODogZXJyb3I6IGNvbXBhcmlzb24gb2Yg
aW50ZWdlciBleHByZXNzaW9ucyBvZiBkaWZmZXJlbnQgc2lnbmVkbmVzczog4oCYc2l6ZV904oCZ
IHtha2Eg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJl9IGFuZCDigJhpbnTigJkgWy1XZXJyb3I9c2ln
bi1jb21wYXJlXQogMjg0NCB8ICAgIGZvciAobiA9IDE7IG4gPCBudW07IG4rKykKICAgICAgfCAg
ICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJv
cnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo3Mjc3OiBtb25pdG9yL3BhY2tldC5vXSBFcnJvciAx
Cm1ha2U6ICoqKiBbTWFrZWZpbGU6NDMxMDogYWxsXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIHcvZXh0IEVMTCAtIE1ha2UgLSBGQUlMCkRlc2M6
IEJ1aWxkIEJsdWVaIHNvdXJjZSB3aXRoICctLWVuYWJsZS1leHRlcm5hbC1lbGwnIGNvbmZpZ3Vy
YXRpb24KT3V0cHV0Ogptb25pdG9yL3BhY2tldC5jOiBJbiBmdW5jdGlvbiDigJhwcmludF9sZV9z
dGF0ZXPigJk6Cm1vbml0b3IvcGFja2V0LmM6Mjg0NDoxODogZXJyb3I6IGNvbXBhcmlzb24gb2Yg
aW50ZWdlciBleHByZXNzaW9ucyBvZiBkaWZmZXJlbnQgc2lnbmVkbmVzczog4oCYc2l6ZV904oCZ
IHtha2Eg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJl9IGFuZCDigJhpbnTigJkgWy1XZXJyb3I9c2ln
bi1jb21wYXJlXQogMjg0NCB8ICAgIGZvciAobiA9IDE7IG4gPCBudW07IG4rKykKICAgICAgfCAg
ICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJv
cnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo3Mjc3OiBtb25pdG9yL3BhY2tldC5vXSBFcnJvciAx
Cm1ha2U6ICoqKiBbTWFrZWZpbGU6NDMxMDogYWxsXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjClRlc3Q6IEluY3JlbWVudGFsIEJ1aWxkIHdpdGggcGF0Y2hlcyAtIEZB
SUwKRGVzYzogSW5jcmVtZW50YWwgYnVpbGQgcGVyIHBhdGNoIGluIHRoZSBzZXJpZXMKT3V0cHV0
Ogptb25pdG9yL3BhY2tldC5jOiBJbiBmdW5jdGlvbiDigJhwcmludF9sZV9zdGF0ZXPigJk6Cm1v
bml0b3IvcGFja2V0LmM6Mjg0NDoxODogZXJyb3I6IGNvbXBhcmlzb24gb2YgaW50ZWdlciBleHBy
ZXNzaW9ucyBvZiBkaWZmZXJlbnQgc2lnbmVkbmVzczog4oCYc2l6ZV904oCZIHtha2Eg4oCYbG9u
ZyB1bnNpZ25lZCBpbnTigJl9IGFuZCDigJhpbnTigJkgWy1XZXJyb3I9c2lnbi1jb21wYXJlXQog
Mjg0NCB8ICAgIGZvciAobiA9IDE7IG4gPCBudW07IG4rKykKICAgICAgfCAgICAgICAgICAgICAg
ICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTog
KioqIFtNYWtlZmlsZTo3Mjc3OiBtb25pdG9yL3BhY2tldC5vXSBFcnJvciAxCm1ha2U6ICoqKiBb
TWFrZWZpbGU6NDMxMDogYWxsXSBFcnJvciAyCgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRv
b3RoCgo=

--===============4503370693048809402==--
