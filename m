Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382B3FD129
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789820471; cv=none; b=Acl8yVeu58JVll5Fc3iBk5k7heFWC7uBTHH1yz69Kyixu27zwkurt813FF0kamFV2f9nRlOdeUfKQdumww8mSGiFAdxkMj9g9uMfmqj8Xq3AfpEGZKRMOedslgQdbzM54yCpE7plhCFQJakdGNj5H2OC+Edo7bK3UtMhJ7KssTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789820471; c=relaxed/simple;
	bh=IsnD30Ng/NEuKUiwy/Yfn0mb24DT7+7+5Pg8LxMz4J8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mzSk/xC7s1CFHnNLVss75kMhUIyTg2bCl8mPG//9VCFxd5H9K1ddPVEIYvPoEFokT5OIHSGqsU4GhdN87ml9mAV6fNf66M1cqLUfosPsA0FNEu4midplOExnhFo0m0i7JI40s3u74DUOfMBSmSmfPptgspSnlkE044lYtvJV9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFWoFGmJ; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFWoFGmJ"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so840893a12.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 05:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789820470; x=1790425270; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aAoQy9sFXxSSjQ0qZNGZLhjVsidUR3K75afkBWaPxN0=;
        b=fFWoFGmJoNpQSoU4Gx+9/h6qCjKo0bGHxtOL/hmhjzAkvM3Rh4B4nW7n5sZXUBGZBn
         BXozo+oGH4mDbmMDwsSW3fAqI2eT7E6DEPe+smNCwL3UIU/+pcwxigaZSqZvCERM2uAY
         iKEKhHAyfBRKBWQmO7jAhUws2Pdr1Fz2UEZa8rWr/sdDZoB8f0CSUawH9QFHW0wn3UUn
         L/KsBMQ4hpX5ZPjZVm6BJuXOgRJgWfDepm5JpTDLP+c2Bk1WN6dwgAWtkmXHmfqEwQJ7
         6N7uK1y4sR1jXLvrlDgSu7UzaEkMe37Z+4yUex3DxvKEjjyBxeDstXWQbWemu7nNy5sJ
         8atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789820470; x=1790425270;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aAoQy9sFXxSSjQ0qZNGZLhjVsidUR3K75afkBWaPxN0=;
        b=MTzEED2a++vCXLlCMLraM1rHL1+UM8gTNA8bnLIq9MpOIxjRJ3Et3pvqKdxunL8Kcr
         eKyUEMHpxC2p8w5I8xrsarvYyV1SIwlgCtbvtqiOsl94MzrCvLz4cJfYu3Hpr9nVCHcA
         kDfs8G4AoJZ4qkY44LCwHPQhchjhuquhIKtA8S8y0235apKskWMX0NIbKYhDzICkyBKw
         kt/bPJMvEX1grBU7QAsL1Z7LaXEOdhnCBdFhR3B9qZ4TYGXFIxbELsuNfbOIeJlQC8F5
         yaMBSK0Zm5v5SQLbXL+HVc3uSdNFpJO4LmRL+74lpzM2UJxD+0saHTpDhil2RN8PDBUu
         hRqA==
X-Gm-Message-State: AFuF++lHfbwArkmfDAvGwXGcVzuvHy+otvAs2jCdN1sssdfP7yRjAP+W
	5hY8gcdBJur3UZGZIm2zlwu8gfZ02rhUjSKkOYRL/DjxkNEXz3DpgqJE/udQXA==
X-Gm-Gg: AYBFou03qubehUcsYrA6Pqw/roFOVWtSVF0jBh7HARkWmOkhnHcZy3jOvh3Ni8VkE5V
	cj4jVRQlrgLwaPyR9RCPNjcAH1mX/cAJz8LRZfOsLIANJ9rGrnwwZ3d/LW1Sonx7qDHVg4XUj4y
	PELzFxynA0Rv/JsWIHiDhQEsZiVfIWWn/C67ji35mEoRGLQPeeFlyVJ+BU/muBE0KdttH8QZR/c
	ySaL2NEVY0jjXMzaNzqB8L9ZZgsDqBu4DO5Fy42E05ZbRBNmkeU8Ux8BOU4rM8FrmV0UYBtoJNA
	BTbzDQ7h8VpVMsbUjNqEtKmpMR5iMHCEif4E+gwQIs6zmuXYafMKrZeEGkxKA4w/OUg7bbv6YMS
	waIM7m6QAfK76hA/OA9MiSmh9HHjDRnNuIUdUNLOM3ju3pWrJTsDmsIb1qwAkF+duI5idCGpcAP
	v06ZXvSknQTv/tH9iHG13o0Wqj+Je6QKuj07nr7mf8RHxzGxUw7iy1brO6ZulIg673kepf16RX0
	Mb2QnY=
X-Received: by 2002:a17:90b:2d0c:b0:39e:6c6a:208f with SMTP id 98e67ed59e1d1-39e6c6a2272mr2996177a91.48.1789820469785;
        Sat, 19 Sep 2026 05:21:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.161.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c33140f7fsm6332820eec.13.2026.09.19.05.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:21:09 -0700 (PDT)
Message-ID: <6aae7e35.d2196d7d.1f3a04.59ce@mx.google.com>
Date: Sat, 19 Sep 2026 05:21:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4513463307372165315=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, benquike@gmail.com
Subject: RE: [v2] Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame()
In-Reply-To: <20260919112514.3871857-1-benquike@gmail.com>
References: <20260919112514.3871857-1-benquike@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4513463307372165315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1169235/

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      29.99 seconds
CheckAllWarning               PASS      33.74 seconds
CheckSparse                   PASS      36.54 seconds
BuildKernel32                 PASS      29.85 seconds
CheckKernelLLVM               PASS      35.45 seconds
TestRunnerSetup               PASS      800.97 seconds
TestRunner_rfcomm-tester      PASS      5.68 seconds
IncrementalBuild              PASS      28.33 seconds



https://github.com/bluez/bluetooth-next/pull/796

---
Regards,
Linux Bluetooth


--===============4513463307372165315==--
