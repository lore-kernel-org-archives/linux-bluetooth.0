Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043DEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 12:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0666610D2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 12:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhKKMsd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Nov 2021 07:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhKKMsc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Nov 2021 07:48:32 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72920C061766
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 04:45:43 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id g1so2321119qvd.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 04:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rjEubTK3Wk4jFUwGlZsj/yfBrOPkXyLavWNUvHXZH3M=;
        b=Tw5NuDQ/hVd4WVU3J2pT22xjMTbQOw52lTNYoi0UBVoON2SqfWMCw+JtYSMsRADwqA
         eBWRoGVnAhsgQXCBzrvh4MuU1Djh6IR57Q0Uk4jsIArUo5Fk7pSRzYAgsV3tbS0lmpMV
         A9yNaMqt5f7tUAL0Wj3rLJOOIbjHff8+Uy1he2FfKq7oRo2t4d1Espgldh1X6/ZsCXKi
         FKWqGHMco7gpXixIe3sqhPlcFF5OyVAceRqUDoPxdQtRTMzGZrXnkvyDBpKl3+8nWE/M
         L/nH6VvuhajRGBAdoMBDm4cppa7Pp7RDYQXo/OJvO5lJKPdMCR6FCZ35rVpFFhRm4qBT
         xKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rjEubTK3Wk4jFUwGlZsj/yfBrOPkXyLavWNUvHXZH3M=;
        b=oyw5pjnhwFDOswaQtyFl3DX/Dxc61ofYJ20dLnkLS0bS0faCn9Q/vI4lnV3B7RljxD
         FjzOWLwmc53JONAZt+UmHv+zzExu1FoIFaJCbVc/Zp/DH8oLB1qGiPGpY7FtMsSmQRwn
         Hh+EXClNXSu/KDCtRJEE/Kt8p9Y0zTFzIlGSQntuxY3k0WMXM2M5ypAaN/AeqR941j/g
         J7t3AwkuTQ2ay2wlcXUJxma64zd1AdZcJ3On0Gc+KA2JKcrWR7tzlCu3n/R69yJ/nRSe
         d7+wvm0cbyy+6QXJak2bW8aDmwAfVst0AXj16Tgl69Vu4W7aU94w3KXBYhDx/UHNY04C
         3wNA==
X-Gm-Message-State: AOAM53268IeWjO5MCVkURLLqx1PlcrxvPvnzd0l9maCg0nrfIhj8BvNi
        MU3ADUrGt6H53CUQ79K+jMFywPt5UGVlLw==
X-Google-Smtp-Source: ABdhPJyN9xYehbKXkEDuvEtjHj/6EaKTIkBKJT5xYU9FN7vauS2iNsRNZAPrMqFgF8CPtP0k0rFGXQ==
X-Received: by 2002:a05:6214:1c8a:: with SMTP id ib10mr6683851qvb.46.1636634742459;
        Thu, 11 Nov 2021 04:45:42 -0800 (PST)
Received: from [172.17.0.2] ([23.102.106.44])
        by smtp.gmail.com with ESMTPSA id 1sm1527330qtx.65.2021.11.11.04.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 04:45:41 -0800 (PST)
