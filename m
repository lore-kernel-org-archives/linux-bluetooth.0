Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D695C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 11:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiIVLL4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 07:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiIVLLk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 07:11:40 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5596DED7C
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 04:10:58 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id g12so4682925ilj.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=RCkZqvA7sO16TtiG22JHa9dVweADsmihRBBGZH/78RU=;
        b=J5/bCs65l68sxEcK1Me6AGCZAbYyE/Xw4feg4D4INEKygZndVHtFT5/qSotsUu4jcA
         KuH1zwyW2wreNttomn9OMbr8svuYI64YaLAzc3JDFJz3bVi6R8FU8AVHre+yIlEiUYk2
         B8zFeqoAw0jUh14HuGw2Sf7ZKyQNXFsOra6D3dUpbHKep3NpHcLDcANdMgT38kmXL9qs
         FUp3PWx990LX0VXDkWGJAgu0OxHp0on6uyROCBcToiemakz23I4ygkAaP+uY1EyVz3Po
         TmEdsNNyznVgY7dPNV5lDG9JJTHApdOIJ4rJ2DNVGLC8oPexxVI2G03eiJpA5CFxIMeF
         WzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=RCkZqvA7sO16TtiG22JHa9dVweADsmihRBBGZH/78RU=;
        b=d4MskonBg3jzGLhHeZAajZqy5sJQdvlapSP0JItaWS17PtZiiT77TFFE6GUuSAemKh
         uTfyJorJebnbeEAuEYAsJ47kXlpwrzan8GIru74KTeXR+Dw/QsMHsWVPpZsEn15WbytR
         mUuN6Ig2ITw56bv9RPICSWfVE3Nnco0RNTzG/5jMmTEDv/nlzbxZil7Lz3D6gzPcq/wU
         5BKL9PfVJ537XLy03e5yslEeDbdODpW3+LpAQQzuzX20QYfscTxU6ZOjlI33ijGmop0V
         H24zDc4Tm/MOUUFDWRWZs2nEvHxBQhVKngfdhx1jFgT1SG0asZoNqKQVk8LT2sJuUV5k
         eZug==
X-Gm-Message-State: ACrzQf1gRWSOySfnNMrTV0eM38+bdB6etBCM5bnHvYeRG1y5gWSZmHqf
        fMO/H4rstw8wrZnhBIMImtwE1Vq5P8hrcg==
X-Google-Smtp-Source: AMsMyM76QBxQ3PMKq3sYYv0DFjv0+873lWYDRyVCNwMMU1QyrMTB1eyPx6GklhkLzEXY2HZ1+4Ndag==
X-Received: by 2002:a92:6b0c:0:b0:2e9:96b:3337 with SMTP id g12-20020a926b0c000000b002e9096b3337mr1285090ilc.283.1663845050168;
        Thu, 22 Sep 2022 04:10:50 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.15.214])
        by smtp.gmail.com with ESMTPSA id c10-20020a92cf4a000000b002f4e6fe33ddsm1912694ilr.84.2022.09.22.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 04:10:50 -0700 (PDT)
