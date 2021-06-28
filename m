Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21EEC2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 10:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F4B61C47
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 10:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhF1Kfu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 06:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhF1Kft (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 06:35:49 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C301C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 03:33:23 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id z3so453354qkl.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 03:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/QapOrzEAvxjlz5LVAardnDYdaak3S5HuW+n30Eh3zM=;
        b=TNpEUFX8Hkk/dYgZ2QI3afA23z6Iv63PVx66tF3LJ9NTM3k9mEy726LA6id5s/62mL
         ox2KxVh/Kl2SoPvYJLN3eLEqx5if6JnFy65nBbvbbSmeSf9At7QypzxBda/Uk0izwspH
         I8gM2Gx5yVXRSskWxs3n1qJRbijdvSyz3++IGqJye0IoFiS1yEVkyjPWgQ1O76i01gG1
         L7t9f3p+7V7N3lGfcr4w10GeRQY3sCvzWl008FwHD++Q20zfxXba/kMdCDqBkrxeeSfg
         qUx5+bmAeLuHGgBk9ftYSQs6dQYXUBLJW1Hcr1ZVla7afmKtl+znT7RFRyMP6Sj+DIUa
         egNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/QapOrzEAvxjlz5LVAardnDYdaak3S5HuW+n30Eh3zM=;
        b=HAr6oJyFUCE4g/7ERj6RGV53OsdXrJJFu2L5oEPyPmTZil8M90zOxLB7S91KNDXpau
         vtSqBzj6Rmh8AISxc+tKpwlD6ASC+gavvnaU+5NW0OyaQvPvIwjrVdEywXvV75D2N11c
         fr+0D9T254bamg+PnMKPcwMw2XMPIjOgoHU34KJdO+kuVp1kngKkWVgEvpv4pq4VqOPW
         UQEOqw/1DK2FBKjm2xJXWzJjqM0oiA0zX/ygCuRO8q53Mi29vEevLihEmim8Z7zi//73
         uCJrQEDUNak9Z9smqdGb9M7DP7IRG1tZWUJfBCsPEdJw7yscS+r8XE6CW2awrKKUvpY6
         /U4Q==
X-Gm-Message-State: AOAM530EE1QQaub7cHCiOedyJlqkl406N713YernYet0a7053rNet+xv
        4/If8/mEM4K2UZIwd4kQx5QyLUqcCnNk5g==
X-Google-Smtp-Source: ABdhPJzbztp/54bCqsVI1nwrTfO7ryEuO3YVbbPmH7lT+xf/LJV58aHUIobsB2hSFFLvW8bMulihlg==
X-Received: by 2002:a37:aa09:: with SMTP id t9mr24445117qke.259.1624876402437;
        Mon, 28 Jun 2021 03:33:22 -0700 (PDT)
Received: from [172.17.0.2] ([104.208.242.100])
        by smtp.gmail.com with ESMTPSA id h128sm10075312qkc.94.2021.06.28.03.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 03:33:22 -0700 (PDT)
Message-ID: <60d9a572.1c69fb81.5d253.b6c2@mx.google.com>
Date:   Mon, 28 Jun 2021 03:33:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0626644162429048115=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [BlueZ,v4,1/3] monitor: add new Intel extended telemetry events
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210628175942.BlueZ.v4.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210628175942.BlueZ.v4.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0626644162429048115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTA3OTA1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS4yNyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjMyIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQwLjc0IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMDkgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNy4w
MSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAyMi4wMyBz
ZWNvbmRzCk1ha2UgQ2hlY2sgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAwLjU3IHNlY29u
ZHMKTWFrZSBEaXN0Y2hlY2sgICAgICAgICAgICAgICAgUEFTUyAgICAgIDIwNC43MCBzZWNvbmRz
CkJ1aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAgIFBBU1MgICAgICA3LjAyIHNlY29uZHMKQnVp
bGQgdy9leHQgRUxMIC0gTWFrZSAgICAgICAgRkFJTCAgICAgIDIxLjk3IHNlY29uZHMKCkRldGFp
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
dWlsZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0Ogptb25pdG9yL2ludGVsLmM6MTQ0Mjoy
NjogZXJyb3I6IG5vIHByZXZpb3VzIGRlY2xhcmF0aW9uIGZvciDigJhpbnRlbF92ZW5kb3JfcHJl
Zml4X2V2dOKAmSBbLVdlcnJvcj1taXNzaW5nLWRlY2xhcmF0aW9uc10KIDE0NDIgfCBjb25zdCBz
dHJ1Y3QgdmVuZG9yX2V2dCAqaW50ZWxfdmVuZG9yX3ByZWZpeF9ldnQoY29uc3Qgdm9pZCAqZGF0
YSwKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4KbW9uaXRvci9pbnRlbC5jOiBJbiBmdW5jdGlvbiDigJhpbnRlbF92ZW5kb3JfcHJlZml4X2V2
dOKAmToKbW9uaXRvci9pbnRlbC5jOjE0NTA6MTY6IGVycm9yOiBjb21wYXJpc29uIG9mIGludGVn
ZXIgZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50IHNpZ25lZG5lc3M6IOKAmGludOKAmSBhbmQg4oCY
bG9uZyB1bnNpZ25lZCBpbnTigJkgWy1XZXJyb3I9c2lnbi1jb21wYXJlXQogMTQ1MCB8ICBmb3Ig
KGkgPSAwOyBpIDwgSU5URUxfVkVORE9SX1BSRUZJWF9TSVpFOyBpKyspIHsKICAgICAgfCAgICAg
ICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1h
a2VbMV06ICoqKiBbTWFrZWZpbGU6NjkzOTogbW9uaXRvci9pbnRlbC5vXSBFcnJvciAxCm1ha2U6
ICoqKiBbTWFrZWZpbGU6NDEzNDogYWxsXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjClRlc3Q6IE1ha2UgQ2hlY2sgLSBGQUlMCkRlc2M6IFJ1biAnbWFrZSBjaGVjaycK
T3V0cHV0Ogptb25pdG9yL2ludGVsLmM6MTQ0MjoyNjogZXJyb3I6IG5vIHByZXZpb3VzIGRlY2xh
cmF0aW9uIGZvciDigJhpbnRlbF92ZW5kb3JfcHJlZml4X2V2dOKAmSBbLVdlcnJvcj1taXNzaW5n
LWRlY2xhcmF0aW9uc10KIDE0NDIgfCBjb25zdCBzdHJ1Y3QgdmVuZG9yX2V2dCAqaW50ZWxfdmVu
ZG9yX3ByZWZpeF9ldnQoY29uc3Qgdm9pZCAqZGF0YSwKICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KbW9uaXRvci9pbnRlbC5jOiBJbiBmdW5j
dGlvbiDigJhpbnRlbF92ZW5kb3JfcHJlZml4X2V2dOKAmToKbW9uaXRvci9pbnRlbC5jOjE0NTA6
MTY6IGVycm9yOiBjb21wYXJpc29uIG9mIGludGVnZXIgZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50
IHNpZ25lZG5lc3M6IOKAmGludOKAmSBhbmQg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJkgWy1XZXJy
b3I9c2lnbi1jb21wYXJlXQogMTQ1MCB8ICBmb3IgKGkgPSAwOyBpIDwgSU5URUxfVkVORE9SX1BS
RUZJWF9TSVpFOyBpKyspIHsKICAgICAgfCAgICAgICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6NjkzOTog
bW9uaXRvci9pbnRlbC5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA0MDY6IGNoZWNr
XSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2UgRGlz
dGNoZWNrIC0gUEFTUwpEZXNjOiBSdW4gZGlzdGNoZWNrIHRvIGNoZWNrIHRoZSBkaXN0cmlidXRp
b24KCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCB3L2V4dCBFTEwg
LSBDb25maWd1cmUgLSBQQVNTCkRlc2M6IENvbmZpZ3VyZSBCbHVlWiBzb3VyY2Ugd2l0aCAnLS1l
bmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9uCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMKVGVzdDogQnVpbGQgdy9leHQgRUxMIC0gTWFrZSAtIEZBSUwKRGVzYzogQnVpbGQg
Qmx1ZVogc291cmNlIHdpdGggJy0tZW5hYmxlLWV4dGVybmFsLWVsbCcgY29uZmlndXJhdGlvbgpP
dXRwdXQ6Cm1vbml0b3IvaW50ZWwuYzoxNDQyOjI2OiBlcnJvcjogbm8gcHJldmlvdXMgZGVjbGFy
YXRpb24gZm9yIOKAmGludGVsX3ZlbmRvcl9wcmVmaXhfZXZ04oCZIFstV2Vycm9yPW1pc3Npbmct
ZGVjbGFyYXRpb25zXQogMTQ0MiB8IGNvbnN0IHN0cnVjdCB2ZW5kb3JfZXZ0ICppbnRlbF92ZW5k
b3JfcHJlZml4X2V2dChjb25zdCB2b2lkICpkYXRhLAogICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fgptb25pdG9yL2ludGVsLmM6IEluIGZ1bmN0
aW9uIOKAmGludGVsX3ZlbmRvcl9wcmVmaXhfZXZ04oCZOgptb25pdG9yL2ludGVsLmM6MTQ1MDox
NjogZXJyb3I6IGNvbXBhcmlzb24gb2YgaW50ZWdlciBleHByZXNzaW9ucyBvZiBkaWZmZXJlbnQg
c2lnbmVkbmVzczog4oCYaW504oCZIGFuZCDigJhsb25nIHVuc2lnbmVkIGludOKAmSBbLVdlcnJv
cj1zaWduLWNvbXBhcmVdCiAxNDUwIHwgIGZvciAoaSA9IDA7IGkgPCBJTlRFTF9WRU5ET1JfUFJF
RklYX1NJWkU7IGkrKykgewogICAgICB8ICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2Fybmlu
Z3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo2OTM5OiBt
b25pdG9yL2ludGVsLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MTM0OiBhbGxdIEVy
cm9yIDIKCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============0626644162429048115==--
