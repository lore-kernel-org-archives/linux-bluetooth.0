Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95D3FE356;
	Tue, 11 Aug 2026 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479070; cv=none; b=DgzUCtIZz/cLE4xKiZfZK2v0EOE6ZwPgCsqzSEZ6J1Vtd5AgQHdBkarYCn/MJhmXXvYxLTsIUUuOsZMauil57BeyO5dnAKG7Ms9mFVGsibW+emoj0ySKAScvzdiI0QuKu07ljaiXoTgwzVXbvy813cbJxaw9TA2ow0bEnRdDBpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479070; c=relaxed/simple;
	bh=obadJYutq4MoBAkBPfl8VuSEHQJByG3fwA1ejUkMTFo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ed30+Pp59Wkuhb1+aMPAi74XfRAGpSDg9Y8f85RDy/ZNu0fjwXd2x3Fqvr+ZQ0/I8hF0ad4RKYzGqw5OH53S+9kZvxg325xWEHZdw30XZW1u/TjUb5xi9NEzYYysQYtMZksI4z6cenxrx16JleS6Uh3//PtfiSoymXhmVACpgGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UF9kTs9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UF9kTs9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255E51F00A3A;
	Tue, 11 Aug 2026 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479067;
	bh=rVOaYLisIJgoGupjuCxOumRf65EqMt7tNwJWES0lvSs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UF9kTs9XadsL3KV/jYMLScYNwMH6qjfwHKVYGjK0Zyu3gtDU/Vl9IftU9Pwqat5GM
	 4yKPUKGDgC3Po32t13vT4N1yxpBk5iYFrL1dkQ5zaALXaWcX5lJviSpsjS5kTuHnx3
	 ROEr2Gn9838csfQB0ietNxTsNrA7xEJZ+0mZrv/CdkH3GGfU3SvK0niNE2+RZhPIIn
	 mHX16yMqUqnfZyQ7tRaMxxJ5MsCS0urE17GCQFF4TPBCdhT0vUpiKP08ZtNBkmxgCP
	 ovF016xNtDvusz4MbxvKN0/e29jqDIJR4iQqTp8rY5ar6gVw5RqCJ+64jFfxIqSkwU
	 QMrg8ijfwUrCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D23809A0A;
	Tue, 11 Aug 2026 20:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek RTL8821CE device 13d3:3558
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647902288.1134064.4544105919269302004.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:22 +0000
References: <20260809-master-v1-1-c62bc61debdd@gmail.com>
In-Reply-To: <20260809-master-v1-1-c62bc61debdd@gmail.com>
To: Richard Nunley <richard.w.nunley@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 09 Aug 2026 15:30:50 -0500 you wrote:
> From: Richard Nunley <richard.w.nunley@gmail.com>
> 
> The IMC Networks Bluetooth controller with USB ID 13d3:3558 uses an
> RTL8821CE. Without BTUSB_REALTEK, btusb uses generic initialization and
> does not load the controller firmware. BLE connections then fail before
> pairing with HCI error 0x3e.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add Realtek RTL8821CE device 13d3:3558
    https://git.kernel.org/bluetooth/bluetooth-next/c/809a66378e9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


