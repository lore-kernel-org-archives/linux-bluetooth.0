Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD08C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 22:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiF2WP5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 18:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiF2WP4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 18:15:56 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2700339B8D
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 15:15:55 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id k20so13195553qkj.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=P9LGzf/Y3NAhIOVC457GgC9mOXj5/u3OZAjpT0wT5ZM=;
        b=LyY71lGFNgvZGDIBQJrHamDKQ8qpta6sKOqAM+g6n7OaoCHnPSCnnKPizHFjCcKJ6+
         m5ljSk2rtHMsqwo3Uj7QgDp6SLoyDhhU1VI6W9EtogAuv7NlipWtuHgNweGw0UuA4bnx
         ahC28ZJSk2+LbMT3U9T32wNOgEKDzmVqRSQa8QUQBRJ7nZPd/wUdGllSvAQPB7wXxdhx
         o1NjcWkmK/KvcMURLVlxRl8Xq2KDCYtwLmB9+l8AJEIgAj/au/SDbDUbrpfg+FPFWAbh
         H6Qnb6qx2xzcszWzmtezeEeJkFV2S0Zcjl6s8dhxOVhzWCyEjccdRagEgROela5QGkvD
         4wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=P9LGzf/Y3NAhIOVC457GgC9mOXj5/u3OZAjpT0wT5ZM=;
        b=PICpjZMk+obbinF5kYqzZ+fa7gMGpAOrxrw1si/+PVQ/ey4ttCS5Pk484QqnI/0u/T
         yCEDrXNCz9Wf2E0D/cjzsSS+A76gDkS7CKjoV5yhBOEA03wwEH4tRE2WHutFzGgDk5/x
         XH0kAddDa9TWwwIEEPhWARkYOCkAFcdfmjpDGW5ZDawoLfldLxZwuaU9P4O8SBttilyF
         dUxhaE0iI5V9E4nkLGSLXSiePNBQkWxhtOc+0InxVrAnixdYLEE7fFOfKtFaL2+B/vyD
         j1W+vQuLF9oCfbws9r5TVU4lTatVU11drK9R8IMrfdD9RPG9yPYYnNLIBmfURBXQxz5o
         /HQQ==
X-Gm-Message-State: AJIora+3nd5TLU9Qfwx669vs6BMMbI5pUlIBgmTTn5XR7Qqoj/nSaqCM
        HtgtQZa+wf7UUBY5J5lNscraTH3bXug=
X-Google-Smtp-Source: AGRyM1tzOg/MpgcqTS+OaXaXMna4XePiQbdnsWOCX5jj3YmDoYwH6jXbxQPvwn9J7xcaQ9LOLTsftw==
X-Received: by 2002:a05:620a:2916:b0:6af:3d79:ebb7 with SMTP id m22-20020a05620a291600b006af3d79ebb7mr3988024qkp.58.1656540954042;
        Wed, 29 Jun 2022 15:15:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.8.70])
        by smtp.gmail.com with ESMTPSA id b15-20020ac87fcf000000b0031ab9d1d6c1sm6507282qtk.74.2022.06.29.15.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 15:15:53 -0700 (PDT)
