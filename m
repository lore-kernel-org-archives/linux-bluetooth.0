Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B00FC001DE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jul 2023 10:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGQKA6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Jul 2023 06:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjGQKA4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Jul 2023 06:00:56 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83451E5A
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 03:00:54 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-634efb81e8dso21725086d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 03:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689588053; x=1692180053;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vSM3kE9G1FomMaziqAKKk+xQv6K+CCUFK/efvYhH7wU=;
        b=jpuWBW9unsmqPBSs3oXzYNuSsYrMhzuz7aRHMFQ2w8av+EkqQ8u4+KCaHl38r5VZWg
         t8GWsK+4wdHGgr0gLRfT16JDEfOqAV5JY9rTf6ftBcVc/DcKyrSAGqGzNuduDzpF/dSu
         9zmClDsDVEnM0vPFjuJfO/KVXxDGiIBl/S+vyPzZ1FNQvIJSNzx1lqrBxPC2Nj6+r1FS
         t9jn4rIY7fa7dLd+I9wabUEJHrjz2ZKvC8wtM7qoWz2n2j3gV5FpifTtlGmeZENIeSYt
         ydZM3+opAYWe7GwG6MMXj0I456rHIorb2h3yqobgr2xS50PCj8TaNvjzEwGU2JrEHhHb
         kIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689588053; x=1692180053;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSM3kE9G1FomMaziqAKKk+xQv6K+CCUFK/efvYhH7wU=;
        b=E9oqwPlLCBbI2d3pHOtXaWRupILWQp0SWrZ42ABtfhWuRkusNHYK/EfFAaTkqdFK53
         DYMlRdqotQPIJdOfTKaCP6vU5ZtOZ78IOC1XfG2l9D18dFjBzloctF3SABDyyzNp0B3J
         GJ2zLPAGV7jfeJlcZq/A+UKzbxyOiNqn6bM75DPSVrspGSki9JdRj2P/wacjZ7QmzYiv
         fiZH90XpzJAnO2fx99RQzzOcukyEMMGxZCeV/VM5nu+GFX1Mhv0MMqxROXO8swdBEdAn
         FJ0tphaNQ732wuSrdsrZMcWvqllouQet9AjhJKodFaPMse1Ielb0/z6tb/sf+682Tavq
         4aXA==
X-Gm-Message-State: ABy/qLZxv3WEdsHko+g+C0LsgU+vPQDoJ7DoL7jH57fBHPQywB27Tphx
        y9iPatbOI10LUJ3D9QlCgRSF2i+U+vg=
X-Google-Smtp-Source: APBJJlHTL3vG26MaL7P29mktMCkZlu/KNQl3RlUCExjFDc5R5X05m7Jk0qD/ou3F6aCgXJD+XtP8NQ==
X-Received: by 2002:a0c:e385:0:b0:63c:6f79:f57e with SMTP id a5-20020a0ce385000000b0063c6f79f57emr7896223qvl.2.1689588053400;
        Mon, 17 Jul 2023 03:00:53 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.205.194])
        by smtp.gmail.com with ESMTPSA id b14-20020a0ccd0e000000b0063627a022b0sm6293829qvm.49.2023.07.17.03.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 03:00:53 -0700 (PDT)
