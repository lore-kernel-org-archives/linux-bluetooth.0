Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D030C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 18:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75111604AC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 18:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhHQSo4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 14:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhHQSoz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 14:44:55 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F49C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 11:44:22 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t66so24293447qkb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3xLXTWKQfq4zGjTYp7P147Ii/1OAva1agR1nUnIl29s=;
        b=FiXccGkeeuaA8xG58xYkNcSaxjEXM/Q+YPTuwb/ky4yo9dt/WkBnaCM3gt4PsjW8sF
         VMCPTVtq1cNlTlL3cWB3QeuMqIc2V6oDTqseEZ5kxMftOcxfhwoAS5OPLtaf9ozz9Nkk
         qXg+wC01ojpxU90dJ9uuIofIUtKJDGkfa6TldtlaeUXAcWYFPNKE1Bj1bSuT+qkvJ3+T
         o16RIjVcSPXk0Uawiav7moIYNgs6PFifZI/rpsZwUPvGAOlR9HrWvZqK9IpZV/J1RbNg
         rapvUoO+S6oAbP6rKys1G+yU2h+Gp9Cwbgl7/HUE3E8z0sdfiui6zrloQ9sTNvGxwyoR
         W4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3xLXTWKQfq4zGjTYp7P147Ii/1OAva1agR1nUnIl29s=;
        b=L5SW2KeM0+TbrsGarNNN9vFLEOBEXYiKowteDSBYSGCYsz697WDUmHtdjJEQLQY5yL
         t3lF/dGr/A3bh3QL1Qbs3Zbw+Nr/A7mMn+4adsvPOATcNTybSPK42KH0IuJhe57Q9y7I
         cTjOcd3AE42oPxQ4yjTxDDVZAWH35aIPKm8oYV0jJ9oDbb0cw9vAkv2piODDRxmmw9cs
         1V72JvmPe0NtdokWL+mnRCOyXQDbhbjsh8J75MET/0TAmI6p2NTYL7BaLmHwqe8LS0rP
         ikGyX/5Rp903XFG2sKRTBHm2GDNEqPCmn4KYDT29atn2BPFmvmTAeljf65eVA1DgZlhK
         HY8w==
X-Gm-Message-State: AOAM531rgfOP+kG5rlv0LYxK4Fj08Y+hjeKhASeS78nfbKOl5P4iBe3E
        8BSrPY/COfcflpSZ7dhsmBdtUQxBaaMprg==
X-Google-Smtp-Source: ABdhPJzQ345farJJQ0fseEUdO+0a/E7APf3X8FBJxU5/BRtI38bRdTRQynQh9tQiVGmmoseu81SLxw==
X-Received: by 2002:a37:2f85:: with SMTP id v127mr5328109qkh.474.1629225861010;
        Tue, 17 Aug 2021 11:44:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.43.222])
        by smtp.gmail.com with ESMTPSA id x13sm1908377qki.97.2021.08.17.11.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:44:20 -0700 (PDT)
