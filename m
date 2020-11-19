Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E553C388F9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 20:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0ED22202
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 20:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cf28XAmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgKSU1P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 15:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgKSU1P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 15:27:15 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C3BC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 12:27:13 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id g17so5445548qts.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 12:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kNrWE2VXRV+BBHJYRYsK/pVXikf8/S7RHt3V6vK14Ww=;
        b=cf28XAmZrUGzN68/NpQFKNq8gfXmf3fhgdKPob/DsuOaMhMdKq1eeS6x3/rXgJumOu
         mTDorSP8RhLm+4hrZYBy2J9gH/r4Lhzk7eOUROxpChPDo6Nor/tYi+opxkNBT9pH6wFy
         VlAvCiAFHqvGlhWwETaYWBb9RwsdQjm/ddSDWgVBxtI1YA7uc93THcgQVgTeyKw7T7d6
         9uOkmgoidVfvbrqYCtdOQ5Uv9dIA1uLEvFT9Zeo5zW1sATd7HWXXd7q9yOGtSzrhPpcm
         MYBmGMed3V2sF7E/nkmA++1ATy6SlYugOOS8ZcFYtyDVhddKmrNMkDhPLrcUmb+8yTn4
         gTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kNrWE2VXRV+BBHJYRYsK/pVXikf8/S7RHt3V6vK14Ww=;
        b=oth19WpFYABmJ91YstbOuBPHKDGjURLem4o/1qmrtzchYz5hNw0cwsJt0qwdG+6UJy
         Kg1XN7ITChUly/IC+9X7QS/WnxS9L02uLPdgoheyWFBefskoobm6GmrnIu0jNhZeg3xC
         BKEFVphm7iBoZYTtls5eRyzrH2oPKCfYFCHFoZ0N48G2FvyyUTJYNc2cnBW4pVyp4ErE
         4ogKmydMZo3L3BQNh61dwidgE38GZCQxOJdndIbzD1P6WZz9L3lNXspc6qR6PPXVLIQK
         U/7UgAIphwsNhi5R2K1+RdmDu9+OGwH8ctyBs/926PanniF47gvNIdSzVH2x8Y723A9Q
         lJXA==
X-Gm-Message-State: AOAM530lQPvs22svtKi/C6SV1EcUU/APa/xk1X+x7/t2CV17aHiFDH6g
        9TAOXUgUiOpT5pa0oUX3QDsoM4DBCnigqQ==
X-Google-Smtp-Source: ABdhPJw9g3HL76SwUhSLaZw7ARMnzuVomIK1iO1ArQ/kIx8iYrYZSmNN/k3c9iu+AcUJ4+svgfY16g==
X-Received: by 2002:ac8:7559:: with SMTP id b25mr12427758qtr.51.1605817632238;
        Thu, 19 Nov 2020 12:27:12 -0800 (PST)
Received: from [172.17.0.2] ([52.247.114.65])
        by smtp.gmail.com with ESMTPSA id m204sm639526qke.117.2020.11.19.12.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 12:27:11 -0800 (PST)
