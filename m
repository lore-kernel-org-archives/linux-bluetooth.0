Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634F4EB38
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944793; cv=none; b=AEYhO3nOP7zW4xEQ1iP68U04JN4b5dDC7IIGvtNwGEn8pGprp9xa/UvbK8PftZR+jk6GGWSEqxUx/0VmA/zKyEfe8Bc0Tw3PDgp1GAF4pRt40ETv84hlZ5R506g/dMSzC5Hl3caJDwWVcbvkTUerbiOFA0K23S/NW9LSh7eyk8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944793; c=relaxed/simple;
	bh=mGF7pYQ6WP419s9vV+zX8saWRSJISDTisqE3NOZTEX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aQjSBRCetF9iS2DKtCQUbRPmv/uLZPRpyVb+SLoclJOtf7TSf6RbnTZ0iX+NcSVJ+b5ueX37wkJH/c7kF679TZ6J0AYzg87qqBv++BVAiG8A+2qGrafjKHKpKX4nZu2Eg9Yn/1cTc5GG+EsHOJqiqcFQZyY3gqKXd7JT1lV3Y2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOWAeWgW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOWAeWgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3A0C4CEED;
	Mon, 11 Aug 2025 20:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754944793;
	bh=mGF7pYQ6WP419s9vV+zX8saWRSJISDTisqE3NOZTEX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SOWAeWgW9KhDsru2SNz8fXznUkkdNGGjozrfBIRd2KSY4kFmUyde9eoflkc+xm24L
	 8ko1oT7ItyifDZoFIAilkoygtsjfM1IFqXqc7jsiUn1JimZh1siYS4AJ34cW9+rOT8
	 RUR7pXsC1fs5AwhFzdOwgkgs6EjQhFiCXlN2wRKihdhUSzhmbRTIt/D2u3UQiF6bmo
	 guOq3jClxG21Hxn7h3OFpQNAVBSg5/AbeDZJ8TeSW8W/wJp+/NUrQjefZBzOeJM+bj
	 AX1h9im7VywjBhX6HNq8OgImy258noseLYefBnAL2wUWoeiiVIs/83PMlyD+dmm29G
	 Kvrf4eX7iv68Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE91383BF51;
	Mon, 11 Aug 2025 20:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] Fix buffer overflow in sdp_xml_parse_uuid128
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175494480575.1883756.16927216242515704087.git-patchwork-notify@kernel.org>
Date: Mon, 11 Aug 2025 20:40:05 +0000
References: <20250810073008.1824799-2-ochang@google.com>
In-Reply-To: <20250810073008.1824799-2-ochang@google.com>
To: Oliver Chang <ochang@google.com>
Cc: linux-bluetooth@vger.kernel.org, oss-fuzz-bugs@google.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 10 Aug 2025 07:30:08 +0000 you wrote:
> This fixes a buffer overflow found by OSS-Fuzz. The ASan stacktrace for
> this is:
> 
> ```
> =================================================================
> ==402==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7c960dd00030 at pc 0x59331ced5b8d bp 0x7fffedcc0c50 sp 0x7fffedcc0c48
> WRITE of size 1 at 0x7c960dd00030 thread T0
>     #0 0x59331ced5b8c in sdp_xml_parse_uuid128 bluez/src/sdp-xml.c:128:17
>     #1 0x59331ced5b8c in sdp_xml_parse_uuid bluez/src/sdp-xml.c:146:9
>     #2 0x59331ced3529 in sdp_xml_parse_datatype bluez/src/sdp-xml.c:428:10
>     #3 0x59331ced3529 in element_start bluez/src/sdp-xml.c:498:32
>     #4 0x59331cf26628 in emit_start_element glib/glib/gmarkup.c:1010:5
>     #5 0x59331cf258d7 in g_markup_parse_context_parse glib/glib/gmarkup.c:1369:17
>     #6 0x59331ced1969 in sdp_xml_parse_record bluez/src/sdp-xml.c:621:6
>     #7 0x59331ced8cc9 in LLVMFuzzerTestOneInput /src/fuzz_xml.c:30:9
>     #8 0x59331ced1879 in ExecuteFilesOnyByOne /src/aflplusplus/utils/aflpp_driver/aflpp_driver.c:255:7
>     #9 0x59331ced1675 in LLVMFuzzerRunDriver /src/aflplusplus/utils/aflpp_driver/aflpp_driver.c:0
>     #10 0x59331ced122d in main /src/aflplusplus/utils/aflpp_driver/aflpp_driver.c:311:10
>     #11 0x7c961015c082 in __libc_start_main /build/glibc-LcI20x/glibc-2.31/csu/libc-start.c:308:16
>     #12 0x59331cdf8a2d in _start
> ```
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] Fix buffer overflow in sdp_xml_parse_uuid128
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=013b3431c58d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


