Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CFBC001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 13:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGXNSA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jul 2023 09:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGXNR7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jul 2023 09:17:59 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7217F5
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 06:17:57 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63d0228d32bso5168866d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690204677; x=1690809477;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G1qOWD6ZuDg+IgHfZniO/yUpuoG28FfyuehXWQTWUpQ=;
        b=cpOeVip8wVV3R3gASPZxUvQSeHC0woRxkZylU5Fh/HtSfTlYExbwbS5cHRfP8DyXoH
         VSYKM/6Bv9rwVY6gjdqrLfTaydXGDRJBNRlGoC90Y58CqOtngxyB3C1bAHcOvxUnJUTa
         w0sUmdwALhxrY5ho2MGfarld2o1/SZSGiY73ap34gDo7qwQ3gmSdnO6/8Fl5gdyK3Mp2
         7tYJymrmbQflp4fH4gA+zvUmE/jCr1G9HbIAV5c0jtdnRCCjvtAoXYC7TqS+WaXPLzWO
         q5QAqNQ5V7Hzvoz/1Pif46uXeYNZDmKUJA7rZMb/39uiZ97UKAhXQrA8ciFxzLIPOt03
         vNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690204677; x=1690809477;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1qOWD6ZuDg+IgHfZniO/yUpuoG28FfyuehXWQTWUpQ=;
        b=YSeWHYKr1zaj0GqHfZfZ6Tg0voGUypmPb9GLe0oSD2h/nX+tmJ60cuyQZFQY/O73ct
         avAtOx0kNUxU/CASkSBavTTscWDhHVcNLN9JPpue5uHQAls3LGQw+e9QuadywXmPQtlX
         BwUgOCP00UACvWJRBf9asauE/1qYsER4wOvuqtcqOt3X8mFK7k6+x2Js0Me/51/mycSs
         UuifioSJ4BaohUqGOTFH4Y+b9he/2HvaZE5i33YIssExhGH3lqLnt/Cvci3hpMPSKQWd
         CGKmnPLb8fAwkaVJ9sDaGkE/716OTrsicWg8Qh3o9d5jmj1JHwssVcB7F0vSaWTc6O67
         RWiA==
X-Gm-Message-State: ABy/qLZEfMDCRXfBTjueiQIcHYo9x0Hx2mLruUXTkkYlJ6S47F1WVNZy
        VLbXC2CTwLh4YZtTHl6aPIoA0xu22bY=
X-Google-Smtp-Source: APBJJlE7XZKPJTqsQVvkEPhGUldnBIjYEol4jFXbOPH0+tHgSZFh4oEa14n/NJ2Nw4ibnn7JGb5NgQ==
X-Received: by 2002:a0c:f1d0:0:b0:63d:5f5:a66b with SMTP id u16-20020a0cf1d0000000b0063d05f5a66bmr1372864qvl.65.1690204676716;
        Mon, 24 Jul 2023 06:17:56 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.206.81])
        by smtp.gmail.com with ESMTPSA id e17-20020a0caa51000000b0063ce736180bsm2174210qvb.112.2023.07.24.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:17:56 -0700 (PDT)
Message-ID: <64be7a04.0c0a0220.85f6.6cf5@mx.google.com>
Date:   Mon, 24 Jul 2023 06:17:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6989155158655525299=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230724123637.2877393-2-quic_tjiang@quicinc.com>
References: <20230724123637.2877393-2-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6989155158655525299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NzY4ODg0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS45OSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjY3IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMjYgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MzMuMzkgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBQQVNTICAgICAgMzYu
NTQgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgNDEuOTEg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTEzLjE5IHNl
Y29uZHMKQnVpbGRLZXJuZWwzMiAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDMyLjY2IHNlY29u
ZHMKVGVzdFJ1bm5lclNldHVwICAgICAgICAgICAgICAgUEFTUyAgICAgIDQ5NS4xMCBzZWNvbmRz
ClRlc3RSdW5uZXJfbDJjYXAtdGVzdGVyICAgICAgIFBBU1MgICAgICAyMy44MCBzZWNvbmRzClRl
c3RSdW5uZXJfaXNvLXRlc3RlciAgICAgICAgIFBBU1MgICAgICA0My4xMCBzZWNvbmRzClRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICAxMC42NyBzZWNvbmRzClRlc3RSdW5u
ZXJfbWdtdC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICAyMTguMzggc2Vjb25kcwpUZXN0UnVubmVy
X3JmY29tbS10ZXN0ZXIgICAgICBQQVNTICAgICAgMTYuMjggc2Vjb25kcwpUZXN0UnVubmVyX3Nj
by10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgMTcuMTcgc2Vjb25kcwpUZXN0UnVubmVyX2lvY3Rs
LXRlc3RlciAgICAgICBQQVNTICAgICAgMTguMTcgc2Vjb25kcwpUZXN0UnVubmVyX21lc2gtdGVz
dGVyICAgICAgICBQQVNTICAgICAgMTMuNTYgc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10ZXN0ZXIg
ICAgICAgICBQQVNTICAgICAgMTQuNjQgc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFuLXRlc3Rl
ciAgICBQQVNTICAgICAgMTEuMjcgc2Vjb25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAg
ICBGQUlMICAgICAgMjQuMjggc2Vjb25kcwoKRGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMKVGVzdDogSW5jcmVtZW50YWxCdWlsZCAtIEZBSUwKRGVzYzogSW5jcmVtZW50YWwg
YnVpbGQgd2l0aCB0aGUgcGF0Y2hlcyBpbiB0aGUgc2VyaWVzCk91dHB1dDoKW3YxMSwxLzJdIEJs
dWV0b290aDogaGNpX3FjYTogQWRkIHN1cHBvcnQgZm9yIFF1YWxjb21tIEJsdWV0b290aCBTb0Mg
UUNBMjA2NgoKZHJpdmVycy9ibHVldG9vdGgvaGNpX3FjYS5jOiBJbiBmdW5jdGlvbiDigJhxY2Ff
c2V0dXDigJk6CmRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9xY2EuYzoxNzY3OjM6IGVycm9yOiDigJhz
b2NfbmFtZeKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKIDE3Njcg
fCAgIHNvY19uYW1lID0gImFyMzAweCI7CiAgICAgIHwgICBefn5+fn5+fgpkcml2ZXJzL2JsdWV0
b290aC9oY2lfcWNhLmM6MTc2NzozOiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBp
cyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgptYWtl
WzRdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjQzOiBkcml2ZXJzL2JsdWV0b290aC9o
Y2lfcWNhLm9dIEVycm9yIDEKbWFrZVszXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ3
NzogZHJpdmVycy9ibHVldG9vdGhdIEVycm9yIDIKbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2Vm
aWxlLmJ1aWxkOjQ3NzogZHJpdmVyc10gRXJyb3IgMgptYWtlWzJdOiAqKiogV2FpdGluZyBmb3Ig
dW5maW5pc2hlZCBqb2JzLi4uLgptYWtlWzFdOiAqKiogWy9naXRodWIvd29ya3NwYWNlL3NyYy9z
cmMvTWFrZWZpbGU6MjAyMDogLl0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjIzNDogX19z
dWItbWFrZV0gRXJyb3IgMgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============6989155158655525299==--