Message-ID: <618d1075.1c69fb81.1adc8.9606@mx.google.com>
Date:   Thu, 11 Nov 2021 04:45:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1643479039727124892=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,1/3] Listen and process remote name resolving failure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211111195423.Bluez.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
References: <20211111195423.Bluez.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1643479039727124892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTc4NjgxCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgNC42MSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAyLjg4IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQ5Ljg5IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuNTAgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOS4y
NCBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxMDguMjUg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMC44NCBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIEZBSUwgICAgICAxMTEuNzIgc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgOS4xOSBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIEZBSUwgICAgICA5NS4xMCBzZWNvbmRzCgpEZXRh
aWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBHaXRMaW50IC0gRkFJTApE
ZXNjOiBSdW4gZ2l0bGludCB3aXRoIHJ1bGUgaW4gLmdpdGxpbnQKT3V0cHV0OgpbQmx1ZXosMS8z
XSBMaXN0ZW4gYW5kIHByb2Nlc3MgcmVtb3RlIG5hbWUgcmVzb2x2aW5nIGZhaWx1cmUKMTU6IEIx
IExpbmUgZXhjZWVkcyBtYXggbGVuZ3RoICgxMjE+ODApOiAiaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9wYXRjaC8yMDIxMTAyODE5MTgwNS4xLkkzNWI3ZjNh
NDk2ZjgzNGRlNmI0M2EzMmY5NGI2MTYwY2IxNDY3Yzk0QGNoYW5nZWlkLyIKCgojIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0gRkFJTApEZXNjOiBCdWls
ZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0OgphbmRyb2lkL2JsdWV0b290aC5jOiBJbiBm
dW5jdGlvbiDigJhjb25maXJtX2RldmljZV9uYW1l4oCZOgphbmRyb2lkL2JsdWV0b290aC5jOjE1
MzQ6NTogZXJyb3I6IOKAmHN0cnVjdCBtZ210X2NwX2NvbmZpcm1fbmFtZeKAmSBoYXMgbm8gbWVt
YmVyIG5hbWVkIOKAmG5hbWVfa25vd27igJkKIDE1MzQgfCAgIGNwLm5hbWVfa25vd24gPSAxOwog
ICAgICB8ICAgICBeCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6Njk5MjogYW5kcm9pZC9ibHVldG9v
dGgub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQxNzU6IGFsbF0gRXJyb3IgMgoKCiMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlIENoZWNrIC0gRkFJTApEZXNj
OiBSdW4gJ21ha2UgY2hlY2snCk91dHB1dDoKYW5kcm9pZC9ibHVldG9vdGguYzogSW4gZnVuY3Rp
b24g4oCYY29uZmlybV9kZXZpY2VfbmFtZeKAmToKYW5kcm9pZC9ibHVldG9vdGguYzoxNTM0OjU6
IGVycm9yOiDigJhzdHJ1Y3QgbWdtdF9jcF9jb25maXJtX25hbWXigJkgaGFzIG5vIG1lbWJlciBu
YW1lZCDigJhuYW1lX2tub3du4oCZCiAxNTM0IHwgICBjcC5uYW1lX2tub3duID0gMTsKICAgICAg
fCAgICAgXgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY5OTI6IGFuZHJvaWQvYmx1ZXRvb3RoLm9d
IEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZToxMDUwMTogY2hlY2tdIEVycm9yIDIKCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBEaXN0Y2hlY2sgLSBGQUlMCkRl
c2M6IFJ1biBkaXN0Y2hlY2sgdG8gY2hlY2sgdGhlIGRpc3RyaWJ1dGlvbgpPdXRwdXQ6Ci4uLy4u
L2FuZHJvaWQvYmx1ZXRvb3RoLmM6IEluIGZ1bmN0aW9uIOKAmGNvbmZpcm1fZGV2aWNlX25hbWXi
gJk6Ci4uLy4uL2FuZHJvaWQvYmx1ZXRvb3RoLmM6MTUzNDo1OiBlcnJvcjog4oCYc3RydWN0IG1n
bXRfY3BfY29uZmlybV9uYW1l4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYbmFtZV9rbm93buKA
mQogMTUzNCB8ICAgY3AubmFtZV9rbm93biA9IDE7CiAgICAgIHwgICAgIF4KbWFrZVsyXTogKioq
IFtNYWtlZmlsZTo2OTkyOiBhbmRyb2lkL2JsdWV0b290aC5vXSBFcnJvciAxCm1ha2VbMV06ICoq
KiBbTWFrZWZpbGU6NDE3NTogYWxsXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA0MjI6
IGRpc3RjaGVja10gRXJyb3IgMQoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0
OiBCdWlsZCB3L2V4dCBFTEwgLSBNYWtlIC0gRkFJTApEZXNjOiBCdWlsZCBCbHVlWiBzb3VyY2Ug
d2l0aCAnLS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9uCk91dHB1dDoKYW5kcm9p
ZC9ibHVldG9vdGguYzogSW4gZnVuY3Rpb24g4oCYY29uZmlybV9kZXZpY2VfbmFtZeKAmToKYW5k
cm9pZC9ibHVldG9vdGguYzoxNTM0OjU6IGVycm9yOiDigJhzdHJ1Y3QgbWdtdF9jcF9jb25maXJt
X25hbWXigJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJhuYW1lX2tub3du4oCZCiAxNTM0IHwgICBj
cC5uYW1lX2tub3duID0gMTsKICAgICAgfCAgICAgXgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY5
OTI6IGFuZHJvaWQvYmx1ZXRvb3RoLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MTc1
OiBhbGxdIEVycm9yIDIKCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============1643479039727124892==--
