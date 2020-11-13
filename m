Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F61C388F7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Nov 2020 11:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C252224B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Nov 2020 11:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="m0diz1Ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgKMLwz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Nov 2020 06:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgKMLum (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Nov 2020 06:50:42 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F05C0617A6
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2020 03:50:35 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id w6so7453285pfu.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2020 03:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version;
        bh=kDk4k3ktWc4jZ761NQpEZTEQU25sVU04767ergPc1vc=;
        b=m0diz1Caj8PRX7P/YxjIzkKMFDiMkBx29mHLco+NTPfYZCiN4xjH/fTahCdbvhshlB
         lnu5skRqcs3DcPgDyJSNnlHPZcr8dIzJ/cmaecFZ8Wgh2X0oW/E4eqCFNaO/HhoqOBS8
         jnkAbcZ6SkJCtdBHQi4y8tMWckW+lpwDavrnCS4NXrB/9LHC9GflPu1Pw5FCSoNduAUA
         SQJyjm+oMfBXZ/jMh0aXmIN4IBwcaZukqpwhSzyU11+2sJc1EDKXEe7HMVyZdp90Ahan
         5XSUmHJ5Ze+UPQE3wjv0hBWMCwABVO4JCHSEjQ+LITEYjWb2Tfk9nZVQC4voLaq66k0M
         X4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version;
        bh=kDk4k3ktWc4jZ761NQpEZTEQU25sVU04767ergPc1vc=;
        b=MFe/jqjbWNpHhGMnVJ8m5GlHibiz1+9QxUOnUXcxsVnAJ1eLFg8PfItlTmpHColLP0
         BcHfRKLPJkdypHQK3jgaD416x8IwVOO3cUM1+RHeW3OBrfuASi4HggUpfHivX0FQbr00
         8XAC6+oV48jxskEomnTnFuzRUe+6WEeU2DCYq4qbpnjmCCr0azfN/+trK2UUAFkYjZnc
         MMnuVxkniesFZuAT2v8kB0dQwK7qS6gx/TfZZxjtZr0vjVKy3PxuYOELQlRBxw2ttn0i
         JajY/eR//HR8PIT74XThzxLUpQMIK2bjl7t5TvPzJSHNg+wqknPnlqL7cqoVfFFBwTnX
         nVOA==
X-Gm-Message-State: AOAM5319BXpuHFO6/iKSkTHK/DVdneUnX4ehNiKBVXtcnAuzA1Nit0kH
        /yvyRmRcdoMy2c16ZnElQguq1A==
X-Google-Smtp-Source: ABdhPJwMxOupwStmBP/iF82tceehZlMJCrat49gtrMKdE26wwaU/sRWLaPsJJ441sZI/DFFnWQtOmQ==
X-Received: by 2002:aa7:8586:0:b029:18c:3aa6:b8bb with SMTP id w6-20020aa785860000b029018c3aa6b8bbmr1651535pfn.39.1605268235333;
        Fri, 13 Nov 2020 03:50:35 -0800 (PST)
Received: from debian ([122.164.70.52])
        by smtp.gmail.com with ESMTPSA id u24sm10485501pfm.81.2020.11.13.03.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 03:50:34 -0800 (PST)
Message-ID: <4fcb3c2f343eb1eafb2e5c95acc44fbab74a31f0.camel@rajagiritech.edu.in>
Subject: [ERROR] Bluetooth: hci0: don't support firmware
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        matthias.bgg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Date:   Fri, 13 Nov 2020 17:20:30 +0530
Content-Type: multipart/mixed; boundary="=-1/CxL7Ya9sTnZ3nBk02A"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--=-1/CxL7Ya9sTnZ3nBk02A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

hello,

i got this stuff from "sudo dmesg -l err"
------------------------x--------------------------x----
[   40.919919] Bluetooth: hci0: don't support firmware rome 0x31010100
-------------------------x-------------------------x----

$uname -a
Linux debian 5.10.0-rc3+ #1 SMP Thu Nov 12 23:37:27 IST 2020 x86_64
GNU/Linux
$

$sudo hcitool dev
Devices:
$

GNU C               	10
GNU Make            	4.3
Binutils            	2.35.1
Util-linux          	2.36
Mount               	2.36
Bison               	3.7.3
Flex                	2.6.4
Dynamic linker (ldd)	2.31
Procps              	3.3.16
Kbd                 	2.3.0
Console-tools       	2.3.0
Sh-utils            	8.32
Udev                	246

file bstatus.txt attached.


Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

-- 
software engineer
rajagiri school of engineering and technology -  autonomous



--=-1/CxL7Ya9sTnZ3nBk02A
Content-Disposition: attachment; filename="bstatus.txt"
Content-Type: text/plain; name="bstatus.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

