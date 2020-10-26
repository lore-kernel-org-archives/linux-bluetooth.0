Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF59C4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 10:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189D520770
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 10:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7WeL0wE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770029AbgJZKe4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 06:34:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40644 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769885AbgJZKdu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 06:33:50 -0400
Received: by mail-io1-f68.google.com with SMTP id r9so9417370ioo.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=WjAlJQrvXfkgFBL9Tu0r50MEGuJKFiclaym02WnKy7s=;
        b=Q7WeL0wEFAWA5p47BpC6VIrwgENt3kJGA77bYh5BhWa6tOGpS5W6EqitStZnEo7p9f
         5rrAAxYYjVOyOhAxRfogULPbCORZRcr2As+02OZIMNjyFTE6RUtSrvsKcb2rFRcABmPD
         5mNMMFXql/MRsiCEOqAn5FwdTzNuEpLQ4rnHgSnCl7Ps+q0dChTQ30kW6GjMce1FoTkz
         oshcqvPZIRXXI7soYmOs6/CFIi9N3JKQtpMKMUW64jhHWUs5cLs7KU0Z9VGXh7K5sW4s
         eVBu3w374h1Y2T0K88OXc20OQyw1bUBTLMV4HbK1Ff/9SeNgZzAQK7gGlp3PHqoThmMG
         mEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=WjAlJQrvXfkgFBL9Tu0r50MEGuJKFiclaym02WnKy7s=;
        b=dRqJzOxhnqMv6LIedmo5TuUwHxJJIWL9vfBUZHSI7+k79v1Vy2LVE0ZEmDC9PHD8fn
         0jr2OwJ4uMQyrDxVIIFgaWh1agbbVY+srkAo1gGl8S+XFM4LXSglgb9Baz/VJ+hbGrxW
         7GfUis5ZKO7N7OceGaHRiteL1dLT+9PVU8eO96c6qEQpOHvnDwVqFxsLvfk/QBI0HJRT
         LQKsFFIdMkjmnl0RZffhzE6j9jz/6rAGQcaz2uqFzcsUHyUq63fOo71jCahUFquuCTOe
         93NMx5o3+GbRNZAW4mH68XMrsT/p8Y+wbC9ygc0IpyBG7llVOXM5m2H49rn7g8SBeiUI
         IHoA==
X-Gm-Message-State: AOAM531a4P6HdGwyY0U/qkSYN7rwuTortih+PCGaMo9tTrpdzGo6PoMu
        kSjs70F5xP1QV/8R/lbD+97ESvs4rayzog==
X-Google-Smtp-Source: ABdhPJyZLB5uuqr62uR16z/u+PJ/PVt9+vr+hl6kL8VZpyGTBXlQzBAxiunEjT3LDPvqlWu6h/wciw==
X-Received: by 2002:a05:6602:2f04:: with SMTP id q4mr9802515iow.75.1603708429121;
        Mon, 26 Oct 2020 03:33:49 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.112.178])
        by smtp.gmail.com with ESMTPSA id u15sm6204702iln.81.2020.10.26.03.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 03:33:48 -0700 (PDT)
Message-ID: <5f96a60c.1c69fb81.b442.18b0@mx.google.com>
Date:   Mon, 26 Oct 2020 03:33:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3786888055492316229=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [BlueZ,v3] core: Add support of variable length params in mgmt_config
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201026182010.BlueZ.v3.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
References: <20201026182010.BlueZ.v3.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3786888055492316229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MzcwMjc3CgotLS1U
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
Yzo1ODA6MTQ6IGVycm9yOiBjb21wYXJpc29uIGlzIGFsd2F5cyBmYWxzZSBkdWUgdG8gbGltaXRl
ZCByYW5nZSBvZiBkYXRhIHR5cGUgWy1XZXJyb3I9dHlwZS1saW1pdHNdCiAgNTgwIHwgIGlmIChi
dWZfbGVuIDwgMCkKICAgICAgfCAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWlu
ZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY4MDI6IHNyYy9zaGFy
ZWQvbWdtdC5sb10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQwMjA6IGFsbF0gRXJyb3Ig
MgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlQ2hlY2sgLSBTS0lQ
UEVECk91dHB1dDoKY2hlY2tidWlsZCBub3Qgc3VjY2VzcwoKCgotLS0KUmVnYXJkcywKTGludXgg
Qmx1ZXRvb3RoCgo=

--===============3786888055492316229==--
