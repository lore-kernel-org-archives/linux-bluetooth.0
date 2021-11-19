Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175AAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B8860273
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhKSJ6m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSJ6m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 04:58:42 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5582C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 01:55:40 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id q64so9647215qkd.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 01:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=AVqbds9IezGl6tDiRuRiKBggmNETQ8geRa0Ho/LVOnk=;
        b=bsNDQNPu8GEooLJIv3xbmlbEJCi6KWimLJHMY/tuR24bRSjkYpT+zkkqeQWfMdWYZB
         5cy1IhbpU7cvHSzfLTNWZFzlr615jqRTjOK/YymRIhsYrmmv3vF9YEjZ41HD6Pbsv4tU
         Q07vOEOluJiYcsKzSHPFOzfHXpRvgee5o+WvOPmhhIS2KP99Snolus+It93zBSspkRih
         EPLoCHelQVZYIK8MkZrY6y/qLWWfKmgJlwr5k6xrbm8IqBD7GQkk8I8pHBIrVdRplzeR
         aJUPDrRxJ5E65t5CEw2g/aJKg1fAxcIouoHeFTbLMkECRnbOeLl3pjgugQHYo6hL2PIL
         6HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=AVqbds9IezGl6tDiRuRiKBggmNETQ8geRa0Ho/LVOnk=;
        b=i+/nk7BORyDt1/5pFjZ7vlszoxrTdc1PU4EKDFsPGUutEnUPCsGPL71eaeeyNgG1Sn
         c1MJfLzOJkld6o2wDJNMO8vdS+wQp/kZ2LWySd3tO9owYdTqkknukUEs82wV0sbznbfO
         7rIzduYJfokQPBFflGNyq/BzSC56u/xYLjhmExCc8nDUF3P/rPypRTLJ0blO9heKt03D
         YpQNUDofw/DmSTqR8/Us6uEK2hx7djWjTIVuxVMtX9GahhE9EIkX6gZKaBNqsCKEEja5
         qOIec+agHnhT1q8sGLd5ikbjT13F13KP9uvSxblVbCLZHuHb/k1/GHqhnWBwzlqfew4R
         xFEw==
X-Gm-Message-State: AOAM531K3JORS0fHsYmDeP1IwnY5p/8CuGP2UrsXelFka0AD2hyZj6/8
        E8zqkG6CVzE0phHlZ6lGCdVnMgN3zGj4NqZZ
X-Google-Smtp-Source: ABdhPJx8p2ubO4/9ez3HiHViAa9VFwGZdluQ4kV7LCpz8UyBTt0IEoIqVCpIdsGbxfPWHqiYzZgqmg==
X-Received: by 2002:a37:f619:: with SMTP id y25mr26827836qkj.201.1637315739234;
        Fri, 19 Nov 2021 01:55:39 -0800 (PST)
Received: from [172.17.0.2] ([20.119.217.120])
        by smtp.gmail.com with ESMTPSA id t15sm1332270qta.45.2021.11.19.01.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 01:55:38 -0800 (PST)