Message-ID: <632c42ba.920a0220.ac36c.2705@mx.google.com>
Date:   Thu, 22 Sep 2022 04:10:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6252036193733132794=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: btusb: Add Realtek devcoredump support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220922103337.26167-1-hildawu@realtek.com>
References: <20220922103337.26167-1-hildawu@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6252036193733132794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9Njc5Mzc1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMi4wMiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjgyIHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuNzYgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MzEuMDEgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjcu
MTAgc2Vjb25kcwpJbmNyZW1lbnRhbCBCdWlsZCB3aXRoIHBhdGNoZXNFUlJPUiAgICAgMC4zMiBz
ZWNvbmRzClRlc3RSdW5uZXI6IFNldHVwICAgICAgICAgICAgIFBBU1MgICAgICA1MTMuMjIgc2Vj
b25kcwpUZXN0UnVubmVyOiBsMmNhcC10ZXN0ZXIgICAgICBQQVNTICAgICAgMTcuMjEgc2Vjb25k
cwpUZXN0UnVubmVyOiBpc28tdGVzdGVyICAgICAgICBQQVNTICAgICAgMTYuMTYgc2Vjb25kcwpU
ZXN0UnVubmVyOiBibmVwLXRlc3RlciAgICAgICBQQVNTICAgICAgNi41MCBzZWNvbmRzClRlc3RS
dW5uZXI6IG1nbXQtdGVzdGVyICAgICAgIFBBU1MgICAgICAxMDUuMzcgc2Vjb25kcwpUZXN0UnVu
bmVyOiByZmNvbW0tdGVzdGVyICAgICBQQVNTICAgICAgMTAuMzMgc2Vjb25kcwpUZXN0UnVubmVy
OiBzY28tdGVzdGVyICAgICAgICBQQVNTICAgICAgOS43NyBzZWNvbmRzClRlc3RSdW5uZXI6IHNt
cC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA5LjcwIHNlY29uZHMKVGVzdFJ1bm5lcjogdXNlcmNo
YW4tdGVzdGVyICAgUEFTUyAgICAgIDYuNzggc2Vjb25kcwoKRGV0YWlscwojIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGRLZXJuZWwgLSBGQUlMIC0gMzEuMDEgc2Vjb25k
cwpCdWlsZCBLZXJuZWwgd2l0aCBtaW5pbWFsIGNvbmZpZ3VyYXRpb24gc3VwcG9ydHMgQmx1ZXRv
b3RoCmRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmM6IEluIGZ1bmN0aW9uIOKAmGJ0dXNiX3J0bF9j
bWRfdGltZW91dOKAmToKZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYzo3NDU6NzogZXJyb3I6IGlt
cGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGhjaV9kZXZjb3JlZHVtcF9pbml04oCZ
IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDc0NSB8ICBpZiAoIWhj
aV9kZXZjb3JlZHVtcF9pbml0KGhkZXYsIHNrYi0+bGVuKSkgewogICAgICB8ICAgICAgIF5+fn5+
fn5+fn5+fn5+fn5+fn5+CmRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmM6NzQ2OjM6IGVycm9yOiBp
bXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhoY2lfZGV2Y29yZWR1bXBfYXBwZW5k
4oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDc0NiB8ICAgaGNp
X2RldmNvcmVkdW1wX2FwcGVuZChoZGV2LCBza2IpOwogICAgICB8ICAgXn5+fn5+fn5+fn5+fn5+
fn5+fn5+fgpkcml2ZXJzL2JsdWV0b290aC9idHVzYi5jOjc0NzozOiBlcnJvcjogaW1wbGljaXQg
ZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYaGNpX2RldmNvcmVkdW1wX2NvbXBsZXRl4oCZIFst
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDc0NyB8ICAgaGNpX2RldmNv
cmVkdW1wX2NvbXBsZXRlKGhkZXYpOwogICAgICB8ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
CmNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzJdOiAqKiog
W3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjQ5OiBkcml2ZXJzL2JsdWV0b290aC9idHVzYi5vXSBF
cnJvciAxCm1ha2VbMl06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1ha2Vb
MV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0NjU6IGRyaXZlcnMvYmx1ZXRvb3RoXSBF
cnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTg1NTogZHJpdmVyc10gRXJyb3IgMgoKCiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZEtlcm5lbDMyIC0gRkFJTCAtIDI3
LjEwIHNlY29uZHMKQnVpbGQgMzJiaXQgS2VybmVsIHdpdGggbWluaW1hbCBjb25maWd1cmF0aW9u
IHN1cHBvcnRzIEJsdWV0b290aApkcml2ZXJzL2JsdWV0b290aC9idHVzYi5jOiBJbiBmdW5jdGlv
biDigJhidHVzYl9ydGxfY21kX3RpbWVvdXTigJk6CmRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmM6
NzQ1Ojc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhoY2lfZGV2
Y29yZWR1bXBfaW5pdOKAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0K
ICA3NDUgfCAgaWYgKCFoY2lfZGV2Y29yZWR1bXBfaW5pdChoZGV2LCBza2ItPmxlbikpIHsKICAg
ICAgfCAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fgpkcml2ZXJzL2JsdWV0b290aC9idHVzYi5j
Ojc0NjozOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYaGNpX2Rl
dmNvcmVkdW1wX2FwcGVuZOKAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlv
bl0KICA3NDYgfCAgIGhjaV9kZXZjb3JlZHVtcF9hcHBlbmQoaGRldiwgc2tiKTsKICAgICAgfCAg
IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYzo3NDc6Mzog
ZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGhjaV9kZXZjb3JlZHVt
cF9jb21wbGV0ZeKAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICA3
NDcgfCAgIGhjaV9kZXZjb3JlZHVtcF9jb21wbGV0ZShoZGV2KTsKICAgICAgfCAgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fgpjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJv
cnMKbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0OTogZHJpdmVycy9ibHVl
dG9vdGgvYnR1c2Iub10gRXJyb3IgMQptYWtlWzJdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hl
ZCBqb2JzLi4uLgptYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDY1OiBkcml2
ZXJzL2JsdWV0b290aF0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjE4NTU6IGRyaXZlcnNd
IEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogSW5jcmVtZW50
YWwgQnVpbGQgd2l0aCBwYXRjaGVzIC0gU0tJUFBFRCAtIDAuMzIgc2Vjb25kcwpJbmNyZW1lbnRh
bCBidWlsZCBwZXIgcGF0Y2ggaW4gdGhlIHNlcmllcwpidWlsZGtlcm5lbCBmYWlsZWQKCgoKLS0t
ClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============6252036193733132794==--
