Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675701;
	b=0ta9o+EA/nicJBjZpbgAlSTqsOA3F+jZmapKAxbDXmM7QDx4hp+igzLEUHMy82JLfHIc
	 bnfZRDuarRkfvWFkx9sTMrRFO8XUYHOnng5SpO+kbpc28qyZ8/w6KAOMrdz0YG2q1Hs2l
	 7hJ/4q/ef0BtEpOTKeS8Wb2xtK3qiXfwC9ivXGRGoLowQdf8wVQelFGJu/LsxY28p5iqV
	 eqoo8vNjjm9c3vciOfA0T92LW+I2dHhgonpZQDUP2+yvNrgBneFnd3ktonbLjUmII7Ios
	 rTv6kkvBd/J+xd5Xhv6OOdlbxztPkN04RZxLtNaUbvHVPR0Q2uL+RGTtTv34HD75aNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675701;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M2BrMkSPI6vZbrPBGOtyoFX7eotWXB0/zUbgHscIdz4=;
	b=RF6FzbnU4vSqh/4ko0U18s6i/wPOfiRaWfvHTuPt3tNdt/66hqStkZNLHBNYUGDJdG1g
	 AB3pO6fZcqkac6JNTBXg9UpHgdVz17mW9g+E+QrcDvzmor/TaY70tiJAcXMOOoAo0HTHt
	 Gg+GSjuyn7izNpgtLQE2m5yC73VMSxbxx69Oz0zg9drXcIGGn9jDdLSaWEI3Lwn8Q//xv
	 7Txl6wEQ03kbDvGKAGlICnmdCTxgmedvDOech1NcaKMUUD5keUbU7o9BTSPvpYxmqkGUg
	 chQQFqa4RFfM4YL0P/3bfAaXvZ3kuuH1AUagkMcBM+rZnFokRKz/FTHQ4LLLeegMuFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=PUdil2NF;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05476606A68C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 06:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05476606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=PUdil2NF
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 30F2D3F68B
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 06:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1795675689;
	bh=M2BrMkSPI6vZbrPBGOtyoFX7eotWXB0/zUbgHscIdz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=PUdil2NF6dbQM25+tmU+4iOdj7tFhZLCHyxwVHLP1uZJDs9iUdL7epRXQV5izfevf
	 AZgqxqCSK9TD9R0bNTZtoEDfzJkuxMc5DM1Xg+4mo+dbNP64UNjGnZdhESvJXFXmKv
	 jEmK47DZc55k1viU5V5UlYm+Zv1U9u7ZK5nYw+7Hq38IBY5nSVGm0ngrjddn8s2UQJ
	 aSkRWxsY0Y0Yv1RJBo8Y5Jh2YIXODZtIoWjh8ytfAP5eF8q1N/+Xuips+2D7BC8/u6
	 8BasSDslgkxDBrGrDsZywGR9Yz4oJtEgBoEOKvs3VxTMt0zNgue8Y/BI9e231DDYVP
	 ygwuJkveVvXBDF3rQOj3GpSBll/7spCPT4IHT89NkyhCbSvlb7CiqvssxkjeFZ77pS
	 1LRq8QhTqu1jyCQSbpnfSU9WAyaIMXQKd/iHAT2HWLq/vT8t24brvJKa0xadiGX4hN
	 SQEfeJ7ZdZ7bnYAJOPr+GJ7dkFaMLMtujvUVC+ZCfAhwik4DOH0q55VDbSHRXkjltt
	 uqCzvBvfSlW0TuUQ7S4eF4wi/sFvx7L4Z3oI0wbglG9cK/FbJJuDeRdOnv6UuCXnB4
	 tC2t10UmDKUJxD6Cq1Yl3W54mzydknyRldQQIK3+In2dZ24WcOJx6HWMdlLYHmexak
	 oVV48mv1PygowcDxjMwliI6U=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b427e5a37dso5396746a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 22:48:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795675688; x=1796280488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M2BrMkSPI6vZbrPBGOtyoFX7eotWXB0/zUbgHscIdz4=;
        b=qJRO/ZxZHhj8ktei7mJmmZy836dpCmYEXIMCuElsf1mdKV5/po0reBVfiYGkQAKCXN
         DBFA/6abWcYy0UozMv6nx4VJ5ykLCFoPYML//aQwjxuFKCAuA6tDDW4e8v9qYeB4qnu5
         BdW+4PAwBRavXXnaDV3QE8NcbSjU4kqGorPnqODGPdlkv5UblEnUQOoZShpvalikcTHD
         4vkaUDR4E7TfFw5DmIkQyaT99AJ2Z7UC7YPlJtLbLp13YOYvyOqNUuA9oY+boTms3/xG
         NKFlxm4ahWFdRBAoM5uj4CtGYbibQlCfmqUNuBWDaR5ZPSeoG2R1Vqok3/H3l0jNnWzC
         pWtw==
