Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA156DCE1
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442049; cv=none; b=U4m4DwN6XuApLWgLogv8Nup7NZuzeEnuJyI0YkqFGcfauLIhPYfoXXFYvr0L4E0Cn3oECGlop7+TfcD6bK1vkCiczf3h3XAsdQ/sTG36Xm3ylo7u3fG53bnYkX1aGfjXgGH4D6T+wsWrefryG4A04M7jj8c1kxoBalM8ds1mDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442049; c=relaxed/simple;
	bh=VQgWjsmB+PCsgd4ZlTxWwNMjN8aRk7v4m52Tp3lTtnM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Z4Ttcdy8w7In0DiRgnBG5QC1R+p2tK5yCbPdtA0FlCgllzRtM6ywb9sz5/AzZlpJsahuFwmaRkBKGqkOth2CrVCRtau6OG9VuLTTwdjjRapE1a3ZMzgg4F+TSLuRZ9rkGAPXr1nQrD+F7vOC/TKDfg764KpwX1M/4JWvkkpPxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GbyvFyUo; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GbyvFyUo"
Received: from github.com (hubbernetes-node-07d554e.va3-iad.github.net [10.48.145.21])
	by smtp.github.com (Postfix) with ESMTPA id 9632A8C07FC
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745442047;
	bh=N/zWA59isA0V/TYhXxQBZsprgcwaUrR5sD1Vz6GcKug=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GbyvFyUokm75nOpmr3839lQZT5PDbxule04evc4sjR83oxcqOC7mdxfzWshAapGvx
	 GqnCIeAryOKKfyxZh3h83fO1wBDQPEsa7NKnS4z1AOV2FgCb8vGN3WeB2RwDi8ftP4
	 hN6rq7gnT3kt5bIN8hBypMkn09wBu2PU3rL9BvV8=
Date: Wed, 23 Apr 2025 14:00:47 -0700
From: Arun Raghavan <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6c582e-629672@github.com>
Subject: [bluez/bluez] 918432: profiles/audio: asha: Reset state on disconnect
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 918432b2c68dd40c180885d10e61b35da42f5358
      https://github.com/bluez/bluez/commit/918432b2c68dd40c180885d10e61b35da42f5358
  Author: Sanchayan Maity <sanchayan@asymptotic.io>
  Date:   2025-04-23 (Wed, 23 Apr 2025)

  Changed paths:
    M src/shared/asha.c

  Log Message:
  -----------
  profiles/audio: asha: Reset state on disconnect


  Commit: 1b137c4bad24b9010cdced5c31d00309bf110608
      https://github.com/bluez/bluez/commit/1b137c4bad24b9010cdced5c31d00309bf110608
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2025-04-23 (Wed, 23 Apr 2025)

  Changed paths:
    M profiles/audio/asha.c
    M src/shared/asha.c
    M src/shared/asha.h

  Log Message:
  -----------
  profiles/audio: asha: Only expose device after we have attributes

Let's get the PSM and read-only properties before we expose the device
and transport. While we're at it, rename "probe" as "attach" for
consistency.


  Commit: 629672307f6c07cdeccc3be2a8fb33b104210b02
      https://github.com/bluez/bluez/commit/629672307f6c07cdeccc3be2a8fb33b104210b02
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2025-04-23 (Wed, 23 Apr 2025)

  Changed paths:
    M src/shared/asha.c
    M src/shared/asha.h

  Log Message:
  -----------
  shared/asha: Use a more descriptive name for the state callback


Compare: https://github.com/bluez/bluez/compare/6c582e7e1360...629672307f6c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
