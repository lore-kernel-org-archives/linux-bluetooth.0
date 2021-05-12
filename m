Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE830C43618
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F0E613FB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 20:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245506AbhELUOD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 16:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359624AbhELSxg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 14:53:36 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A743C06134D
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 11:50:07 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y12so17975721qtx.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bPjYxIb9RAiNc71Rgxqvz+SJ+rzfzSS38lmMcnLp3dY=;
        b=BFXpMWwYyW7wkr0usfyVNCtiSlHEvCGyOXCdCp+t49ldy8yhHipSHoDab21s40VK+F
         XtZ3BfZozr5u3Lv36/1RXs9vV06DvGQrVzXRBsJVrP1OZrGmuVxJoFuBEJDAdF2jqWdc
         BxL5jD7TI9XG/DkclKQEhsq/mTBt7/eTI6Gir8kdpxYOJsEx6l39kazX9mSA9onnq6hb
         Y2+VLTjRNUsHYcMu/UKhDeZKMzkwOpK9ZahpAGpY9PdV/fgmpO2/w2WYQ4oLbqfURAY+
         EF7sQK8wKvbxsiZPVDSmTTA8agvULBb6cr5T8ecC17i7tH3fLCWgJ/Cd2esYkJ3TxvaI
         Nh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bPjYxIb9RAiNc71Rgxqvz+SJ+rzfzSS38lmMcnLp3dY=;
        b=o8dsGKM1Hh8pprH7jZ8ZlQOedPq84t6IWAPyQHLIeClhJjQmonmj77UaO9TYFYHRbn
         XuUs4s577lX9dacZDDZshjZQxvmeeZEJEAJHzKRGx3g7/qxyIV3bFjU2h7yge+H2aaAp
         iAUBHGA0TD/7JO8bHpvq4omi/I6+8qFM43qkH7BHGrabHnGU5lp4NiVGPmUxFt1IEQGP
         66WjgrR1qUHSzUYbsl9/+eKRQefKvQWGcjrrIingvihG5xTxZELCz24TpId5uMMgOy6v
         mHqKllJaCp7Hkc4OvFrPbp/FXNFOD3mv0ht2kpc4CaXxazrsViQrGls3UC2RhpwFfzEV
         oYnA==
X-Gm-Message-State: AOAM532xrXR8lQwzkipHGOAOOqXchrgWEjc1ybZyvtjNxanmFqy6BPzH
        mV5ltHKM0TtBLNEhkDusDia/qydeL+bpsQ==
X-Google-Smtp-Source: ABdhPJwtrQhFxi4Ha8XnPjCpQ/ukbrYxO3Rs/ujwuyhUKhzuj6+3JjrUQ2xQL7QzMIvrLN+RYyo1ww==
X-Received: by 2002:a05:622a:1493:: with SMTP id t19mr33861718qtx.147.1620845406473;
        Wed, 12 May 2021 11:50:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.225.13])
        by smtp.gmail.com with ESMTPSA id g25sm552853qtu.93.2021.05.12.11.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 11:50:05 -0700 (PDT)
