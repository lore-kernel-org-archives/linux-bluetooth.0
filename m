Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35009286D63
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764864190; cv=none; b=C4r6DMfokayGN/JTe8yfgGCY6KaFQlggxDpLgue//BEHonp5uiosoVyrJIPurZ93538b0fGdhdtv4MSNtOFB4tjPmy8cQSZsoa3TLyHpSSeDvQ8xJOilJ4j1bb8UAECzRsA+JD+8WhBtYdM2Z+CHDWYaeMHL18cYL8bITEUA388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764864190; c=relaxed/simple;
	bh=T8xRLFZ4ZQNxb2WwhwxuJJ1IDSgiTiYQjcU6Rj2P5vo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g7rquJZwPRyw7Pq6KA98x4R+W33PGYPb5uuyIxMl8yeUHukVgDrzD9sgVBAhRgZ3ReVU7WnlvtKHFueRusdbSjC+2TDF112TsNRjHwzL5GV7N7MwYv+DxmJnw+MTuirH4hlY2iC7+dC/FgQ1VqgP8iIZiJ7pCpYTUtv3B7xJZ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ/oinFp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ/oinFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EF1C116B1;
	Thu,  4 Dec 2025 16:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764864189;
	bh=T8xRLFZ4ZQNxb2WwhwxuJJ1IDSgiTiYQjcU6Rj2P5vo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gZ/oinFpS743AioXWFaBOIe1LxPFrKIR1tCSX/LfvHAC3wGL1GQeLr8cP/1IdJ77+
	 Us9yXj5u9FNbS5KgB7ciX6wdbOSl+jJZGNPv+mmyoUaNg5Sj9GSdaSU3HAQYe35XMT
	 jbU5Yh4JId0KF4x55vvFf3EUrVGae54UXBbFlfL1GncevTU6CUmXzsK96imHfUC0GR
	 AdQykF5Ka7eNOqttSzDp1RVbdXIPDDwVhX+rMTvf2T0cEbmXuVtX7awtpHDJWUhTJn
	 cE53gO03L49xG63I7TpQCw8pbSDpre8NeCWp321KyB+tJS5w8FntkP9X7OdzwtVRmH
	 jOZfKrxGFkddQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B26C3AA9ABB;
	Thu,  4 Dec 2025 16:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client: Fix transport.acquire auto not working
 as
 initiator
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176486400793.832454.1631055037045046996.git-patchwork-notify@kernel.org>
Date: Thu, 04 Dec 2025 16:00:07 +0000
References: <20251202201810.2022976-1-luiz.dentz@gmail.com>
In-Reply-To: <20251202201810.2022976-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Dec 2025 15:18:10 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Transports configured as client/initiator do not transit to
> State:pending since that is used to indicate that a stream has been
> configured and has to be accepted, when acting as initiator role
> SelectProperties/SelectConfiguration can used to indicate that
> endpoint stream configuration has been initiated locally so use that
> to mark endpoint to auto configure if that has been set.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] client: Fix transport.acquire auto not working as initiator
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d383c81f848d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


