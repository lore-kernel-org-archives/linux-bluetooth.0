Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C507C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 07:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbiKRHdG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiKRHdF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 02:33:05 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7D57CBB8
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:33:02 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-14286d5ebc3so1750534fac.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4N4TKYsSuODYCWy4QC6Zmtb/KfMj2hXbrofHGEXK694=;
        b=LO8NXZWFOAXzruNnyNdZ6uLQLQXrIpcSlnvDsKiv5n2bH9TddbCIMfnTGstrIQNsub
         ZOS4kmoXtTnju88ATrepqogJETx9WDsehKRrjyXPvHUBdHTCIgGqcsN6roSvUYqoTpkS
         YhoRtWZYgeV+HUBfrQkYYhdg85DHuWyAsqwf4jFGiqR7uGEdFwwHffbuTn+8k7D+bM8h
         //hIB8TsTTqUJXvdQEqrz8fhu5G9H3gOwcXQQwIK472kmQ9mqKA16JGiRJ/5EQ5xseYJ
         yX0aAcdX+4/CCe0vXgn95biPQ5GTdQPMW1rwfI55PlNTKYmM1iRi/73hWMy60MygBDiQ
         V96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4N4TKYsSuODYCWy4QC6Zmtb/KfMj2hXbrofHGEXK694=;
        b=jVYzI8s5PvlE5dkvZJKx8HSyvr4IsxIqi1QbfjmLCPEnLUn8aq5ShYxTmg32rYxrCU
         5uaGQ54xdOKbs3EfO4ZNrUUFhfgJx/vNTMj7xugHIixdAhCLmcKwUXVp5oGC+jmd+VGW
         fBreSy2JeQ+Q70eIq9xgYMzPKDD2OWZb3HxwXjgr4zXNsvteQsdTaGaF4s2c7vvHlVpj
         w8u7mr6ElJz4YU/bNKEW4qWICoH7Rv2rOqMaWfsottKgeJYkAbXMXuHc6iI+KVaaeCrf
         xReIpURPlHtG1XKRDEmSOVpqMpXmOUdwMjb+plncs+qtOnbcxEWnbKvLZVOJ3hIPzmeB
         OKYA==
X-Gm-Message-State: ANoB5pl+dcTERC62odtfK+trF78JeuT9gtu5PZdesLWTpekF4xa3IEUr
        1MbUpf+ilLfDCiM008aPa9uu1ILaS+eBrw==
X-Google-Smtp-Source: AA0mqf6P17wQHU3M7NYCJR13C/lxZA47JPAvk3pklia5u38/jj2WMP4coZRNmwjqIo94bR5ybgIIzg==
X-Received: by 2002:a05:6870:c90b:b0:13d:9ae1:4a90 with SMTP id hj11-20020a056870c90b00b0013d9ae14a90mr3480835oab.262.1668756781674;
        Thu, 17 Nov 2022 23:33:01 -0800 (PST)
Received: from [172.17.0.2] ([20.225.93.20])
        by smtp.gmail.com with ESMTPSA id e3-20020a544f03000000b0035a66bb4982sm1153716oiy.57.2022.11.17.23.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:33:01 -0800 (PST)
Message-ID: <6377352d.540a0220.dbdbb.544f@mx.google.com>
Date:   Thu, 17 Nov 2022 23:33:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9207791264582974657=="
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

--===============9207791264582974657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjkyMzQ4CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS4wNSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjMxIHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMDkgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MzIuMjggc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjgu
MDMgc2Vjb25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNTM2LjA0
IHNlY29uZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDE4Ljg4IHNl
Y29uZHMKVGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE5Ljg1IHNlY29u
ZHMKVGVzdFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDYuNzggc2Vjb25kcwpU
ZXN0UnVubmVyX21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTMwLjYzIHNlY29uZHMKVGVz
dFJ1bm5lcl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDExLjQwIHNlY29uZHMKVGVzdFJ1
bm5lcl9zY28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDEwLjY2IHNlY29uZHMKVGVzdFJ1bm5l
cl9pb2N0bC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDEyLjUzIHNlY29uZHMKVGVzdFJ1bm5lcl9t
ZXNoLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDguNjYgc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10
ZXN0ZXIgICAgICAgICBQQVNTICAgICAgMTAuNDAgc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFu
LXRlc3RlciAgICBQQVNTICAgICAgNy4xOSBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAg
ICAgICAgIEZBSUwgICAgICAyOS42MiBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMj
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

--===============9207791264582974657==--
