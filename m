Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06841C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiKRFcy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiKRFcw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:32:52 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C8C9A245
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:32:51 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z6so2540511qtv.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pa9y4F+TdTjHXhCNIEW8s+zZM3DPpE1spAG6rSePi/E=;
        b=VDefhYbicBD9/Qg48KxWxkpBOwemfxCARDUzDMYgn8s5PrOvSQMNHuWfOsuYZpBZp3
         LHoDPVgs1hhEE93QcOBclC7pOKA+qYV+zsCSwM5DSOsz01yQoGdxFG5g5tucbW1dRSwH
         jLKdY4H8VcZzvY8djVyZy5vrr7nHuRGkxeQMMuNDjqwpCS9ZywuBQ7hrORIR13lHE1KJ
         E3qW9p8Ygbp1BP9vSZWc/TTpWMViKUyChZCPZVcPhOMXkDSc0YF21Z3w7o54TcxddDxv
         yZ0osgBKkvhR4vh6fiPUgk9+imsLPtuGtrqdlQVz92ySVwQdUod9U5GtUuKHjSeQ/wsK
         KhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pa9y4F+TdTjHXhCNIEW8s+zZM3DPpE1spAG6rSePi/E=;
        b=DRSMWNVEwPoWqRF4H1hqmrkXJKDV9N33j68qe/M6HRFy9iSGzMC5CLEXvyxuhMvopT
         UymabJFmG/sHJLuOLxGZzefoilGxrvOonOgmjATo9PunUhDAtxSm8R/7FzgAwIvf8Bb3
         nc4Y/5aw5nbImHM6oWhbuLjpd+6wM4nXix6etUEJbH2rMMLWyPtSSGBBFj3ARthp1l4T
         iBkdPBt4E423o+kr1hg8PjAX2DHbXMrA/LRevHwrBojX826rxhsvh3w9056HDvWJ8/u+
         NbT29ve3qApbrqdyTEYR5uo+rPDWpLzN4d8MlX9/j5AswNfdxHykSPM/rxjN3F0VqxHc
         rmoQ==
X-Gm-Message-State: ANoB5pkzG7O1H5IDYXkdcxQ2nfYUEfCaO9j5wdkN13xY3Q6+3Bpzywp3
        S9cPPIG4yahIeDQNYnHka+4ajf9/AZVzqg==
X-Google-Smtp-Source: AA0mqf4tQ/VTBLo6nKVIA5jL1ZPb5WKeuIO2jJls2GsWqPA4HXBsQ9/lMwi/ll+uaraQ5BKBBSXMaQ==
X-Received: by 2002:ac8:70c7:0:b0:3a5:6d59:852e with SMTP id g7-20020ac870c7000000b003a56d59852emr5368186qtp.334.1668749570558;
        Thu, 17 Nov 2022 21:32:50 -0800 (PST)
Received: from [172.17.0.2] ([20.231.199.158])
        by smtp.gmail.com with ESMTPSA id x30-20020a05620a0b5e00b006fbb833fef8sm1812040qkg.28.2022.11.17.21.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:32:50 -0800 (PST)
Message-ID: <63771902.050a0220.260f3.8ead@mx.google.com>
Date:   Thu, 17 Nov 2022 21:32:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5149969826016024284=="
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

--===============5149969826016024284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkyMzQ4CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS4xNiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjM5IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTMgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MzEuNDQgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjcu
NTcgc2Vjb25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNTMwLjU2
IHNlY29uZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDE4LjYyIHNl
Y29uZHMKVGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE5LjI2IHNlY29u
ZHMKVGVzdFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDYuNDMgc2Vjb25kcwpU
ZXN0UnVubmVyX21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTI2LjY0IHNlY29uZHMKVGVz
dFJ1bm5lcl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDExLjIzIHNlY29uZHMKVGVzdFJ1
bm5lcl9zY28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDEwLjkyIHNlY29uZHMKVGVzdFJ1bm5l
cl9pb2N0bC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDEyLjE0IHNlY29uZHMKVGVzdFJ1bm5lcl9t
ZXNoLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDguNTAgc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10
ZXN0ZXIgICAgICAgICBQQVNTICAgICAgMTAuMjkgc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFu
LXRlc3RlciAgICBQQVNTICAgICAgNy4yNiBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAg
ICAgICAgIEZBSUwgICAgICAyOC43NyBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZEtlcm5lbCAtIEZBSUwKRGVzYzogQnVpbGQgS2VybmVs
IGZvciBCbHVldG9vdGgKT3V0cHV0OgoKZHJpdmVycy9ibHVldG9vdGgvaGNpX2Jjc3AuYzogSW4g
ZnVuY3Rpb24g4oCYYmNzcF9jbG9zZeKAmToKZHJpdmVycy9ibHVldG9vdGgvaGNpX2Jjc3AuYzo3
NDA6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHRpbWVyX3No
dXRkb3duX3N5bmPigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAg
NzQwIHwgIHRpbWVyX3NodXRkb3duX3N5bmMoJmJjc3AtPnRiY3NwKTsKICAgICAgfCAgXn5+fn5+
fn5+fn5+fn5+fn5+fgpjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMK
bWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0OTogZHJpdmVycy9ibHVldG9v
dGgvaGNpX2Jjc3Aub10gRXJyb3IgMQptYWtlWzJdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hl
ZCBqb2JzLi4uLgptYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDY1OiBkcml2
ZXJzL2JsdWV0b290aF0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjE4NTI6IGRyaXZlcnNd
IEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkS2VybmVs
MzIgLSBGQUlMCkRlc2M6IEJ1aWxkIDMyYml0IEtlcm5lbCBmb3IgQmx1ZXRvb3RoCk91dHB1dDoK
CmRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY3NwLmM6IEluIGZ1bmN0aW9uIOKAmGJjc3BfY2xvc2Xi
gJk6CmRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY3NwLmM6NzQwOjI6IGVycm9yOiBpbXBsaWNpdCBk
ZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJh0aW1lcl9zaHV0ZG93bl9zeW5j4oCZIFstV2Vycm9y
PWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDc0MCB8ICB0aW1lcl9zaHV0ZG93bl9z
eW5jKCZiY3NwLT50YmNzcCk7CiAgICAgIHwgIF5+fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBzb21l
IHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMl06ICoqKiBbc2NyaXB0cy9N
YWtlZmlsZS5idWlsZDoyNDk6IGRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY3NwLm9dIEVycm9yIDEK
bWFrZVsyXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZVsxXTogKioq
IFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ2NTogZHJpdmVycy9ibHVldG9vdGhdIEVycm9yIDIK
bWFrZTogKioqIFtNYWtlZmlsZToxODUyOiBkcml2ZXJzXSBFcnJvciAyCiMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBJbmNyZW1lbnRhbEJ1aWxkIC0gRkFJTApEZXNjOiBJbmNy
ZW1lbnRhbCBidWlsZCB3aXRoIHRoZSBwYXRjaGVzIGluIHRoZSBzZXJpZXMKT3V0cHV0OgpbdjRh
LDEwLzM4XSB0aW1lcnM6IEJsdWV0b290aDogVXNlIHRpbWVyX3NodXRkb3duX3N5bmMoKSBiZWZv
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

--===============5149969826016024284==--
