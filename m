Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A125C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 22:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240503AbiHEW7O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 18:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbiHEW7N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 18:59:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD3A3138B
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 15:59:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso4179871pjd.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Aug 2022 15:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=My/u8+EZGewJYynFwBba0AaiSJ46m75JbfN5lSAIWPk=;
        b=Fvs88p2y3ofIOJmWC1b+0mSdpd+aBdCzNs2ZwwdoVr6Etvwdu0sXReGLv2fvVnG+Jo
         k1HQuP7Cd3QUa03Uh5LPP/OR6Wtj1JcP2MMt1ebwzyyZ+ddxHGnTr52vW/F8Bctugx99
         0zciWnM3DJNq3pvZh7dkOJift2qwJSej8rs8l24aKtJNkZGBJd5soe8EsNBSsptxhZzk
         n7M3gs6GhzK1m7Eo50YRkGeCbWzZBLVygX5j8bng7ivLBpHzfR5OGMFOPKzpeEGY3ea+
         hSHyAsmvvR1G3VhBet5mZEdsKh4ck+c/1NslQMDEZ33gXNhe5phIpRcsdLeI539nAyZz
         fbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=My/u8+EZGewJYynFwBba0AaiSJ46m75JbfN5lSAIWPk=;
        b=Gi5o8N2yITTzS4wcauM33Rrxosp2heTaXzKcrcs3dUIueSHyCHKA6h0VZRmdgnsbB2
         91dedJWCcGKfykM9DNpQEvpPvwjf+bkIPTsmbhY/gcDe34yUo07wWBr8dRFrItpcDQE7
         cMyO3PAxe6axi7mvVSbv1fv3stD/lUgcD6yIKSASBnLjy1CeNBzmecxPhtz3nnKVClTP
         Kzl+JAqQk0g/BGKgt0qeY1jHnGp/I9PEJU7L7vr9tF+G+PgSkPulmJM4NWF3usHTiQ4Z
         CFi1aUfO/SzN8BaUdUL/+jCKBYLW8/lBVAxjLuffJcu2gf6M0MRjSHUswFDKj/BHxZCb
         14Cw==
X-Gm-Message-State: ACgBeo0F+zFrSjAFKLlzGK9RACMPRkv0UYNV8H9ZxZNUs3F8W+cYzg/w
        ui0MuqXZPxbp/k6t8tuO9cOw9jgiLhw=
X-Google-Smtp-Source: AA6agR414EOa8aYUsdBNvVbace7eFY0w/v+b+zxuf+vllkoSNuT/Hx4Ulxic05Fdxz8jkHi1konkCw==
X-Received: by 2002:a17:902:dace:b0:170:8c21:3b1f with SMTP id q14-20020a170902dace00b001708c213b1fmr1049622plx.55.1659740352086;
        Fri, 05 Aug 2022 15:59:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.57.29])
        by smtp.gmail.com with ESMTPSA id p7-20020aa79e87000000b0052de09a38d0sm3638179pfq.2.2022.08.05.15.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 15:59:11 -0700 (PDT)
Message-ID: <62eda0bf.a70a0220.6e650.6c05@mx.google.com>
Date:   Fri, 05 Aug 2022 15:59:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5415582139414608169=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] bthost: Add qos support to bthost_set_cig_params
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220805215622.3958723-1-luiz.dentz@gmail.com>
References: <20220805215622.3958723-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5415582139414608169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjY1NzY5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS41OCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAxLjA3IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI2LjYwIHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuNTggc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOC4y
MSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIFBBU1MgICAgICA3NTUuMDIg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTEuNjggc2Vj
b25kcwpNYWtlIENoZWNrIHcvVmFsZ3JpbmQgICAgICAgICBQQVNTICAgICAgMjgzLjM5IHNlY29u
ZHMKTWFrZSBEaXN0Y2hlY2sgICAgICAgICAgICAgICAgUEFTUyAgICAgIDIzMy44NCBzZWNvbmRz
CkJ1aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAgIFBBU1MgICAgICA4LjIzIHNlY29uZHMKQnVp
bGQgdy9leHQgRUxMIC0gTWFrZSAgICAgICAgUEFTUyAgICAgIDgxLjM4IHNlY29uZHMKSW5jcmVt
ZW50YWwgQnVpbGQgdy8gcGF0Y2hlcyAgRkFJTCAgICAgIDIxLjk3IHNlY29uZHMKU2NhbiBCdWls
ZCAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDQ4OS4xNCBzZWNvbmRzCgpEZXRhaWxzCiMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBJbmNyZW1lbnRhbCBCdWlsZCB3LyBw
YXRjaGVzIC0gRkFJTApEZXNjOiBJbmNyZW1lbnRhbCBidWlsZCBwZXIgcGF0Y2ggaW4gdGhlIHNl
cmllcwpPdXRwdXQ6CnRvb2xzL2lzby10ZXN0ZXIuYzogSW4gZnVuY3Rpb24g4oCYc2V0dXBfbGlz
dGVu4oCZOgp0b29scy9pc28tdGVzdGVyLmM6MTQ1MzozOiBlcnJvcjogdG9vIGZldyBhcmd1bWVu
dHMgdG8gZnVuY3Rpb24g4oCYYnRob3N0X3NldF9jaWdfcGFyYW1z4oCZCiAxNDUzIHwgICBidGhv
c3Rfc2V0X2NpZ19wYXJhbXMoaG9zdCwgMHgwMSwgMHgwMSk7CiAgICAgIHwgICBefn5+fn5+fn5+
fn5+fn5+fn5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIHRvb2xzL2lzby10ZXN0ZXIuYzoyNzoK
Li9lbXVsYXRvci9idGhvc3QuaDoxMDU6Njogbm90ZTogZGVjbGFyZWQgaGVyZQogIDEwNSB8IHZv
aWQgYnRob3N0X3NldF9jaWdfcGFyYW1zKHN0cnVjdCBidGhvc3QgKmJ0aG9zdCwgdWludDhfdCBj
aWdfaWQsCiAgICAgIHwgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn4KbWFrZVsxXTogKioqIFtN
YWtlZmlsZTo3MzQ1OiB0b29scy9pc28tdGVzdGVyLm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdh
aXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZTogKioqIFtNYWtlZmlsZTo0MzU1OiBh
bGxdIEVycm9yIDIKCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============5415582139414608169==--