Message-ID: <611c0384.1c69fb81.304c1.d56d@mx.google.com>
Date:   Tue, 17 Aug 2021 11:44:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3757071256596511355=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bernie@allthenticate.net
Subject: RE: method to notify/indicate to one device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210817181300.24479-2-bernie@allthenticate.net>
References: <20210817181300.24479-2-bernie@allthenticate.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3757071256596511355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTMyODkzCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC41NyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjE0IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDU3LjUwIHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTcgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgMTAu
MTMgc2Vjb25kcwpCdWlsZCAtIE1ha2UgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjA5LjA0
IHNlY29uZHMKTWFrZSBDaGVjayAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDAuNzEgc2Vj
b25kcwpNYWtlIERpc3RjaGVjayAgICAgICAgICAgICAgICBGQUlMICAgICAgMTk1Ljk0IHNlY29u
ZHMKQnVpbGQgdy9leHQgRUxMIC0gQ29uZmlndXJlICAgUEFTUyAgICAgIDkuODEgc2Vjb25kcwpC
dWlsZCB3L2V4dCBFTEwgLSBNYWtlICAgICAgICBGQUlMICAgICAgMTkyLjc0IHNlY29uZHMKCkRl
dGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0Y2ggLSBQ
QVNTCkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdCB3aXRoIHJ1bGUgaW4gLmNoZWNrcGF0
Y2guY29uZgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBQ
QVNTCkRlc2M6IFJ1biBnaXRsaW50IHdpdGggcnVsZSBpbiAuZ2l0bGludAoKIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFByZXAgLSBTZXR1cCBFTEwgLSBQQVNTCkRlc2M6IENs
b25lLCBidWlsZCwgYW5kIGluc3RhbGwgRUxMCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMKVGVzdDogQnVpbGQgLSBQcmVwIC0gUEFTUwpEZXNjOiBQcmVwYXJlIGVudmlyb25tZW50IGZv
ciBidWlsZAoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIC0gQ29u
ZmlndXJlIC0gUEFTUwpEZXNjOiBDb25maWd1cmUgdGhlIEJsdWVaIHNvdXJjZSB0cmVlCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0gRkFJTApEZXNj
OiBCdWlsZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0OgpzcmMvZ2F0dC1kYXRhYmFzZS5j
OiBJbiBmdW5jdGlvbiDigJhub3RpZnlfY2hhcmFjdGVyaXN0aWNfY2hhbmdlZOKAmToKc3JjL2dh
dHQtZGF0YWJhc2UuYzozNjQyOjEwOiBlcnJvcjog4oCYYnRkX2Vycm9yX2lu4oCZIHVuZGVjbGFy
ZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuIOKAmGJ0ZF9lcnJv
cuKAmT8KIDM2NDIgfCAgIHJldHVybiBidGRfZXJyb3JfaW4gdmFsaWRfYXJncyhtc2cpOwogICAg
ICB8ICAgICAgICAgIF5+fn5+fn5+fn5+fgogICAgICB8ICAgICAgICAgIGJ0ZF9lcnJvcgpzcmMv
Z2F0dC1kYXRhYmFzZS5jOjM2NDI6MTA6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVy
IGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCnNy
Yy9nYXR0LWRhdGFiYXNlLmM6MzY0MjoyMjogZXJyb3I6IGV4cGVjdGVkIOKAmDvigJkgYmVmb3Jl
IOKAmHZhbGlkX2FyZ3PigJkKIDM2NDIgfCAgIHJldHVybiBidGRfZXJyb3JfaW4gdmFsaWRfYXJn
cyhtc2cpOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+CiAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgOwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjkyMDU6IHNyYy9i
bHVldG9vdGhkLWdhdHQtZGF0YWJhc2Uub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQx
NDc6IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBN
YWtlIENoZWNrIC0gRkFJTApEZXNjOiBSdW4gJ21ha2UgY2hlY2snCk91dHB1dDoKc3JjL2dhdHQt
ZGF0YWJhc2UuYzogSW4gZnVuY3Rpb24g4oCYbm90aWZ5X2NoYXJhY3RlcmlzdGljX2NoYW5nZWTi
gJk6CnNyYy9nYXR0LWRhdGFiYXNlLmM6MzY0MjoxMDogZXJyb3I6IOKAmGJ0ZF9lcnJvcl9pbuKA
mSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiDi
gJhidGRfZXJyb3LigJk/CiAzNjQyIHwgICByZXR1cm4gYnRkX2Vycm9yX2luIHZhbGlkX2FyZ3Mo
bXNnKTsKICAgICAgfCAgICAgICAgICBefn5+fn5+fn5+fn4KICAgICAgfCAgICAgICAgICBidGRf
ZXJyb3IKc3JjL2dhdHQtZGF0YWJhc2UuYzozNjQyOjEwOiBub3RlOiBlYWNoIHVuZGVjbGFyZWQg
aWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBw
ZWFycyBpbgpzcmMvZ2F0dC1kYXRhYmFzZS5jOjM2NDI6MjI6IGVycm9yOiBleHBlY3RlZCDigJg7
4oCZIGJlZm9yZSDigJh2YWxpZF9hcmdz4oCZCiAzNjQyIHwgICByZXR1cm4gYnRkX2Vycm9yX2lu
IHZhbGlkX2FyZ3MobXNnKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+
fgogICAgICB8ICAgICAgICAgICAgICAgICAgICAgIDsKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo5
MjA1OiBzcmMvYmx1ZXRvb3RoZC1nYXR0LWRhdGFiYXNlLm9dIEVycm9yIDEKbWFrZTogKioqIFtN
YWtlZmlsZToxMDQzNjogY2hlY2tdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMKVGVzdDogTWFrZSBEaXN0Y2hlY2sgLSBGQUlMCkRlc2M6IFJ1biBkaXN0Y2hlY2sgdG8g
Y2hlY2sgdGhlIGRpc3RyaWJ1dGlvbgpPdXRwdXQ6Ci4uLy4uL3NyYy9nYXR0LWRhdGFiYXNlLmM6
IEluIGZ1bmN0aW9uIOKAmG5vdGlmeV9jaGFyYWN0ZXJpc3RpY19jaGFuZ2Vk4oCZOgouLi8uLi9z
cmMvZ2F0dC1kYXRhYmFzZS5jOjM2NDI6MTA6IGVycm9yOiDigJhidGRfZXJyb3JfaW7igJkgdW5k
ZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g4oCYYnRk
X2Vycm9y4oCZPwogMzY0MiB8ICAgcmV0dXJuIGJ0ZF9lcnJvcl9pbiB2YWxpZF9hcmdzKG1zZyk7
CiAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+CiAgICAgIHwgICAgICAgICAgYnRkX2Vycm9y
Ci4uLy4uL3NyYy9nYXR0LWRhdGFiYXNlLmM6MzY0MjoxMDogbm90ZTogZWFjaCB1bmRlY2xhcmVk
IGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFw
cGVhcnMgaW4KLi4vLi4vc3JjL2dhdHQtZGF0YWJhc2UuYzozNjQyOjIyOiBlcnJvcjogZXhwZWN0
ZWQg4oCYO+KAmSBiZWZvcmUg4oCYdmFsaWRfYXJnc+KAmQogMzY0MiB8ICAgcmV0dXJuIGJ0ZF9l
cnJvcl9pbiB2YWxpZF9hcmdzKG1zZyk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgXn5+
fn5+fn5+fn4KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICA7Cm1ha2VbMl06ICoqKiBbTWFr
ZWZpbGU6OTIwNTogc3JjL2JsdWV0b290aGQtZ2F0dC1kYXRhYmFzZS5vXSBFcnJvciAxCm1ha2Vb
MV06ICoqKiBbTWFrZWZpbGU6NDE0NzogYWxsXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6
MTAzNTc6IGRpc3RjaGVja10gRXJyb3IgMQoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwpUZXN0OiBCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgLSBQQVNTCkRlc2M6IENvbmZpZ3Vy
ZSBCbHVlWiBzb3VyY2Ugd2l0aCAnLS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9u
CgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgdy9leHQgRUxMIC0g
TWFrZSAtIEZBSUwKRGVzYzogQnVpbGQgQmx1ZVogc291cmNlIHdpdGggJy0tZW5hYmxlLWV4dGVy
bmFsLWVsbCcgY29uZmlndXJhdGlvbgpPdXRwdXQ6CnNyYy9nYXR0LWRhdGFiYXNlLmM6IEluIGZ1
bmN0aW9uIOKAmG5vdGlmeV9jaGFyYWN0ZXJpc3RpY19jaGFuZ2Vk4oCZOgpzcmMvZ2F0dC1kYXRh
YmFzZS5jOjM2NDI6MTA6IGVycm9yOiDigJhidGRfZXJyb3JfaW7igJkgdW5kZWNsYXJlZCAoZmly
c3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g4oCYYnRkX2Vycm9y4oCZPwog
MzY0MiB8ICAgcmV0dXJuIGJ0ZF9lcnJvcl9pbiB2YWxpZF9hcmdzKG1zZyk7CiAgICAgIHwgICAg
ICAgICAgXn5+fn5+fn5+fn5+CiAgICAgIHwgICAgICAgICAgYnRkX2Vycm9yCnNyYy9nYXR0LWRh
dGFiYXNlLmM6MzY0MjoxMDogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVw
b3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4Kc3JjL2dhdHQt
ZGF0YWJhc2UuYzozNjQyOjIyOiBlcnJvcjogZXhwZWN0ZWQg4oCYO+KAmSBiZWZvcmUg4oCYdmFs
aWRfYXJnc+KAmQogMzY0MiB8ICAgcmV0dXJuIGJ0ZF9lcnJvcl9pbiB2YWxpZF9hcmdzKG1zZyk7
CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn4KICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICA7Cm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6OTIwNTogc3JjL2JsdWV0b290
aGQtZ2F0dC1kYXRhYmFzZS5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDE0NzogYWxs
XSBFcnJvciAyCgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============3757071256596511355==--