Message-ID: <6197749a.1c69fb81.b8201.8248@mx.google.com>
Date:   Fri, 19 Nov 2021 01:55:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5731389825600000469=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/9] adapter: Enable MSFT a2dp offload codec when Experimental is set
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211119094235.2432-1-kiran.k@intel.com>
References: <20211119094235.2432-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5731389825600000469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTgyOTQ1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBGQUlMICAgICAgMTMuNDUgc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBQ
QVNTICAgICAgOC45NyBzZWNvbmRzClByZXAgLSBTZXR1cCBFTEwgICAgICAgICAgICAgIFBBU1Mg
ICAgICA0MS42MiBzZWNvbmRzCkJ1aWxkIC0gUHJlcCAgICAgICAgICAgICAgICAgIFBBU1MgICAg
ICAwLjY1IHNlY29uZHMKQnVpbGQgLSBDb25maWd1cmUgICAgICAgICAgICAgUEFTUyAgICAgIDcu
OTEgc2Vjb25kcwpCdWlsZCAtIE1ha2UgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTM4Ljkz
IHNlY29uZHMKTWFrZSBDaGVjayAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDEuNjYgc2Vj
b25kcwpNYWtlIERpc3RjaGVjayAgICAgICAgICAgICAgICBQQVNTICAgICAgMjE3LjMzIHNlY29u
ZHMKQnVpbGQgdy9leHQgRUxMIC0gQ29uZmlndXJlICAgUEFTUyAgICAgIDguMTMgc2Vjb25kcwpC
dWlsZCB3L2V4dCBFTEwgLSBNYWtlICAgICAgICBGQUlMICAgICAgMTI3LjM1IHNlY29uZHMKCkRl
dGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0Y2ggLSBG
QUlMCkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdCB3aXRoIHJ1bGUgaW4gLmNoZWNrcGF0
Y2guY29uZgpPdXRwdXQ6Clt2MiwxLzldIGFkYXB0ZXI6IEVuYWJsZSBNU0ZUIGEyZHAgb2ZmbG9h
ZCBjb2RlYyB3aGVuIEV4cGVyaW1lbnRhbCBpcyBzZXQKV0FSTklORzpMT05HX0xJTkVfU1RSSU5H
OiBsaW5lIGxlbmd0aCBvZiA4MyBleGNlZWRzIDgwIGNvbHVtbnMKIzg5OiBGSUxFOiBzcmMvYWRh
cHRlci5jOjk4MDY6CisJCWVycm9yKCJTZXQgTVNGVCBhMmRwIG9mZmxvYWQgY29kZWMgZmFpbGVk
IHdpdGggc3RhdHVzIDB4JTAyeCAoJXMpIiwKCi9naXRodWIvd29ya3NwYWNlL3NyYy8xMjYyODU1
MS5wYXRjaCB0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDc1IGxpbmVzIGNoZWNrZWQKCk5P
VEU6IEZvciBzb21lIG9mIHRoZSByZXBvcnRlZCBkZWZlY3RzLCBjaGVja3BhdGNoIG1heSBiZSBh
YmxlIHRvCiAgICAgIG1lY2hhbmljYWxseSBjb252ZXJ0IHRvIHRoZSB0eXBpY2FsIHN0eWxlIHVz
aW5nIC0tZml4IG9yIC0tZml4LWlucGxhY2UuCgovZ2l0aHViL3dvcmtzcGFjZS9zcmMvMTI2Mjg1
NTEucGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LgoKTk9URTogSWdub3Jl
ZCBtZXNzYWdlIHR5cGVzOiBDT01NSVRfTUVTU0FHRSBDT01QTEVYX01BQ1JPIENPTlNUX1NUUlVD
VCBGSUxFX1BBVEhfQ0hBTkdFUyBNSVNTSU5HX1NJR05fT0ZGIFBSRUZFUl9QQUNLRUQgU1BEWF9M
SUNFTlNFX1RBRyBTUExJVF9TVFJJTkcgU1NDQU5GX1RPX0tTVFJUTwoKTk9URTogSWYgYW55IG9m
IHRoZSBlcnJvcnMgYXJlIGZhbHNlIHBvc2l0aXZlcywgcGxlYXNlIHJlcG9ydAogICAgICB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUgQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KClt2Miw2
LzldIGF2ZHRwOiBBZGQgc3VwcG9ydCBmb3Igb2ZmbG9hZCBNU0ZUIG9wZW4gY29tbWFuZApXQVJO
SU5HOlBSRUZFUl9ERUZJTkVEX0FUVFJJQlVURV9NQUNSTzogUHJlZmVyIF9fcGFja2VkIG92ZXIg
X19hdHRyaWJ1dGVfXygocGFja2VkKSkKIzcyOiBGSUxFOiBsaWIvYmx1ZXRvb3RoLmg6MTY2Ogor
fSBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKTsKCi9naXRodWIvd29ya3NwYWNlL3NyYy8xMjYyODU2
MS5wYXRjaCB0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDcxIGxpbmVzIGNoZWNrZWQKCk5P
VEU6IEZvciBzb21lIG9mIHRoZSByZXBvcnRlZCBkZWZlY3RzLCBjaGVja3BhdGNoIG1heSBiZSBh
YmxlIHRvCiAgICAgIG1lY2hhbmljYWxseSBjb252ZXJ0IHRvIHRoZSB0eXBpY2FsIHN0eWxlIHVz
aW5nIC0tZml4IG9yIC0tZml4LWlucGxhY2UuCgovZ2l0aHViL3dvcmtzcGFjZS9zcmMvMTI2Mjg1
NjEucGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LgoKTk9URTogSWdub3Jl
ZCBtZXNzYWdlIHR5cGVzOiBDT01NSVRfTUVTU0FHRSBDT01QTEVYX01BQ1JPIENPTlNUX1NUUlVD
VCBGSUxFX1BBVEhfQ0hBTkdFUyBNSVNTSU5HX1NJR05fT0ZGIFBSRUZFUl9QQUNLRUQgU1BEWF9M
SUNFTlNFX1RBRyBTUExJVF9TVFJJTkcgU1NDQU5GX1RPX0tTVFJUTwoKTk9URTogSWYgYW55IG9m
IHRoZSBlcnJvcnMgYXJlIGZhbHNlIHBvc2l0aXZlcywgcGxlYXNlIHJlcG9ydAogICAgICB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUgQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0gRkFJTApEZXNj
OiBCdWlsZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0Ogpwcm9maWxlcy9hdWRpby9hdmR0
cC5jOiBJbiBmdW5jdGlvbiDigJhhdmR0cF9uZXfigJk6CnByb2ZpbGVzL2F1ZGlvL2F2ZHRwLmM6
MjQ3Nzo4OiBlcnJvcjogdW51c2VkIHZhcmlhYmxlIOKAmHVzZV9vZmZsb2Fk4oCZIFstV2Vycm9y
PXVudXNlZC12YXJpYWJsZV0KIDI0NzcgfCAgY2hhciAqdXNlX29mZmxvYWQ7CiAgICAgIHwgICAg
ICAgIF5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3Jz
Cm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6ODY0MDogcHJvZmlsZXMvYXVkaW8vYmx1ZXRvb3RoZC1h
dmR0cC5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDE3NTogYWxsXSBFcnJvciAyCgoK
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2UgQ2hlY2sgLSBGQUlMCkRl
c2M6IFJ1biAnbWFrZSBjaGVjaycKT3V0cHV0Ogpwcm9maWxlcy9hdWRpby9hdmR0cC5jOiBJbiBm
dW5jdGlvbiDigJhhdmR0cF9uZXfigJk6CnByb2ZpbGVzL2F1ZGlvL2F2ZHRwLmM6MjQ3Nzo4OiBl
cnJvcjogdW51c2VkIHZhcmlhYmxlIOKAmHVzZV9vZmZsb2Fk4oCZIFstV2Vycm9yPXVudXNlZC12
YXJpYWJsZV0KIDI0NzcgfCAgY2hhciAqdXNlX29mZmxvYWQ7CiAgICAgIHwgICAgICAgIF5+fn5+
fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06
ICoqKiBbTWFrZWZpbGU6ODY0MDogcHJvZmlsZXMvYXVkaW8vYmx1ZXRvb3RoZC1hdmR0cC5vXSBF
cnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA1MDE6IGNoZWNrXSBFcnJvciAyCgoKIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIHcvZXh0IEVMTCAtIE1ha2UgLSBG
QUlMCkRlc2M6IEJ1aWxkIEJsdWVaIHNvdXJjZSB3aXRoICctLWVuYWJsZS1leHRlcm5hbC1lbGwn
IGNvbmZpZ3VyYXRpb24KT3V0cHV0Ogpwcm9maWxlcy9hdWRpby9hdmR0cC5jOiBJbiBmdW5jdGlv
biDigJhhdmR0cF9uZXfigJk6CnByb2ZpbGVzL2F1ZGlvL2F2ZHRwLmM6MjQ3Nzo4OiBlcnJvcjog
dW51c2VkIHZhcmlhYmxlIOKAmHVzZV9vZmZsb2Fk4oCZIFstV2Vycm9yPXVudXNlZC12YXJpYWJs
ZV0KIDI0NzcgfCAgY2hhciAqdXNlX29mZmxvYWQ7CiAgICAgIHwgICAgICAgIF5+fn5+fn5+fn5+
CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBb
TWFrZWZpbGU6ODY0MDogcHJvZmlsZXMvYXVkaW8vYmx1ZXRvb3RoZC1hdmR0cC5vXSBFcnJvciAx
Cm1ha2U6ICoqKiBbTWFrZWZpbGU6NDE3NTogYWxsXSBFcnJvciAyCgoKCgotLS0KUmVnYXJkcywK
TGludXggQmx1ZXRvb3RoCgo=

--===============5731389825600000469==--
