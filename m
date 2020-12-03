Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2135CC63777
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 12:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78412086A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 12:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgLCMBt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 07:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgLCMBs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 07:01:48 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A67FC061A4D
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Dec 2020 04:01:08 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id y5so1779368iow.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Dec 2020 04:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=G92SSxSMPY9M5ZiNyqr6N6YUku52thhxX68E9AbbBpQ=;
        b=ibmsDRC5jHJmy7VBCE/W4ip+o/c1C6iD5PCFTaZ2FBVjRRQ872AorhaqhHnn/fRm6a
         8J6MCE2taSZmk2mXSwrnLKfFFZUoQL92Jkfeq5hJfM1flQMfr1Nsh7hKQhzyPaLJNJQw
         xZ4zZHs2IfGfCWXIGju+k8YiFZwZpSzEB2g0WVfCenyQZ3Qhaz9LcUhVXKSueJ4FMXdj
         NMRk9B6eO78Vhk+F+Tpr95EV5za6ZF0dPq7JRpKj778pq0xiMg51MtetfSJNPz6Dj2Z0
         UhTh83WJipcJmml2ph/pKsNa1dMUQ5/li8dsBmLUgqqVYfxIVa5yHe/Du8oYxl3qQ4ld
         njfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=G92SSxSMPY9M5ZiNyqr6N6YUku52thhxX68E9AbbBpQ=;
        b=FJKIEzPr0zpdMRio1KDcNacOqZBQqfag0V0zKKQHZaRrVCiPSZ57IJuZlTA3vPhzZh
         BGXvitOgr0FAkse35Sz1wbf/ZdfNMRwg5eDDVzTYyaYsZhI434qKnCde3MJOWhMINy+N
         8FCgR3g9r2uvhLS9HOe7Vd3RxcM/LxxIV0vaebC6KmVLrhgvu9zSUgzHuZI8twHAtvmH
         t3aM3zzDvIAaV2QVfvRBN2JFkzWAcAzT4KZAYZTzXO5Ad3Bq7cnW3AXPivxLNJ0mK9Cs
         Aa3LwwpbzIzKRgarVBFHOFUVy1L63w/nnifP2Ey36IkqFhfhf7JVRaJRPjpvojPlD9Ea
         z57A==
X-Gm-Message-State: AOAM530NTK2vO+NrZgZHj8/Mdfu3vOqgm5c0gWEpy87qdZPzEmln8DXK
        /4T8TUjWS+IGrmaWUDjcnwD4H+JwnU4=
X-Google-Smtp-Source: ABdhPJz3h3GHO72iBjRapYDOw77CACoNKB0EL33d868LvQ9dMX7MemIBI22o8RqPcQmH+oG0GV0Cag==
X-Received: by 2002:a6b:fd03:: with SMTP id c3mr2823486ioi.64.1606996867547;
        Thu, 03 Dec 2020 04:01:07 -0800 (PST)
Received: from [172.17.0.2] ([52.179.192.61])
        by smtp.gmail.com with ESMTPSA id k4sm248373ioh.45.2020.12.03.04.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 04:01:07 -0800 (PST)
Message-ID: <5fc8d383.1c69fb81.4dd2c.0f81@mx.google.com>
Date:   Thu, 03 Dec 2020 04:01:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7640308464025752128=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: [v3] Bluetooth: btusb: Add workaround for remote-wakeup issues with Barrot 8041a02 fake CSR controllers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201203110944.49307-2-hdegoede@redhat.com>
References: <20201203110944.49307-2-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7640308464025752128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9Mzk1MzkxCgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBQQVNTCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tH
aXRMaW50IC0gRkFJTApPdXRwdXQ6CkJsdWV0b290aDogYnR1c2I6IEFkZCB3b3JrYXJvdW5kIGZv
ciByZW1vdGUtd2FrZXVwIGlzc3VlcyB3aXRoIEJhcnJvdCA4MDQxYTAyIGZha2UgQ1NSIGNvbnRy
b2xsZXJzCjE6IFQxIFRpdGxlIGV4Y2VlZHMgbWF4IGxlbmd0aCAoOTg+NzIpOiAiQmx1ZXRvb3Ro
OiBidHVzYjogQWRkIHdvcmthcm91bmQgZm9yIHJlbW90ZS13YWtldXAgaXNzdWVzIHdpdGggQmFy
cm90IDgwNDFhMDIgZmFrZSBDU1IgY29udHJvbGxlcnMiCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjClRlc3Q6IENoZWNrQnVpbGRLIC0gRkFJTApPdXRwdXQ6CmRyaXZlcnMvYmx1ZXRv
b3RoL2J0dXNiLmM6IEluIGZ1bmN0aW9uIOKAmGJ0dXNiX3NldHVwX2NzcuKAmToKZHJpdmVycy9i
bHVldG9vdGgvYnR1c2IuYzoxODkzOjc6IGVycm9yOiDigJhiY2REZXZpY2XigJkgdW5kZWNsYXJl
ZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g4oCYZGV2aWNl4oCZ
PwogMTg5MyB8ICAgaWYgKGJjZERldmljZSA9PSAweDg4OTEgJiYKICAgICAgfCAgICAgICBefn5+
fn5+fn4KICAgICAgfCAgICAgICBkZXZpY2UKZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYzoxODkz
Ojc6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25j
ZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCmRyaXZlcnMvYmx1ZXRvb3RoL2J0dXNi
LmM6MTg5OToyMjogZXJyb3I6IOKAmGRhdGHigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRo
aXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g4oCYX2RhdGHigJk/CiAxODk5IHwgICAgcG1fcnVu
dGltZV9hbGxvdygmZGF0YS0+dWRldi0+ZGV2KTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICBefn5+CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgX2RhdGEKbWFrZVsyXTogKioqIFtz
Y3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI4MzogZHJpdmVycy9ibHVldG9vdGgvYnR1c2Iub10gRXJy
b3IgMQptYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTAwOiBkcml2ZXJzL2Js
dWV0b290aF0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjE3OTk6IGRyaXZlcnNdIEVycm9y
IDIKCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============7640308464025752128==--
