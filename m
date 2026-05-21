Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43BA37C91B
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356886; cv=none; b=Zolm9ARfh0ArhNmhMC8n66m7dMpnQLvy3FVFWw3m9n9NAf1CAyM5EKcpVAkyvj2C0QShkbIkuNuq1aAurANbzBSjgH5LD2RAH7RJfoLLbjpdO4eHWzVHU5bM794ZvHZL/d6xDzVUmIC3P37Ict/iyIsPe+HHTjVHmyfmWDWhePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356886; c=relaxed/simple;
	bh=XLDE8xRuy+InTgOYMa+wE4f7qGk2i6To9dGH1ICIaZ8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MY+P3kypms84Bmyhv49o0JhiLpFSCPkxgoU3g5xNOiHI5Ho/lXKBPiFX0BQiTyccRvP2tnsPUP0JagVjHgYLusCOzK0YKK3/uZ6C+LilzTE/oN9djpOfUzzwc/5bZe+7pG2r45uLrxqKEZC6oaP9yH0vH4C+kleXy0T5/uJF7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpGUX4vR; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpGUX4vR"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso4122047eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779356884; x=1779961684; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XLDE8xRuy+InTgOYMa+wE4f7qGk2i6To9dGH1ICIaZ8=;
        b=UpGUX4vRSiQ8HF/ugaGupouFJacVlpFOZ4uo+A3GJpBUUrvBhW+zy8BDqEsEzEpOjT
         NdsLMopekK+3kPuf1FzJwpmHEISKqS1rWQNddblJXJtLmlGfdWZ5kICUPCgMxj8SJIzE
         /9M3qjUgMLX8ZgS557u7LNXoyOX/7u78QsKjg06RGcwR1MvxoJU2BiL+47dr+YVxs3Lo
         YvE2P0PUC58/CwgO9EYEqPGvIpGHqQWDW6uSKDUJMJpaXSDw3xrJ1gPhgvLFXE4lVtrE
         5Crmwn5V0hWE2NMx8MVwZRIE+dhZeHBfCI2+6v4JY9iYathIx0y4H3yNtJYY6lY0+N0s
         XPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779356884; x=1779961684;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLDE8xRuy+InTgOYMa+wE4f7qGk2i6To9dGH1ICIaZ8=;
        b=qMXfk2Cy5UhgJYT+/dxUAFZoQCF7CfYcySOguDWoR1RMYQ6b8qqZnGsY0U98fetM64
         Uik18ysOPpRfYn8cBiXOqfvoIdhThmI+ROokzDTEziosjBreUCUIxXiHusbY8NPX3yJ4
         C1HrIJ039XlTWWFiGXVYVRIC153oB6cnbFSOLb2xTd3hT97Spo6FyKB/l3Jtg+CqhzpX
         ZCqxGuSC0R1xylNO8qCw36Te7ejjKbEXJ6cMeNXpBMMZw5pceOFviBZJvl4fiqAWJDxc
         YM9XuYuN/qsruK0ANzBkCS8sOiayi4H8Q3nCV7A9PxK9IQz8F08ZQYEXdMBiSGNOh7Np
         dGSA==
X-Gm-Message-State: AOJu0Yw/mebS0KJvDl+3r9rti+lmhiRMRuPyIVGIkkmeWIU2OmqG1Wdo
	8s3UGR4LGQCwGLpIWFx57B0M5QH53fei4p0B53VH3+CRkF2Wzk3PPxoN7ykKtQ==
X-Gm-Gg: Acq92OFbVIKq/d4eV/YqdZRm83uzuNgR1hmI859j+Dd49SEPFUXBldt1zLCVWriA5z8
	P41p/tWtm8IWHmERz8j/tHXADT1+YGMKsxjan0xFEHHkrlVfFiI1cynJdONw7bIhdmJDtcPdaeV
	9k54E35/lmTmHgSxDxJqpeFSzm0D4+2IhLFcabgpfQP02attrB9PkUNTCiEmHrasRx56sPBl5tb
	VeQSO25AeKBCUHUJIl4aK3b2Q6O78Br0MNVrW1iwrNyli1jrAZn/05xq8N3/1ox3Ct+rmypxahl
	qJ0mbs+Ukz3RU798rgCOp+ufwRQ9/CEXOveRLdqPGE3hoOH07fgwe/m5TLCOscB6V3++vbNooPv
	JENRb1huOa79LRIeJqCDaSPNMaAlsUAnvsoU6lfqsgjOFh1660PGhg2lUmWUp/NCR+YV3YVMgnz
	+L3BU+AIsMTdb1fawdlYuEWFt/1yA/qDfY2Jfn6yg7ZX0=
