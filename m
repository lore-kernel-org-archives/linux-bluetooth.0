Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795253503;
	b=VcjtiZPqBTEM3EMH+Sf96p7lfYE4rERCPrev1bYOybhDDR6QYV0kVwvyD8C6A70aZ0js
	 tR4p7PVDSZarAk93RpsVhtQuXtC+AUdA8f2cFaCO22zziFt+n5U1tf1/lMdjweQt+Zau0
	 VKJDm47KC9IV2jsbwvXNIFFPt5hdtI7oX65mSE3ZBFYic3rVWmcdl6G/1C1LvDqoqu+e7
	 2GG6N94/C5uNk8HXkRTfSdcLpY9Tf4si8N9vfXGh3DJa8BWN41D2gfitcSxGsIW5bLSlY
	 f4oqDGyzwbn9EO3I7Fil2eWsPbQpZG/E1Juorqu/Wb6OdO6ZCxi1MEy415SrWK4qctQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795253503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=kZxP/NTxeJ/pECNT8p8FubrpWjy4l7WPBOr3C/+cNWo=;
	b=nZvp0NnGZW9DA+yJ5sAP6YpYjIwRHdqod57QxMoe0pp+UAUDrT2UNnSXflfAxnsNQp98
	 Kds4xfCUeBA9BXxXxY48+aJWGTYyi+2nPNhZttPrjNba7PkI3oYrap9w5Rrdop+ebG52N
	 uz2+7EiMhpyqmrvPqAxniKi6oLRwd7sTvYbGL7xaR3oLu9uLs3CcBuc0BUPfHPjdwjngA
	 QWWIOnEJXILhauhyBuokNiZZANOXoBg/gogquNS7LkKwO5MRuQPZJL6T/g65SMLJbkyij
	 eu73In7CEjeMFFDoSSYgXousTd9O0f+toXafjwapTXbxjuV7sqD2mihglpuzO+X2gjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4eoNDzl;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE0606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 09:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BBE0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4eoNDzl
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-5642e0910a3so836567b6e.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 01:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795253502; x=1795858302; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kZxP/NTxeJ/pECNT8p8FubrpWjy4l7WPBOr3C/+cNWo=;
        b=k4eoNDzlkIZpzdAyLjnWc8A0xxgqIP5kFuhREVfSbNKlP+73mCk3h1xGMcNzoPmUcd
         AZNE+cZpuFktPQCkzLdrCOk0OeaScZE2YWRJc17V2D78L63PJ8kJvaHrHNgIGi/acebF
         k+lwUULhFTZaWzVdQelKL8g3v+uuMwGFRCS31tMxuTJnPoJJMRQi8/HaaKKbwcmq7D4P
         0C3i5t0qSJlzby4Lf+F1/ovgbdO2cUtQ2A3NM3qKPAzOfpDqnnHSMMuCuij/dCczKBvW
         8bKqNb5Sm7xn6j60bvdmJ3ypEH/u0HaT8X271cl1MyzN5qbzpIhcxV3LJ466snKRvyYH
         hMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795253502; x=1795858302;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kZxP/NTxeJ/pECNT8p8FubrpWjy4l7WPBOr3C/+cNWo=;
        b=SXD9wdMNzz0M9EnbIa8txVparIrQwTyuyYbWvy4KIUC2GEKhKzqI7l6DwpM8HHqzCK
         SQX32qavUqYpB9ZHkdECk2hLuynqoXAoOkQEOmrrVBbsRqGkYdl8xfpzwVN9pTHb7WsD
         n7p1P+pXho4JueI5geBOxSbUMZl+OsHYOpmAQr6PUKdoifTGRZy0fJ6Pqdva6zrddvW4
         3EuctKnIjk9I6HUFQFj01PCAWw4lf4KSXQ0Zlo5Sz8htvOETViyZ6+zzQen4sR9AJjcY
         VY12HYObIvt+RQ8Obqheb8kVogf9QopdLM/x02XUF1jta89q13kH+HDMwif8oOHQT1Rw
         Rpqw==
X-Gm-Message-State: APuU4Z/QgCipjcbQj9WNdRq2snB2aHSnZOwavHtxI8W68bGVL62DQvqr
	dbvbFKwhg+WTI2Xp7Dh5v53c0M1TkQME35bK3HhlJ5E74PXcHbRAI2djc2WaK8j4
X-Gm-Gg: AZFdTZdYvkl916wnNQGhM2nb+EPIv8lrEzfMiOJBsq/cCaB5rIjEMujBO+0HZXqAM6c
	q9KhZjpTEWc+PQCpNNkfkqD867UqL470Ol3xG8lqWXm8wUcGR6skg/Kxs6s2QEVBY8Py+Rd8gRG
	LtwCZqTmz/WsmDEc8x0JAYmix45TdGs7kq2R8w8ZBPEBZ06HhBPElO1SR9dealYMwz1CRklLvX/
	lDnv+eaFOh+TV6JEulAQBCHpSO6jPFtbk2c+/hkBN6ecqB2phwa9LA31KiMGeAGczXaYH7FsCk2
	bZjF7WavJVBpG/R7F7XFFcT8nSOYa+7Kiu5oV4j6fts8JWA6A+vr74ZoVHuPX2N7a1eVGOAPzCq
	8YdbLD/E2Pz1S1W3e8wPBxv1c7tyZeieGTDI+ndbtmFH58irQ1dedrdRbwajYTY44vitcTdoEAe
	Qzxph7SNKa+aqqxxN25Qba743kEgtbs6f1v/xbIM8FWKMnsCwitMqaXIPxCAYt62u+LJcWVufHv
	HvCm/YZin4vA1kYuyKchRV3dU+CuxbN/WoHzOdxhU0FL2qvVj8bQdYEaxg112wd
X-Received: by 2002:a05:6808:bc6:b0:572:e8bb:4f51 with SMTP id 5614622812f47-57a0cadfae5mr6228191b6e.56.1795253501896;
        Sat, 21 Nov 2026 01:31:41 -0800 (PST)
Received: from [172.17.0.2] ([40.124.227.100])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a34252251sm4368760b6e.6.2026.11.21.01.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 01:31:41 -0800 (PST)
Message-ID: <6b0164fd.a8342903.a6b10.352d@mx.google.com>
Date: Sat, 21 Nov 2026 01:31:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7151695938971930648=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: MGMT: Fix pending command races
In-Reply-To: <pm-bluetooth-objects-candidate-0167-v9-45c99868af18e41665a3-1@gmail.com>
References: <pm-bluetooth-objects-candidate-0167-v9-45c99868af18e41665a3-1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7151695938971930648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217952/

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.78 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      18.62 seconds
CheckAllWarning               PASS      21.13 seconds
CheckSparse                   PASS      22.86 seconds
BuildKernel32                 PASS      19.91 seconds
CheckKernelLLVM               PASS      20.53 seconds
TestRunnerSetup               PASS      438.39 seconds
TestRunner_mgmt-tester        PASS      82.77 seconds
TestRunner_mesh-tester        PASS      4.07 seconds
IncrementalBuild              PASS      23.10 seconds



https://github.com/bluez/bluetooth-next/pull/1175

---
Regards,
Linux Bluetooth


--===============7151695938971930648==--
