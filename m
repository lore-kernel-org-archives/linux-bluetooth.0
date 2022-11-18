Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF7CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 06:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiKRGeO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 01:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbiKRGeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 01:34:02 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7516272120
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:34:01 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id fz10so2600974qtb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Oyfyfn71t7x/eSM3hheWgg9Bzn1tag5XMzkT9HJOjK8=;
        b=ROlseekAUXHW6gBo/G+0jgEUpNSSdJcKXPuTLRweuhWSrMZe1Y1QzBwDSlKi4S2bc1
         3slB6MV/hfYlz0qTPYhq5r47ukGyAJodixtfErSwnSTbCmEaC4pn5xIQI5NFhWAIWL6U
         /4IaYdpBXA6hhxRwjwa1HHre8bzC+lnV1k1KQ7a5v3s/h0l+hSe4wEA9Tqx8SO0ewJZN
         mO/2OHdb/dC7nd+kvypykxZhgjftEzhgMUkH6O6OtWJ6euf4LfF6xfH9teJgG42tmu8p
         +zU8yO2q6T/dQ4jhlEn+fwjpQsEpCmgr3x1eysv/FYF4qCXv/9wCbG06a/lP3fYmHELR
         JIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oyfyfn71t7x/eSM3hheWgg9Bzn1tag5XMzkT9HJOjK8=;
        b=ctJpSI7YqSwoWbxpg3wWVfPRa9P5upAp3XUA+1IUgioaD0YW2H8tgsX1SIsgL2ATmB
         5ZHtNH2OtC1AM4Cq443QCU44GJFElosqYH7ThU96mJ7VG4ZqevKfIY6v9LwEop5PYMo7
         Cfawfu5JYiYJpIcKoMpmfZxu0NPlewIZmUyIlgOg4DdAv4Q/ZPm+pkyec9i74lf5qMGJ
         tecXqkusC7uYZnF+Tva4llOBn8g04KvIwmZk3cX22Iz5nOlfZqV287nHRz1J4MGHyz7W
         BQlyMlYHqKOlvcdKnJaGpPRwK4qNmoDbTLWEWr6DNcCQS3G5h2M4H8CeGf6cuuvkwD0M
         5buQ==
X-Gm-Message-State: ANoB5pkyh9uByIz72DJyd0DYnCcJf5uB77pkstfkut8pb8fJoW2WN2wy
        ZDjhLhb0jI/i6f+PvbHJ+TAssFl6+M3I8g==
X-Google-Smtp-Source: AA0mqf7/H9Rq3roGb1Iz4IUCfpKkbLKfXB/2W600CS84gADwDit1qSNPAV9QwK/6yoboxWbiRW4mtQ==
X-Received: by 2002:ac8:4453:0:b0:3a5:4fd3:865f with SMTP id m19-20020ac84453000000b003a54fd3865fmr5518281qtn.307.1668753240509;
        Thu, 17 Nov 2022 22:34:00 -0800 (PST)
Received: from [172.17.0.2] ([52.188.210.8])
        by smtp.gmail.com with ESMTPSA id r5-20020ac85e85000000b00398df095cf5sm1551738qtx.34.2022.11.17.22.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:34:00 -0800 (PST)
Message-ID: <63772758.c80a0220.d62a.72d4@mx.google.com>
Date:   Thu, 17 Nov 2022 22:34:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8964695807300865764=="
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

