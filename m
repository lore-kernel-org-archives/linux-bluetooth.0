Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F08C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 04:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A31061929
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 04:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhC3EEx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 00:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhC3EEd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 00:04:33 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B730C061762
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 21:04:33 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 7so14668864qka.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 21:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=v07pSbiTQCys/iBevPlSaWNCNREhZdFuIuVAwJ6f80s=;
        b=nAESad52FQp+2cEFBgk9MPsdL5U6UDQpnNuwPhH9WcaoWlyu9sQa/6q5H6U3E+PyKQ
         Tdjlhqh8QmZwg96tug3uLe0x+AhJcPrpsA2NJEs4zLdSQWe0OK0f/yYxO1XWzvhQukv7
         B5eRlnH1h4siVnP/kY5EHBk5XgJR3ZofRDkUDJIxs/CjeJXJ0rRmI2dkNvJJSMjp6ebI
         iVlt8Iqkkyj8bd06xnF5RGfRxPUX9+jXickWl2q+15SqDwm+j7nV+pR1Ucr6RrKwbVJO
         wLUFtYWhONhjPKz4LlASkN5TVN2Y29YedphVOXHa7kLAmwPXblKc52yEyHEOXk2xiNPV
         mGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=v07pSbiTQCys/iBevPlSaWNCNREhZdFuIuVAwJ6f80s=;
        b=cm3tyouLOZb54nk/VPXBy4ts8E85DQwsetjyWcS6x07Ta2ncKk4aIsrVxUkKMvbL4y
         CywcIstOcWnuRi6DeSx3v4A4owFrTLkQfgODVRMnowvMTlOQjfZyZHagPl4TlSFOeit8
         e5MR9ltAykOSzcCxD8+wFI9wyj43OF2f5881iTMAoy19sZv9b6RBJfV6uypX4Umne8AB
         Gi0tB3sgxR21r4bOS7jph9FzPl1uNacPDK7sswWoZk+u/g0g7A8FAVnIu9WAxjMuxE/i
         J8imLeFnDHeMSxtvwdaZdYLUIpC4Csb8YR/ELEzKJG5o4CNee5qYajRjL369wkfODg8u
         92Mg==
X-Gm-Message-State: AOAM530t9rUz3aWcrh8sEC7cV+sM9myGMi7GkWjTpXMf0pMSKfEmHJYa
        ijX7K085R9JiE6ZEbzNUiFyK7uOvMdm8dA==
X-Google-Smtp-Source: ABdhPJwxDhnm39366JrNtDrlCzlCLXXWA4PT/0GxFKZr59X6tG/hsy605WZ8sIhdtzURD7zMza4eKw==
X-Received: by 2002:a37:ef14:: with SMTP id j20mr29167654qkk.471.1617077071974;
        Mon, 29 Mar 2021 21:04:31 -0700 (PDT)
Received: from [172.17.0.2] ([52.149.221.38])
        by smtp.gmail.com with ESMTPSA id y13sm12160791qto.39.2021.03.29.21.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 21:04:31 -0700 (PDT)
