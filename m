Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794766134;
	b=dNY4moTB5liCAA44Vc8Z80S8ocBXC4aKrdOqlU9EUn9CUhoTJ3op8c8myqdAtfMP2GOf
	 iJsdfymMjnm2U+ZFbwvno52RiuZgkR0MUS8HClrpfJKmAT6LD4jqdyH0PBN8iIS5VQ9oc
	 1K4wGmAexZzcZmeGOzL7trY0Y7T9VtDEOgsuVB6iN/GhQmfsmptw08MuSzUuqM88ID36v
	 HhlwOhRkm7qd3KkZkOFy4JtlggGL9n++IbxjDA9k3vRj+19cwmJ5FTFnlqr6FSR50bPYm
	 3TsnGZMWi5Z7wvgUv3xrUJGtHHyfNKYX4oOLgF1NzyLzHKHbeZqBRaJk+CDw1IqiJrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794766134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=BLKtPUQTDXoLFv72rOpGExBlBMoH+xESwylo93hfWgk=;
	b=kvzFcr09hX7R71KEh2SuUbX074d661xf6cueEE11zk9wMvVRX8Iefi2f6rBphMFi1oSG
	 SErr9Ek+FhAVRflOaHlDPFASvO3RJ03W24oF/gq/QrGpTUeEViHZ6KY6PkRVgwTnkkQ7z
	 PFCg6PNwxf57b1pwkFx9Ttvq33Ez8TJXGRGUhFmuxKZUQH6ejyGZY3qlUzxFvwN+T33iZ
	 0Fq93onyHiBWd56tY8RAoikA2TJKtbQtfCUwlHq1kLNZWQGf+69k7j940Gx4Oc4zavekw
	 Wua7BviOQ9I64DzlCSIfqTMFSFNj6qCkEQvwfRjSpDgk5DwxQ4EClZLTSpni5Qnht1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FYCCmMk7;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD7606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 18:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FFD7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FYCCmMk7
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-55bd96affd2so26577191cf.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 10:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794766133; x=1795370933; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BLKtPUQTDXoLFv72rOpGExBlBMoH+xESwylo93hfWgk=;
        b=FYCCmMk73cJqx7UNG9aN6u7z0mDz51xHCrY+FrRz/DnwfUT/k5YXFH2egfMW9UR+cO
         g+9kZgq+TDOmaMSLOePaIVJbkj7jW6NdyQ6h+KM19NzBe9pXx//yUg+5JwCKANy0qfzv
         fL2TNVLSJfGpbH8Gd9fhZNerIhA0HVCwx+Qx2QWPOwAgwUGDlTYOfr5Ht3cQLE4znkhZ
         FDkWEM1ceoN0m+LUQ1azZBc4SAnhg+NkJENM00n0CfFXYo3TUnJtcjd3YoTCxgglLco1
         Of4qf5Ut4o7hnYHD9SYec4DcvxDf5ktAH0Hr1uQgrQDB+V/Xg/tox0JdgbstiMjgIE+I
         0oPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794766133; x=1795370933;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BLKtPUQTDXoLFv72rOpGExBlBMoH+xESwylo93hfWgk=;
        b=ofdoAwGx8A6vGOBchyKfd9iVoBGnMAY1qVtcHSiUni7yE8K7wNgxRe+23qx+SkGUpT
         Qdlg8bomchYh2BpdrMHvybxst+T7NZM4pA5hFxYgTXczotIwZ26y3K7C6Z9nwBpIEfSh
         YVhuwS6jf91JOJeeuZMmBTBLrvuMEnDvSu61Pq9G0ptJs14DBDDGrPZLgtUXzI9Kq5WJ
         0oW6WEdLEBONVeOUeoJi/LX4EOerbZybcTdUV8wSoGPpvnG8ipehoolHq0HWVgCLfvrz
         pKr/UPGiRdzxz1m+o5/aeeSMOZ0vMmcEBoeZCh+jv2r2Fj6KWY6YtfALBLLMKkaNG5fr
         KBIA==
X-Gm-Message-State: APuU4Z/cABJz1cJ+TUBTAvefWQme49BsENRvV5Ubng/VugebySfBngMe
	zXgB4DxwlXa9etrMJqe/dF0U1FFle9sAcF366Eoi1aY8/1Lq6GpF4izicZ4OEg==
X-Gm-Gg: AYBFou2J+ogIqZtWapM/kT/ZUet1Uo3im90rkQTj4PZYSuCya6Mh+ijPbWgb+mP0N1l
	M3+cqlwHlNVKgZld5TSYl1nnwKIDs7ZaEIQgBET8wiKCMbU5iBR9xEY9cH7uvvsfQiOtouHongt
	W850sdReFRmXehmXzZqQs7FzPcTvSGMB1y8KZD6WW55K6jyE7/skRv34Ahc4HBtH0RPOPZ/A2py
	8JvMtHCMiIObKDk3DeAGFvawvRUMZebu2vVzpN0lJcmXASHvWQTq9daXP2RiAcwJulFtx3Y5gMe
	qWGe1+g+2mAgS3jdWz2S1kr1azIKawhbeqOfQz5trNCd37nJBUvSaU47Bq+xvmxIkSNxUeIDsvc
	TY2ZmGqtKnplTbP3H/DUWSryXatQaxxf5atmNnccfxf2t3LjrhxFH4v22EtESYda7kxf6nD3ogI
	AeMmO9ie62E/h2Q1O8wFiCX+sLky1Z0ooHYT9AW6YTRvSr38bxtRQZ/VX9Jl5NwKyeqJ+iotd0K
	+jRtLUe08mf8vpeb6TmPptZNwTsY5jAijbVmLCWFgNE43LDqWXWU+PBPCVWH8i3z0bTmVEnemAN
	/ftJxHjTa7aCeYbRUNQ9UcuFL75T
X-Received: by 2002:a05:622a:4d04:b0:536:18c0:ab9c with SMTP id d75a77b69052e-55957840d5cmr167226271cf.43.1794766133309;
        Sun, 15 Nov 2026 10:08:53 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-41-210-75.compute-1.amazonaws.com. [3.41.210.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d2df66cb7sm23875291cf.21.2026.11.15.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 10:08:52 -0800 (PST)
Message-ID: <6af9f534.b96af62d.1b344b.3383@mx.google.com>
Date: Sun, 15 Nov 2026 10:08:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5271558326588385649=="
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
To: linux-bluetooth@vger.kernel.org, ngocthang2710.1999@gmail.com
Subject: RE: Bluetooth: L2CAP: don't reserve an ident for L2CAP_LE_CREDITS
In-Reply-To: <20261115115341.316484-1-ngocthang2710.1999@gmail.com>
References: <20261115115341.316484-1-ngocthang2710.1999@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5271558326588385649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1211811/

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      20.46 seconds
CheckAllWarning               PASS      23.38 seconds
CheckSparse                   PASS      24.58 seconds
BuildKernel32                 PASS      20.47 seconds
CheckKernelLLVM               PASS      21.01 seconds
TestRunnerSetup               PASS      484.24 seconds
TestRunner_l2cap-tester       PASS      13.81 seconds
IncrementalBuild              PASS      19.03 seconds



https://github.com/bluez/bluetooth-next/pull/1137

---
Regards,
Linux Bluetooth


--===============5271558326588385649==--
