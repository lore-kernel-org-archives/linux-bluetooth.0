Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EDD22D783
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121024; cv=none; b=tTrTfxUFa2k/wuBiGfyqi5cykMn5COhF85cacpHMCcSNDR35eLtqHb9kmIVkkOQj7IYNy4NItkQfqdduQRAKpOupHdGJYD56WYjDPHf0ci9Wk/9treJP8I0HixCuVk+xwkuT4d+NSnslqEk/bV751BwiGKZ90nO8MrN8DNgSZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121024; c=relaxed/simple;
	bh=0sWs6GHQlSuBkgnWY3Fr33CgXjRQPaR7rqQJQVd2nfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dMWCQea7gtmCfOfm5bCd09f1oarFTPz+IpE+/9fUC7BTzCpwbHAkzE7GuSzZnpxyBjgR1eNC0pcYsABdDa41f8472VeCOcU4iAeiovX9HOWFcfa4NstCehNJ+zHsYdNmgz/2i1RiRJiE5HsPdW0UYJ6eDqw1M8KkmUpLYTLwkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlPcjlOY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlPcjlOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1575DC4CEE5;
	Tue,  8 Apr 2025 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744121024;
	bh=0sWs6GHQlSuBkgnWY3Fr33CgXjRQPaR7rqQJQVd2nfw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jlPcjlOY3zuCH2DbaF4iGEbNh/IPMXufMVEgl998KO+VzDOp9VUMWhTIIyAChTyEj
	 Bw1fWqnbvlsc2r2blxkZeNX/1XLYx48h9PKnyrvX/VnUdHtCZnHaU4j7raExTt6km2
	 nbd0kZMLmvxgxQfRbU2xzvjvP3J8v+f3vg3DKrY/kBHC9Qagmw/Vk6nmHSkwMWKi7B
	 aqvXREBPhq5TFGkOWDdpXPd1CL1TFIpGbQfQIalBY8sg8okypPvBJx5bW32Hb2ewos
	 lXn17S0UYAhFKkYWB6rB+RVFZUOrePuQpwHpYKokeLTdvpTMvp7feARUjcdawYRkC0
	 73UZXR1lVccuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4338111D4;
	Tue,  8 Apr 2025 14:04:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 00/15] BAP Server test cases
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174412106123.1926106.11836112789749291152.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 14:04:21 +0000
References: <20250407200124.881534-1-luiz.dentz@gmail.com>
In-Reply-To: <20250407200124.881534-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  7 Apr 2025 16:01:06 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This implements the following BAP Server test cases, and required fixes, from
> the testing specification:
> 
> BAP/USR/DISC/BV-01-C
> BAP/USR/DISC/BV-02-C
> BAP/USR/DISC/BV-06-C
> BAP/USR/DISC/BV-07-C
> BAP/USR/DISC/BV-03-C
> BAP/USR/DISC/BV-04-C
> BAP/USR/DISC/BV-05-C
> BAP/USR/SCC/BV-001-C [USR SNK Config Codec, LC3 8_1]
> BAP/USR/SCC/BV-002-C [USR SNK Config Codec, LC3 8_2]
> BAP/USR/SCC/BV-003-C [USR SNK Config Codec, LC3 16_1]
> BAP/USR/SCC/BV-004-C [USR SNK Config Codec, LC3 16_2]
> BAP/USR/SCC/BV-005-C [USR SNK Config Codec, LC3 24_1]
> BAP/USR/SCC/BV-006-C [USR SNK Config Codec, LC3 24_2]
> BAP/USR/SCC/BV-007-C [USR SNK Config Codec, LC3 32_1]
> BAP/USR/SCC/BV-008-C [USR SNK Config Codec, LC3 32_2]
> BAP/USR/SCC/BV-009-C [USR SNK Config Codec, LC3 44.1_1]
> BAP/USR/SCC/BV-010-C [USR SNK Config Codec, LC3 44.1_2]
> BAP/USR/SCC/BV-011-C [USR SNK Config Codec, LC3 48_1]
> BAP/USR/SCC/BV-012-C [USR SNK Config Codec, LC3 48_2]
> BAP/USR/SCC/BV-013-C [USR SNK Config Codec, LC3 48_3]
> BAP/USR/SCC/BV-014-C [USR SNK Config Codec, LC3 48_4]
> BAP/USR/SCC/BV-015-C [USR SNK Config Codec, LC3 48_5]
> BAP/USR/SCC/BV-016-C [USR SNK Config Codec, LC3 48_6]
> BAP/USR/SCC/BV-017-C [USR SRC Config Codec, LC3 8_1]
> BAP/USR/SCC/BV-018-C [USR SRC Config Codec, LC3 8_2]
> BAP/USR/SCC/BV-019-C [USR SRC Config Codec, LC3 16_1]
> BAP/USR/SCC/BV-020-C [USR SRC Config Codec, LC3 16_2]
> BAP/USR/SCC/BV-021-C [USR SRC Config Codec, LC3 24_1]
> BAP/USR/SCC/BV-022-C [USR SRC Config Codec, LC3 24_2]
> BAP/USR/SCC/BV-023-C [USR SRC Config Codec, LC3 32_1]
> BAP/USR/SCC/BV-024-C [USR SRC Config Codec, LC3 32_2]
> BAP/USR/SCC/BV-025-C [USR SRC Config Codec, LC3 44.1_1]
> BAP/USR/SCC/BV-026-C [USR SRC Config Codec, LC3 44.1_2]
> BAP/USR/SCC/BV-027-C [USR SRC Config Codec, LC3 48_1]
> BAP/USR/SCC/BV-028-C [USR SRC Config Codec, LC3 48_2]
> BAP/USR/SCC/BV-029-C [USR SRC Config Codec, LC3 48_3]
> BAP/USR/SCC/BV-030-C [USR SRC Config Codec, LC3 48_4]
> BAP/USR/SCC/BV-031-C [USR SRC Config Codec, LC3 48_5]
> BAP/USR/SCC/BV-032-C [USR SRC Config Codec, LC3 48_6]
> BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS]
> BAP/USR/SCC/BV-034-C [USR SRC Config Codec, VS]
> BAP/USR/SCC/BV-069-C [USR SNK Config QoS, LC3 8_1_1]
> BAP/USR/SCC/BV-070-C [USR SNK Config QoS, LC3 8_2_1]
> BAP/USR/SCC/BV-071-C [USR SNK Config QoS, LC3 16_1_1]
> BAP/USR/SCC/BV-072-C [USR SNK Config QoS, LC3 16_2_1]
> BAP/USR/SCC/BV-073-C [USR SNK Config QoS, LC3 24_1_1]
> BAP/USR/SCC/BV-074-C [USR SNK Config QoS, LC3 24_2_1]
> BAP/USR/SCC/BV-075-C [USR SNK Config QoS, LC3 32_1_1]
> BAP/USR/SCC/BV-076-C [USR SNK Config QoS, LC3 32_2_1]
> BAP/USR/SCC/BV-077-C [USR SNK Config QoS, LC3 44.1_1_1]
> BAP/USR/SCC/BV-078-C [USR SNK Config QoS, LC3 44.1_2_1]
> BAP/USR/SCC/BV-079-C [USR SNK Config QoS, LC3 48_1_1]
> BAP/USR/SCC/BV-080-C [USR SNK Config QoS, LC3 48_2_1]
> BAP/USR/SCC/BV-081-C [USR SNK Config QoS, LC3 48_3_1]
> BAP/USR/SCC/BV-082-C [USR SNK Config QoS, LC3 48_4_1]
> BAP/USR/SCC/BV-083-C [USR SNK Config QoS, LC3 48_5_1]
> BAP/USR/SCC/BV-084-C [USR SNK Config QoS, LC3 48_6_1]
> BAP/USR/SCC/BV-085-C [USR SRC Config QoS, LC3 8_1_1]
> BAP/USR/SCC/BV-086-C [USR SRC Config QoS, LC3 8_2_1]
> BAP/USR/SCC/BV-087-C [USR SRC Config QoS, LC3 16_1_1]
> BAP/USR/SCC/BV-088-C [USR SRC Config QoS, LC3 16_2_1]
> BAP/USR/SCC/BV-089-C [USR SRC Config QoS, LC3 24_1_1]
> BAP/USR/SCC/BV-090-C [USR SRC Config QoS, LC3 24_2_1]
> BAP/USR/SCC/BV-091-C [USR SRC Config QoS, LC3 32_1_1]
> BAP/USR/SCC/BV-092-C [USR SRC Config QoS, LC3 32_2_1]
> BAP/USR/SCC/BV-093-C [USR SRC Config QoS, LC3 44.1_1_1]
> BAP/USR/SCC/BV-094-C [USR SRC Config QoS, LC3 44.1_2_1]
> BAP/USR/SCC/BV-095-C [USR SRC Config QoS, LC3 48_1_1]
> BAP/USR/SCC/BV-096-C [USR SRC Config QoS, LC3 48_2_1]
> BAP/USR/SCC/BV-097-C [USR SRC Config QoS, LC3 48_3_1]
> BAP/USR/SCC/BV-098-C [USR SRC Config QoS, LC3 48_4_1]
> BAP/USR/SCC/BV-099-C [USR SRC Config QoS, LC3 48_5_1]
> BAP/USR/SCC/BV-100-C [USR SRC Config QoS, LC3 48_6_1]
> BAP/USR/SCC/BV-101-C [USR SNK Config QoS, LC3 8_1_2]
> BAP/USR/SCC/BV-102-C [USR SNK Config QoS, LC3 8_2_2]
> BAP/USR/SCC/BV-103-C [USR SNK Config QoS, LC3 16_1_2]
> BAP/USR/SCC/BV-104-C [USR SNK Config QoS, LC3 16_2_2]
> BAP/USR/SCC/BV-105-C [USR SNK Config QoS, LC3 24_1_2]
> BAP/USR/SCC/BV-106-C [USR SNK Config QoS, LC3 24_2_2]
> BAP/USR/SCC/BV-107-C [USR SNK Config QoS, LC3 32_1_2]
> BAP/USR/SCC/BV-108-C [USR SNK Config QoS, LC3 32_2_2]
> BAP/USR/SCC/BV-109-C [USR SNK Config QoS, LC3 44.1_1_2]
> BAP/USR/SCC/BV-110-C [USR SNK Config QoS, LC3 44.1_2_2]
> BAP/USR/SCC/BV-111-C [USR SNK Config QoS, LC3 48_1_2]
> BAP/USR/SCC/BV-112-C [USR SNK Config QoS, LC3 48_2_2]
> BAP/USR/SCC/BV-113-C [USR SNK Config QoS, LC3 48_3_2]
> BAP/USR/SCC/BV-114-C [USR SNK Config QoS, LC3 48_4_2]
> BAP/USR/SCC/BV-115-C [USR SNK Config QoS, LC3 48_5_2]
> BAP/USR/SCC/BV-116-C [USR SNK Config QoS, LC3 48_6_2]
> BAP/USR/SCC/BV-117-C [USR SRC Config QoS, LC3 8_1_2]
> BAP/USR/SCC/BV-118-C [USR SRC Config QoS, LC3 8_2_2]
> BAP/USR/SCC/BV-119-C [USR SRC Config QoS, LC3 16_1_2]
> BAP/USR/SCC/BV-120-C [USR SRC Config QoS, LC3 16_2_2]
> BAP/USR/SCC/BV-121-C [USR SRC Config QoS, LC3 24_1_2]
> BAP/USR/SCC/BV-122-C [USR SRC Config QoS, LC3 24_2_2]
> BAP/USR/SCC/BV-123-C [USR SRC Config QoS, LC3 32_1_2]
> BAP/USR/SCC/BV-124-C [USR SRC Config QoS, LC3 32_2_2]
> BAP/USR/SCC/BV-125-C [USR SRC Config QoS, LC3 44.1_1_2]
> BAP/USR/SCC/BV-126-C [USR SRC Config QoS, LC3 44.1_2_2]
> BAP/USR/SCC/BV-127-C [USR SRC Config QoS, LC3 48_1_2]
> BAP/USR/SCC/BV-128-C [USR SRC Config QoS, LC3 48_2_2]
> BAP/USR/SCC/BV-129-C [USR SRC Config QoS, LC3 48_3_2]
> BAP/USR/SCC/BV-130-C [USR SRC Config QoS, LC3 48_4_2]
> BAP/USR/SCC/BV-131-C [USR SRC Config QoS, LC3 48_5_2]
> BAP/USR/SCC/BV-132-C [USR SRC Config QoS, LC3 48_6_2]
> BAP/USR/SCC/BV-133-C [USR SNK Config QoS, VS]
> BAP/USR/SCC/BV-134-C [USR SRC Config QoS, VS]
> BAP/USR/SCC/BV-135-C [USR SNK Enable]
> BAP/USR/SCC/BV-136-C [UCL SRC Enable]
> BAP/USR/SCC/BV-137-C [USR SRC Disable in Enabling State]
> BAP/USR/SCC/BV-138-C [USR SNK Disable in Enabling or Streaming state]
> BAP/USR/SCC/BV-139-C [USR SRC Disable in Streaming State]
> BAP/USR/SCC/BV-143-C [USR SRC Release in Codec Configured state]
> BAP/USR/SCC/BV-144-C [USR SNK Release in Codec Configured state]
> BAP/USR/SCC/BV-145-C [USR SRC Release in QoS Configured state]
> BAP/USR/SCC/BV-146-C [USR SNK Release in QoS Configured state]
> BAP/USR/SCC/BV-147-C [USR SRC Release in Enabling state]
> BAP/USR/SCC/BV-148-C [USR SNK Release in Enabling or Streaming state]
> BAP/USR/SCC/BV-149-C [USR SRC Release in Streaming state]
> BAP/USR/SCC/BV-150-C [USR SRC Release in Disabling state]
> BAP/USR/SCC/BV-161-C [USR SRC Update Metadata in Enabling State]
> BAP/USR/SCC/BV-162-C [USR SNK Update Metadata in Enabling or Streaming state]
> BAP/USR/SCC/BV-163-C [USR SRC Update Metadata in Streaming State]
> BAP/USR/STR/BV-001-C [USR, AC 2, LC3 8_1_1]
> BAP/USR/STR/BV-002-C [USR, AC 10, LC3 8_1_1]
> BAP/USR/STR/BV-003-C [USR, AC 2, LC3 8_2_1]
> BAP/USR/STR/BV-004-C [USR, AC 10, LC3 8_2_1]
> BAP/USR/STR/BV-005-C [USR, AC 2, LC3 16_1_1]
> BAP/USR/STR/BV-006-C [USR, AC 10, LC3 16_1_1]
> BAP/USR/STR/BV-007-C [USR, AC 2, LC3 16_2_1]
> BAP/USR/STR/BV-008-C [USR, AC 10, LC3 16_2_1]
> BAP/USR/STR/BV-009-C [USR, AC 2, LC3 24_1_1]
> BAP/USR/STR/BV-010-C [USR, AC 10, LC3 24_1_1]
> BAP/USR/STR/BV-011-C [USR, AC 2, LC3 24_2_1]
> BAP/USR/STR/BV-012-C [USR, AC 10, LC3 24_2_1]
> BAP/USR/STR/BV-013-C [USR, AC 2, LC3 32_1_1]
> BAP/USR/STR/BV-014-C [USR, AC 10, LC3 32_1_1]
> BAP/USR/STR/BV-015-C [USR, AC 2, LC3 32_2_1]
> BAP/USR/STR/BV-016-C [USR, AC 10, LC3 32_2_1]
> BAP/USR/STR/BV-017-C [USR, AC 2, LC3 441_1_1]
> BAP/USR/STR/BV-018-C [USR, AC 10, LC3 441_1_1]
> BAP/USR/STR/BV-019-C [USR, AC 2, LC3 44_2_1]
> BAP/USR/STR/BV-020-C [USR, AC 10, LC3 44_2_1]
> BAP/USR/STR/BV-021-C [USR, AC 2, LC3 48_1_1]
> BAP/USR/STR/BV-022-C [USR, AC 10, LC3 48_1_1]
> BAP/USR/STR/BV-023-C [USR, AC 2, LC3 48_2_1]
> BAP/USR/STR/BV-024-C [USR, AC 10, LC3 48_2_1]
> BAP/USR/STR/BV-025-C [USR, AC 2, LC3 48_3_1]
> BAP/USR/STR/BV-026-C [USR, AC 10, LC3 48_3_1]
> BAP/USR/STR/BV-027-C [USR, AC 2, LC3 48_4_1]
> BAP/USR/STR/BV-028-C [USR, AC 10, LC3 48_4_1]
> BAP/USR/STR/BV-029-C [USR, AC 2, LC3 48_5_1]
> BAP/USR/STR/BV-030-C [USR, AC 10, LC3 48_5_1]
> BAP/USR/STR/BV-031-C [USR, AC 2, LC3 48_6_1]
> BAP/USR/STR/BV-032-C [USR, AC 10, LC3 48_6_1]
> BAP/USR/STR/BV-033-C [USR, SRC, AC 1, LC3 8_1_1]
> BAP/USR/STR/BV-034-C [USR, SRC, AC 4, LC3 8_1_1]
> BAP/USR/STR/BV-035-C [USR, SRC, AC 1, LC3 8_2_1]
> BAP/USR/STR/BV-036-C [USR, SRC, AC 4, LC3 8_2_1]
> BAP/USR/STR/BV-037-C [USR, SRC, AC 1, LC3 16_1_1]
> BAP/USR/STR/BV-038-C [USR, SRC, AC 4, LC3 16_1_1]
> BAP/USR/STR/BV-039-C [USR, SRC, AC 1, LC3 16_2_1]
> BAP/USR/STR/BV-040-C [USR, SRC, AC 4, LC3 16_2_1]
> BAP/USR/STR/BV-041-C [USR, SRC, AC 1, LC3 24_1_1]
> BAP/USR/STR/BV-042-C [USR, SRC, AC 4, LC3 24_1_1]
> BAP/USR/STR/BV-043-C [USR, SRC, AC 1, LC3 24_2_1]
> BAP/USR/STR/BV-044-C [USR, SRC, AC 4, LC3 24_2_1]
> BAP/USR/STR/BV-045-C [USR, SRC, AC 1, LC3 32_1_1]
> BAP/USR/STR/BV-046-C [USR, SRC, AC 4, LC3 32_1_1]
> BAP/USR/STR/BV-047-C [USR, SRC, AC 1, LC3 32_2_1]
> BAP/USR/STR/BV-048-C [USR, SRC, AC 4, LC3 32_2_1]
> BAP/USR/STR/BV-049-C [USR, SRC, AC 1, LC3 44_1_1]
> BAP/USR/STR/BV-050-C [USR, SRC, AC 4, LC3 44_1_1]
> BAP/USR/STR/BV-051-C [USR, SRC, AC 1, LC3 44_2_1]
> BAP/USR/STR/BV-052-C [USR, SRC, AC 4, LC3 44_2_1]
> BAP/USR/STR/BV-053-C [USR, SRC, AC 1, LC3 48_1_1]
> BAP/USR/STR/BV-054-C [USR, SRC, AC 4, LC3 48_1_1]
> BAP/USR/STR/BV-055-C [USR, SRC, AC 1, LC3 48_2_1]
> BAP/USR/STR/BV-056-C [USR, SRC, AC 4, LC3 48_2_1]
> BAP/USR/STR/BV-057-C [USR, SRC, AC 1, LC3 48_3_1]
> BAP/USR/STR/BV-058-C [USR, SRC, AC 4, LC3 48_3_1]
> BAP/USR/STR/BV-059-C [USR, SRC, AC 1, LC3 48_4_1]
> BAP/USR/STR/BV-060-C [USR, SRC, AC 4, LC3 48_4_1]
> BAP/USR/STR/BV-061-C [USR, SRC, AC 1, LC3 48_5_1]
> BAP/USR/STR/BV-062-C [USR, SRC, AC 4, LC3 48_5_1]
> BAP/USR/STR/BV-063-C [USR, SRC, AC 1, LC3 48_6_1]
> BAP/USR/STR/BV-064-C [USR, SRC, AC 4, LC3 48_6_1]
> BAP/USR/STR/BV-065-C [USR, AC 2, LC3 8_1_2]
> BAP/USR/STR/BV-066-C [USR, AC 10, LC3 8_1_2]
> BAP/USR/STR/BV-067-C [USR, AC 2, LC3 8_2_2]
> BAP/USR/STR/BV-068-C [USR, AC 10, LC3 8_2_2]
> BAP/USR/STR/BV-069-C [USR, AC 2, LC3 16_1_2]
> BAP/USR/STR/BV-070-C [USR, AC 10, LC3 16_1_2]
> BAP/USR/STR/BV-071-C [USR, AC 2, LC3 16_2_2]
> BAP/USR/STR/BV-072-C [USR, AC 10, LC3 16_2_2]
> BAP/USR/STR/BV-073-C [USR, AC 2, LC3 24_1_2]
> BAP/USR/STR/BV-074-C [USR, AC 10, LC3 24_1_2]
> BAP/USR/STR/BV-075-C [USR, AC 2, LC3 24_2_2]
> BAP/USR/STR/BV-076-C [USR, AC 10, LC3 24_2_2]
> BAP/USR/STR/BV-077-C [USR, AC 2, LC3 32_1_2]
> BAP/USR/STR/BV-078-C [USR, AC 10, LC3 32_1_2]
> BAP/USR/STR/BV-079-C [USR, AC 2, LC3 32_2_2]
> BAP/USR/STR/BV-080-C [USR, AC 10, LC3 32_2_2]
> BAP/USR/STR/BV-081-C [USR, AC 2, LC3 44_1_2]
> BAP/USR/STR/BV-082-C [USR, AC 10, LC3 44_1_2]
> BAP/USR/STR/BV-083-C [USR, AC 2, LC3 44_2_2]
> BAP/USR/STR/BV-084-C [USR, AC 10, LC3 44_2_2]
> BAP/USR/STR/BV-085-C [USR, AC 2, LC3 48_1_2]
> BAP/USR/STR/BV-086-C [USR, AC 10, LC3 48_1_2]
> BAP/USR/STR/BV-087-C [USR, AC 2, LC3 48_2_2]
> BAP/USR/STR/BV-088-C [USR, AC 10, LC3 48_2_2]
> BAP/USR/STR/BV-089-C [USR, AC 2, LC3 48_3_2]
> BAP/USR/STR/BV-090-C [USR, AC 10, LC3 48_3_2]
> BAP/USR/STR/BV-091-C [USR, AC 2, LC3 48_4_2]
> BAP/USR/STR/BV-092-C [USR, AC 10, LC3 48_4_2]
> BAP/USR/STR/BV-093-C [USR, AC 2, LC3 48_5_2]
> BAP/USR/STR/BV-094-C [USR, AC 10, LC3 48_5_2]
> BAP/USR/STR/BV-095-C [USR, AC 2, LC3 48_6_2]
> BAP/USR/STR/BV-096-C [USR, AC 10, LC3 48_6_2]
> BAP/USR/STR/BV-097-C [USR, SRC, AC 1, LC3 8_1_2]
> BAP/USR/STR/BV-098-C [USR, SRC, AC 4, LC3 8_1_2]
> BAP/USR/STR/BV-099-C [USR, SRC, AC 1, LC3 8_2_2]
> BAP/USR/STR/BV-100-C [USR, SRC, AC 4, LC3 8_2_2]
> BAP/USR/STR/BV-101-C [USR, SRC, AC 1, LC3 16_1_2]
> BAP/USR/STR/BV-102-C [USR, SRC, AC 4, LC3 16_1_2]
> BAP/USR/STR/BV-103-C [USR, SRC, AC 1, LC3 16_2_2]
> BAP/USR/STR/BV-104-C [USR, SRC, AC 4, LC3 16_2_2]
> BAP/USR/STR/BV-105-C [USR, SRC, AC 1, LC3 24_1_2]
> BAP/USR/STR/BV-106-C [USR, SRC, AC 4, LC3 24_1_2]
> BAP/USR/STR/BV-107-C [USR, SRC, AC 1, LC3 24_2_2]
> BAP/USR/STR/BV-108-C [USR, SRC, AC 4, LC3 24_2_2]
> BAP/USR/STR/BV-109-C [USR, SRC, AC 1, LC3 32_1_2]
> BAP/USR/STR/BV-110-C [USR, SRC, AC 4, LC3 32_1_2]
> BAP/USR/STR/BV-111-C [USR, SRC, AC 1, LC3 32_2_2]
> BAP/USR/STR/BV-112-C [USR, SRC, AC 4, LC3 32_2_2]
> BAP/USR/STR/BV-113-C [USR, SRC, AC 1, LC3 44_1_2]
> BAP/USR/STR/BV-114-C [USR, SRC, AC 4, LC3 44_1_2]
> BAP/USR/STR/BV-115-C [USR, SRC, AC 1, LC3 44_2_2]
> BAP/USR/STR/BV-116-C [USR, SRC, AC 4, LC3 44_2_2]
> BAP/USR/STR/BV-117-C [USR, SRC, AC 1, LC3 48_1_2]
> BAP/USR/STR/BV-118-C [USR, SRC, AC 4, LC3 48_1_2]
> BAP/USR/STR/BV-119-C [USR, SRC, AC 1, LC3 48_2_2]
> BAP/USR/STR/BV-120-C [USR, SRC, AC 4, LC3 48_2_2]
> BAP/USR/STR/BV-121-C [USR, SRC, AC 1, LC3 48_3_2]
> BAP/USR/STR/BV-122-C [USR, SRC, AC 4, LC3 48_3_2]
> BAP/USR/STR/BV-123-C [USR, SRC, AC 1, LC3 48_4_2]
> BAP/USR/STR/BV-124-C [USR, SRC, AC 4, LC3 48_4_2]
> BAP/USR/STR/BV-121-C [USR, SRC, AC 1, LC3 48_5_2]
> BAP/USR/STR/BV-122-C [USR, SRC, AC 4, LC3 48_5_2]
> BAP/USR/STR/BV-123-C [USR, SRC, AC 1, LC3 48_6_2]
> BAP/USR/STR/BV-124-C [USR, SRC, AC 4, LC3 48_6_2]
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,01/15] test-bap: Introduce DISC tests for LC3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ad5f318cd71a
  - [BlueZ,v2,02/15] test-bap: Introduce USR/SCC tests for LC3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9d6138923ad8
  - [BlueZ,v2,03/15] test-bap: Introduce USR/SCC - VS tests for LC3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a3be1992b27
  - [BlueZ,v2,04/15] test-bap: Introduce USR/SCC QoS tests for LC3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8890cd714fc0
  - [BlueZ,v2,05/15] test-bap: Introduce USR/SCC QoS tests for VS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fd45490650ba
  - [BlueZ,v2,06/15] test-bap: Introduce USR/SCC Enable tests for LC3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f2e717548f1d
  - [BlueZ,v2,07/15] test-bap: Introduce USR/SCC Enable tests for LC3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=88cacb8fd38e
  - [BlueZ,v2,08/15] shared/bap: Fix not always sending Releasing state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dfebcc9c100c
  - [BlueZ,v2,09/15] shared/bap: Fix not notifying idle state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=15fd57f26079
  - [BlueZ,v2,10/15] test-bap: Introduce USR/SCC Release tests for LC3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=da110920dda8
  - [BlueZ,v2,11/15] shared/bap: Fix not sending ASE Notication in case of Metadata update
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ae5fe4aafe81
  - [BlueZ,v2,12/15] test-bap: Introduce USR/SCC Metadata tests for LC3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7d4fc8021652
  - [BlueZ,v2,13/15] shared/bap: Fix notifying with the wrong state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=713655c10fe2
  - [BlueZ,v2,14/15] shared/tester: Fix not detecting NULL packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ed9fb8ae7acd
  - [BlueZ,v2,15/15] test-bap: Introduce USR/STR tests for LC3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e367244efcce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


