Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA27149C64
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834944; cv=none; b=IAqvBajXAo2u+umPMTxCiaGtyXojFmrLQzOUw97CJYcf2s5h5tBOcwszOkUnmHY3t3T2cB/63DGWb1Ia8Gm2Gs334xRzYOdakIUos1s953g9fpHLiMQK2uRYM/vGuYuyDwztbJdCSLM4vlXhXMl3k0CKJgFNyEe23mscZ7KHfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834944; c=relaxed/simple;
	bh=us35E7mPh16CGCx3ZQ0h3VQwI2q0rnWcSWc0LLXYvFA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DD6/mgHVEe27kWKP3iZBkRxb0yt3sIR/uhfaiICNNJ5aiN0yxI6UjI7BvDZm2WjnWtkORiS8FmZD5nyTKdP72MKg9j97/zHOsrJjJFZJvL1uA9YFX809cKAlN9NF3ZFkEkFpeYwarw77qRmo4kKnQjbT7Xoz4ZVmaTsUn00Bqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Sa6XWfYg; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Sa6XWfYg"
Received: from github.com (hubbernetes-node-1d7443e.va3-iad.github.net [10.48.161.40])
	by smtp.github.com (Postfix) with ESMTPA id 540CFE0A39
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Jun 2025 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749834942;
	bh=qw6QMVIhAA+ZPp//ZPnu7C8vb+XvCsE8vV6fiawGmSM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Sa6XWfYgrTe94UsVCPgHgPyBbzM5klUxkUIh+RXEjdn98dpfvk9XmR1yKpp7229ft
	 8mtCvLeqZCIBgnWjZitj5pmeXT9IG6gn+OORDMcu1C0B0YgdwYAOp3oauR56V39vI6
	 PdGvhVXpv8O0m1eCi8TllkoRnWY5x4pHbAILhi40=
Date: Fri, 13 Jun 2025 10:15:42 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/971929/000000-455bc7@github.com>
Subject: [bluez/bluez] 455bc7: client: Add prompt to enter metadata for custom
 pr...
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

  Branch: refs/heads/971929
  Home:   https://github.com/bluez/bluez
  Commit: 455bc748ba4c3fa9122fa18d7c13cb6304fc351e
      https://github.com/bluez/bluez/commit/455bc748ba4c3fa9122fa18d7c13cb6304fc351e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-13 (Fri, 13 Jun 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Add prompt to enter metadata for custom presets

When adding a custom preset prompt the user to enter metadata for it
e.g.:

[bluetoothctl]> endpoint.presets 00002bcb-0000-1000-8000-00805f9b34fb 0x06 custom
[Codec] Enter frequency (Khz): **
[Codec] Enter frame duration (ms): *
[Codec] Enter channel allocation: *
[Codec] Enter frame length: **
[Metadata] Enter Metadata (value/no): <len> <type> <value...>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
