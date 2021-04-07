Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C0C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 07:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35466139E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 07:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhDGHhw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Apr 2021 03:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244547AbhDGHht (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Apr 2021 03:37:49 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C432C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Apr 2021 00:37:39 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y12so13072059qtx.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Apr 2021 00:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ufTceTG0LjfcBaUtxdaiqJIsVgLI8JS521ikvlxCja4=;
        b=Tyjks/MDJhE7E5ZU662LFHhuHlpm2pdJmn/E/kxGW6TNKegmfz1EOg5lmS7tIoQ/FK
         kdcBtS8jU8dmbrQ1AsFRe8ghecpjumY4mRhwevykOQh8KUzlmJ6GSpB/fZbBefQnT4m9
         F5boQWlFrqFp1c03n75GcX3zTBlnKp8ewF9QXwoJ1HVW4E+M2dSS8gVXyu+bpk4PDxwx
         RlG1AlX63F7DTTdk+BS5epC7CKSsl5fUcIhQAr5UyQeXdfPuCaub2ucHJwZiGaThlCfr
         GbX3tRX9YVZU6NPsqyul8zW/tQY5CJCB4mc8LvdvYAmm+iEcVLB0lYHGuWk6iywUu/vK
         FCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ufTceTG0LjfcBaUtxdaiqJIsVgLI8JS521ikvlxCja4=;
        b=L+mYe/EAAbLziLEsBd7Zt1yyQWBvz8oEHevptVCZQUVMd1qmesZ+DBPmzx58w03tro
         +rkjzowKWK5qIYKdLSmnf6DXOIBMn4hRQgdrXM6diC8v/UulBZ8o2YrvAo0t1IeHngNq
         TI4ApIPNDbqtdWlGB0/hqhQWJKxbF/WPYkPmSXya79l8zTtkmQJZ6RFZsCicaJlr6e2e
         g4X3BsEQw+K8TVY5TnUgLe9W+5ommpVUZJXCpppmA20Ol3co5Z/l/Ef+zTlmgTuSeE8W
         hdMTbEaFq/CshjiQEamS6UQQYvgss7kfhQq5uvwm4OhNXLicoS5ywZQUkSd33wJZ2y7o
         jO8A==
X-Gm-Message-State: AOAM531amfWGccvrvIlzjmegBy9ZSd763Y+wYXrvyYkO5F0oM6SR5FTM
        B+6+U0YkjM87qugNeYnzPAi8bVG33KHY1A==
X-Google-Smtp-Source: ABdhPJzlFypNI3zyGDfKAzcwgvEPzM8uJ9MkCskZGHfGJ1iV9PSwBje3w7ZSQHqBbqBW7bFb9Fqeog==
X-Received: by 2002:ac8:7b23:: with SMTP id l3mr1659699qtu.165.1617781058391;
        Wed, 07 Apr 2021 00:37:38 -0700 (PDT)
Received: from [172.17.0.2] ([13.77.107.179])
        by smtp.gmail.com with ESMTPSA id z24sm17459743qkz.65.2021.04.07.00.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 00:37:37 -0700 (PDT)
Message-ID: <606d6141.1c69fb81.7f587.5fec@mx.google.com>
Date:   Wed, 07 Apr 2021 00:37:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8298091406265178514=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez] input/hog: support multiple variable length notification
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210407151649.Bluez.1.I4ff127dde9bc6adb2a07507af2bf2cc6b6bcf0f2@changeid>
References: <20210407151649.Bluez.1.I4ff127dde9bc6adb2a07507af2bf2cc6b6bcf0f2@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8298091406265178514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDYyMTM1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBQQVNTCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tH
aXRMaW50IC0gUEFTUwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
QnVpbGQ6IFNldHVwIEVMTCAtIFBBU1MKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBDaGVja0J1aWxkOiBTZXR1cCAtIFBBU1MKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIwpUZXN0OiBDaGVja0J1aWxkIC0gRkFJTApPdXRwdXQ6CnByb2ZpbGVzL2lucHV0L2hvZy1s
aWIuYzogSW4gZnVuY3Rpb24g4oCYcmVwb3J0X2NjY193cml0dGVuX2Ni4oCZOgpwcm9maWxlcy9p
bnB1dC9ob2ctbGliLmM6MzkwOjE0OiBlcnJvcjog4oCYc3RydWN0IHJlcG9ydOKAmSBoYXMgbm8g
bWVtYmVyIG5hbWVkIOKAmG5vdGlmeWlk4oCZOyBkaWQgeW91IG1lYW4g4oCYbm90aWZ5X2lk4oCZ
PwogIDM5MCB8ICBpZiAocmVwb3J0LT5ub3RpZnlpZCkKICAgICAgfCAgICAgICAgICAgICAgXn5+
fn5+fn4KICAgICAgfCAgICAgICAgICAgICAgbm90aWZ5X2lkCnByb2ZpbGVzL2lucHV0L2hvZy1s
aWIuYzogSW4gZnVuY3Rpb24g4oCYYnRfaG9nX2F0dGFjaOKAmToKcHJvZmlsZXMvaW5wdXQvaG9n
LWxpYi5jOjE3NjI6MTA6IGVycm9yOiDigJhzdHJ1Y3QgcmVwb3J04oCZIGhhcyBubyBtZW1iZXIg
bmFtZWQg4oCYbm90aWZ5aWTigJk7IGRpZCB5b3UgbWVhbiDigJhub3RpZnlfaWTigJk/CiAxNzYy
IHwgICBpZiAoci0+bm90aWZ5aWQpCiAgICAgIHwgICAgICAgICAgXn5+fn5+fn4KICAgICAgfCAg
ICAgICAgICBub3RpZnlfaWQKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo2ODAzOiBwcm9maWxlcy9p
bnB1dC9ob2ctbGliLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MDI5OiBhbGxdIEVy
cm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZUNoZWNrIC0g
U0tJUFBFRApPdXRwdXQ6CmNoZWNrYnVpbGQgbm90IHN1Y2Nlc3MKCiMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja0J1aWxkIHcvZXh0ZXJuYWwgZWxsIC0gRkFJTApPdXRw
dXQ6CnByb2ZpbGVzL2lucHV0L2hvZy1saWIuYzogSW4gZnVuY3Rpb24g4oCYcmVwb3J0X2NjY193
cml0dGVuX2Ni4oCZOgpwcm9maWxlcy9pbnB1dC9ob2ctbGliLmM6MzkwOjE0OiBlcnJvcjog4oCY
c3RydWN0IHJlcG9ydOKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmG5vdGlmeWlk4oCZOyBkaWQg
eW91IG1lYW4g4oCYbm90aWZ5X2lk4oCZPwogIDM5MCB8ICBpZiAocmVwb3J0LT5ub3RpZnlpZCkK
ICAgICAgfCAgICAgICAgICAgICAgXn5+fn5+fn4KICAgICAgfCAgICAgICAgICAgICAgbm90aWZ5
X2lkCnByb2ZpbGVzL2lucHV0L2hvZy1saWIuYzogSW4gZnVuY3Rpb24g4oCYYnRfaG9nX2F0dGFj
aOKAmToKcHJvZmlsZXMvaW5wdXQvaG9nLWxpYi5jOjE3NjI6MTA6IGVycm9yOiDigJhzdHJ1Y3Qg
cmVwb3J04oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYbm90aWZ5aWTigJk7IGRpZCB5b3UgbWVh
biDigJhub3RpZnlfaWTigJk/CiAxNzYyIHwgICBpZiAoci0+bm90aWZ5aWQpCiAgICAgIHwgICAg
ICAgICAgXn5+fn5+fn4KICAgICAgfCAgICAgICAgICBub3RpZnlfaWQKbWFrZVsxXTogKioqIFtN
YWtlZmlsZTo2ODAzOiBwcm9maWxlcy9pbnB1dC9ob2ctbGliLm9dIEVycm9yIDEKbWFrZTogKioq
IFtNYWtlZmlsZTo0MDI5OiBhbGxdIEVycm9yIDIKCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVl
dG9vdGgKCg==

--===============8298091406265178514==--
