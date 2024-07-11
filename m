Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19F653
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720666853; cv=none; b=nBEuQsb6nWIwDAcwDyz2sYvfXdfTcd81jTLVtqyAQA07AOGpRNdIuBLMpbwMvwM+6lmHMCQKQqBlQS4qw695yaOtV43qYPPG0Eph1IO8K+6ugH+0uhmyNOffLAzW2YWgI1dI/xYs2iARGwGvN1vGKQC11JJWlnCaNoaWoPRhFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720666853; c=relaxed/simple;
	bh=G6piUQ6R4OffaHVM9FY/NiA5Mz9MRYqSFNKuNwNjBbk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FuzZBNk7iNvBuRKRSJH2doBoqpP8+8ekCGwOhgxgIWX7MDNuiqrTG7+Tz1EcMJl4aMaOqEB+XvWRB/jUnDpYZdDV7KLWrKYjD3z6vrVJ+mmXagMlKqQCpCr4qwgg/pqY3ryfpdkNMoO75XrNyTklMouKpIibA7+tmL+ig7Gh//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il+tfZmP; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il+tfZmP"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ad8243dba8so2710466d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 20:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720666851; x=1721271651; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G6piUQ6R4OffaHVM9FY/NiA5Mz9MRYqSFNKuNwNjBbk=;
        b=Il+tfZmPNipmUljWuB2oD0MiwA1pmlT0tVt4vWSWJt6jpvvldXHoisl2fGDyY+QRy4
         Ga4UCcsPSE8Sbl0YIHe5OUdxQdInCzZmZRtE0n9MVH7jV6GfQQUtGecIbSjsT5EDIIqB
         +IzreqzQ9k95f6QN47ejG4x1UXDWbdj7yyXl6YILkuhxf680bYF+/Yuy68bzdk1KQ0lB
         uzptLkcZzutVjzgSo9QRIb1JUttG4tbDGbCuYk2EdogYUdjvG89W3gzS2QZFxiUbKexJ
         rJFHp0wGUDslKPuYum0Vd9IL2Q919nF5hktvhPKoVZO1oLoYM55M5pKzAZ5MEhzUUXhe
         hl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720666851; x=1721271651;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6piUQ6R4OffaHVM9FY/NiA5Mz9MRYqSFNKuNwNjBbk=;
        b=G2N+mfdx4fWwt0IMS/XUFklrfPOLcHJcJXZFIinqADHOr5riqbmPlAZFGovzA4KwMC
         8awTfxwxfFE22fCwfTJBfIoGPEyyswPOfk6ogQk0cRw04L8LGdcHNXa7aQJBHp4niaoJ
         pjL6QlBz3tf8Dl7RglVpFgngk+2nx60zaFzScJ7Z9nGWruIqW3d0TChZARalLdJEkuys
         QL8kAWgMkoS+lTVmt6JZWU6nF/HjhCN2tHO0N/fSpyICWn2rSzrEbp2muR3RCBI3dMts
         qnL2yfXwQFwXsxDvWEF1e0IdfMFqEm1JbgdjRp70Et1i5hGLUWvIneyqqiPKCEYIpPB1
         j5KQ==
X-Gm-Message-State: AOJu0YzmY5JfHTLF/yaQBwsq6uwC6dKCWcckw/JKqrSqmv+NdGXptHO9
	XMi8EIBeok/zDWmpKp9jjHUaOt82NHFJzGFaeJcSQtSqeOz6i67B2Cps3Q==
X-Google-Smtp-Source: AGHT+IEYMasZNmi0uYR4o2KX847wUi2N9Gz31jO5q+mjycy1x/fJ/E8NXMIXXSDE4Zo0zttasZhXAQ==
X-Received: by 2002:a05:6214:124f:b0:6b5:ec27:886a with SMTP id 6a1803df08f44-6b61bc7e7c1mr95407546d6.4.1720666850927;
        Wed, 10 Jul 2024 20:00:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.55.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9f1694sm22000606d6.50.2024.07.10.20.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 20:00:50 -0700 (PDT)