--===============8964695807300865764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkxOTQ0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC45OCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjM2IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTMgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MjYuODEgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjIu
OTkgc2Vjb25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNDM0LjMx
IHNlY29uZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDE2LjA5IHNl
Y29uZHMKVGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE1LjkyIHNlY29u
ZHMKVGVzdFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDUuNjAgc2Vjb25kcwpU
ZXN0UnVubmVyX21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTA4LjE0IHNlY29uZHMKVGVz
dFJ1bm5lcl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDkuNTMgc2Vjb25kcwpUZXN0UnVu
bmVyX3Njby10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgOC45MiBzZWNvbmRzClRlc3RSdW5uZXJf
aW9jdGwtdGVzdGVyICAgICAgIFBBU1MgICAgICAxMC4yNCBzZWNvbmRzClRlc3RSdW5uZXJfbWVz
aC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA3LjA5IHNlY29uZHMKVGVzdFJ1bm5lcl9zbXAtdGVz
dGVyICAgICAgICAgUEFTUyAgICAgIDguNzIgc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFuLXRl
c3RlciAgICBQQVNTICAgICAgNS45NCBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAgICAg
ICAgIEZBSUwgICAgICAyNC41MyBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIwpUZXN0OiBCdWlsZEtlcm5lbCAtIEZBSUwKRGVzYzogQnVpbGQgS2VybmVsIGZv
ciBCbHVldG9vdGgKT3V0cHV0OgoKZHJpdmVycy9ibHVldG9vdGgvaGNpX2Jjc3AuYzogSW4gZnVu
Y3Rpb24g4oCYYmNzcF9jbG9zZeKAmToKZHJpdmVycy9ibHVldG9vdGgvaGNpX2Jjc3AuYzo3NDA6
MjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHRpbWVyX3NodXRk
b3duX3N5bmPigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgNzQw
IHwgIHRpbWVyX3NodXRkb3duX3N5bmMoJmJjc3AtPnRiY3NwKTsKICAgICAgfCAgXn5+fn5+fn5+
fn5+fn5+fn5+fgpjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFr
ZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0OTogZHJpdmVycy9ibHVldG9vdGgv
aGNpX2Jjc3Aub10gRXJyb3IgMQptYWtlWzJdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBq
b2JzLi4uLgptYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDY1OiBkcml2ZXJz
L2JsdWV0b290aF0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjE4NTI6IGRyaXZlcnNdIEVy
cm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkS2VybmVsMzIg
LSBGQUlMCkRlc2M6IEJ1aWxkIDMyYml0IEtlcm5lbCBmb3IgQmx1ZXRvb3RoCk91dHB1dDoKCmRy
aXZlcnMvYmx1ZXRvb3RoL2hjaV9iY3NwLmM6IEluIGZ1bmN0aW9uIOKAmGJjc3BfY2xvc2XigJk6
CmRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY3NwLmM6NzQwOjI6IGVycm9yOiBpbXBsaWNpdCBkZWNs
YXJhdGlvbiBvZiBmdW5jdGlvbiDigJh0aW1lcl9zaHV0ZG93bl9zeW5j4oCZIFstV2Vycm9yPWlt
cGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDc0MCB8ICB0aW1lcl9zaHV0ZG93bl9zeW5j
KCZiY3NwLT50YmNzcCk7CiAgICAgIHwgIF5+fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBzb21lIHdh
cm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMl06ICoqKiBbc2NyaXB0cy9NYWtl
ZmlsZS5idWlsZDoyNDk6IGRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY3NwLm9dIEVycm9yIDEKbWFr
ZVsyXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZVsxXTogKioqIFtz
Y3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ2NTogZHJpdmVycy9ibHVldG9vdGhdIEVycm9yIDIKbWFr
ZTogKioqIFtNYWtlZmlsZToxODUyOiBkcml2ZXJzXSBFcnJvciAyCiMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwpUZXN0OiBJbmNyZW1lbnRhbEJ1aWxkIC0gRkFJTApEZXNjOiBJbmNyZW1l
bnRhbCBidWlsZCB3aXRoIHRoZSBwYXRjaGVzIGluIHRoZSBzZXJpZXMKT3V0cHV0OgpbUkZDLHYz
LDA4LzMzXSB0aW1lcnM6IEJsdWV0b290aDogVXNlIHRpbWVyX3NodXRkb3duX3N5bmMoKSBiZWZv
cmUgZnJlZWluZyB0aW1lcgoKZHJpdmVycy9ibHVldG9vdGgvaGNpX2Jjc3AuYzogSW4gZnVuY3Rp
b24g4oCYYmNzcF9jbG9zZeKAmToKZHJpdmVycy9ibHVldG9vdGgvaGNpX2Jjc3AuYzo3NDA6Mjog
ZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHRpbWVyX3NodXRkb3du
X3N5bmPigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgNzQwIHwg
IHRpbWVyX3NodXRkb3duX3N5bmMoJmJjc3AtPnRiY3NwKTsKICAgICAgfCAgXn5+fn5+fn5+fn5+
fn5+fn5+fgpjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsy
XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0OTogZHJpdmVycy9ibHVldG9vdGgvaGNp
X2Jjc3Aub10gRXJyb3IgMQptYWtlWzJdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgptYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDY1OiBkcml2ZXJzL2Js
dWV0b290aF0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjE4NTI6IGRyaXZlcnNdIEVycm9y
IDIKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============8964695807300865764==--
