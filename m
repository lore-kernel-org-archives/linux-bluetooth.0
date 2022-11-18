Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222D4C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 09:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbiKRJbG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241932AbiKRJbC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 04:31:02 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE10742FB
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:31:00 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id r2so2253123ilg.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9EC2+oRv7XKxLQOijsw9gb6Suuzs+f7K3BjDmcbhgGs=;
        b=UOrH/QdFtela5azAkldazRjwd6adyOaehxNhA7bsjA6pJ1q64UFDPZNMABCiLP688c
         lUfuZWoqJvFYUaGJ4WxEsy/Aduuw1bk3fpU9za4vObfeX/DiIeqHY/adN3ZdpMzXvIg9
         RPEsgv9qSVKXIKbJxMKCHpNfXfQ4ic65H0MK1CQ9AI7aA0ER93OicQor2V0ywEeE648+
         1Pn6fBgeoLMddKDeiQ7wbBDPB/D6ygycfmLIcwTeI4lGw/qZjPBbv4iAph//mhVYgxSK
         2wXGXCX0739+NDhPikh+cOXKyn5Td3CVtReRXngWjNXAo3uelalRLtZk+Ic9uQ/ISfxm
         lgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EC2+oRv7XKxLQOijsw9gb6Suuzs+f7K3BjDmcbhgGs=;
        b=pHlQ+gO/zUyh0rnGwhGcyE175tSsVFOl3lJXm+D6fsLNkhU2BhAuyrAg/vdLH6vHMe
         jIASJHwNSqZTxm/9tB3jA/qTNQUjIqJR0SxF8QdLEck8onUktCCeHZEhxqxpUJ43HPpk
         fmlguAIagzZhEqzDMLhxstq0CLuPNQomeQzwtO18rzSOCPvayd4cTW1wCTf9NhTOPJ4H
         Vz3MOGbZYfXhw0rknaEbTValaa037Y/AXKn8HvZqJ1BiNPCHyPL0dtYqxxX/EwmN7yCI
         FYr2XKNIAVeznZYiZok/wxpZjMu/WSs5AbEdf8chEn4hTLZ9aDHlwZQ0pC1q69lG/PPC
         HTOQ==
X-Gm-Message-State: ANoB5pluf9EVSWaAqRBDULZgpzFgZX1o8sXQk0xnl2EVbqe/41Asq9wY
        c4xGTR/Ccy6RWusD32chmH2J4FOFLKA=
X-Google-Smtp-Source: AA0mqf7GLZEMzV5/2qmg/r2UPe8S7t70y4PuYhmvMECh8HfmypRI6vyItwRRQ8ES6q5fydAlNczsqw==
X-Received: by 2002:a92:ce90:0:b0:2f9:516b:25f3 with SMTP id r16-20020a92ce90000000b002f9516b25f3mr2891397ilo.156.1668763859667;
        Fri, 18 Nov 2022 01:30:59 -0800 (PST)
Received: from [172.17.0.2] ([20.9.58.63])
        by smtp.gmail.com with ESMTPSA id b24-20020a5d8918000000b0069e1bcbddaesm1187874ion.16.2022.11.18.01.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:30:59 -0800 (PST)
Message-ID: <637750d3.5d0a0220.15602.26d3@mx.google.com>
Date:   Fri, 18 Nov 2022 01:30:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3320036724517155253=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rostedt@goodmis.org
Subject: RE: timers: Use timer_shutdown*() before freeing timers
In-Reply-To: <20221105060156.686027537@goodmis.org>
References: <20221105060156.686027537@goodmis.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3320036724517155253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkyMzQ4CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC44NyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjI5IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMDkgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MjYuMzggc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjIu
NjIgc2Vjb25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNDI5LjE4
IHNlY29uZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDE2LjM4IHNl
Y29uZHMKVGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE1LjkzIHNlY29u
ZHMKVGVzdFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDUuNjQgc2Vjb25kcwpU
ZXN0UnVubmVyX21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTExLjE5IHNlY29uZHMKVGVz
dFJ1bm5lcl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDkuNTcgc2Vjb25kcwpUZXN0UnVu
bmVyX3Njby10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgOC45MCBzZWNvbmRzClRlc3RSdW5uZXJf
aW9jdGwtdGVzdGVyICAgICAgIFBBU1MgICAgICAxMC40MyBzZWNvbmRzClRlc3RSdW5uZXJfbWVz
aC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA3LjExIHNlY29uZHMKVGVzdFJ1bm5lcl9zbXAtdGVz
dGVyICAgICAgICAgUEFTUyAgICAgIDguNzUgc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFuLXRl
c3RlciAgICBQQVNTICAgICAgNS44NiBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAgICAg
ICAgIEZBSUwgICAgICAyMy44OSBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMj
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
bnRhbCBidWlsZCB3aXRoIHRoZSBwYXRjaGVzIGluIHRoZSBzZXJpZXMKT3V0cHV0OgpbdjRhLDEw
LzM4XSB0aW1lcnM6IEJsdWV0b290aDogVXNlIHRpbWVyX3NodXRkb3duX3N5bmMoKSBiZWZvcmUg
ZnJlZWluZyB0aW1lcgoKZHJpdmVycy9ibHVldG9vdGgvaGNpX2Jjc3AuYzogSW4gZnVuY3Rpb24g
4oCYYmNzcF9jbG9zZeKAmToKZHJpdmVycy9ibHVldG9vdGgvaGNpX2Jjc3AuYzo3NDA6MjogZXJy
b3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHRpbWVyX3NodXRkb3duX3N5
bmPigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgNzQwIHwgIHRp
bWVyX3NodXRkb3duX3N5bmMoJmJjc3AtPnRiY3NwKTsKICAgICAgfCAgXn5+fn5+fn5+fn5+fn5+
fn5+fgpjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsyXTog
KioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0OTogZHJpdmVycy9ibHVldG9vdGgvaGNpX2Jj
c3Aub10gRXJyb3IgMQptYWtlWzJdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4u
LgptYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDY1OiBkcml2ZXJzL2JsdWV0
b290aF0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjE4NTI6IGRyaXZlcnNdIEVycm9yIDIK
CgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============3320036724517155253==--
