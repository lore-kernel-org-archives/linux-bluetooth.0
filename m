Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31562FD1A9
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086206; cv=none; b=NK/AS14dq5oUqSG/6SenZG9LqXtNq/HghPJFvPlJWP4N3RKV6cMXeNrpFVztBvhAx+9rzf8Qzy8p5E5INBTWsItoJ4pZNdGGLEyJZMHWIbYOQlAhlg9NVYL0dnBrMExmw7ocIg/bDTrdRYQVL//F0KrSWWXBPw0LzcxUHmKoQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086206; c=relaxed/simple;
	bh=ryMFpJBd+Vxj/YH5Cypp2nRJ3BbukamXAtqHhwHEgE8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=czCMNjJd5+wTiRwQaQLkqPDRQbBS2BtKsVy/eM4ciZE88OUqC6zK1cQwAYXT0JwuHy9IvEq0Gbfcr3BnPXfa8tpjuB9x3iflXIoQ2LC6LcGpgQZ0akySxsm+SQ9Msdp423toTEe/ABALyvxqipUApslO5JDxmVjulmmj1Efkr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffvPwoNT; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffvPwoNT"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e84640f6d3so100171985a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755086203; x=1755691003; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IHB5ygAheuVuHS3UM2FqFFRmfZ9lW1kk8AYVUPj7JQ8=;
        b=ffvPwoNTfFPRv587Yut94xEMJ0hNJtSk9NMBk8oIXQ7rYE+5+EHGIdTL+xo3OxRXLu
         dxMmhLQzdafs8wBkwwVQ6TmR80xfnXn3EkwvWZzbEK6tM6ch2M+BjZR65nxbwBM8TjCk
         SYT6hXjIctioLAjuRXWbHG1NsToqGwBvmTi55KKKSSF3SfXjcGALO1gKtzWwjoXb954C
         EYBNcGhWIso521YVsQfQci+uSw9pdiOY0WfKEU3H5YHfp9EcLn565lihCoBv7ZvHCxal
         1z7W4qsG/7D/nqJAeSl0Ob/xzJCr7VgZTZI+AuBHNNTuNVdcvaxL3FETLzx3rP/eyQZf
         rM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755086203; x=1755691003;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHB5ygAheuVuHS3UM2FqFFRmfZ9lW1kk8AYVUPj7JQ8=;
        b=v02WvVD/jkU3ZsauuSbWmnl9Xxyh9L25wZRQVuRWxho3v8gJG7Vok8EaGOD5XPNC8u
         2w93EYrutmalNaBlHPYjO4RIePtWC1JTWDqPnle4rtqyKfIutbBO/q2XBBsPm5s7P7N+
         rOK24UYC91+kuuU4eOTVbpkCtPKek7eE5ed58rdeGa7qiabG8J/UFF4ifOLzmCmzVG6w
         NZ38ppnhoZru6XMmQ1VVJ0CheQmKItS5AZM6lD2/Gx7+fFBwssZgo0mECCZ7mAltO8L3
         2ogo5YpNTtO1P1kSKsx3fj0ygwCUhqlvVDxvr3cl9fSs+PR5PrtMTcRl+rqjVDDgoA+R
         pciA==
X-Gm-Message-State: AOJu0Yyb+Q7EOepcjjxofUsdTsLaLrgGtz9nAFfC4PsG763WvkVa/MdG
	9H8LHjkvuTulbp6hsH6I+RfQEhmkhngF4ivWXQZPcXYriXJZsx5WacCM/NfmbA==
X-Gm-Gg: ASbGncuwIVufyOXo4EhYms02mcrqn9C2cXHdyEGhOl8G2i82kSKnNcBu3b51ETU7WrA
	RfS3EPkhYRzLRzG39OIOUojemAjB1oDU+hAkG/q8X31XTGG4JHU81GG14ooJzuG+Hy3xZ83saYB
	xjGRgHfwp1DnrNjnUMEvOymr4pg3bMZP9n0ERm1KrTy0Db74XoZsIfc3Gn/LtHeWA6o2QE+086C
	58vUSujbHDf26gv7ciXJE2OIL+aDCFvvYrc1/7Uf+BY4K+Drr+mPp+1tzy8xz4Z8krHHc46Zof+
	hF6XVcdrd9TLLX2BhCxVkF6jOAGxy3nsiTg7FC/7WUL+2YjmKxnLsY0j2VOANhayGW6x94RZHTT
	9YBM3cjYxd1sSVe2itBtfJI7knQc=
X-Google-Smtp-Source: AGHT+IG5o7YRYZQJuQvCqEQQDD8/2I5lKYJZdFzBzNLarQEBUt5C6Hep21HoyxSTHbANVQYlwHOW8A==
X-Received: by 2002:a05:620a:bcd:b0:7e6:9de3:aa0d with SMTP id af79cd13be357-7e866bdf43cmr203287485a.26.1755086203563;
        Wed, 13 Aug 2025 04:56:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.15.225])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e69e5c4be0sm1630880685a.45.2025.08.13.04.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:56:43 -0700 (PDT)
Message-ID: <689c7d7b.050a0220.169a85.c0cc@mx.google.com>
Date: Wed, 13 Aug 2025 04:56:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2102700148465200287=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ochang@google.com
Subject: RE: Fix heap-buffer-overflow in sdp_xml.c:compute_seq_size
In-Reply-To: <20250813103459.3690107-2-ochang@google.com>
References: <20250813103459.3690107-2-ochang@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2102700148465200287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=990970

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.00 seconds
BluezMake                     PASS      2559.06 seconds
MakeCheck                     PASS      20.01 seconds
MakeDistcheck                 PASS      185.63 seconds
CheckValgrind                 PASS      237.11 seconds
CheckSmatch                   PASS      306.15 seconds
bluezmakeextell               PASS      128.33 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      911.91 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2102700148465200287==--
