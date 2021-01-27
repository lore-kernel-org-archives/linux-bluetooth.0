Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06582C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 18:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE05464DAC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 18:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344259AbhA0SDk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 13:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344248AbhA0SDZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 13:03:25 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A25C061788
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 10:02:43 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id t17so2081211qtq.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 10:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vtegEomYY8EPO2f/ynQZ4XnmZp7SjSFYJaLNXB1/UMY=;
        b=cFLHnVFjTQM2Y8owcBsRdUjAWSGz/MXynM1OICme758O6EMkghsSkxaWE2Iyhm5LFA
         2n+1wb0QgSBeg/3/59CgIwmSAPwNqsAmYUZKmdhGhugh9JPmlbxUba3z7F6M1tcHy8V7
         /uSCURvF6g8tB4NUfBnC5A1sKyxkfxaf6d8g3rnl6ooj40VFJF0KmR5D5MwaL534kj1x
         FoaiVoN9xxQ/ylQAp2O10QY92UDIabeYFbxV5eSj630utmKvJfqWoZ51WZV8W65P+Emg
         Ht8D3UTLRzBzow5MohJdwvYYQnqwY7pOnAljgCJoSVzpvmHzqzuR8uZQDhZKJz6R73z6
         GT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vtegEomYY8EPO2f/ynQZ4XnmZp7SjSFYJaLNXB1/UMY=;
        b=VZAtBH2TSJ5JMfCuWiyd70O2Xuh/JT/LMPpSVQsUm6ciZIbANbWFiTy87k1gYyFEGL
         1/NG4JPL9eJkF+ldchuc77+d8zT7odAH6B/0QdnIX4IJXbT90/P7JvjkvKZJp9D1x89H
         oVfia6jNmqwizFCG1YveqcE8KzZIPvH2PGJFDLtgafYWAFkHsfHBEk04zapbI+moAHp7
         4UGfSC1BCrOBipga8EIDw+9/0t9SJotU2hCoLS8UsYUVnQvEPWI/cV3MSEI8Lib2ph1+
         WTdmbigVaRQ9mpjr1yK11jFASyqjceIPIVDUkfI1cj6PNzVXLgSnx5ViTKcWSH63gPiX
         wSlw==
X-Gm-Message-State: AOAM533oDiqFULZOsVVW5f0qtzPtl9K7XsRdvFtZLIpwmqGlLJwacnDF
        +BMngCchTIHt5tI/yjOLcMbDxco+AXLTkA==
X-Google-Smtp-Source: ABdhPJzOcLflawveJlRYlnXoDZ7nUNjgKxOfxCF7yq7KmVCMFZGCLtyBArSop5untf9kD+2Yu1s/9Q==
X-Received: by 2002:ac8:4313:: with SMTP id z19mr10724722qtm.225.1611770562272;
        Wed, 27 Jan 2021 10:02:42 -0800 (PST)
Received: from [172.17.0.2] ([40.65.196.146])
        by smtp.gmail.com with ESMTPSA id t14sm1668384qkt.50.2021.01.27.10.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 10:02:41 -0800 (PST)
