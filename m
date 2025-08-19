Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E3E25F973
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613799; cv=none; b=XJNuNNs74yVziIbeIc96AubPH+Z2jSslXrfNj7Xbkx+JBoLtGI0137QH5NEpaMT5FyJuLDqjDL813vC7MTPnfnhhmkUCfbxSReUJlU2djmCSFzro0v0Fud+7D2YcVOYOWNhpurOEzYNQGp28LC9fpqxn5BH9/CGKpM4jX56DS/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613799; c=relaxed/simple;
	bh=+ZHb+Pod90ypJYNNOebXkKTL87kth8W//3H1cJfdqzE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bpKkUOM4bZj3/oje8nu0XXX2uTVSZDF7M1K4hyy/rUzhrGpzpCtO0ouPYJvmWhncxbk8lXccf9xuKcmRpbBxdxrJJAYk/HaDc83Qezsun58Egp2jFkU3Tyz3mT1uwhHKdLtITYRV27KvYDwVSev4Xv0q528KtOn0vR6eLO7P+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3rPR/82; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3rPR/82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563CAC4CEF1;
	Tue, 19 Aug 2025 14:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755613799;
	bh=+ZHb+Pod90ypJYNNOebXkKTL87kth8W//3H1cJfdqzE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h3rPR/82NGUrIK92v2ntqXvVw+MjHX/sgs4/vmnEYbAyOkNwxDholJ1wp1FCh7hV3
	 tTHJKeEMvvoqi6X9Z6QWljdBsXs+Zs7Gh6Ie3ETK/RO5SPxEjoupz8dsDFXNtvs6RR
	 ceOKiA/GxbU1+vY5f8H96f/ygSic/OU+AGFS1GmZsDBUu2EqdbiL5kWDsd+rNTCvEZ
	 aV7DX9EaaKqJDsymtWTuwOWL7p8ccquI5Nf3FRcZYOmb/6u0w9yxqYV/5/GqT0Fok0
	 9bib/uQ9W04SXOYr9zliXnKTZsCMmDYPTors7dhmKHqNX36YI033mPNXUdJt8Vo8So
	 laqifybKkG2VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71182383BF58;
	Tue, 19 Aug 2025 14:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/1] Fix heap-buffer-overflow in
 sdp_xml.c:compute_seq_size
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175561380923.3572360.4132650504542772239.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 14:30:09 +0000
References: <20250813103459.3690107-1-ochang@google.com>
In-Reply-To: <20250813103459.3690107-1-ochang@google.com>
To: Oliver Chang <ochang@google.com>
Cc: linux-bluetooth@vger.kernel.org, oss-fuzz-bugs@google.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 13 Aug 2025 10:34:58 +0000 you wrote:
> This is a follow up to my first patch attempt. After scrutinizing this a
> bit more, it turns out my previous patch wasn't actually addresing the
> root cause.
> 
> The ASan stacktrace (found by OSS-Fuzz) for this issue is:
> 
> ```
> ==399==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x502000000218 at pc 0x5cffda946877 bp 0x7ffe90702810 sp 0x7ffe90702808
> READ of size 4 at 0x502000000218 thread T0
>     #0 0x5cffda946876 in compute_seq_size bluez/src/sdp-xml.c:62:21
>     #1 0x5cffda946876 in element_end bluez/src/sdp-xml.c:548:42
>     #2 0x5cffda984416 in emit_end_element glib/glib/gmarkup.c:1045:5
>     #3 0x5cffda983978 in g_markup_parse_context_parse glib/glib/gmarkup.c:1603:19
>     #4 0x5cffda944c55 in sdp_xml_parse_record bluez/src/sdp-xml.c:621:6
>     #5 0x5cffda949cf1 in LLVMFuzzerTestOneInput /src/fuzz_xml.c:30:9
>     #6 0x5cffda7f9730 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:614:13
>     #7 0x5cffda7e49a5 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:327:6
>     #8 0x5cffda7ea43f in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:862:9
>     #9 0x5cffda8156e2 in main /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerMain.cpp:20:10
>     #10 0x7e0ccb446082 in __libc_start_main /build/glibc-LcI20x/glibc-2.31/csu/libc-start.c:308:16
>     #11 0x5cffda7dcb8d in _start
> ```
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/1] Fix heap-buffer-overflow in sdp_xml.c:compute_seq_size
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=00eea35722b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


