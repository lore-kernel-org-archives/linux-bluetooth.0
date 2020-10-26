Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52DAC4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 12:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FC4238E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 12:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9lLpCla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775341AbgJZMi3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 08:38:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42184 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775336AbgJZMi2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 08:38:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id b18so4361580qkc.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Dcu5fNfjiHkOCj4GijtpXFyinpeuVDOMTDu9vE7tJmE=;
        b=A9lLpClaadgi5KU6otCxAEi74+k96goW88dfSejsgf2kpb4akvujT3hfT4sTVdiDoo
         Kd+keKM75gikq26XL7jEKkPjsz2TFO+TMv4modcyD43+duYW8E2HmEbKk3ppbvl4nSV6
         Na7eTGqgXlTOMZa2NQqOEBTuvIRVqFlc9COqqWwKpQuuvE68k+KpdI2ugMpT/7MHxaJh
         AXNaK2qBKb/cLONZxPbK3UOAHr4qKCfklwJDd0xHJHLQk1FTMuWfV04WYnld9k/IZeFS
         kCOdtFWEuSRW/402Y3PkuP1YALZTxp60OLhHbc3jZ7tDVWl/yx1T0IN9kA+MwNDdqG6n
         YnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Dcu5fNfjiHkOCj4GijtpXFyinpeuVDOMTDu9vE7tJmE=;
        b=oQUlDGYXOv85Zsvv2YKxkxRZPBCMeaRs52aIUg+t2F4VBLzKEMA7pYU2nK+5ezf/Zr
         B/V7omlZ56zBLPh2OgOronHLvEafQSulq9Mno40zteqvdXdkV9OfHUDE+s2v34jm7nDe
         Il5Tr38GGBOyYToTpbdyOxEnl7fnVlEgHbRleUcg6eOF53D+rVgVHy102FX3oM7Lg5nO
         IWQIn8hCgTfkHKiF3Viu+tzHIXFwhvZudz8F57jEk/RdiTcZ5JJNFQJWCgmDGljnBnTl
         Roll/Pj0VBaZcHnmn6r6X1ctW/yb+dkffCZJEFWxBXJJqtYIWLxoMO5uYbqQmD1s1+CZ
         dbjA==
X-Gm-Message-State: AOAM53158n43B1GAp2mpI6I9D/ivrswt5lF5FrU5jMVHKnGttFksxOcy
        M07QwSLJ9/anpJnfVO4povmzTSNJbq4=
X-Google-Smtp-Source: ABdhPJwo6A4StRPskWiQKfZtPJOn+DbJd/sKJGZIDszxtJkRfU5LGNm6tj7jDpL1byNrR9r3eIoypw==
X-Received: by 2002:a37:4984:: with SMTP id w126mr16055682qka.104.1603715906186;
        Mon, 26 Oct 2020 05:38:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.58.108])
        by smtp.gmail.com with ESMTPSA id 61sm6531004qta.19.2020.10.26.05.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:38:25 -0700 (PDT)