Message-ID: <609c235d.1c69fb81.bf9a9.4a1b@mx.google.com>
Date:   Wed, 12 May 2021 11:50:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6858751545569254572=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sgrubb@redhat.com
Subject: RE: [1/1] Fix various memory leaks
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210512133932.4e2b4bd0@ivy-bridge>
References: <20210512133932.4e2b4bd0@ivy-bridge>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6858751545569254572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDgxNDIzCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC40NSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjEyIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDM4LjY2IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTAgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNi45
MSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICA5LjM3IHNl
Y29uZHMKTWFrZSBDaGVjayAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDAuNDIgc2Vjb25k
cwpNYWtlIERpc3RjaGVjayAgICAgICAgICAgICAgICBGQUlMICAgICAgNzAuMTQgc2Vjb25kcwpC
dWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgNi45MiBzZWNvbmRzCkJ1aWxk
IHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIEZBSUwgICAgICA5LjIzIHNlY29uZHMKCkRldGFpbHMK
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0Y2ggLSBQQVNTCkRl
c2M6IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdCB3aXRoIHJ1bGUgaW4gLmNoZWNrcGF0Y2guY29u
ZgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBQQVNTCkRl
c2M6IFJ1biBnaXRsaW50IHdpdGggcnVsZSBpbiAuZ2l0bGludAoKIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjClRlc3Q6IFByZXAgLSBTZXR1cCBFTEwgLSBQQVNTCkRlc2M6IENsb25lLCBi
dWlsZCwgYW5kIGluc3RhbGwgRUxMCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVz
dDogQnVpbGQgLSBQcmVwIC0gUEFTUwpEZXNjOiBQcmVwYXJlIGVudmlyb25tZW50IGZvciBidWls
ZAoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIC0gQ29uZmlndXJl
IC0gUEFTUwpEZXNjOiBDb25maWd1cmUgdGhlIEJsdWVaIHNvdXJjZSB0cmVlCgojIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0gRkFJTApEZXNjOiBCdWls
ZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0OgpzcmMvc2hhcmVkL3NoZWxsLmM6IEluIGZ1
bmN0aW9uIOKAmGJ0X3NoZWxsX3Byb21wdF9pbnB1dOKAmToKc3JjL3NoYXJlZC9zaGVsbC5jOjYx
NDozOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYZ19mcmVl4oCZ
OyBkaWQgeW91IG1lYW4g4oCYcmxfZnJlZeKAmT8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24t
ZGVjbGFyYXRpb25dCiAgNjE0IHwgICBnX2ZyZWUoc3RyKTsKICAgICAgfCAgIF5+fn5+fgogICAg
ICB8ICAgcmxfZnJlZQpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwpt
YWtlWzFdOiAqKiogW01ha2VmaWxlOjY5NDc6IHNyYy9zaGFyZWQvc2hlbGwubG9dIEVycm9yIDEK
bWFrZTogKioqIFtNYWtlZmlsZTo0MTI4OiBhbGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBDaGVjayAtIEZBSUwKRGVzYzogUnVuICdtYWtlIGNo
ZWNrJwpPdXRwdXQ6CnNyYy9zaGFyZWQvc2hlbGwuYzogSW4gZnVuY3Rpb24g4oCYYnRfc2hlbGxf
cHJvbXB0X2lucHV04oCZOgpzcmMvc2hhcmVkL3NoZWxsLmM6NjE0OjM6IGVycm9yOiBpbXBsaWNp
dCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhnX2ZyZWXigJk7IGRpZCB5b3UgbWVhbiDigJhy
bF9mcmVl4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICA2MTQg
fCAgIGdfZnJlZShzdHIpOwogICAgICB8ICAgXn5+fn5+CiAgICAgIHwgICBybF9mcmVlCmNjMTog
YWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZp
bGU6Njk0Nzogc3JjL3NoYXJlZC9zaGVsbC5sb10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxl
OjEwMzk4OiBjaGVja10gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBNYWtlIERpc3RjaGVjayAtIEZBSUwKRGVzYzogUnVuIGRpc3RjaGVjayB0byBjaGVjayB0
aGUgZGlzdHJpYnV0aW9uCk91dHB1dDoKLi4vLi4vc3JjL3NoYXJlZC9zaGVsbC5jOiBJbiBmdW5j
dGlvbiDigJhidF9zaGVsbF9wcm9tcHRfaW5wdXTigJk6Ci4uLy4uL3NyYy9zaGFyZWQvc2hlbGwu
Yzo2MTQ6Mzogd2FybmluZzogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYZ19m
cmVl4oCZOyBkaWQgeW91IG1lYW4g4oCYcmxfZnJlZeKAmT8gWy1XaW1wbGljaXQtZnVuY3Rpb24t
ZGVjbGFyYXRpb25dCiAgNjE0IHwgICBnX2ZyZWUoc3RyKTsKICAgICAgfCAgIF5+fn5+fgogICAg
ICB8ICAgcmxfZnJlZQovdXNyL2Jpbi9sZDogc3JjLy5saWJzL2xpYnNoYXJlZC1lbGwuYShzaGVs
bC5vKTogaW4gZnVuY3Rpb24gYGJ0X3NoZWxsX3Byb21wdF9pbnB1dCc6Ci9naXRodWIvd29ya3Nw
YWNlL3NyYy9ibHVlei01LjU4L19idWlsZC9zdWIvLi4vLi4vc3JjL3NoYXJlZC9zaGVsbC5jOjYx
NDogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgZ19mcmVlJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJl
dHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZVsyXTogKioqIFtNYWtlZmlsZTo1OTU2OiB0b29scy9t
ZXNoLWNmZ2NsaWVudF0gRXJyb3IgMQptYWtlWzFdOiAqKiogW01ha2VmaWxlOjQxMjg6IGFsbF0g
RXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjEwMzE5OiBkaXN0Y2hlY2tdIEVycm9yIDEKCgoj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgdy9leHQgRUxMIC0gQ29u
ZmlndXJlIC0gUEFTUwpEZXNjOiBDb25maWd1cmUgQmx1ZVogc291cmNlIHdpdGggJy0tZW5hYmxl
LWV4dGVybmFsLWVsbCcgY29uZmlndXJhdGlvbgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjClRlc3Q6IEJ1aWxkIHcvZXh0IEVMTCAtIE1ha2UgLSBGQUlMCkRlc2M6IEJ1aWxkIEJsdWVa
IHNvdXJjZSB3aXRoICctLWVuYWJsZS1leHRlcm5hbC1lbGwnIGNvbmZpZ3VyYXRpb24KT3V0cHV0
OgpzcmMvc2hhcmVkL3NoZWxsLmM6IEluIGZ1bmN0aW9uIOKAmGJ0X3NoZWxsX3Byb21wdF9pbnB1
dOKAmToKc3JjL3NoYXJlZC9zaGVsbC5jOjYxNDozOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRp
b24gb2YgZnVuY3Rpb24g4oCYZ19mcmVl4oCZOyBkaWQgeW91IG1lYW4g4oCYcmxfZnJlZeKAmT8g
Wy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgNjE0IHwgICBnX2ZyZWUo
c3RyKTsKICAgICAgfCAgIF5+fn5+fgogICAgICB8ICAgcmxfZnJlZQpjYzE6IGFsbCB3YXJuaW5n
cyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY5NDc6IHNy
Yy9zaGFyZWQvc2hlbGwubG9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MTI4OiBhbGxd
IEVycm9yIDIKCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============6858751545569254572==--
