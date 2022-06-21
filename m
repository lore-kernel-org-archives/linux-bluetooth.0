Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFB1C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 15:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352669AbiFUPVX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 11:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352661AbiFUPVV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 11:21:21 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0AC286D7
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 08:21:20 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id c1so20453542qvi.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Tx4eBPJsEbRebrV3Fp++ZnArAXnMIZudf6we4l0dGjI=;
        b=oDtdCLIYAg1eN9WzslR0/AC1R4YYOMZ8vTNjep4XgkF608TifZq/cq119BdC+tKlF9
         aOMBOlYsTLYuBz5jrhgbMo3wrYNZNuNY8GWBDX7JbNjfsaqcvwbeRO4REkA5wmsFB3hp
         nhTHNs7zFU4r3aM3rZmqqUBnFaDIkJl6nEgXaa1O7lG0vKp/sSv6yN5tD2Ynp6EXwu/v
         2ibjCe3ziTuOo8NIBsSxu44dptUDXK/cbDU/cphTYbePhXTPipK9ayNSPwx7UuI51lUO
         5lRD6gl+2E6/ChxvBPpZBr9qbd2JIr1BTEatOmrA/WVbOnaN0SGpgu0XkdjNM6ZiUqin
         tShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Tx4eBPJsEbRebrV3Fp++ZnArAXnMIZudf6we4l0dGjI=;
        b=wRwjtDd0eecyuN1XD9Cj5GA7UqKppaGLs9Y161DR+V+DLt61YiVkW8VsyGVSamFFYs
         vGMd5Go/rCX600mm1msYT5zyclqjNq7iHBJ3sU1+53YhyOA5v0hwXdO3fEH5OKRJau9Q
         yJuwc2MEsIliPY6ZgXYxbuuvqCeSfqZEdUusI/mzh1AL8jiFV5MYWRTOlkzoAOe+gVLG
         T3gDN+F1LpDgVxa3Z25mKwwIqyO2x91cnZLkeQ2GJ5rXjhLp48bLYYxLxG9CmOTmN9Wz
         NtbYiS2P6LfFc4Sncelyr/q0Kx3sIGmmUZtULi79HBgZ6NvqNCuU4cw112WV5ee1LL0L
         A22Q==
X-Gm-Message-State: AJIora+gUuLpFxBGnEOj/GPZPpGMMhko8Ws6PENvnpS93PLwz+9Pl/G9
        ZKosBgrYQNZzlVCkjjmxNazIEtT2NFRsSg==
X-Google-Smtp-Source: AGRyM1sCiJ9RCRGpPsvgptiNmCteHtNBp+Vhq6hvPxW16JyTH4IfK6hwpbtfN50L5eaegbjnQVEX/g==
X-Received: by 2002:ac8:4e94:0:b0:305:fca:8740 with SMTP id 20-20020ac84e94000000b003050fca8740mr24776718qtp.378.1655824879195;
        Tue, 21 Jun 2022 08:21:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.63.167])
        by smtp.gmail.com with ESMTPSA id i3-20020a05622a08c300b002f92b74ba99sm12325270qte.13.2022.06.21.08.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 08:21:18 -0700 (PDT)
Message-ID: <62b1e1ee.1c69fb81.1dd09.5d50@mx.google.com>
Date:   Tue, 21 Jun 2022 08:21:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2266728231524586676=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: device: Fix timeout=1 to remove the device immediately
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220621134818.11515-1-wangyouwan@uniontech.com>
References: <20220621134818.11515-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2266728231524586676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjUyMzkwCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS40NiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAwLjk5IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDM5Ljg2IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuNjUgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNy43
NSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxMjk3LjM5
IHNlY29uZHMKTWFrZSBDaGVjayAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDExLjM2IHNl
Y29uZHMKTWFrZSBDaGVjayB3L1ZhbGdyaW5kICAgICAgICAgUEFTUyAgICAgIDQwMy44NCBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMTYuMDUgc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgOC4yNiBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIFBBU1MgICAgICAxMzA5LjAxIHNlY29uZHMKSW5j
cmVtZW50YWwgQnVpbGQgd2l0aCBwYXRjaGVzUEFTUyAgICAgIDAuMDAgc2Vjb25kcwoKRGV0YWls
cwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIEZBSUwKRGVz
YzogUnVuIGdpdGxpbnQgd2l0aCBydWxlIGluIC5naXRsaW50Ck91dHB1dDoKZGV2aWNlOiBGaXgg
dGltZW91dD0xIHRvIHJlbW92ZSB0aGUgZGV2aWNlIGltbWVkaWF0ZWx5Cjk6IEIzIExpbmUgY29u
dGFpbnMgaGFyZCB0YWIgY2hhcmFjdGVycyAoXHQpOiAiCWlmICghdGltZW91dCkiCjEwOiBCMyBM
aW5lIGNvbnRhaW5zIGhhcmQgdGFiIGNoYXJhY3RlcnMgKFx0KTogIgkJcmV0dXJuOyIKMTM6IEIy
IExpbmUgaGFzIHRyYWlsaW5nIHdoaXRlc3BhY2U6ICIg44CAIgoKCgoKLS0tClJlZ2FyZHMsCkxp
bnV4IEJsdWV0b290aAoK

--===============2266728231524586676==--