Message-ID: <5fb6d51f.1c69fb81.41bea.4c5d@mx.google.com>
Date:   Thu, 19 Nov 2020 12:27:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6914605169208453702=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pavelm@google.com
Subject: RE: Fix duplicate free for GATT service includes
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201119200250.3848680-1-pavelm@google.com>
References: <20201119200250.3848680-1-pavelm@google.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6914605169208453702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9Mzg3ODY3CgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBGQUlMCk91dHB1dDoKRml4IGR1cGxpY2F0ZSBmcmVlIGZvciBHQVRUIHNlcnZpY2Ug
aW5jbHVkZXMKV0FSTklORzpDT01NSVRfTE9HX0xPTkdfTElORTogUG9zc2libGUgdW53cmFwcGVk
IGNvbW1pdCBkZXNjcmlwdGlvbiAocHJlZmVyIGEgbWF4aW11bSA3NSBjaGFycyBwZXIgbGluZSkK
IzEzOiAKYmx1ZXRvb3RoZFs5NzcxXTogc3JjL2dhdHQtZGF0YWJhc2UuYzpnYXR0X2RiX3NlcnZp
Y2VfcmVtb3ZlZCgpIExvY2FsIEdBVFQgc2VydmljZSByZW1vdmVkCgpFUlJPUjpQT0lOVEVSX0xP
Q0FUSU9OOiAiZm9vKiBiYXIiIHNob3VsZCBiZSAiZm9vICpiYXIiCiMzMTogRklMRTogc3JjL2dh
dHQtZGF0YWJhc2UuYzoyMDIwOgorCQljb25zdCBjaGFyKiBpbmNsdWRlcyA9IGdfc3RyZHVwKG9i
aik7CgpXQVJOSU5HOkxJTkVfU1BBQ0lORzogTWlzc2luZyBhIGJsYW5rIGxpbmUgYWZ0ZXIgZGVj
bGFyYXRpb25zCiMzMjogRklMRTogc3JjL2dhdHQtZGF0YWJhc2UuYzoyMDIxOgorCQljb25zdCBj
aGFyKiBpbmNsdWRlcyA9IGdfc3RyZHVwKG9iaik7CisJCWlmICghaW5jbHVkZXMpCgotIHRvdGFs
OiAxIGVycm9ycywgMiB3YXJuaW5ncywgMTIgbGluZXMgY2hlY2tlZAoKTk9URTogRm9yIHNvbWUg
b2YgdGhlIHJlcG9ydGVkIGRlZmVjdHMsIGNoZWNrcGF0Y2ggbWF5IGJlIGFibGUgdG8KICAgICAg
bWVjaGFuaWNhbGx5IGNvbnZlcnQgdG8gdGhlIHR5cGljYWwgc3R5bGUgdXNpbmcgLS1maXggb3Ig
LS1maXgtaW5wbGFjZS4KCiJbUEFUQ0hdIEZpeCBkdXBsaWNhdGUgZnJlZSBmb3IgR0FUVCBzZXJ2
aWNlIGluY2x1ZGVzIiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuCgpOT1RFOiBJ
Z25vcmVkIG1lc3NhZ2UgdHlwZXM6IENPTU1JVF9NRVNTQUdFIENPTVBMRVhfTUFDUk8gQ09OU1Rf
U1RSVUNUIEZJTEVfUEFUSF9DSEFOR0VTIE1JU1NJTkdfU0lHTl9PRkYgUFJFRkVSX1BBQ0tFRCBT
UExJVF9TVFJJTkcgU1NDQU5GX1RPX0tTVFJUTwoKTk9URTogSWYgYW55IG9mIHRoZSBlcnJvcnMg
YXJlIGZhbHNlIHBvc2l0aXZlcywgcGxlYXNlIHJlcG9ydAogICAgICB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUgQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tHaXRMaW50IC0gRkFJTApPdXRwdXQ6CkZpeCBkdXBs
aWNhdGUgZnJlZSBmb3IgR0FUVCBzZXJ2aWNlIGluY2x1ZGVzCjEwOiBCMSBMaW5lIGV4Y2VlZHMg
bWF4IGxlbmd0aCAoOTA+ODApOiAiYmx1ZXRvb3RoZFs5NzcxXTogc3JjL2dhdHQtZGF0YWJhc2Uu
YzpnYXR0X2RiX3NlcnZpY2VfcmVtb3ZlZCgpIExvY2FsIEdBVFQgc2VydmljZSByZW1vdmVkIgox
MjogQjEgTGluZSBleGNlZWRzIG1heCBsZW5ndGggKDg1PjgwKTogImJsdWV0b290aGRbOTc3MV06
IHNyYy9hZGFwdGVyLmM6cmVtb3ZlX3V1aWQoKSBzZW5kaW5nIHJlbW92ZSB1dWlkIGNvbW1hbmQg
Zm9yIGluZGV4IDAiCjEzOiBCMSBMaW5lIGV4Y2VlZHMgbWF4IGxlbmd0aCAoMTAwPjgwKTogImJs
dWV0b290aGRbOTc3MV06IHNyYy9zZHBkLXNlcnZpY2UuYzpyZW1vdmVfcmVjb3JkX2Zyb21fc2Vy
dmVyKCkgUmVtb3ZpbmcgcmVjb3JkIHdpdGggaGFuZGxlIDB4MTAwMDYiCjE0OiBCMSBMaW5lIGV4
Y2VlZHMgbWF4IGxlbmd0aCAoMTAwPjgwKTogImJsdWV0b290aGRbOTc3MV06IHNyYy9nYXR0LWRh
dGFiYXNlLmM6cHJveHlfcmVtb3ZlZF9jYigpIFByb3h5IHJlbW92ZWQgLSByZW1vdmluZyBzZXJ2
aWNlOiAvc2VydmljZTEiCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENo
ZWNrQnVpbGQgLSBGQUlMCk91dHB1dDoKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBE
JyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNl
IGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNp
bmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVk
IHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25v
cmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKc3JjL2dhdHQtZGF0YWJhc2Uu
YzogSW4gZnVuY3Rpb24g4oCYcGFyc2VfaW5jbHVkZXPigJk6CnNyYy9nYXR0LWRhdGFiYXNlLmM6
MjAyMDozOiBlcnJvcjogSVNPIEM5MCBmb3JiaWRzIG1peGVkIGRlY2xhcmF0aW9ucyBhbmQgY29k
ZSBbLVdlcnJvcj1kZWNsYXJhdGlvbi1hZnRlci1zdGF0ZW1lbnRdCiAyMDIwIHwgICBjb25zdCBj
aGFyKiBpbmNsdWRlcyA9IGdfc3RyZHVwKG9iaik7CiAgICAgIHwgICBefn5+fgpzcmMvZ2F0dC1k
YXRhYmFzZS5jOjIwMjQ6NDM6IGVycm9yOiBwYXNzaW5nIGFyZ3VtZW50IDIgb2Yg4oCYcXVldWVf
cHVzaF90YWls4oCZIGRpc2NhcmRzIOKAmGNvbnN04oCZIHF1YWxpZmllciBmcm9tIHBvaW50ZXIg
dGFyZ2V0IHR5cGUgWy1XZXJyb3I9ZGlzY2FyZGVkLXF1YWxpZmllcnNdCiAyMDI0IHwgICBpZiAo
IXF1ZXVlX3B1c2hfdGFpbChzZXJ2aWNlLT5pbmNsdWRlcywgaW5jbHVkZXMpKSB7CiAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn4KSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIHNyYy9nYXR0LWRhdGFiYXNlLmM6Mjc6Ci4vc3JjL3NoYXJlZC9xdWV1
ZS5oOjI1OjQ5OiBub3RlOiBleHBlY3RlZCDigJh2b2lkICrigJkgYnV0IGFyZ3VtZW50IGlzIG9m
IHR5cGUg4oCYY29uc3QgY2hhciAq4oCZCiAgIDI1IHwgYm9vbCBxdWV1ZV9wdXNoX3RhaWwoc3Ry
dWN0IHF1ZXVlICpxdWV1ZSwgdm9pZCAqZGF0YSk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+Xn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWlu
ZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjkwMjI6IHNyYy9ibHVl
dG9vdGhkLWdhdHQtZGF0YWJhc2Uub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQwMjA6
IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtl
Q2hlY2sgLSBTS0lQUEVECk91dHB1dDoKY2hlY2tidWlsZCBub3Qgc3VjY2VzcwoKCgotLS0KUmVn
YXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============6914605169208453702==--
