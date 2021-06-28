Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC178C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 08:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E496141F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 08:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhF1Ifz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhF1Ify (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 04:35:54 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34FBC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 01:33:28 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f13so6852870qtb.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 01:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IK51j2ZZQrCLBe99YOJPT6h32otlJOpnXYAnNOhUWJc=;
        b=UdKBaEr+wqoOfeh2hCHdTlHWz6gXf+FSk6KHyWNknSAcB/9H71vEI/zjEDkn3UTaW9
         S/8wZzlPC21RKagA8yOzTKqWE+g/ekBHwUP8nccmPXzeFLwNx/xHqXA7TMn8v1qNlJ5Z
         yDf4+a7T6mtIOouciIatErcR5FIOgfddR6JPB5fRHrWCNb1DeSD83VW9c8YNI91kFBdc
         O3aVNbuK4nKzT4GD++e0JxrKvw0o0NhfVphqxHRmdT5L8IAbi5dq/CUCO8/v/QzfJeoY
         PjQfOiIdXF8jd6hS7gZZCTyVyj9Y3wI1yv9LV2OpHV+qHAwIcQEKT0tPGqJyPehHgdh/
         wPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IK51j2ZZQrCLBe99YOJPT6h32otlJOpnXYAnNOhUWJc=;
        b=UjFsHlubTaWk8IAXAjzKRlmlXNZCH3ClfZDOhDrkTnj8UzCoNy5wIekZ7OubKQ6A5+
         tcs2oUEGw0/44Zzj/p9C4jJxa5aemP/GGyiTHDPl0Yupw7R66SBT71QIVsERRyb1nVnE
         FA6GxrQbdZ1uUtA4zVx8PJ3XZ2yGf6Z21AlaZIjYBEjeXSkHHDtlrjLoEE7MYP1Q01Bc
         7EiC3LMU+QedfzXKt49r24wCrRF1hmUqW6YLKhHzoaU0DdNGjm3jvdgb40FsU0B8ouG3
         60ogidwyExA3sdT9tPoR/jiqGOX+khwgs+bridZmQCvDae9RHJf52lBR0Q8h3PuFAePV
         TzCA==
X-Gm-Message-State: AOAM532tkm0cYp1Ov5p2ZRchNb2RT5HZROKO2uZSfrmSbvHrGoGDWvZ4
        fb+Jfyn5diK/frMKQ4ig22MrTM6ly4yECA==
X-Google-Smtp-Source: ABdhPJzFAwIJLL7vjqUbOAK7lwZB+JDA5+ZmSsmOUKHT2YzBKjCvjCD29LyOAOJkDsTpHJqy7bs/Zg==
X-Received: by 2002:ac8:5dd1:: with SMTP id e17mr20911537qtx.252.1624869207555;
        Mon, 28 Jun 2021 01:33:27 -0700 (PDT)
Received: from [172.17.0.2] ([52.242.78.206])
        by smtp.gmail.com with ESMTPSA id 198sm10404176qkn.29.2021.06.28.01.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 01:33:27 -0700 (PDT)
Message-ID: <60d98957.1c69fb81.d8c53.cd37@mx.google.com>
Date:   Mon, 28 Jun 2021 01:33:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6594575804401014271=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [BlueZ,v3,1/3] monitor: add new Intel extended telemetry events
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210628162107.BlueZ.v3.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210628162107.BlueZ.v3.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6594575804401014271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTA3ODQ1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS4zNCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjM0IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQxLjk3IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTAgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNy4y
OSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxNi45NiBz
ZWNvbmRzCk1ha2UgQ2hlY2sgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICA1LjA0IHNlY29u
ZHMKTWFrZSBEaXN0Y2hlY2sgICAgICAgICAgICAgICAgUEFTUyAgICAgIDIxNS4zNiBzZWNvbmRz
CkJ1aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAgIFBBU1MgICAgICA3LjMyIHNlY29uZHMKQnVp
bGQgdy9leHQgRUxMIC0gTWFrZSAgICAgICAgRkFJTCAgICAgIDE2LjgyIHNlY29uZHMKCkRldGFp
bHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0Y2ggLSBQQVNT
CkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdCB3aXRoIHJ1bGUgaW4gLmNoZWNrcGF0Y2gu
Y29uZgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBQQVNT
CkRlc2M6IFJ1biBnaXRsaW50IHdpdGggcnVsZSBpbiAuZ2l0bGludAoKIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjClRlc3Q6IFByZXAgLSBTZXR1cCBFTEwgLSBQQVNTCkRlc2M6IENsb25l
LCBidWlsZCwgYW5kIGluc3RhbGwgRUxMCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMK
VGVzdDogQnVpbGQgLSBQcmVwIC0gUEFTUwpEZXNjOiBQcmVwYXJlIGVudmlyb25tZW50IGZvciBi
dWlsZAoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIC0gQ29uZmln
dXJlIC0gUEFTUwpEZXNjOiBDb25maWd1cmUgdGhlIEJsdWVaIHNvdXJjZSB0cmVlCgojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0gRkFJTApEZXNjOiBC
dWlsZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0Ogptb25pdG9yL3BhY2tldC5jOiBJbiBm
dW5jdGlvbiDigJhjdXJyZW50X3ZlbmRvcl9ldnTigJk6Cm1vbml0b3IvcGFja2V0LmM6OTM3OToy
NzogZXJyb3I6IHVudXNlZCB2YXJpYWJsZSDigJh2bmTigJkgWy1XZXJyb3I9dW51c2VkLXZhcmlh
YmxlXQogOTM3OSB8ICBjb25zdCBzdHJ1Y3QgdmVuZG9yX2V2dCAqdm5kOwogICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQg
YXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6NjkzOTogbW9uaXRvci9wYWNrZXQub10g
RXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQxMzQ6IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlIENoZWNrIC0gRkFJTApEZXNjOiBSdW4g
J21ha2UgY2hlY2snCk91dHB1dDoKbW9uaXRvci9wYWNrZXQuYzogSW4gZnVuY3Rpb24g4oCYY3Vy
cmVudF92ZW5kb3JfZXZ04oCZOgptb25pdG9yL3BhY2tldC5jOjkzNzk6Mjc6IGVycm9yOiB1bnVz
ZWQgdmFyaWFibGUg4oCYdm5k4oCZIFstV2Vycm9yPXVudXNlZC12YXJpYWJsZV0KIDkzNzkgfCAg
Y29uc3Qgc3RydWN0IHZlbmRvcl9ldnQgKnZuZDsKICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtl
WzFdOiAqKiogW01ha2VmaWxlOjY5Mzk6IG1vbml0b3IvcGFja2V0Lm9dIEVycm9yIDEKbWFrZTog
KioqIFtNYWtlZmlsZToxMDQwNjogY2hlY2tdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKVGVzdDogTWFrZSBEaXN0Y2hlY2sgLSBQQVNTCkRlc2M6IFJ1biBkaXN0Y2hl
Y2sgdG8gY2hlY2sgdGhlIGRpc3RyaWJ1dGlvbgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjClRlc3Q6IEJ1aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAtIFBBU1MKRGVzYzogQ29uZmln
dXJlIEJsdWVaIHNvdXJjZSB3aXRoICctLWVuYWJsZS1leHRlcm5hbC1lbGwnIGNvbmZpZ3VyYXRp
b24KCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCB3L2V4dCBFTEwg
LSBNYWtlIC0gRkFJTApEZXNjOiBCdWlsZCBCbHVlWiBzb3VyY2Ugd2l0aCAnLS1lbmFibGUtZXh0
ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9uCk91dHB1dDoKbW9uaXRvci9wYWNrZXQuYzogSW4gZnVu
Y3Rpb24g4oCYY3VycmVudF92ZW5kb3JfZXZ04oCZOgptb25pdG9yL3BhY2tldC5jOjkzNzk6Mjc6
IGVycm9yOiB1bnVzZWQgdmFyaWFibGUg4oCYdm5k4oCZIFstV2Vycm9yPXVudXNlZC12YXJpYWJs
ZV0KIDkzNzkgfCAgY29uc3Qgc3RydWN0IHZlbmRvcl9ldnQgKnZuZDsKICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFz
IGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY5Mzk6IG1vbml0b3IvcGFja2V0Lm9dIEVy
cm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MTM0OiBhbGxdIEVycm9yIDIKCgoKCi0tLQpSZWdh
cmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============6594575804401014271==--
