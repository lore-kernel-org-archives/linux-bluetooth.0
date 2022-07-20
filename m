Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E79C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 14:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiGTO0g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiGTO0f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 10:26:35 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89BD3FA34
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 07:26:32 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id y18so2327960qvo.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=fxnUCgx7AINMvTOIm4PeFsUwZwMQiFw6eDoYKRrppxQ=;
        b=DX+xP2jZlwhHoPNL8Wjv9O0tTu8nEFUQQS2iGxsXlANG+E8Ee1cyWZvDgkJF2yzXme
         WyNITjop0EM/PLp5FYABn9K0qYTWIQ6kIvYsktAmLUb/ZxkgWF40cEhrQek/f/PUeW5n
         3HZVCqB9yY2trRqVOq/ftq0wUxlUq1ypW87V2xVVcy9OyJYw0H1+wrseUWwpFZIUdPcq
         9hXpKNneNCIwY2cwwxTXCgRbKaFRJP3o8rB3efoIObvTjsvNjJMWWuzt1YPaSQpOY3W6
         SEhM8cFW4NSd6H1KzcJb1ujsaTymSELHvUX2812MIfIN5gWRj1OBbnr0OlqF/HihLq6d
         W/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=fxnUCgx7AINMvTOIm4PeFsUwZwMQiFw6eDoYKRrppxQ=;
        b=ED2OPJjjeWjI+evKwMPhSSMCSDjwJ1mV+r3sMgfv6fMVf38WjpyHJ1rX76XTx6sG+R
         LDC3rwHyB+7eMxWH/oxTSAJCSMM/t2yuzH0xZ6CB7ATt00M9yJTWrDTVh6ctYD1Js4UT
         zahSubEC7wFJhcLx+2n9nPmjMPQVHCqCnl+Q2Vhn1I9DaBOH0jOKRnRUPuSUCoGs8V4h
         2HozZTGtX93h+HSi5RcRp/czSoxdEg32Z+zizAL9mkAzQ2u1M70q5m7gQECxEztgbeDF
         MUijzaK9QBBZvSjhiJO0j9ccT8it8mv5RXqphvtxdoHXWR6TqdFFGxk3tEqCZ5mctYal
         2C/Q==
X-Gm-Message-State: AJIora9HWfKRm+IpZlfuImLTzc53gnvE/F4aQI2V30Nx6mJzuZpp1Pj5
        yiuuKd5fPJ5zgU7FYJiE167VqNwzkB4=
X-Google-Smtp-Source: AGRyM1vPO9uN1KDkBQ4xRu2AKcxCzsewpw5GHQNOGPyWoAniNi7mtOBUl0PwaqwjrfADR24v/DHGvw==
X-Received: by 2002:a05:6214:226d:b0:473:339e:3264 with SMTP id gs13-20020a056214226d00b00473339e3264mr29384287qvb.41.1658327191445;
        Wed, 20 Jul 2022 07:26:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.186.230])
        by smtp.gmail.com with ESMTPSA id y20-20020a37f614000000b006b5f7d0d0b6sm5454888qkj.4.2022.07.20.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:26:31 -0700 (PDT)