Message-ID: <6011aac1.1c69fb81.c4916.acf9@mx.google.com>
Date:   Wed, 27 Jan 2021 10:02:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4647147233903435156=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Fix 32 bit Compiler Errors
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210127174050.1536152-2-brian.gix@intel.com>
References: <20210127174050.1536152-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4647147233903435156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDIzMTA5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBGQUlMCk91dHB1dDoKYWR2ZXJ0aXNpbmc6IE1ha2UgZGF0YSBzaXplIGV4cGxpY2l0
IGZvciBmb3JtYXRzCldBUk5JTkc6Q09NTUlUX0xPR19MT05HX0xJTkU6IFBvc3NpYmxlIHVud3Jh
cHBlZCBjb21taXQgZGVzY3JpcHRpb24gKHByZWZlciBhIG1heGltdW0gNzUgY2hhcnMgcGVyIGxp
bmUpCiMyNTogCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbG9uZyB1bnNpZ25lZCBpbnQKCi0gdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5p
bmdzLCA4IGxpbmVzIGNoZWNrZWQKCk5PVEU6IEZvciBzb21lIG9mIHRoZSByZXBvcnRlZCBkZWZl
Y3RzLCBjaGVja3BhdGNoIG1heSBiZSBhYmxlIHRvCiAgICAgIG1lY2hhbmljYWxseSBjb252ZXJ0
IHRvIHRoZSB0eXBpY2FsIHN0eWxlIHVzaW5nIC0tZml4IG9yIC0tZml4LWlucGxhY2UuCgoiW1BB
VENIXSBhZHZlcnRpc2luZzogTWFrZSBkYXRhIHNpemUgZXhwbGljaXQgZm9yIGZvcm1hdHMiIGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4KCk5PVEU6IElnbm9yZWQgbWVzc2FnZSB0
eXBlczogQ09NTUlUX01FU1NBR0UgQ09NUExFWF9NQUNSTyBDT05TVF9TVFJVQ1QgRklMRV9QQVRI
X0NIQU5HRVMgTUlTU0lOR19TSUdOX09GRiBQUkVGRVJfUEFDS0VEIFNQTElUX1NUUklORyBTU0NB
TkZfVE9fS1NUUlRPCgpOT1RFOiBJZiBhbnkgb2YgdGhlIGVycm9ycyBhcmUgZmFsc2UgcG9zaXRp
dmVzLCBwbGVhc2UgcmVwb3J0CiAgICAgIHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZSBDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgoKdG9vbHMvbWdtdC10ZXN0ZXI6IE1ha2UgZGF0YSBzaXpl
IGV4cGxpY2l0IGZvciBmb3JtYXRzCldBUk5JTkc6Q09NTUlUX0xPR19MT05HX0xJTkU6IFBvc3Np
YmxlIHVud3JhcHBlZCBjb21taXQgZGVzY3JpcHRpb24gKHByZWZlciBhIG1heGltdW0gNzUgY2hh
cnMgcGVyIGxpbmUpCiMxODogCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9uZyB1bnNpZ25lZCBpbnQKCi0gdG90YWw6IDAg
ZXJyb3JzLCAxIHdhcm5pbmdzLCA4IGxpbmVzIGNoZWNrZWQKCk5PVEU6IEZvciBzb21lIG9mIHRo
ZSByZXBvcnRlZCBkZWZlY3RzLCBjaGVja3BhdGNoIG1heSBiZSBhYmxlIHRvCiAgICAgIG1lY2hh
bmljYWxseSBjb252ZXJ0IHRvIHRoZSB0eXBpY2FsIHN0eWxlIHVzaW5nIC0tZml4IG9yIC0tZml4
LWlucGxhY2UuCgoiW1BBVENIXSB0b29scy9tZ210LXRlc3RlcjogTWFrZSBkYXRhIHNpemUgZXhw
bGljaXQgZm9yIGZvcm1hdHMiIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4KCk5P
VEU6IElnbm9yZWQgbWVzc2FnZSB0eXBlczogQ09NTUlUX01FU1NBR0UgQ09NUExFWF9NQUNSTyBD
T05TVF9TVFJVQ1QgRklMRV9QQVRIX0NIQU5HRVMgTUlTU0lOR19TSUdOX09GRiBQUkVGRVJfUEFD
S0VEIFNQTElUX1NUUklORyBTU0NBTkZfVE9fS1NUUlRPCgpOT1RFOiBJZiBhbnkgb2YgdGhlIGVy
cm9ycyBhcmUgZmFsc2UgcG9zaXRpdmVzLCBwbGVhc2UgcmVwb3J0CiAgICAgIHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZSBDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKCiMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja0dpdExpbnQgLSBGQUlMCk91dHB1dDoKYWR2
ZXJ0aXNpbmc6IE1ha2UgZGF0YSBzaXplIGV4cGxpY2l0IGZvciBmb3JtYXRzCjk6IEIxIExpbmUg
ZXhjZWVkcyBtYXggbGVuZ3RoICgxMzk+ODApOiAic3JjL2xvZy5oOjYwOjIwOiBlcnJvcjogZm9y
bWF0IOKAmCVsdeKAmSBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUg4oCYbG9uZyB1bnNpZ25lZCBp
bnTigJksIGJ1dCBhcmd1bWVudCA1IGhhcyB0eXBlIOKAmHVuc2lnbmVkIGludOKAmSBbLVdlcnJv
cj1mb3JtYXQ9XSIKCnRvb2xzL21nbXQtdGVzdGVyOiBNYWtlIGRhdGEgc2l6ZSBleHBsaWNpdCBm
b3IgZm9ybWF0cwo4OiBCMSBMaW5lIGV4Y2VlZHMgbWF4IGxlbmd0aCAoMTUxPjgwKTogInRvb2xz
L21nbXQtdGVzdGVyLmM6OTEyNDo1ODogZXJyb3I6IGZvcm1hdCDigJglbHXigJkgZXhwZWN0cyBh
cmd1bWVudCBvZiB0eXBlIOKAmGxvbmcgdW5zaWduZWQgaW504oCZLCBidXQgYXJndW1lbnQgMiBo
YXMgdHlwZSDigJh1bnNpZ25lZCBpbnTigJkgWy1XZXJyb3I9Zm9ybWF0PV0iCjEyOiBCMSBMaW5l
IGV4Y2VlZHMgbWF4IGxlbmd0aCAoODI+ODApOiAiICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsb25nIHVuc2lnbmVkIGludCIK
CgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tCdWlsZCAtIFBBU1MK
CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlQ2hlY2sgLSBQQVNTCgoK
Ci0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============4647147233903435156==--