Message-ID: <668f4ae2.050a0220.82d5.9c2b@mx.google.com>
Date: Wed, 10 Jul 2024 20:00:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1460999080430267805=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_qca: Fix build error
In-Reply-To: <20240711023256.3546349-1-luiz.dentz@gmail.com>
References: <20240711023256.3546349-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1460999080430267805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODcwMzAwCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC42NyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjM0IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTMgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MzYuNzEgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBXQVJOSU5HICAgMzIu
MTkgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMzcuNjUg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMTAxLjc5IHNl
Y29uZHMKQnVpbGRLZXJuZWwzMiAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDI4LjYyIHNlY29u
ZHMKVGVzdFJ1bm5lclNldHVwICAgICAgICAgICAgICAgUEFTUyAgICAgIDUyNi4xOCBzZWNvbmRz
ClRlc3RSdW5uZXJfbDJjYXAtdGVzdGVyICAgICAgIFBBU1MgICAgICAyMS45OCBzZWNvbmRzClRl
c3RSdW5uZXJfaXNvLXRlc3RlciAgICAgICAgIFBBU1MgICAgICAzNi42NiBzZWNvbmRzClRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA0Ljc5IHNlY29uZHMKVGVzdFJ1bm5l
cl9tZ210LXRlc3RlciAgICAgICAgUEFTUyAgICAgIDExMi4xMiBzZWNvbmRzClRlc3RSdW5uZXJf
cmZjb21tLXRlc3RlciAgICAgIFBBU1MgICAgICA3LjQzIHNlY29uZHMKVGVzdFJ1bm5lcl9zY28t
dGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE0Ljk1IHNlY29uZHMKVGVzdFJ1bm5lcl9pb2N0bC10
ZXN0ZXIgICAgICAgUEFTUyAgICAgIDcuODUgc2Vjb25kcwpUZXN0UnVubmVyX21lc2gtdGVzdGVy
ICAgICAgICBQQVNTICAgICAgNS45MiBzZWNvbmRzClRlc3RSdW5uZXJfc21wLXRlc3RlciAgICAg
ICAgIFBBU1MgICAgICA2Ljg3IHNlY29uZHMKVGVzdFJ1bm5lcl91c2VyY2hhbi10ZXN0ZXIgICAg
UEFTUyAgICAgIDUuMDIgc2Vjb25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQQVNT
ICAgICAgMjcuODUgc2Vjb25kcwoKRGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMKVGVzdDogQ2hlY2tBbGxXYXJuaW5nIC0gV0FSTklORwpEZXNjOiBSdW4gbGludXgga2VybmVs
IHdpdGggYWxsIHdhcm5pbmcgZW5hYmxlZApPdXRwdXQ6CmRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9x
Y2EuYzogSW4gZnVuY3Rpb24g4oCYcWNhX3NlcmRldl9yZW1vdmXigJk6ZHJpdmVycy9ibHVldG9v
dGgvaGNpX3FjYS5jOjI0OTA6Mjogd2FybmluZzogZW51bWVyYXRpb24gdmFsdWUg4oCYUUNBX0lO
VkFMSUTigJkgbm90IGhhbmRsZWQgaW4gc3dpdGNoIFstV3N3aXRjaF0gMjQ5MCB8ICBzd2l0Y2gg
KHFjYWRldi0+YnRzb2NfdHlwZSkgeyAgICAgIHwgIF5+fn5+fmRyaXZlcnMvYmx1ZXRvb3RoL2hj
aV9xY2EuYzoyNDkwOjI6IHdhcm5pbmc6IGVudW1lcmF0aW9uIHZhbHVlIOKAmFFDQV9BUjMwMDLi
gJkgbm90IGhhbmRsZWQgaW4gc3dpdGNoIFstV3N3aXRjaF1kcml2ZXJzL2JsdWV0b290aC9oY2lf
cWNhLmM6MjQ5MDoyOiB3YXJuaW5nOiBlbnVtZXJhdGlvbiB2YWx1ZSDigJhRQ0FfUk9NReKAmSBu
b3QgaGFuZGxlZCBpbiBzd2l0Y2ggWy1Xc3dpdGNoXWRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9xY2Eu
YzoyNDkwOjI6IHdhcm5pbmc6IGVudW1lcmF0aW9uIHZhbHVlIOKAmFFDQV9RQ0EyMDY24oCZIG5v
dCBoYW5kbGVkIGluIHN3aXRjaCBbLVdzd2l0Y2hdZHJpdmVycy9ibHVldG9vdGgvaGNpX3FjYS5j
OjI0OTA6Mjogd2FybmluZzogZW51bWVyYXRpb24gdmFsdWUg4oCYUUNBX1FDQTYzOTDigJkgbm90
IGhhbmRsZWQgaW4gc3dpdGNoIFstV3N3aXRjaF0KIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjClRlc3Q6IENoZWNrU3BhcnNlIC0gV0FSTklORwpEZXNjOiBSdW4gc3BhcnNlIHRvb2wgd2l0
aCBsaW51eCBrZXJuZWwKT3V0cHV0Ogpkcml2ZXJzL2JsdWV0b290aC9oY2lfcWNhLmM6IEluIGZ1
bmN0aW9uIOKAmHFjYV9zZXJkZXZfcmVtb3Zl4oCZOmRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9xY2Eu
YzoyNDkwOjI6IHdhcm5pbmc6IGVudW1lcmF0aW9uIHZhbHVlIOKAmFFDQV9JTlZBTElE4oCZIG5v
dCBoYW5kbGVkIGluIHN3aXRjaCBbLVdzd2l0Y2hdZHJpdmVycy9ibHVldG9vdGgvaGNpX3FjYS5j
OjI0OTA6Mjogd2FybmluZzogZW51bWVyYXRpb24gdmFsdWUg4oCYUUNBX0FSMzAwMuKAmSBub3Qg
aGFuZGxlZCBpbiBzd2l0Y2ggWy1Xc3dpdGNoXWRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9xY2EuYzoy
NDkwOjI6IHdhcm5pbmc6IGVudW1lcmF0aW9uIHZhbHVlIOKAmFFDQV9ST01F4oCZIG5vdCBoYW5k
bGVkIGluIHN3aXRjaCBbLVdzd2l0Y2hdZHJpdmVycy9ibHVldG9vdGgvaGNpX3FjYS5jOjI0OTA6
Mjogd2FybmluZzogZW51bWVyYXRpb24gdmFsdWUg4oCYUUNBX1FDQTIwNjbigJkgbm90IGhhbmRs
ZWQgaW4gc3dpdGNoIFstV3N3aXRjaF1kcml2ZXJzL2JsdWV0b290aC9oY2lfcWNhLmM6MjQ5MDoy
OiB3YXJuaW5nOiBlbnVtZXJhdGlvbiB2YWx1ZSDigJhRQ0FfUUNBNjM5MOKAmSBub3QgaGFuZGxl
ZCBpbiBzd2l0Y2ggWy1Xc3dpdGNoXQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVz
dDogQ2hlY2tTbWF0Y2ggLSBXQVJOSU5HCkRlc2M6IFJ1biBzbWF0Y2ggdG9vbCB3aXRoIHNvdXJj
ZQpPdXRwdXQ6CmRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9xY2EuYzogSW4gZnVuY3Rpb24g4oCYcWNh
X3NlcmRldl9yZW1vdmXigJk6ZHJpdmVycy9ibHVldG9vdGgvaGNpX3FjYS5jOjI0OTA6Mjogd2Fy
bmluZzogZW51bWVyYXRpb24gdmFsdWUg4oCYUUNBX0lOVkFMSUTigJkgbm90IGhhbmRsZWQgaW4g
c3dpdGNoIFstV3N3aXRjaF1kcml2ZXJzL2JsdWV0b290aC9oY2lfcWNhLmM6MjQ5MDoyOiB3YXJu
aW5nOiBlbnVtZXJhdGlvbiB2YWx1ZSDigJhRQ0FfQVIzMDAy4oCZIG5vdCBoYW5kbGVkIGluIHN3
aXRjaCBbLVdzd2l0Y2hdZHJpdmVycy9ibHVldG9vdGgvaGNpX3FjYS5jOjI0OTA6Mjogd2Fybmlu
ZzogZW51bWVyYXRpb24gdmFsdWUg4oCYUUNBX1JPTUXigJkgbm90IGhhbmRsZWQgaW4gc3dpdGNo
IFstV3N3aXRjaF1kcml2ZXJzL2JsdWV0b290aC9oY2lfcWNhLmM6MjQ5MDoyOiB3YXJuaW5nOiBl
bnVtZXJhdGlvbiB2YWx1ZSDigJhRQ0FfUUNBMjA2NuKAmSBub3QgaGFuZGxlZCBpbiBzd2l0Y2gg
Wy1Xc3dpdGNoXWRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9xY2EuYzoyNDkwOjI6IHdhcm5pbmc6IGVu
dW1lcmF0aW9uIHZhbHVlIOKAmFFDQV9RQ0E2Mzkw4oCZIG5vdCBoYW5kbGVkIGluIHN3aXRjaCBb
LVdzd2l0Y2hdCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============1460999080430267805==--