X-Received: by 2002:a05:7300:478d:b0:2be:17b1:e49f with SMTP id 5a478bee46e88-304304f77d6mr958654eec.4.1779356883810;
        Thu, 21 May 2026 02:48:03 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.216.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3044359ecaesm74788eec.25.2026.05.21.02.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 02:48:03 -0700 (PDT)
Message-ID: <6a0ed4d3.fb9e70e9.1b46bc.15ca@mx.google.com>
Date: Thu, 21 May 2026 02:48:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8186490371161186244=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kx960506@163.com
Subject: RE: [BlueZ] doc: Fix Data Path direction in btmin-le-audio.rst
In-Reply-To: <20260521060919.2124-1-kx960506@163.com>
References: <20260521060919.2124-1-kx960506@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8186490371161186244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTA5ODQ2OAoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgUEFTUyAgICAgIDAuMzIgc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBQ
QVNTICAgICAgMC4yNSBzZWNvbmRzCkJ1aWxkRWxsICAgICAgICAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAyMC4yMiBzZWNvbmRzCkJsdWV6TWFrZSAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAg
ICA2NDYuNzkgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTguNjYgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjMw
LjczIHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI5Mi4y
MCBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzNTQuMDcg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTgxLjcxIHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDY0OC4wNCBzZWNv
bmRzClNjYW5CdWlsZCAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxMDIxLjEwIHNlY29u
ZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VDaGVj
ayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sKT3V0cHV0OgoKbWFrZVszXTogKioq
IFtNYWtlZmlsZToxMDIzOTogdGVzdC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTogKioqIFtN
YWtlZmlsZToxMDM0NzogY2hlY2stVEVTVFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmls
ZToxMDgxODogY2hlY2stYW1dIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToxMDgyMDogY2hl
Y2tdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VEaXN0
Y2hlY2sgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIERpc3RjaGVjawpPdXRwdXQ6CgptYWtl
WzRdOiAqKiogW01ha2VmaWxlOjEwMjM5OiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3IgMQptYWtlWzNd
OiAqKiogW01ha2VmaWxlOjEwMzQ3OiBjaGVjay1URVNUU10gRXJyb3IgMgptYWtlWzJdOiAqKiog
W01ha2VmaWxlOjEwODE4OiBjaGVjay1hbV0gRXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2VmaWxl
OjEwODIwOiBjaGVja10gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjEwNzQxOiBkaXN0Y2hl
Y2tdIEVycm9yIDEKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrVmFs
Z3JpbmQgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrIHdpdGggVmFsZ3JpbmQKT3V0
cHV0OgoKdG9vbHMvbWdtdC10ZXN0ZXIuYzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToKdG9vbHMv
bWdtdC10ZXN0ZXIuYzoxMjk5MDo1OiBub3RlOiB2YXJpYWJsZSB0cmFja2luZyBzaXplIGxpbWl0
IGV4Y2VlZGVkIHdpdGgg4oCYLWZ2YXItdHJhY2tpbmctYXNzaWdubWVudHPigJksIHJldHJ5aW5n
IHdpdGhvdXQKMTI5OTAgfCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogICAgICB8
ICAgICBefn5+Cm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTAyMzk6IHRlc3Qtc3VpdGUubG9nXSBF
cnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTAzNDc6IGNoZWNrLVRFU1RTXSBFcnJvciAy
Cm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTA4MTg6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2U6ICoq
KiBbTWFrZWZpbGU6MTA4MjA6IGNoZWNrXSBFcnJvciAyCgoKaHR0cHM6Ly9naXRodWIuY29tL2Js
dWV6L2JsdWV6L3B1bGwvMjE0MAoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============8186490371161186244==--
