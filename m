Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F522B8D5
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754808472; cv=none; b=FwU5r2Xc1mQ/xgSsHko7z8sJBxEe6bNVsQf2xoB4Rox7qnqHxMuBUeRWO7PyOSbFBGXQgSQfaZSUsLYQqsp4sRIsz7DSGhgIPzYfg9Al89U+3Bp6uhuh6lTkCut/VrFZWLt8EF2ad0AHOGRFfL9srJxwUeL2XbeONJ4QPdqmfXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754808472; c=relaxed/simple;
	bh=FNLsZcQ3fnq+WZKzEJ/KMr9OYi3Tee475w5wg8g97Bg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o6bHA+oOKD5r4Nnq7ENFeFUOnrIoPpTJOw6Oqa3VJNRGvzBjAMHTR5ZG4VxpNjvZxDLc9wnCoLvU1umNDRlH/kg1nFyAnTFfKPhU5K1bSj9+LSNwVh9PBSEaG2iLcVIv0cTs9NXf0fEKXhdmk263BvrnwqWyGWF++w7wO4yUYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nSPCRePV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSPCRePV"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bcd829ff1so3387639b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Aug 2025 23:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754808470; x=1755413270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TNpdT+fjCXyyA5Sf6vkYDgKjEkUCjUQNlXXJ7bQp3i4=;
        b=nSPCRePVvY2O736UsMliz0eRLJlTIhkzggZucx67llbHGpcvzymD/6kb03OcRt2bt7
         COKtMobHIZn1sRENntJAbB5ZHYUrkuZyNKcwgzyrrDE4ww4wavwmKeS5BA9Nq+xsCzJW
         hDfsM/g4bwYyHeDT4ZaALktPPJhxrgbx6VIHvan9qMa7dn26XZ9gX4dQ1xK6TmVzXGji
         IppujhwksuAI1BTuyd9KSH3lyRF5Yx+26ISiDChXxilvGrHbhPSkzpo2ugVSsY3Zy172
         Xrz7+4cYziT/8JJ9u439lmsrBP/RHS0dOYC2fPgiiQ3ZwsX74vYyTUOHYfuY3xx0ZMSU
         Sxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754808470; x=1755413270;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNpdT+fjCXyyA5Sf6vkYDgKjEkUCjUQNlXXJ7bQp3i4=;
        b=VHpZG8+IMP0AI5HD2RScxK3xXPd6nWm2dAThL1o5C+/WfG9OSIgsSgEaE6Fw7LO+2/
         +SLyoP6g0O/f9IW/3+PS/Fw4FWdH2K9CxyCuGkUeBZz2STcb1pLvKJxf1BMTpumWE6og
         +e7Bd6HxqMeyNkFjOQeDagd3+nmu6JY5LtbfkKYVVayDdYRSxVhWbxfF/nddmwBLN+gq
         FHBs/bPqm0qgfZKRUH1eJDjmzcYJTtZEPwLcsgKfnnwptSHHHxpO+FjHSlwieTFNk8dC
         mXwq4CARcpDfMJO79+LflYdHS1ps1f3qYTu3C94ZgWngz4lIsfYiNml+1wEtjwseczIW
         yPBQ==
X-Gm-Message-State: AOJu0YzS41L2xVOZWcz0Np+z/rdy2/yKu7Wq0ofdsg7vodVaY0laJ8vp
	+4A1K8qS4rvCICckYMuHXc23zxRu6nCAKUNPZ2h5xSgdJSeH90saRHEmb1YABulzLyYcFEyyYef
	Ezph1JcG00ZuEW30Tjevu4T9Mg0n1r3l1y35zjYmS3sgzBwKs1NcAA07n2xeyc2EXpE3igeF6t2
	2zStKU723I64em1yxVlhVdziTIFr7rZVT5l9tPY3e7TJk2voxj
X-Google-Smtp-Source: AGHT+IFvHgPUrHdBSPcVVNld1XLIac4S6LMOnlmDfZZIeFBFyNlgCDaYCNqC4a+/yYECfCCLJX4U3WOafag=
X-Received: from pfbdh20.prod.google.com ([2002:a05:6a00:4794:b0:748:8e9:968e])
 (user=ochang job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:548d:b0:240:810:5005
 with SMTP id adf61e73a8af0-2405516049dmr13460731637.28.1754808469516; Sat, 09
 Aug 2025 23:47:49 -0700 (PDT)
Date: Sun, 10 Aug 2025 06:46:56 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250810064656.1810093-2-ochang@google.com>
Subject: [PATCH BlueZ 0/1] *** Fixed heap-buffer-overflow in
 `compute_seq_size` ***
From: Oliver Chang <ochang@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net, Oliver Chang <ochang@google.com>
Content-Type: text/plain; charset="UTF-8"

The change from the last patch I submitted is the removal of the memory leak fix.
This patch focuses on fixing the buffer overflow.

This fixes an ASan crash discovered by OSS-Fuzz:

```
==402==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x502000000218 at pc 0x564763e67877 bp 0x7ffc1a9f92b0 sp 0x7ffc1a9f92a8
READ of size 4 at 0x502000000218 thread T0
    #0 0x564763e67876 in compute_seq_size bluez/src/sdp-xml.c:62:21
    #1 0x564763e67876 in element_end bluez/src/sdp-xml.c:548:42
    #2 0x564763ea5416 in emit_end_element glib/glib/gmarkup.c:1045:5
    #3 0x564763ea4978 in g_markup_parse_context_parse glib/glib/gmarkup.c:1603:19
    #4 0x564763e65c55 in sdp_xml_parse_record bluez/src/sdp-xml.c:621:6
    #5 0x564763e6acf1 in LLVMFuzzerTestOneInput /src/fuzz_xml.c:30:9
    #6 0x564763d1a730 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:614:13
    #7 0x564763d059a5 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:327:6
    #8 0x564763d0b43f in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:862:9
    #9 0x564763d366e2 in main /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerMain.cpp:20:10
    #10 0x79ed69692082 in __libc_start_main /build/glibc-LcI20x/glibc-2.31/csu/libc-start.c:308:16
    #11 0x564763cfdb8d in _start
```

Oliver Chang (1):
  Fixed heap-buffer-overflow in `compute_seq_size`.

 src/sdp-xml.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.50.1.703.g449372360f-goog

