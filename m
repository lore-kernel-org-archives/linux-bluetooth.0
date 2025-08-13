Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0192F656D
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081553; cv=none; b=DNK56xzvdyDJ3dbcxlWuy6PQl363AB+GVB8Z1Sd5EZ0uDmFSShXrXsd6mFSJQa+sZh0usjYMt7y6kSyqfZ/dESRpcqJAvgdxclLxsrk4wXAEbqO3xIdMTgZ9LAPTdq4mRtWdqqEMs+P92jyMCUkrp9czSV9wALx6vfxgmT99G9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081553; c=relaxed/simple;
	bh=avecXMihQvqtzHrnnoSj4eWJlrD6RUJPW2JYGVhhkyg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q6jr0K/2r2BTu82zWYR0i+q0OVM896A195JWQMcPejR4RRWBrmIvboUo5sE/OODnsRlCk5fjnm4iHRHEEGuaFspGI53EY/rB+k6jJP1GxBdR3ioOYa6GKN2K+megqa2OYTPuJZ3thISnQZIzowvEDeq+/ALo7jYvNH/wroQgfZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oD2rzMwg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oD2rzMwg"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2400a0ad246so51338225ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 03:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755081551; x=1755686351; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nAKvXs/PuHACeEREQBPWKpFvMO00or9vKoJdoEugwSA=;
        b=oD2rzMwg5ZMHC0l5IOJMS4mDrEtAWh/1+1wJ4whagC6mQXYscPMzxzf06np3DGSzg5
         Ev8mSGtRngYcZ0lklZCcAqC7lCWaZNNzL1lFbnqQeHiNuR7r+nigBX6mQJBpCzdwFSSz
         9JqSRrKBWCkg7F0HWHRtnTBeBJ5zHmP+IS8j1FkMQPW0FQDoPbMmZRbAgHuE06Opjchw
         zRY8AnYIo0xucj7wdBiDvqh4U/yP8gx0QhbLr8RuUawR6CVm0vkv8higLa0zAJgPRnwU
         3A9PopZqxTAawezzfM31RNkvp91xQDHcFCP+EVspKKRH/VDTr8eWvefIYmqO4REzJugu
         jTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755081551; x=1755686351;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAKvXs/PuHACeEREQBPWKpFvMO00or9vKoJdoEugwSA=;
        b=wza1wG3E6tmFKPKiyoGLoBs44bakZwgXzIhqNG+05zuq7XZH1b4N/PSH1iX4h9kC9N
         yMnZi+f+JEYDincY3wFherhx6ivlZvrhEZiQFtlBFkxGhAD5Ip+xFLVDr7eMzh/ACbW7
         xI0kbKjpLRYhOz0MCu911F9rYcCMEJABlrrCi2caLawu5PKsUegsZkdtRlR02kv73Pfk
         6RZowffLv9QxdHdsA1lBkHrEQSgk1jyqtv0vQEanbm/bFCbXu85GlkVptg/Ml8EXdePC
         H0X0mE+NnWb1pjvpeNm9jc5nCgk4YIwvuIO59grZF3lzprpVG3BEqKEqBU4xG7U5GkaK
         rVhw==
X-Gm-Message-State: AOJu0Yzi/ZZxWbtFVVC9pLeNUQgWsUxLXLf/TvLsb+Cj04aYDPYNHgQq
	EaEpwK3XDgr5feer0NsYaF19RhHCno0STE6s9gZVSN0vPLShbuoY9ptXlRYtDHJY7tm/ZJLsOVV
	A2ryk1RqT+ms3rlaXnlDB+hwn1xqkHGNfQTcWZoRNWs2s0Y04ugzYcW7vCGkC0LJgxawWEM3Vvi
	4bZ+BW8+VWzVbXqwUjywKSCvaxnktmMMbqCcRVNjlO4vfIW5ZJ
X-Google-Smtp-Source: AGHT+IEwUtQdHRUJiuqu1NeK4HvAK33sqAIW3kVu0w8vKEj6uromOv6jgindoNKF+MOLO9f6rk6Dunz36xg=
X-Received: from plgu1.prod.google.com ([2002:a17:902:e801:b0:23f:d0e0:7e93])
 (user=ochang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c65:b0:240:7235:6292
 with SMTP id d9443c01a7336-2430d21d442mr38348455ad.39.1755081551301; Wed, 13
 Aug 2025 03:39:11 -0700 (PDT)
Date: Wed, 13 Aug 2025 10:34:58 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250813103459.3690107-1-ochang@google.com>
Subject: [PATCH BlueZ v2 0/1] Fix heap-buffer-overflow in sdp_xml.c:compute_seq_size
From: Oliver Chang <ochang@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: oss-fuzz-bugs@google.com, Oliver Chang <ochang@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a follow up to my first patch attempt. After scrutinizing this a
bit more, it turns out my previous patch wasn't actually addresing the
root cause.

The ASan stacktrace (found by OSS-Fuzz) for this issue is:

```
==399==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x502000000218 at pc 0x5cffda946877 bp 0x7ffe90702810 sp 0x7ffe90702808
READ of size 4 at 0x502000000218 thread T0
    #0 0x5cffda946876 in compute_seq_size bluez/src/sdp-xml.c:62:21
    #1 0x5cffda946876 in element_end bluez/src/sdp-xml.c:548:42
    #2 0x5cffda984416 in emit_end_element glib/glib/gmarkup.c:1045:5
    #3 0x5cffda983978 in g_markup_parse_context_parse glib/glib/gmarkup.c:1603:19
    #4 0x5cffda944c55 in sdp_xml_parse_record bluez/src/sdp-xml.c:621:6
    #5 0x5cffda949cf1 in LLVMFuzzerTestOneInput /src/fuzz_xml.c:30:9
    #6 0x5cffda7f9730 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:614:13
    #7 0x5cffda7e49a5 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:327:6
    #8 0x5cffda7ea43f in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:862:9
    #9 0x5cffda8156e2 in main /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerMain.cpp:20:10
    #10 0x7e0ccb446082 in __libc_start_main /build/glibc-LcI20x/glibc-2.31/csu/libc-start.c:308:16
    #11 0x5cffda7dcb8d in _start
```

This patch should address this issue properly. Please see the commit
message for more details.

Oliver Chang (1):
  Fix heap-buffer-overflow in sdp_xml.c:compute_seq_size

 src/sdp-xml.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.51.0.rc0.205.g4a044479a3-goog