Message-ID: <64b51155.0c0a0220.8e13e.49be@mx.google.com>
Date:   Mon, 17 Jul 2023 03:00:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7472062633542922697=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: RE: [v1,1/1] Bluetooth: MGMT: Use correct address for memcpy()
In-Reply-To: <20230717093214.82102-1-andriy.shevchenko@linux.intel.com>
References: <20230717093214.82102-1-andriy.shevchenko@linux.intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7472062633542922697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NzY2NDAzCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBGQUlMICAgICAgMS4wMCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAwLjYzIHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTIgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MzMuMDcgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBQQVNTICAgICAgMzYu
NTEgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgNDEuODkg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTExLjg0IHNl
Y29uZHMKQnVpbGRLZXJuZWwzMiAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDMyLjEwIHNlY29u
ZHMKVGVzdFJ1bm5lclNldHVwICAgICAgICAgICAgICAgUEFTUyAgICAgIDQ4Ni4xMCBzZWNvbmRz
ClRlc3RSdW5uZXJfbDJjYXAtdGVzdGVyICAgICAgIFBBU1MgICAgICAyMy4zNyBzZWNvbmRzClRl
c3RSdW5uZXJfaXNvLXRlc3RlciAgICAgICAgIFBBU1MgICAgICA0NC42NCBzZWNvbmRzClRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICAxMC42NyBzZWNvbmRzClRlc3RSdW5u
ZXJfbWdtdC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICAyMTkuMDAgc2Vjb25kcwpUZXN0UnVubmVy
X3JmY29tbS10ZXN0ZXIgICAgICBQQVNTICAgICAgMTYuMDAgc2Vjb25kcwpUZXN0UnVubmVyX3Nj
by10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgMTcuMDMgc2Vjb25kcwpUZXN0UnVubmVyX2lvY3Rs
LXRlc3RlciAgICAgICBQQVNTICAgICAgMTguMDkgc2Vjb25kcwpUZXN0UnVubmVyX21lc2gtdGVz
dGVyICAgICAgICBQQVNTICAgICAgMTMuNDEgc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10ZXN0ZXIg
ICAgICAgICBQQVNTICAgICAgMTQuNDQgc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFuLXRlc3Rl
ciAgICBQQVNTICAgICAgMTEuMTcgc2Vjb25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAg
ICBQQVNTICAgICAgMzAuNzAgc2Vjb25kcwoKRGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAtIEZBSUwKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwg
c2NyaXB0Ck91dHB1dDoKW3YxLDEvMV0gQmx1ZXRvb3RoOiBNR01UOiBVc2UgY29ycmVjdCBhZGRy
ZXNzIGZvciBtZW1jcHkoKQpXQVJOSU5HOiBQb3NzaWJsZSB1bndyYXBwZWQgY29tbWl0IGRlc2Ny
aXB0aW9uIChwcmVmZXIgYSBtYXhpbXVtIDc1IGNoYXJzIHBlciBsaW5lKQojNzA6IAogICAgaW5s
aW5lZCBmcm9tIOKAmGdldF9jb25uX2luZm9fY29tcGxldGXigJkgYXQgbmV0L2JsdWV0b290aC9t
Z210LmM6NzI4MToyOgoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAwIGNoZWNrcywgOCBs
aW5lcyBjaGVja2VkCgpOT1RFOiBGb3Igc29tZSBvZiB0aGUgcmVwb3J0ZWQgZGVmZWN0cywgY2hl
Y2twYXRjaCBtYXkgYmUgYWJsZSB0bwogICAgICBtZWNoYW5pY2FsbHkgY29udmVydCB0byB0aGUg
dHlwaWNhbCBzdHlsZSB1c2luZyAtLWZpeCBvciAtLWZpeC1pbnBsYWNlLgoKL2dpdGh1Yi93b3Jr
c3BhY2Uvc3JjL3NyYy8xMzMxNTM1OS5wYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuCgpOT1RFOiBJZ25vcmVkIG1lc3NhZ2UgdHlwZXM6IFVOS05PV05fQ09NTUlUX0lECgpO
T1RFOiBJZiBhbnkgb2YgdGhlIGVycm9ycyBhcmUgZmFsc2UgcG9zaXRpdmVzLCBwbGVhc2UgcmVw
b3J0CiAgICAgIHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZSBDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBHaXRMaW50IC0g
RkFJTApEZXNjOiBSdW4gZ2l0bGludApPdXRwdXQ6Clt2MSwxLzFdIEJsdWV0b290aDogTUdNVDog
VXNlIGNvcnJlY3QgYWRkcmVzcyBmb3IgbWVtY3B5KCkKCldBUk5JTkc6IEkzIC0gaWdub3JlLWJv
ZHktbGluZXM6IGdpdGxpbnQgd2lsbCBiZSBzd2l0Y2hpbmcgZnJvbSB1c2luZyBQeXRob24gcmVn
ZXggJ21hdGNoJyAobWF0Y2ggYmVnaW5uaW5nKSB0byAnc2VhcmNoJyAobWF0Y2ggYW55d2hlcmUp
IHNlbWFudGljcy4gUGxlYXNlIHJldmlldyB5b3VyIGlnbm9yZS1ib2R5LWxpbmVzLnJlZ2V4IG9w
dGlvbiBhY2NvcmRpbmdseS4gVG8gcmVtb3ZlIHRoaXMgd2FybmluZywgc2V0IGdlbmVyYWwucmVn
ZXgtc3R5bGUtc2VhcmNoPVRydWUuIE1vcmUgZGV0YWlsczogaHR0cHM6Ly9qb3Jpc3Jvb3ZlcnMu
Z2l0aHViLmlvL2dpdGxpbnQvY29uZmlndXJhdGlvbi8jcmVnZXgtc3R5bGUtc2VhcmNoCjU6IEIx
IExpbmUgZXhjZWVkcyBtYXggbGVuZ3RoICgyMTc+ODApOiAiaW5jbHVkZS9saW51eC9mb3J0aWZ5
LXN0cmluZy5oOjU5MjoyNTogZXJyb3I6IGNhbGwgdG8g4oCYX19yZWFkX292ZXJmbG93Ml9maWVs
ZOKAmSBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZSB3YXJuaW5nOiBkZXRlY3RlZCByZWFkIGJleW9u
ZCBzaXplIG9mIGZpZWxkICgybmQgcGFyYW1ldGVyKTsgbWF5YmUgdXNlIHN0cnVjdF9ncm91cCgp
PyBbLVdlcnJvcj1hdHRyaWJ1dGUtd2FybmluZ10iCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0
b290aAoK

--===============7472062633542922697==--