X-Gm-Message-State: APuU4Z9mggw3n8bFefalmOQmLRAYo4xXKaKtr0Ws5qivFrc+Yq4+2jjf
	rjnY634LHmkg3H5mArxoRN/kZFG7IrMZiSigg7gG1lX7I9glTWVGMx5rl0qlAMsbgHgR4J89DTd
	L2utBfhzoQMD82WBFJ/cgV5iNbOMdk+IpwVjb6hlQeq5I7WrRgfbczD4BbgHV9ie4ZMFajtDWHx
	nw8Bm44TA2ptT46yWPKyh1
X-Gm-Gg: AZFdTZeOI9BUBE0myAB9K0HXpnOKkNJU2hnKV1fUTtfQc6fD+tCUDqie+2yYwctDXJD
	nTCa2HLZLb91r2wN0lZT5bDo6W0Ubk6q8VwfbBVscguzTu9bDT66R7UTc31y14fOivUlFwoowgR
	FrylppRwoWdxY3V+g3rYM36FOTJ+I+nCmbkGNwk+HOj5urjvK4RJleNQlh7G9Mq9kpNRaUhBTit
	vwUYxDXKVnOkR2TDcoE0S3uYlohXov4fOh4skmCT1LN2crfQEiQVTkf7ZUMYNR/amDtBsirESqc
	WGa2BKipSpnYzeAvKbrwpI5XyDOwvvM16njiVqSgDeSTmLHxzoNMNVT4hYIpYHqaVYzN0YVGZYs
	IifZYoNhsgr+KAQyKrMILHUaq9bHsxaAaInN1197N3OOiFHIYQjcD+u8AZarpULyRYkPnrxdODv
	5qFTz4CrLGIYZduMgA/fBBNlEQaQmPFAYfdQ==
X-Received: by 2002:a17:90b:2b4c:b0:3b0:a7b5:c037 with SMTP id 98e67ed59e1d1-3b41c7b6145mr19433878a91.1.1795675687675;
        Wed, 25 Nov 2026 22:48:07 -0800 (PST)
X-Received: by 2002:a17:90b:2b4c:b0:3b0:a7b5:c037 with SMTP id 98e67ed59e1d1-3b41c7b6145mr19433860a91.1.1795675687172;
        Wed, 25 Nov 2026 22:48:07 -0800 (PST)
Received: from kchsieh-C1-X14-laptop (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b2156c2sm13787468a91.0.2026.11.25.22.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:48:05 -0800 (PST)
From: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net
Subject: [PATCH BlueZ v2 0/3] mpris-proxy: Fix possible crash on OBEX transfer
Date: Thu, 26 Nov 2026 14:47:56 +0800
Message-ID: <20261126064759.95429-1-kaichuan.hsieh@canonical.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <6b7836f674530e930c8fc7431a50b5d2eec017f4.camel@hadess.net>
References: <6b7836f674530e930c8fc7431a50b5d2eec017f4.camel@hadess.net>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bastien,

Sorry for the mess with the consolidated patch, and thanks for the
review.

Yes, your reading is correct: your two patches are re-sent here as
patches 1 and 2, unmodified and with your authorship kept. Patch 3
contains what was left of my contribution after the split: the inner
OBEX proxy guards for the failed-CreateSession case discussed in
issue #2569.

All three patches carry Fixes: 01a5a26814 ("mpris-proxy: Add mpris:artUrl
support"), which introduced the affected code path and first shipped in
5.80. The code content is identical to the consolidated version that
passed the BlueZ CI on 2026-11-06 (CheckPatch, GitLint, builds, smatch,
scan-build and functional tests, series 1203891), only split differently.

Downstream bug report with reproducer and analysis:
https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/2172906

Regarding regression tests: I agree they would be worthwhile. I could
not find an existing harness that covers mpris-proxy, which is a
standalone client tool rather than a daemon component, so neither unit/
nor test/functional/ has anything to build on. If there is a preferred
place for such tests, I am happy to add one as a follow-up.

Bastien Nocera (2):
  mpris-proxy: Fix possible crash
  mpris-proxy: Avoid session->obex dereference

Kai-Chuan Hsieh (1):
  mpris-proxy: Check OBEX session proxy before use

 tools/mpris-proxy.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

-- 
2.53.0

