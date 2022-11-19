Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EA9C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 05:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKSFEX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 00:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiKSFES (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 00:04:18 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DEEA44E
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:04:15 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id v81so7526372oie.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SWZdUK//UerUkVc6to90fXvsNGiQJ884vxnkmoKVn5E=;
        b=CeYKWthiseW8/fBfmu50kpcRuZLXHXijQjN880Xgw7BqYbkc2flhVWcgQaqD5Uodvc
         IVVmn40l2MDQrOBkRguQawrjct2BWp09Rf4R3UsPbYs8plhcfroIONanAzfgw+J6BN+x
         8vgalpQ1GG2KJBU06PPtWKBOl0AaqsHoEDa9KQo36ndV1TwXT2hGzHUA3XSGBDU2WIvE
         MWExjxziP2tH0qoKb9QTuSFM9W1SfKKQDGJnqoGE9W6cqLmffxzNpfvo8Ey/J71+brJG
         aBAdiWCJNZHNyTAvSRGrDZlRRaAsW3LeKPskNIzqysbO5kmjFKS47rMWjFVP51U+Gcl+
         JNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWZdUK//UerUkVc6to90fXvsNGiQJ884vxnkmoKVn5E=;
        b=6imupC8o7RqkC8bw4JK9noSAN7EO4SqzNjjWekqBj8OIu+YamUrulntdXkJXvkzGFG
         13LFeTJu4NtXWFPyS7tm+cgZOBjKTWxouqBh6DrYUVQtKCnszc9CIKsgaoIUToqlNELM
         Sny7Hltm+sAGCkQdQNXDwMzc0Awcb52nyIjHiQ8bPRvC4XNLONYrt8JT4szUs5M80KEB
         M208cFAzh4FRPIhrZXWj5zYMxtq3riL6PISsZrxfR2PgLwOUSZy6au7UKZSQfap01HvE
         h/CN8CsLoVIPpPJj4jIdEUZlFg+u124gbt+xOohSkTtdZkoEzjy4PPwpnewZJKxzvo9h
         G21w==
X-Gm-Message-State: ANoB5pmBoHQuy10SsxznJF1zPFQIT+S2PIy82TiYDifttJyBtjBwVwS3
        VRvU/W4jCxTCClLBC28zMRi1y9M968tVYQ==
X-Google-Smtp-Source: AA0mqf7wHEzDzVBibqkK6vjfXm9qMNjXtsHoQqvp6szJwka6Rq44HEMfllUawM1O4bIjAISYHmRjnA==
X-Received: by 2002:a05:6808:b1a:b0:35a:d50:35e3 with SMTP id s26-20020a0568080b1a00b0035a0d5035e3mr7462905oij.52.1668834254226;
        Fri, 18 Nov 2022 21:04:14 -0800 (PST)
Received: from [172.17.0.2] ([104.214.104.68])
        by smtp.gmail.com with ESMTPSA id a4-20020a0568300b8400b0066ca7af5745sm2366008otv.26.2022.11.18.21.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:04:14 -0800 (PST)
Message-ID: <637863ce.050a0220.ee231.a79e@mx.google.com>
Date:   Fri, 18 Nov 2022 21:04:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5962872878868386540=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rostedt@goodmis.org
Subject: RE: timers: Use timer_shutdown*() before freeing timers
In-Reply-To: <20221104054913.358784408@goodmis.org>
References: <20221104054913.358784408@goodmis.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5962872878868386540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkxOTQ0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS4wNiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjMyIHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTAgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MzAuNDUgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjYu
NDQgc2Vjb25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNDk4Ljk0
IHNlY29uZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDE3Ljg2IHNl
Y29uZHMKVGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE4LjE4IHNlY29u
ZHMKVGVzdFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDYuNDcgc2Vjb25kcwpU
ZXN0UnVubmVyX21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTIwLjcyIHNlY29uZHMKVGVz
dFJ1bm5lcl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDEwLjg5IHNlY29uZHMKVGVzdFJ1
bm5lcl9zY28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDkuOTUgc2Vjb25kcwpUZXN0UnVubmVy
X2lvY3RsLXRlc3RlciAgICAgICBQQVNTICAgICAgMTEuNjggc2Vjb25kcwpUZXN0UnVubmVyX21l
c2gtdGVzdGVyICAgICAgICBQQVNTICAgICAgOC4yMiBzZWNvbmRzClRlc3RSdW5uZXJfc21wLXRl
c3RlciAgICAgICAgIFBBU1MgICAgICA5LjkzIHNlY29uZHMKVGVzdFJ1bm5lcl91c2VyY2hhbi10
ZXN0ZXIgICAgUEFTUyAgICAgIDYuODkgc2Vjb25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAg
ICAgICBGQUlMICAgICAgMjguNTIgc2Vjb25kcwoKRGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKVGVzdDogQnVpbGRLZXJuZWwgLSBGQUlMCkRlc2M6IEJ1aWxkIEtlcm5lbCBm
b3IgQmx1ZXRvb3RoCk91dHB1dDoKCmRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY3NwLmM6IEluIGZ1
bmN0aW9uIOKAmGJjc3BfY2xvc2XigJk6CmRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY3NwLmM6NzQw
OjI6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJh0aW1lcl9zaHV0
ZG93bl9zeW5j4oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDc0
MCB8ICB0aW1lcl9zaHV0ZG93bl9zeW5jKCZiY3NwLT50YmNzcCk7CiAgICAgIHwgIF5+fn5+fn5+
fn5+fn5+fn5+fn4KY2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1h
a2VbMl06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyNDk6IGRyaXZlcnMvYmx1ZXRvb3Ro
L2hjaV9iY3NwLm9dIEVycm9yIDEKbWFrZVsyXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQg
am9icy4uLi4KbWFrZVsxXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ2NTogZHJpdmVy
cy9ibHVldG9vdGhdIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToxODUyOiBkcml2ZXJzXSBF
cnJvciAyCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZEtlcm5lbDMy
IC0gRkFJTApEZXNjOiBCdWlsZCAzMmJpdCBLZXJuZWwgZm9yIEJsdWV0b290aApPdXRwdXQ6Cgpk
cml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5jOiBJbiBmdW5jdGlvbiDigJhiY3NwX2Nsb3Nl4oCZ
Ogpkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5jOjc0MDoyOiBlcnJvcjogaW1wbGljaXQgZGVj
bGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYdGltZXJfc2h1dGRvd25fc3luY+KAmSBbLVdlcnJvcj1p
bXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICA3NDAgfCAgdGltZXJfc2h1dGRvd25fc3lu
YygmYmNzcC0+dGJjc3ApOwogICAgICB8ICBefn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogc29tZSB3
YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFr
ZWZpbGUuYnVpbGQ6MjQ5OiBkcml2ZXJzL2JsdWV0b290aC9oY2lfYmNzcC5vXSBFcnJvciAxCm1h
a2VbMl06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1ha2VbMV06ICoqKiBb
c2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0NjU6IGRyaXZlcnMvYmx1ZXRvb3RoXSBFcnJvciAyCm1h
a2U6ICoqKiBbTWFrZWZpbGU6MTg1MjogZHJpdmVyc10gRXJyb3IgMgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKVGVzdDogSW5jcmVtZW50YWxCdWlsZCAtIEZBSUwKRGVzYzogSW5jcmVt
ZW50YWwgYnVpbGQgd2l0aCB0aGUgcGF0Y2hlcyBpbiB0aGUgc2VyaWVzCk91dHB1dDoKW1JGQyx2
MywwOC8zM10gdGltZXJzOiBCbHVldG9vdGg6IFVzZSB0aW1lcl9zaHV0ZG93bl9zeW5jKCkgYmVm
b3JlIGZyZWVpbmcgdGltZXIKCmRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY3NwLmM6IEluIGZ1bmN0
aW9uIOKAmGJjc3BfY2xvc2XigJk6CmRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY3NwLmM6NzQwOjI6
IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJh0aW1lcl9zaHV0ZG93
bl9zeW5j4oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDc0MCB8
ICB0aW1lcl9zaHV0ZG93bl9zeW5jKCZiY3NwLT50YmNzcCk7CiAgICAgIHwgIF5+fn5+fn5+fn5+
fn5+fn5+fn4KY2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2Vb
Ml06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyNDk6IGRyaXZlcnMvYmx1ZXRvb3RoL2hj
aV9iY3NwLm9dIEVycm9yIDEKbWFrZVsyXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9i
cy4uLi4KbWFrZVsxXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ2NTogZHJpdmVycy9i
bHVldG9vdGhdIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToxODUyOiBkcml2ZXJzXSBFcnJv
ciAyCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============5962872878868386540==--