Message-ID: <5f96c341.1c69fb81.64fb7.4b12@mx.google.com>
Date:   Mon, 26 Oct 2020 05:38:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2919078085955738868=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [BlueZ,v4] core: Add support of variable length params in mgmt_config
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201026194757.BlueZ.v4.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
References: <20201026194757.BlueZ.v4.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2919078085955738868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MzcwMzc1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBGQUlMCk91dHB1dDoKY29yZTogQWRkIHN1cHBvcnQgb2YgdmFyaWFibGUgbGVuZ3Ro
IHBhcmFtcyBpbiBtZ210X2NvbmZpZwpXQVJOSU5HOkxPTkdfTElORTogbGluZSBvdmVyIDgwIGNo
YXJhY3RlcnMKIzEzODogRklMRTogc3JjL2FkYXB0ZXIuYzo0MjM2OgorCQkJc2l6ZW9mKG1haW5f
b3B0cy5kZWZhdWx0X3BhcmFtcy5icl9saW5rX3N1cGVydmlzaW9uX3RpbWVvdXQpLAoKV0FSTklO
RzpMT05HX0xJTkU6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyMTE6IEZJTEU6IHNyYy9hZGFw
dGVyLmM6NDI3ODoKKwkJCXNpemVvZihtYWluX29wdHMuZGVmYXVsdF9wYXJhbXMubGVfbXVsdGlf
YWR2X3JvdGF0aW9uX2ludGVydmFsKSwKCldBUk5JTkc6TE9OR19MSU5FOiBsaW5lIG92ZXIgODAg
Y2hhcmFjdGVycwojMjEyOiBGSUxFOiBzcmMvYWRhcHRlci5jOjQyNzk6CisJCQkmbWFpbl9vcHRz
LmRlZmF1bHRfcGFyYW1zLmxlX211bHRpX2Fkdl9yb3RhdGlvbl9pbnRlcnZhbCk7CgpXQVJOSU5H
OkxPTkdfTElORTogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzIyNDogRklMRTogc3JjL2FkYXB0
ZXIuYzo0Mjg1OgorCQkJc2l6ZW9mKG1haW5fb3B0cy5kZWZhdWx0X3BhcmFtcy5sZV9zY2FuX2lu
dGVydmFsX2F1dG9jb25uZWN0KSwKCldBUk5JTkc6TE9OR19MSU5FOiBsaW5lIG92ZXIgODAgY2hh
cmFjdGVycwojMjM3OiBGSUxFOiBzcmMvYWRhcHRlci5jOjQyOTI6CisJCQlzaXplb2YobWFpbl9v
cHRzLmRlZmF1bHRfcGFyYW1zLmxlX3NjYW5fd2luX2F1dG9jb25uZWN0KSwKCldBUk5JTkc6TE9O
R19MSU5FOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMjUwOiBGSUxFOiBzcmMvYWRhcHRlci5j
OjQyOTk6CisJCQlzaXplb2YobWFpbl9vcHRzLmRlZmF1bHRfcGFyYW1zLmxlX3NjYW5faW50ZXJ2
YWxfc3VzcGVuZCksCgpXQVJOSU5HOkxPTkdfTElORTogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMK
IzI3NTogRklMRTogc3JjL2FkYXB0ZXIuYzo0MzEzOgorCQkJc2l6ZW9mKG1haW5fb3B0cy5kZWZh
dWx0X3BhcmFtcy5sZV9zY2FuX2ludGVydmFsX2Rpc2NvdmVyeSksCgpXQVJOSU5HOkxPTkdfTElO
RTogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzMwMTogRklMRTogc3JjL2FkYXB0ZXIuYzo0MzI3
OgorCQkJc2l6ZW9mKG1haW5fb3B0cy5kZWZhdWx0X3BhcmFtcy5sZV9zY2FuX2ludGVydmFsX2Fk
dl9tb25pdG9yKSwKCldBUk5JTkc6TE9OR19MSU5FOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwoj
MzE0OiBGSUxFOiBzcmMvYWRhcHRlci5jOjQzMzQ6CisJCQlzaXplb2YobWFpbl9vcHRzLmRlZmF1
bHRfcGFyYW1zLmxlX3NjYW5fd2luX2Fkdl9tb25pdG9yKSwKCldBUk5JTkc6TE9OR19MSU5FOiBs
aW5lIG92ZXIgODAgY2hhcmFjdGVycwojMzI3OiBGSUxFOiBzcmMvYWRhcHRlci5jOjQzNDE6CisJ
CQlzaXplb2YobWFpbl9vcHRzLmRlZmF1bHRfcGFyYW1zLmxlX3NjYW5faW50ZXJ2YWxfY29ubmVj
dCksCgpXQVJOSU5HOkxPTkdfTElORTogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzQ5NTogRklM
RTogc3JjL21haW4uYzozNzU6CisJCSAgc2l6ZW9mKG1haW5fb3B0cy5kZWZhdWx0X3BhcmFtcy5s
ZV9tdWx0aV9hZHZfcm90YXRpb25faW50ZXJ2YWwpLAoKLSB0b3RhbDogMCBlcnJvcnMsIDExIHdh
cm5pbmdzLCA2MjEgbGluZXMgY2hlY2tlZAoKTk9URTogRm9yIHNvbWUgb2YgdGhlIHJlcG9ydGVk
IGRlZmVjdHMsIGNoZWNrcGF0Y2ggbWF5IGJlIGFibGUgdG8KICAgICAgbWVjaGFuaWNhbGx5IGNv
bnZlcnQgdG8gdGhlIHR5cGljYWwgc3R5bGUgdXNpbmcgLS1maXggb3IgLS1maXgtaW5wbGFjZS4K
CllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LgoKTk9URTogSWdu
b3JlZCBtZXNzYWdlIHR5cGVzOiBDT01NSVRfTUVTU0FHRSBDT01QTEVYX01BQ1JPIENPTlNUX1NU
UlVDVCBGSUxFX1BBVEhfQ0hBTkdFUyBNSVNTSU5HX1NJR05fT0ZGIFBSRUZFUl9QQUNLRUQgU1BM
SVRfU1RSSU5HIFNTQ0FORl9UT19LU1RSVE8KCk5PVEU6IElmIGFueSBvZiB0aGUgZXJyb3JzIGFy
ZSBmYWxzZSBwb3NpdGl2ZXMsIHBsZWFzZSByZXBvcnQKICAgICAgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlIENIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoKIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrR2l0TGludCAtIFBBU1MKCiMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja0J1aWxkIC0gRkFJTApPdXRwdXQ6CmFyOiBgdScgbW9k
aWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1bHQgKHNlZSBgVScpCnNyYy9zaGFy
ZWQvbWdtdC5jOiBJbiBmdW5jdGlvbiDigJhtZ210X3NlbmR24oCZOgpzcmMvc2hhcmVkL21nbXQu
Yzo1ODk6MzQ6IGVycm9yOiBjb21wYXJpc29uIG9mIGludGVnZXIgZXhwcmVzc2lvbnMgb2YgZGlm
ZmVyZW50IHNpZ25lZG5lc3M6IOKAmHNpemVfdOKAmSB7YWthIOKAmGxvbmcgdW5zaWduZWQgaW50
4oCZfSBhbmQg4oCYc3NpemVfdOKAmSB7YWthIOKAmGxvbmcgaW504oCZfSBbLVdlcnJvcj1zaWdu
LWNvbXBhcmVdCiAgNTg5IHwgIGlmIChmcmVhZChidWYsIDEsIGJ1Zl9sZW4sIHB0cikgPCBidWZf
bGVuKQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwg
d2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo2
ODAyOiBzcmMvc2hhcmVkL21nbXQubG9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MDIw
OiBhbGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFr
ZUNoZWNrIC0gU0tJUFBFRApPdXRwdXQ6CmNoZWNrYnVpbGQgbm90IHN1Y2Nlc3MKCgoKLS0tClJl
Z2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============2919078085955738868==--