4pePIGJsdWV0b290aC5zZXJ2aWNlIC0gQmx1ZXRvb3RoIHNlcnZpY2UKICAgICBMb2FkZWQ6IGxv
YWRlZCAoL2xpYi9zeXN0ZW1kL3N5c3RlbS9ibHVldG9vdGguc2VydmljZTsgZW5hYmxlZDsgdmVu
ZG9yIHByZXNldDogZW5hYmxlZCkKICAgICBBY3RpdmU6IGFjdGl2ZSAocnVubmluZykgc2luY2Ug
RnJpIDIwMjAtMTEtMTMgMTY6MDg6NTggSVNUOyA1NG1pbiBhZ28KICAgICAgIERvY3M6IG1hbjpi
bHVldG9vdGhkKDgpCiAgIE1haW4gUElEOiA1ODIgKGJsdWV0b290aGQpCiAgICAgU3RhdHVzOiAi
UnVubmluZyIKICAgICAgVGFza3M6IDEgKGxpbWl0OiA0MDE1KQogICAgIE1lbW9yeTogMi45TQog
ICAgIENHcm91cDogL3N5c3RlbS5zbGljZS9ibHVldG9vdGguc2VydmljZQogICAgICAgICAgICAg
4pSU4pSANTgyIC91c3IvbGliZXhlYy9ibHVldG9vdGgvYmx1ZXRvb3RoZAoKTm92IDEzIDE2OjA4
OjU0IGRlYmlhbiBibHVldG9vdGhkWzU4Ml06IHNyYy9tYWluLmM6cGFyc2VfY29udHJvbGxlcl9j
b25maWcoKSBLZXkgZmlsZSBkb2VzIG5vdCBoYXZlIGtleSDigJxMRVNjYW5JbnRlcnZhbENvbm5l
Y3TigJ0gaW4gZ3JvdXAg4oCcQ29udHJvbGxlcuKAnQpOb3YgMTMgMTY6MDg6NTQgZGViaWFuIGJs
dWV0b290aGRbNTgyXTogc3JjL21haW4uYzpwYXJzZV9jb250cm9sbGVyX2NvbmZpZygpIEtleSBm
aWxlIGRvZXMgbm90IGhhdmUga2V5IOKAnExFU2NhbldpbmRvd0Nvbm5lY3TigJ0gaW4gZ3JvdXAg
4oCcQ29udHJvbGxlcuKAnQpOb3YgMTMgMTY6MDg6NTQgZGViaWFuIGJsdWV0b290aGRbNTgyXTog
c3JjL21haW4uYzpwYXJzZV9jb250cm9sbGVyX2NvbmZpZygpIEtleSBmaWxlIGRvZXMgbm90IGhh
dmUga2V5IOKAnExFTWluQ29ubmVjdGlvbkludGVydmFs4oCdIGluIGdyb3VwIOKAnENvbnRyb2xs
ZXLigJ0KTm92IDEzIDE2OjA4OjU0IGRlYmlhbiBibHVldG9vdGhkWzU4Ml06IHNyYy9tYWluLmM6
cGFyc2VfY29udHJvbGxlcl9jb25maWcoKSBLZXkgZmlsZSBkb2VzIG5vdCBoYXZlIGtleSDigJxM
RU1heENvbm5lY3Rpb25JbnRlcnZhbOKAnSBpbiBncm91cCDigJxDb250cm9sbGVy4oCdCk5vdiAx
MyAxNjowODo1NCBkZWJpYW4gYmx1ZXRvb3RoZFs1ODJdOiBzcmMvbWFpbi5jOnBhcnNlX2NvbnRy
b2xsZXJfY29uZmlnKCkgS2V5IGZpbGUgZG9lcyBub3QgaGF2ZSBrZXkg4oCcTEVDb25uZWN0aW9u
TGF0ZW5jeeKAnSBpbiBncm91cCDigJxDb250cm9sbGVy4oCdCk5vdiAxMyAxNjowODo1NCBkZWJp
YW4gYmx1ZXRvb3RoZFs1ODJdOiBzcmMvbWFpbi5jOnBhcnNlX2NvbnRyb2xsZXJfY29uZmlnKCkg
S2V5IGZpbGUgZG9lcyBub3QgaGF2ZSBrZXkg4oCcTEVDb25uZWN0aW9uU3VwZXJ2aXNpb25UaW1l
b3V04oCdIGluIGdyb3VwIOKAnENvbnRyb2xsZXLigJ0KTm92IDEzIDE2OjA4OjU0IGRlYmlhbiBi
bHVldG9vdGhkWzU4Ml06IHNyYy9tYWluLmM6cGFyc2VfY29udHJvbGxlcl9jb25maWcoKSBLZXkg
ZmlsZSBkb2VzIG5vdCBoYXZlIGtleSDigJxMRUF1dG9jb25uZWN0dGltZW91dOKAnSBpbiBncm91
cCDigJxDb250cm9sbGVy4oCdCk5vdiAxMyAxNjowODo1OCBkZWJpYW4gc3lzdGVtZFsxXTogU3Rh
cnRlZCBCbHVldG9vdGggc2VydmljZS4KTm92IDEzIDE2OjA4OjU4IGRlYmlhbiBibHVldG9vdGhk
WzU4Ml06IFN0YXJ0aW5nIFNEUCBzZXJ2ZXIKTm92IDEzIDE2OjA5OjAwIGRlYmlhbiBibHVldG9v
dGhkWzU4Ml06IEJsdWV0b290aCBtYW5hZ2VtZW50IGludGVyZmFjZSAxLjE4IGluaXRpYWxpemVk
Cg==


--=-1/CxL7Ya9sTnZ3nBk02A--

