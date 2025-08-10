Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F48E1531F9
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811021; cv=none; b=p55/wXYruq4VlS6/dAeEiK4Vk3w2PPf51GRVd/nvWdmcSA7K2GtOSzrzRrggJRtRrOpCGSr3Sjxka14xSt1QdgdFwO5urAPv9nAhSiZdFw7DvMfRk9MdFYiuD2WW1JO2lRu9fj1+HIUtxnkNQTHJilh57BTVXNOAQNpSPjU2MAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811021; c=relaxed/simple;
	bh=nCsV6GflRHJor0F8zLV/eJzIDvoOAlN2o7SREoYWFvs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FcHl+NU/YuOIsaSfpKn+QEDLnpasDX0ZBJdOD9meaMNsy9rq0hsuIgoo5lZZBH2wKQRtp11py+I8ZFWMnGRg/uA9ECmZZuguyopYjUjM/IGmbX/LuRzoC4/2hUSJWfYtiMPL7+GbfBJILwj448GAI6JaGD7TJaPieAvYJ1ZemrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IB9C1ToV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IB9C1ToV"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31edd69d754so3417853a91.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 00:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754811019; x=1755415819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y9WrTMHBg9w4e3Mux2Q/uxRBSUyL0IbaDwLYTMxIBYU=;
        b=IB9C1ToVHZ6xpqtol7hHOurnkaAk3lnqohV5neqgyle2nPJxnLmKmDXGtydo7GqYYk
         XKYZwGSU3rER5BCPbERFhpFGRQ4OhXyVsu99d2n06egRmfwCwzHZ5vT+EZgfSevF9Bbx
         bSqz9kG/YbPEenG9EIcQ4qKUFbkjEeEfuJhSfqevfGf0BFA+gh1bOq/Vy1JMfg3obBqO
         SikEDQZFLqpFyTt8FFLtnQ5RWLeER+artA9yrzPkNkOdUFh4+Hxh/+JUyUD19EZHv+V2
         OYwL30VLGg8xM+MTyLoBTwal34WVop8KDOm8KwYwgp9bxwKAp3ABKdMjX4ugaPacOnwa
         gasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754811019; x=1755415819;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9WrTMHBg9w4e3Mux2Q/uxRBSUyL0IbaDwLYTMxIBYU=;
        b=gKrJsqPNw7phzq45MPLzmKj8+4jd0mssMv9hy++uObMwE/KYobgyjAygPqvC2rmqAA
         JS/SsWUDL868yw9goS+TXEaTSMTzCO3VTQEBYwdW3/qjatevCbhsCGvWpMLNe1gZU2kU
         x0ZbTdLekFuVdljJjLe4mitZ5Cq1xicS57MSbTe4m/o72wveMM0DtgHdsPR434pJQJ9A
         WqEMUI+R5OWrvSKBToiLLczPgHefKbJ/PqnfhhuRXiU+8MbL/cBh+j9ihMCvJlK2fWSA
         ILE1mhErliMS9hILBhFmqN6T3Vn251tjR02NhXF02zJ8OZrD6k0Y7FsjfLMqDDnpREDr
         g/JA==
X-Gm-Message-State: AOJu0Ywbk+3NZmd60v7VUynDg6e5wasUOX5r/0gg7216hCWj1Do6uysM
	bIoXh1rJIdSJtmnYciognP8eSIuM4A30WP0TwLaMF1ufU/UHSkyEHMR69VqJGr16aiNFue+lY6L
	1jpHuujLX0LK9ORYcCxX1Ll356Jngc8Oo7mKJgQNFYczoXo9dHZYBR3o1kWh1NVGX597e/SYdGJ
	jvwOoT/q+IpTeWg27HtZh5P3Tm88YckQhbXETrm36GuWJvMqi6
X-Google-Smtp-Source: AGHT+IHmhGvAH9+TA83UC1cLKXAcAn4I0bWTeJnUXL5Ti2iGMEcZpAfqahhy2txRUpAoI5PbHdf1vg1gV5M=
X-Received: from pjbpx16.prod.google.com ([2002:a17:90b:2710:b0:2e0:915d:d594])
 (user=ochang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dce:b0:313:dcf4:37bc
 with SMTP id 98e67ed59e1d1-32183e80aabmr11942026a91.34.1754811018503; Sun, 10
 Aug 2025 00:30:18 -0700 (PDT)
Date: Sun, 10 Aug 2025 07:30:08 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250810073008.1824799-2-ochang@google.com>
Subject: [PATCH BlueZ 0/1] Fix buffer overflow in sdp_xml_parse_uuid128
From: Oliver Chang <ochang@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: oss-fuzz-bugs@google.com, Oliver Chang <ochang@google.com>
Content-Type: text/plain; charset="UTF-8"

This fixes a buffer overflow found by OSS-Fuzz. The ASan stacktrace for
this is:

```
=================================================================
==402==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7c960dd00030 at pc 0x59331ced5b8d bp 0x7fffedcc0c50 sp 0x7fffedcc0c48
WRITE of size 1 at 0x7c960dd00030 thread T0
    #0 0x59331ced5b8c in sdp_xml_parse_uuid128 bluez/src/sdp-xml.c:128:17
    #1 0x59331ced5b8c in sdp_xml_parse_uuid bluez/src/sdp-xml.c:146:9
    #2 0x59331ced3529 in sdp_xml_parse_datatype bluez/src/sdp-xml.c:428:10
    #3 0x59331ced3529 in element_start bluez/src/sdp-xml.c:498:32
    #4 0x59331cf26628 in emit_start_element glib/glib/gmarkup.c:1010:5
    #5 0x59331cf258d7 in g_markup_parse_context_parse glib/glib/gmarkup.c:1369:17
    #6 0x59331ced1969 in sdp_xml_parse_record bluez/src/sdp-xml.c:621:6
    #7 0x59331ced8cc9 in LLVMFuzzerTestOneInput /src/fuzz_xml.c:30:9
    #8 0x59331ced1879 in ExecuteFilesOnyByOne /src/aflplusplus/utils/aflpp_driver/aflpp_driver.c:255:7
    #9 0x59331ced1675 in LLVMFuzzerRunDriver /src/aflplusplus/utils/aflpp_driver/aflpp_driver.c:0
    #10 0x59331ced122d in main /src/aflplusplus/utils/aflpp_driver/aflpp_driver.c:311:10
    #11 0x7c961015c082 in __libc_start_main /build/glibc-LcI20x/glibc-2.31/csu/libc-start.c:308:16
    #12 0x59331cdf8a2d in _start
```

Oliver Chang (1):
  Fix buffer overflow in sdp_xml_parse_uuid128

 src/sdp-xml.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.50.1.703.g449372360f-goog

