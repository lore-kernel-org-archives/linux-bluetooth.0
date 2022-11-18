Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F20EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 07:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbiKRH3y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiKRH3w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 02:29:52 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6827CBB8
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:29:51 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id n186so4515625oih.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z8jH0I865+uJgwBNeDKiNx3+nJgam/lqLp4kQ7+ZM28=;
        b=DUaVFvUVJIljd+tipDa0se8VjupbjP4OGrZrP5v2jE5VdxycqlrIZYDOc2dfJcDXBo
         UOUacmJGoEt53feq24WaHJP241/BC7Wo0ykpggMVArnhmIfHNiBZOFtkd99cD3H8BQ8J
         xsdRgqJiUA5ldWZZx2YLkcodPZB8lykzS1nAqXVvOIK26LH9rTPVynOrJisq7A8OOAeJ
         E0WtJNzvgk9hKisorEAe1mubSUCUlsPoYp4fosRjf6iWMj3P6C7BexPFoANM7BCNtoPi
         x1/CsQRW2uxCRz725oAAIYOg1gKFSqjr97k4/QOXOBkvJrZGjULduLpJYIilDRc0TKUJ
         JloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8jH0I865+uJgwBNeDKiNx3+nJgam/lqLp4kQ7+ZM28=;
        b=bWpMEaTi1Krhch2s8Bh6KxBzjkwgUcnu6KwrDI/H33D7ruWqAfWS7Assv+8xHKJWO1
         A/Y5pFpKhBF2F70WkEbcxj43PSWB/hz2cONrwWm+wJEbtrncO7a6rUeFpIWWu219yiYb
         +l41AFZyTQZunGB5VRYCmc73/BQLPbCo0kcLylVnmPQs32WMuW7RC0u2OK16FVa6iA3P
         XRg16LEBfplv8Fin60y/RBxDIlnk5+6cvnSlzbBWxiEgH7z7kU9s0cvc3WpyddBF3Eap
         QmfhSPJtjEZk5H54wfwCCAjXjAHWO7m0ar4ZQji4t4FV5YGFt2tSejXzmyU3eoes9tJ+
         JJvw==
X-Gm-Message-State: ANoB5pmddjYWqgP5c7K6Bhtsq0Sjd5HUVq/M/3HEB1d9QCox+J+eOa5h
        6tO9nJY5wjXzmvLts7NKHYJSUyQG6AU=
X-Google-Smtp-Source: AA0mqf6iHh/mvDOp3B7N6hTRpD4zqtURTnAn8H0l3UXe14y3/g2mvjKDPK8uckBTxCbAnYfZ7JnuAQ==
X-Received: by 2002:a05:6808:3096:b0:355:ebd:8b3a with SMTP id bl22-20020a056808309600b003550ebd8b3amr2834739oib.117.1668756590682;
        Thu, 17 Nov 2022 23:29:50 -0800 (PST)
Received: from [172.17.0.2] ([20.165.56.76])
        by smtp.gmail.com with ESMTPSA id s32-20020a056870612000b0011dca1bd2cdsm1641787oae.0.2022.11.17.23.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:29:50 -0800 (PST)
Message-ID: <6377346e.050a0220.52b9c.723d@mx.google.com>
Date:   Thu, 17 Nov 2022 23:29:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4883417543340031721=="
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

--===============4883417543340031721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkxOTQ0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC44OCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjI5IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMDkgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MjUuODcgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjIu
MDcgc2Vjb25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNDI0LjAx
IHNlY29uZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDE2LjA2IHNl
Y29uZHMKVGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE1Ljc1IHNlY29u
ZHMKVGVzdFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDUuNTAgc2Vjb25kcwpU
ZXN0UnVubmVyX21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTA3LjE0IHNlY29uZHMKVGVz
dFJ1bm5lcl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDkuNDggc2Vjb25kcwpUZXN0UnVu
bmVyX3Njby10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgOC45MiBzZWNvbmRzClRlc3RSdW5uZXJf
aW9jdGwtdGVzdGVyICAgICAgIFBBU1MgICAgICAxMC4xNSBzZWNvbmRzClRlc3RSdW5uZXJfbWVz
aC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA3LjAxIHNlY29uZHMKVGVzdFJ1bm5lcl9zbXAtdGVz
dGVyICAgICAgICAgUEFTUyAgICAgIDguNzMgc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFuLXRl
c3RlciAgICBQQVNTICAgICAgNS43OCBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAgICAg
ICAgIEZBSUwgICAgICAyNC4wMCBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMj
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

--===============4883417543340031721==--
