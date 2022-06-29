Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD0AC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 22:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiF2W7S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 18:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiF2W7C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 18:59:02 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B89A41628
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 15:57:38 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b125so13156169qkg.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 15:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=sKeLFcoCAyyD12gLv5MADboHugwo9BeLo24Sx69atXA=;
        b=V3edzlaIEiIZLJjWvfMrGwllFkSYPpohX62iNIDKjVaT7g8bASg0gp28iDbu+httjS
         85b1ghK8MXpcNjPzOwqPws00vJyDVvMSRsvMZ831AmqlN0FVXxG2DOY1YkbjJmzC2ucN
         kSwLuim0dmk/QK6Szwq4iuGW/T/fmr7tXGM7JXOhJDyqj/4EbYb0t9YP32bilYtbwpHv
         tRh7EBc/ZKGdu5QEy2dd8+puSiC1szOHy+h65ae12EmqZjjEflJ9tr+ilkNcfaHd7I+7
         ufNsdVOaj0kwPjoQ5s0M10PY1ByApBkbFZiYcG9fzPjdlDNOlFgxWCix65iTLTxkVrh5
         2mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=sKeLFcoCAyyD12gLv5MADboHugwo9BeLo24Sx69atXA=;
        b=LKJWoxzmHi2PHJMjPiqu1EijZxprfDgo2XHJNyftO2UEC1HADZPpV8EP61BrpBzM+8
         pK+ddorTA6ZKMWBsGsAw8moOR1KNChNn68btR+JLaK/9mO8lX9bJTjghxZYz1PlsGwF7
         vOic9F5tYv51kl7CEvgJPs964p4yLT21YapY0nRM2VzYcxnMpmMNg3uxEiHCGZfF5mjK
         GTYr8oHHSgIBJNf3hovVakULUfUZCZPvSYmRPNoyptYoqlC4DNRX37eJ8uMS2JNU3Qzc
         jLC2uvBHX//xlO6ODOqdMLp0OMVBh8bepBy8xLVjsLgIJN+L6wpyp/4P6wJLwia7KkKw
         hrbg==
X-Gm-Message-State: AJIora+dJAmQ0GVeB25xkz8hvrCoNTKCaYsHczax+PEIZQsvdRsRusL/
        z0f0W2bO5oGPTjxqOHC/1xtphju13306oA==
X-Google-Smtp-Source: AGRyM1sWJjl6iVj310cTdilLU9Ok7VK+JbrA+N64sGBfWDG8ycVPpAeKEMBZS5KcJfAMyDAHc5K4Zg==
X-Received: by 2002:a05:620a:15b:b0:6ae:e3b8:ea2c with SMTP id e27-20020a05620a015b00b006aee3b8ea2cmr3909197qkn.214.1656543457176;
        Wed, 29 Jun 2022 15:57:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.34.218])
        by smtp.gmail.com with ESMTPSA id m5-20020ac84445000000b00307beda5c6esm11346859qtn.26.2022.06.29.15.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 15:57:36 -0700 (PDT)
Message-ID: <62bcd8e0.1c69fb81.a818a.868a@mx.google.com>
Date:   Wed, 29 Jun 2022 15:57:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8786412558632738070=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v2,1/2] core: make bt_uuid_hash() portable across archs
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220629211640.65822-1-brian.gix@intel.com>
References: <20220629211640.65822-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8786412558632738070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjU1MTcyCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMi44OSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAxLjk5IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQxLjY5IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuNjQgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOC4x
OCBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxMjAwLjE3
IHNlY29uZHMKTWFrZSBDaGVjayAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDExLjU5IHNl
Y29uZHMKTWFrZSBDaGVjayB3L1ZhbGdyaW5kICAgICAgICAgUEFTUyAgICAgIDQzOS42OSBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMjguNTMgc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgOC4yMSBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIFBBU1MgICAgICAxMTcyLjM2IHNlY29uZHMKSW5j
cmVtZW50YWwgQnVpbGQgd2l0aCBwYXRjaGVzUEFTUyAgICAgIDI0MjguNDUgc2Vjb25kcwoKRGV0
YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIEZBSUwK
RGVzYzogUnVuIGdpdGxpbnQgd2l0aCBydWxlIGluIC5naXRsaW50Ck91dHB1dDoKW0JsdWVaLHYy
LDEvMl0gY29yZTogbWFrZSBidF91dWlkX2hhc2goKSBwb3J0YWJsZSBhY3Jvc3MgYXJjaHMKOTog
QjEgTGluZSBleGNlZWRzIG1heCBsZW5ndGggKDk4PjgwKTogInNyYy9hZGFwdGVyLmM6MzYxNzo4
OiBlcnJvcjogY2FzdCBpbmNyZWFzZXMgcmVxdWlyZWQgYWxpZ25tZW50IG9mIHRhcmdldCB0eXBl
IFstV2Vycm9yPWNhc3QtYWxpZ25dIgoKW0JsdWVaLHYyLDIvMl0gY29yZTogRml4IHNpZ25lZCB2
cyB1bnNpZ25lZCBjb21wYXJlCjk6IEIxIExpbmUgZXhjZWVkcyBtYXggbGVuZ3RoICgxNjI+ODAp
OiAic3JjL2RldmljZS5jOjQwOTI6MTc6IGVycm9yOiBjb21wYXJpc29uIG9mIGludGVnZXIgZXhw
cmVzc2lvbnMgb2YgZGlmZmVyZW50IHNpZ25lZG5lc3M6IOKAmF9fdGltZV904oCZIHtha2Eg4oCY
bG9uZyBpbnTigJl9IGFuZCDigJhsb25nIHVuc2lnbmVkIGludOKAmSBbLVdlcnJvcj1zaWduLWNv
bXBhcmVdIgoKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============8786412558632738070==--