Message-ID: <6062a34f.1c69fb81.92571.aabf@mx.google.com>
Date:   Mon, 29 Mar 2021 21:04:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4071590900233541289=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v5,1/2] adv_monitor: split rssi_parameters into its own struct
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210330114413.Bluez.v5.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
References: <20210330114413.Bluez.v5.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4071590900233541289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDU3Nzc1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBQQVNTCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tH
aXRMaW50IC0gUEFTUwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
QnVpbGQ6IFNldHVwIEVMTCAtIFBBU1MKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBDaGVja0J1aWxkOiBTZXR1cCAtIFBBU1MKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIwpUZXN0OiBDaGVja0J1aWxkIC0gRkFJTApPdXRwdXQ6CnNyYy9hZHZfbW9uaXRvci5jOiBJ
biBmdW5jdGlvbiDigJhtb25pdG9yX3N0YXRlX3JlbGVhc2Vk4oCZOgpzcmMvYWR2X21vbml0b3Iu
Yzo2MjY6NTogZXJyb3I6IHN1Z2dlc3QgcGFyZW50aGVzZXMgYXJvdW5kIOKAmCYm4oCZIHdpdGhp
biDigJh8fOKAmSBbLVdlcnJvcj1wYXJlbnRoZXNlc10KICA2MjUgfCAgaWYgKCFtb25pdG9yIHx8
IG1vbml0b3ItPnN0YXRlICE9IE1PTklUT1JfU1RBVEVfSU5JVEVECiAgICAgIHwgICAgICAgICAg
ICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgogIDYyNiB8ICAg
ICAmJiBtb25pdG9yLT5zdGF0ZSAhPSBNT05JVE9SX1NUQVRFX0FDVElWRSkKICAgICAgfCAgICAg
Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4Kc3JjL2Fkdl9tb25pdG9y
LmM6IEluIGZ1bmN0aW9uIOKAmGFkZF9hZHZfcGF0dGVybnNfbW9uaXRvcl9jYuKAmToKc3JjL2Fk
dl9tb25pdG9yLmM6MTA2NjoyODogZXJyb3I6IHVudXNlZCB2YXJpYWJsZSDigJhl4oCZIFstV2Vy
cm9yPXVudXNlZC12YXJpYWJsZV0KIDEwNjYgfCAgY29uc3Qgc3RydWN0IHF1ZXVlX2VudHJ5ICpl
OwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4Kc3JjL2Fkdl9tb25pdG9yLmM6
IEluIGZ1bmN0aW9uIOKAmG1vbml0b3Jfc3RhdGVfcmVtb3ZlZOKAmToKc3JjL2Fkdl9tb25pdG9y
LmM6MTQ4NTo1OiBlcnJvcjogc3VnZ2VzdCBwYXJlbnRoZXNlcyBhcm91bmQg4oCYJibigJkgd2l0
aGluIOKAmHx84oCZIFstV2Vycm9yPXBhcmVudGhlc2VzXQogMTQ4NCB8ICBpZiAoIW1vbml0b3Ig
fHwgbW9uaXRvci0+c3RhdGUgIT0gTU9OSVRPUl9TVEFURV9JTklURUQKICAgICAgfCAgICAgICAg
ICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAxNDg1IHwg
ICAgICYmIG1vbml0b3ItPnN0YXRlICE9IE1PTklUT1JfU1RBVEVfQUNUSVZFKQogICAgICB8ICAg
ICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJu
aW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjkyNzY6
IHNyYy9ibHVldG9vdGhkLWFkdl9tb25pdG9yLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmls
ZTo0MDI4OiBhbGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVz
dDogTWFrZUNoZWNrIC0gU0tJUFBFRApPdXRwdXQ6CmNoZWNrYnVpbGQgbm90IHN1Y2Nlc3MKCiMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja0J1aWxkIHcvZXh0ZXJuYWwg
ZWxsIC0gRkFJTApPdXRwdXQ6CnNyYy9hZHZfbW9uaXRvci5jOiBJbiBmdW5jdGlvbiDigJhtb25p
dG9yX3N0YXRlX3JlbGVhc2Vk4oCZOgpzcmMvYWR2X21vbml0b3IuYzo2MjY6NTogZXJyb3I6IHN1
Z2dlc3QgcGFyZW50aGVzZXMgYXJvdW5kIOKAmCYm4oCZIHdpdGhpbiDigJh8fOKAmSBbLVdlcnJv
cj1wYXJlbnRoZXNlc10KICA2MjUgfCAgaWYgKCFtb25pdG9yIHx8IG1vbml0b3ItPnN0YXRlICE9
IE1PTklUT1JfU1RBVEVfSU5JVEVECiAgICAgIHwgICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgogIDYyNiB8ICAgICAmJiBtb25pdG9yLT5zdGF0
ZSAhPSBNT05JVE9SX1NUQVRFX0FDVElWRSkKICAgICAgfCAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4Kc3JjL2Fkdl9tb25pdG9yLmM6IEluIGZ1bmN0aW9uIOKA
mGFkZF9hZHZfcGF0dGVybnNfbW9uaXRvcl9jYuKAmToKc3JjL2Fkdl9tb25pdG9yLmM6MTA2Njoy
ODogZXJyb3I6IHVudXNlZCB2YXJpYWJsZSDigJhl4oCZIFstV2Vycm9yPXVudXNlZC12YXJpYWJs
ZV0KIDEwNjYgfCAgY29uc3Qgc3RydWN0IHF1ZXVlX2VudHJ5ICplOwogICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF4Kc3JjL2Fkdl9tb25pdG9yLmM6IEluIGZ1bmN0aW9uIOKAmG1v
bml0b3Jfc3RhdGVfcmVtb3ZlZOKAmToKc3JjL2Fkdl9tb25pdG9yLmM6MTQ4NTo1OiBlcnJvcjog
c3VnZ2VzdCBwYXJlbnRoZXNlcyBhcm91bmQg4oCYJibigJkgd2l0aGluIOKAmHx84oCZIFstV2Vy
cm9yPXBhcmVudGhlc2VzXQogMTQ4NCB8ICBpZiAoIW1vbml0b3IgfHwgbW9uaXRvci0+c3RhdGUg
IT0gTU9OSVRPUl9TVEFURV9JTklURUQKICAgICAgfCAgICAgICAgICAgICAgICAgIH5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAxNDg1IHwgICAgICYmIG1vbml0b3ItPnN0
YXRlICE9IE1PTklUT1JfU1RBVEVfQUNUSVZFKQogICAgICB8ICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVk
IGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjkyNzY6IHNyYy9ibHVldG9vdGhkLWFk
dl9tb25pdG9yLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MDI4OiBhbGxdIEVycm9y
IDIKCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============4071590900233541289==--
