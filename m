Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7112622256C
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jan 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439410; cv=none; b=G8mE3O892Qlk+a0+o4AfUC/3QqfEVaBx3PxjCEAiSPZaANUDZYuyCrXyXS9DYOq/BbOVWKFw1Nt3VCC02hxKSIk5jWTH5Ir74Pnqvpz+KeCHii2216B5chA7uLl8kiv/TaTt66p7hi12feMalLx8D2dCmdVYhxBOsZQuLajfauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439410; c=relaxed/simple;
	bh=YvEkxMQPJrlksaBIvOha8KL0SrkDqSCJFHa4pBWzb+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M5MGzXKZ7TKm+1Z6Y0wN5HADn9KHnRXqxJMab30B0xAKLAxFQwYemM5E1n4I3m9dZ5hbNQxXhmjE/Zib5Nce62SFA6HJ0nPpQE6rpkwsDUyQGLTM+yHVZ4DLy/6pJiMmeuoT/sTEfGycToIEAjp4lEUIOD/Qz3Z1ljnoCLVQhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNVGTd6w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNVGTd6w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0969DC4CED2;
	Thu,  9 Jan 2025 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439410;
	bh=YvEkxMQPJrlksaBIvOha8KL0SrkDqSCJFHa4pBWzb+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eNVGTd6w6Md4cO7qtaC3wrGeDCZpk3J4YKNtDBPzBfklvBdlQfdQuCspV+Q5aWL/K
	 4YQPaInsNJrSSmcYIwEa3Mwl5Y3/RD34vN+czURnyoe/KITDcL6oxfITdEkBaoda5F
	 iLlPCjaxZnspmVd5S96z+I3UIHRsd8qITOxwTGUUJpbKJuWXVHYBIG04UZV+3YXpGi
	 42f2ghS1ddVk7R3eFWR+AC52dKBnwn4nXv0IjW1ZxveR3CbLPfBq0J7KBLEMpfOCB0
	 U7NPaXpgJR7pG0fqP97o7ygaH8tDtlwASj3skoyqIAqEdNmAEACDyFk++C7SaBIMFh
	 U3/GMxiTPSNYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB30C380A97D;
	Thu,  9 Jan 2025 16:17:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Doc: Obex Implement support for message listing format
 version 1.1
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173643943149.1375203.16208448974957892.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:17:11 +0000
References: <20250107114532.3593843-1-quic_amisjain@quicinc.com>
In-Reply-To: <20250107114532.3593843-1-quic_amisjain@quicinc.com>
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 7 Jan 2025 17:15:32 +0530 you wrote:
> Add the documentation for the ‘Messages-Listing Format Version 1.1’
> feature for MCE.
> 
> ---
>  doc/org.bluez.obex.Message.rst | 39 ++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Here is the summary with links:
  - [v3] Doc: Obex Implement support for message listing format version 1.1
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=036041136f10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


