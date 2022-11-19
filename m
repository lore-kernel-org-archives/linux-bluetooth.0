Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B17C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 05:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiKSFDu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 00:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKSFDt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 00:03:49 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5958449B46
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:03:39 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id d123so5298761iof.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iCh2fG4rnMiOfzRZwUxK7RZ5DZr5/yaN9YdH4/pFsJA=;
        b=nzNqcc6ffpRTKQcKYT/uLed9rOhoqG31xhsE+GJdYFA8SajVEuPiCLn2EIspTUJVXi
         xdG3OD/omMxAbvVlJe9g5EVUhjcVrN7mkhIlbdNibGokmwu0iNafYbJsNoLaHNyL02WS
         FSGOa/IpsqDrKqkV9QfF7mekHXLILiPwVEFQfrWywyYe9hFDeN3gUyFdrGvqbvIcMvGy
         njNiAQt72YM7KG3yxs1dmbTlmWC3r62wf9skjThJ0AdD/tHlw5qfZKFHryW4LGwvR1jy
         m/m+1t0QGTwxCL0lJv2W/F/G2m0rVexgibhw/teAf5RBQR8vvQMZLbrybxRWWCjaQ1f1
         gBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCh2fG4rnMiOfzRZwUxK7RZ5DZr5/yaN9YdH4/pFsJA=;
        b=DpWIhn51XJwYSm4IcNq1iTe4orppe9FeX2XJm8pZ/9SJYhYMJsp0XiXQKHAjVijCIT
         Tu5uhpk0Sw2QWUg3WyiKUgau0gBmK8XquFtBJi7rc/vx+m0QqegTMxGlFXJ65rwNGHOC
         eRg2vxFI5FAiNaAHviw25gu3smuqdlNgR6w9L8BWB/JEo2Q9Bznguy957uIraqsj6hku
         RJoRQ/LEdZk66eX+ZARzhim29ri37f0+83mHbqJjbCv1epLQRST2VBCqg9nnYWYZ2iEA
         SEL1LA/tFTzB1fGcX0tbO/Lo+OQal7ShoUpnemrrMBT2VjCDm2kTJJczrlp6V1Y6e2Wj
         It0g==
X-Gm-Message-State: ANoB5plINwa6AkbSKP8OpX0Nk8/VDdgv7A1HIMohIh6WnuRkHLvlJOFr
        BYsQPtWuTX4DlXwxbwkjifvcX894Muc=
X-Google-Smtp-Source: AA0mqf46vfho5vyq9/XE6aSl7/lXTYNbPyjAFpR4JfRBmoH1vMD1UyYNzOi0lm3VRdvbUgAr5GoBJw==
X-Received: by 2002:a5e:840f:0:b0:6dd:2127:50b9 with SMTP id h15-20020a5e840f000000b006dd212750b9mr4629147ioj.120.1668834218616;
        Fri, 18 Nov 2022 21:03:38 -0800 (PST)
Received: from [172.17.0.2] ([20.29.94.22])
        by smtp.gmail.com with ESMTPSA id x1-20020a056638026100b003627dc2a94esm1901748jaq.96.2022.11.18.21.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:03:38 -0800 (PST)
Message-ID: <637863aa.050a0220.a4f24.4af6@mx.google.com>
Date:   Fri, 18 Nov 2022 21:03:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5928213382248873398=="
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

--===============5928213382248873398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkyMzQ4CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC45MiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjMwIHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTAgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MjcuNTkgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjMu
MjIgc2Vjb25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNTA2LjU3
IHNlY29uZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDE2LjM1IHNl
Y29uZHMKVGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE2LjA3IHNlY29u
ZHMKVGVzdFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDUuNTkgc2Vjb25kcwpU
ZXN0UnVubmVyX21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTA4LjM4IHNlY29uZHMKVGVz
dFJ1bm5lcl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDkuNjIgc2Vjb25kcwpUZXN0UnVu
bmVyX3Njby10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgOC45NSBzZWNvbmRzClRlc3RSdW5uZXJf
aW9jdGwtdGVzdGVyICAgICAgIFBBU1MgICAgICAxMC4zOSBzZWNvbmRzClRlc3RSdW5uZXJfbWVz
aC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA3LjExIHNlY29uZHMKVGVzdFJ1bm5lcl9zbXAtdGVz
dGVyICAgICAgICAgUEFTUyAgICAgIDguODUgc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFuLXRl
c3RlciAgICBQQVNTICAgICAgNS45MiBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAgICAg
ICAgIEZBSUwgICAgICAyNC44MiBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMj
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

--===============5928213382248873398==--