Message-ID: <62d81097.1c69fb81.6dc4a.ee9f@mx.google.com>
Date:   Wed, 20 Jul 2022 07:26:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0074630254843182072=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Bluetooth: Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1658326045-9931-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1658326045-9931-2-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0074630254843182072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjYxNDg2CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgNC44NCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAyLjg3IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDIuNjMgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MzMuOTEgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBQQVNTICAgICAgMzAu
Mjkgc2Vjb25kcwpJbmNyZW1lbnRhbCBCdWlsZCB3aXRoIHBhdGNoZXNGQUlMICAgICAgMzkuNDYg
c2Vjb25kcwpUZXN0UnVubmVyOiBTZXR1cCAgICAgICAgICAgICBQQVNTICAgICAgNTA1LjU0IHNl
Y29uZHMKVGVzdFJ1bm5lcjogbDJjYXAtdGVzdGVyICAgICAgUEFTUyAgICAgIDE3LjMwIHNlY29u
ZHMKVGVzdFJ1bm5lcjogYm5lcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDYuMDMgc2Vjb25kcwpU
ZXN0UnVubmVyOiBtZ210LXRlc3RlciAgICAgICBQQVNTICAgICAgOTkuNzQgc2Vjb25kcwpUZXN0
UnVubmVyOiByZmNvbW0tdGVzdGVyICAgICBQQVNTICAgICAgOS4zNiBzZWNvbmRzClRlc3RSdW5u
ZXI6IHNjby10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA5LjE4IHNlY29uZHMKVGVzdFJ1bm5lcjog
c21wLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDkuMjYgc2Vjb25kcwpUZXN0UnVubmVyOiB1c2Vy
Y2hhbi10ZXN0ZXIgICBQQVNTICAgICAgNi4xOCBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBHaXRMaW50IC0gRkFJTCAtIDIuODcgc2Vjb25kcwpS
dW4gZ2l0bGludCB3aXRoIHJ1bGUgaW4gLmdpdGxpbnQKW3YxLDMvM10gQmx1ZXRvb3RoOiBidHVz
YjogUmVtb3ZlIEhDSV9RVUlSS19CUk9LRU5fRVJSX0RBVEFfUkVQT1JUSU5HIGZvciBmYWtlIENT
UgoxOiBUMSBUaXRsZSBleGNlZWRzIG1heCBsZW5ndGggKDgyPjgwKTogIlt2MSwzLzNdIEJsdWV0
b290aDogYnR1c2I6IFJlbW92ZSBIQ0lfUVVJUktfQlJPS0VOX0VSUl9EQVRBX1JFUE9SVElORyBm
b3IgZmFrZSBDU1IiCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEluY3Jl
bWVudGFsIEJ1aWxkIHdpdGggcGF0Y2hlcyAtIEZBSUwgLSAzOS40NiBzZWNvbmRzCkluY3JlbWVu
dGFsIGJ1aWxkIHBlciBwYXRjaCBpbiB0aGUgc2VyaWVzCmRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNi
LmM6IEluIGZ1bmN0aW9uIOKAmGJ0dXNiX3NldHVwX2NzcuKAmToKZHJpdmVycy9ibHVldG9vdGgv
YnR1c2IuYzoyMDc1OjExOiBlcnJvcjog4oCYSENJX1FVSVJLX0JST0tFTl9FUlJfREFUQV9SRVBP
UlRJTkfigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91
IG1lYW4g4oCYSENJX09QX1JFQURfREVGX0VSUl9EQVRBX1JFUE9SVElOR+KAmT8KIDIwNzUgfCAg
IHNldF9iaXQoSENJX1FVSVJLX0JST0tFTl9FUlJfREFUQV9SRVBPUlRJTkcsICZoZGV2LT5xdWly
a3MpOwogICAgICB8ICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fgogICAgICB8ICAgICAgICAgICBIQ0lfT1BfUkVBRF9ERUZfRVJSX0RBVEFfUkVQT1JUSU5HCmRy
aXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmM6MjA3NToxMTogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlk
ZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVh
cnMgaW4KZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYzogSW4gZnVuY3Rpb24g4oCYYnR1c2Jfc2V0
dXBfcWNh4oCZOgpkcml2ZXJzL2JsdWV0b290aC9idHVzYi5jOjMzNTg6MTA6IGVycm9yOiDigJhI
Q0lfUVVJUktfQlJPS0VOX0VSUl9EQVRBX1JFUE9SVElOR+KAmSB1bmRlY2xhcmVkIChmaXJzdCB1
c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiDigJhIQ0lfT1BfUkVBRF9ERUZfRVJS
X0RBVEFfUkVQT1JUSU5H4oCZPwogMzM1OCB8ICBzZXRfYml0KEhDSV9RVUlSS19CUk9LRU5fRVJS
X0RBVEFfUkVQT1JUSU5HLCAmaGRldi0+cXVpcmtzKTsKICAgICAgfCAgICAgICAgICBefn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgogICAgICB8ICAgICAgICAgIEhDSV9PUF9SRUFE
X0RFRl9FUlJfREFUQV9SRVBPUlRJTkcKbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1
aWxkOjI4ODogZHJpdmVycy9ibHVldG9vdGgvYnR1c2Iub10gRXJyb3IgMQptYWtlWzJdOiAqKiog
V2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgptYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFr
ZWZpbGUuYnVpbGQ6NTUwOiBkcml2ZXJzL2JsdWV0b290aF0gRXJyb3IgMgptYWtlOiAqKiogW01h
a2VmaWxlOjE4MzQ6IGRyaXZlcnNdIEVycm9yIDIKCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVl
dG9vdGgKCg==

--===============0074630254843182072==--