Message-ID: <62bccf19.1c69fb81.228f2.089d@mx.google.com>
Date:   Wed, 29 Jun 2022 15:15:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8291483930734774406=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,1/2] core: make bt_uuid_hash() portable across archs
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220629194432.20229-1-brian.gix@intel.com>
References: <20220629194432.20229-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8291483930734774406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjU1MTU1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBGQUlMICAgICAgMi45NiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAxLjk3IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQzLjgwIHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuNjggc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOC42
OCBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxMzg0LjE4
IHNlY29uZHMKTWFrZSBDaGVjayAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDExLjgwIHNl
Y29uZHMKTWFrZSBDaGVjayB3L1ZhbGdyaW5kICAgICAgICAgUEFTUyAgICAgIDQ0My44MyBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMzIuODEgc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgOC43MSBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIFBBU1MgICAgICAxNDE0LjI1IHNlY29uZHMKSW5j
cmVtZW50YWwgQnVpbGQgd2l0aCBwYXRjaGVzUEFTUyAgICAgIDI3NjcuMDYgc2Vjb25kcwoKRGV0
YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAtIEZB
SUwKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0IHdpdGggcnVsZSBpbiAuY2hlY2twYXRj
aC5jb25mCk91dHB1dDoKW0JsdWVaLDIvMl0gY29yZTogRml4IHNpZ25lZCB2cyB1bnNpZ25lZCBj
b21wYXJlCldBUk5JTkc6VU5TUEVDSUZJRURfSU5UOiBQcmVmZXIgJ3Vuc2lnbmVkIGludCcgdG8g
YmFyZSB1c2Ugb2YgJ3Vuc2lnbmVkJwojODk6IEZJTEU6IHNyYy9kZXZpY2UuYzo0MDkxOgorCWlm
ICgodW5zaWduZWQpbm93LnR2X3NlYyA+PSBkZXZpY2UtPm5hbWVfcmVzb2x2ZV9mYWlsZWRfdGlt
ZSArCgovZ2l0aHViL3dvcmtzcGFjZS9zcmMvMTI5MDA2NTIucGF0Y2ggdG90YWw6IDAgZXJyb3Jz
LCAxIHdhcm5pbmdzLCA4IGxpbmVzIGNoZWNrZWQKCk5PVEU6IEZvciBzb21lIG9mIHRoZSByZXBv
cnRlZCBkZWZlY3RzLCBjaGVja3BhdGNoIG1heSBiZSBhYmxlIHRvCiAgICAgIG1lY2hhbmljYWxs
eSBjb252ZXJ0IHRvIHRoZSB0eXBpY2FsIHN0eWxlIHVzaW5nIC0tZml4IG9yIC0tZml4LWlucGxh
Y2UuCgovZ2l0aHViL3dvcmtzcGFjZS9zcmMvMTI5MDA2NTIucGF0Y2ggaGFzIHN0eWxlIHByb2Js
ZW1zLCBwbGVhc2UgcmV2aWV3LgoKTk9URTogSWdub3JlZCBtZXNzYWdlIHR5cGVzOiBDT01NSVRf
TUVTU0FHRSBDT01QTEVYX01BQ1JPIENPTlNUX1NUUlVDVCBGSUxFX1BBVEhfQ0hBTkdFUyBNSVNT
SU5HX1NJR05fT0ZGIFBSRUZFUl9QQUNLRUQgU1BEWF9MSUNFTlNFX1RBRyBTUExJVF9TVFJJTkcg
U1NDQU5GX1RPX0tTVFJUTwoKTk9URTogSWYgYW55IG9mIHRoZSBlcnJvcnMgYXJlIGZhbHNlIHBv
c2l0aXZlcywgcGxlYXNlIHJlcG9ydAogICAgICB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUg
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMKVGVzdDogR2l0TGludCAtIEZBSUwKRGVzYzogUnVuIGdpdGxpbnQgd2l0aCBydWxlIGluIC5n
aXRsaW50Ck91dHB1dDoKW0JsdWVaLDEvMl0gY29yZTogbWFrZSBidF91dWlkX2hhc2goKSBwb3J0
YWJsZSBhY3Jvc3MgYXJjaHMKOTogQjEgTGluZSBleGNlZWRzIG1heCBsZW5ndGggKDk4PjgwKTog
InNyYy9hZGFwdGVyLmM6MzYxNzo4OiBlcnJvcjogY2FzdCBpbmNyZWFzZXMgcmVxdWlyZWQgYWxp
Z25tZW50IG9mIHRhcmdldCB0eXBlIFstV2Vycm9yPWNhc3QtYWxpZ25dIgoKW0JsdWVaLDIvMl0g
Y29yZTogRml4IHNpZ25lZCB2cyB1bnNpZ25lZCBjb21wYXJlCjk6IEIxIExpbmUgZXhjZWVkcyBt
YXggbGVuZ3RoICgxNjI+ODApOiAic3JjL2RldmljZS5jOjQwOTI6MTc6IGVycm9yOiBjb21wYXJp
c29uIG9mIGludGVnZXIgZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50IHNpZ25lZG5lc3M6IOKAmF9f
dGltZV904oCZIHtha2Eg4oCYbG9uZyBpbnTigJl9IGFuZCDigJhsb25nIHVuc2lnbmVkIGludOKA
mSBbLVdlcnJvcj1zaWduLWNvbXBhcmVdIgoKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290
aAoK

--===============8291483930734774406==--
