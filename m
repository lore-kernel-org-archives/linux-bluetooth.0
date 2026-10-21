Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587434;
	b=YRLxAXDnwqY90k+vlcNrvVExsJ5uE2+LZ/SU4in9b3PNxrPF2wl1LpFM9qtTmIQIVRH+
	 6mxSyk1IwxtI51srNrkVrS6tyD387+ypN507qkCpgp/nkRmXfQFdIlBTM+7IPklX14pLV
	 XzPBOqaImhlH5CxktLox1oUYw0YbEFtuagrIMzkpkEBstmtXwm5CjUFMGBJV9IN5yCHhx
	 h3nze1r/xLejeJwHzmni/UBLurvCa/FLn43DrghG9T08RXLoYcW1QpM/iR4NAp5Z89iTl
	 Zm0PHh1q0+9wsllzTW0mhCjhY/RjiodwKDwgVSTKSYG7rhaFCNd5h2W+n4TFjpLBIlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=aBjU7hYYBlv9Rm7vRJUpW+QnjKauay9ppffAO3rQi1M=;
	b=HLGm2B42oTEMRo69s9SP2+CYOb862n3VPJ+OT2Idd5lGlJoXmLDLfIehTwEsfOCC6awB
	 jcD7eN5bD1FfbsbxP0UTE4lX21KmdVKTKz4jvAvS1qde2sPD2yxc53KHO/6qa4IZSEcBZ
	 rxOfdrMlzZppRRxN8Dw0cxMoTtNfgy9pGLu6fmXQB26A4C6jIGtNttEFJSRLIdRaKW8Yp
	 hhliqBqfzY37ELaYiOP1+rORUzdbpL81cG4nt+LYakVkmmf24pLCe0uetkUevYbWgoDwl
	 fvxY80e1EVsFcYN8mGRVLsHnc0h8xwceR2dNKcVeWciCKqP8LbaA0oRKJ2xGkjKkBEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rJnKvIyC;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4DB606A319
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 12:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED4DB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rJnKvIyC
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f84a55e31aso395897a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587433; x=1793192233; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aBjU7hYYBlv9Rm7vRJUpW+QnjKauay9ppffAO3rQi1M=;
        b=rJnKvIyCt0W/ZSQxCvRz+CzqxXEoe+tqZEVkpl9HkFohDwzkWpHjPrk+7Sau6fAKvy
         Rafy54Q6suhSsqrTEq0W5OA63+mrgJbHIlqGCo++lwo1gNKyCVz1qNA7A1Z98G/aIZFw
         zv5sVJRjEd1vn7JZR0siGPLLqx0oFnvUjp366Z7nGGP+SDuFwzt+JuTIn/Jr6dRpT73v
         P7NGpjILDF4ItP3gtGR2SFBEwU5zFGdqn/qeQROHyPci1sbOMIbCjr2aXwHeFWMvmll7
         tKdnsP4ID26ZtjPYPDhmMFjjiEcSSGgyI9xHHi89CUYCwTVZpPAuJf5Nh2EeNhKm6LGU
         qGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587433; x=1793192233;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aBjU7hYYBlv9Rm7vRJUpW+QnjKauay9ppffAO3rQi1M=;
        b=qnpve/Opn2M7ilSRMnK5ct9eiVgtGx1TWIgvpw1NHzgjsFIrPNujirzHO/eM0pSmQk
         e/JlGoX+SroPMaUNbBYA+wm8Z1d3z9YqIvG0dek0lKombs9sjFfOtZYh94uT1eMAtbey
         b+aDnj9DUsY1AXxHthxYJ7NwcxRcgREMit/oXsMN4ix9sWhQhXkfJt+9v8Ha3qG9uO4p
         Dm6ZIspPPCvt9XbsY1cf4oWalSTHVsVgCpzNtmR/R2f6yGH34oD2sTa5TZ2OI+mcOkos
         pNj10cKUOoJ5cY3WzqG2wY9ensrcQgoXv+lkhC5UzaqezUHWD03w2cx+KVPR3sKkoEZt
         HpHA==
X-Gm-Message-State: AFq9FYJN7eWpAAtjU68tFjtX5Rw2Iez9PmS5T0Bo5EWz0Wq+VGcBl2+b
	y4JWAUnaRMe08uwdznycfr5CuM/O3X66Q3MYtqrBC7IXXvVafCcEAHEYT69x4w==
X-Gm-Gg: AYBFou1qV4zg+Pd4e7zhUkT2UhRFpiE5A06mnpzsB03YVFzLMM68Pd4M5wV1gZ3BeJ6
	c/l3+E4fi8n2hH7+D+REp4uXKs/IZNrtYXJFyIMwAKMaowRDI9UYVae3QpuRbw8dz6sb31wZS+k
	5TjnX2/NkLQ4tMduu9d1hrHy0ao6xmIrDlysgeQNNY5KdOu6bdWlQ34VyC3eco/LcOY+FYUkaJC
	gVlkG0AzCtAa1V3h3be8QWMbGxkC3Q5Unnhq0hlJAcI7ZaGIoNpqAey/6RFaTajZ7DbBu8w7qUd
	YBFuGe/WJXZDpe5J4oaro8ts0lSnYPktBPmFXSSLMvmyOQMznf8M8PgqgXDVeT7sE7rIbyviBXW
	ofMGl2A+ybGe1L+8eLGTUHWEATTkxhYpd8PZSrLT4PKMgUZxaDkhPNnicPlU8/zvTu3N2pao08C
	ZJesBkb0s3Qz1DvxiBpBn3wEv93yC7mMgpa1DFIZDh7tkM8loy7pzqUeplh7WV1jdf2UvvYf4LK
	lM9tlXYKKlB7Cwx8ouETVJXkPsN+Vga4cILvLfyHV/35k8wY1frkmZGDVFFdEgypQ==
X-Received: by 2002:a05:6830:2b29:b0:805:cd51:568a with SMTP id 46e09a7af769-84d05cba0dcmr1315052a34.2.1792587432916;
        Wed, 21 Oct 2026 05:57:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.206.133])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbc7d9b1asm2148334a34.8.2026.10.21.05.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:57:12 -0700 (PDT)
Message-ID: <6ad8b6a8.c3449938.213f4d.5293@mx.google.com>
Date: Wed, 21 Oct 2026 05:57:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1774733647217342018=="
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
To: linux-bluetooth@vger.kernel.org, tooangel@tooangel.de
Subject: RE: Bluetooth: MGMT: Return RFKILLED for Set Powered on a blocked controller
In-Reply-To: <20261021065833.120347-1-tooangel@tooangel.de>
References: <20261021065833.120347-1-tooangel@tooangel.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1774733647217342018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1190246/

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
VerifyFixes                   PASS      0.26 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      18.15 seconds
CheckAllWarning               PASS      20.75 seconds
CheckSparse                   PASS      23.78 seconds
BuildKernel32                 PASS      19.03 seconds
CheckKernelLLVM               PASS      20.97 seconds
TestRunnerSetup               PASS      404.56 seconds
TestRunner_mgmt-tester        PASS      80.42 seconds
TestRunner_mesh-tester        PASS      4.98 seconds
IncrementalBuild              PASS      17.38 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: MGMT: Return RFKILLED for Set Powered on a blocked controller

35: B2 Line has trailing whitespace: "    "
37: B2 Line has trailing whitespace: "    "


https://github.com/bluez/bluetooth-next/pull/970

---
Regards,
Linux Bluetooth


--===============1774733647217342018==--
