Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674332EAF7
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Dec 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733175620; cv=none; b=iv4EBOB+R2OniJCTanwD7Z8l5LrnVWPXa2//edENAvnvCkXh/fWrOgosuSUCAyHT7E4vU2oaSMaKuyRILv6XJuFoihJikua6rWZAlZlHVTeCnJ0ON/TEVKDTvpyiQ0jCCWLOSwFoKi/vVLIEaiQtFUjungT3bl5CQkXB6SPnW20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733175620; c=relaxed/simple;
	bh=PQ3ULjvQ/2U+YoiP2FUtVLB3O5JpvvQ0j4qVFAQyfkc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uk7aksUL2ODeYEpZVBmckgF/d7UnLyQgWG/8ewJdZK6lNCBhorNIrOFFbAmH2v87qaMexMMqq50bKNIinbZ0zq059/eMmSei/aW3+Nc7IT5OW0Cq9sRceZo+UMm0JswpP/+jB60mp5OEL0riCAyBBT67q1vCL1U/Xh8Z5Ov8V/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joboocTa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joboocTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D735CC4CED1;
	Mon,  2 Dec 2024 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733175619;
	bh=PQ3ULjvQ/2U+YoiP2FUtVLB3O5JpvvQ0j4qVFAQyfkc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=joboocTaTmUrNZH5yKnddHskZ81DCRH7VX3sWnZhdCe0aFWq8e5hLrnLytaaQe1K9
	 Hoxbyoc5O2VwiqM0vGI5GhyXpZJdxs4TUkdaPiZFgpqCBJLAjkBvWv7DgCU08nyVV3
	 gqe9EkE4hDdS+DGfhYC0yzFOEgYHvXCsIWUViVEwFfEaVIrM19GpccQeAQmZy9IsPJ
	 8/ZKCPRwpmG0Ab44+HOSw5qENcB7JV7eA0OMjMo/QHSZy+k5Xipyz3himdgcV8u0Y+
	 YlcdXbfPBjlwJzaeIWoJitHqiGD+6vquPd7Yqza5xn3DAKeenI9LK2FGh/Pz6gb8+J
	 aBHuaR8kS/Qhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E2E3806656;
	Mon,  2 Dec 2024 21:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ 1/2] profiles/audio: Quiet plug-in warnings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173317563374.3902418.18033009959697183180.git-patchwork-notify@kernel.org>
Date: Mon, 02 Dec 2024 21:40:33 +0000
References: <20241127115007.1303616-1-hadess@hadess.net>
In-Reply-To: <20241127115007.1303616-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Nov 2024 12:49:52 +0100 you wrote:
> A normal daemon start should not throw warnings on a system in the
> default configuration. Quiet the plug-in warnings that require
> experimental features to be enabled. They will still appear in the debug
> output.
> 
> bluetoothd[896]: profiles/audio/micp.c:micp_init() D-Bus experimental not enabled
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] profiles/audio: Quiet plug-in warnings
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fdcde2ce2112
  - [BlueZ,2/2] plugin: Quiet start-up warnings
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=252883241228

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


