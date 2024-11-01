Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2C1CB321
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482225; cv=none; b=k2ruNCeNcBtVhBlWu0XS3B4nrwRAEVpdDgNgXXFCD6USGvOtpnqIRljv9s7WTEDkMnehOERn5h7k0p/Bt2PX1OG8LDEDJ/vRyMYniuia7tCCjp98QB+hNtSjEcIT+vfB8Cbhmt3mP5Dq/zFh8GRwpmGKS7LI4oU8Bo0h/aBatZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482225; c=relaxed/simple;
	bh=FVZPuSGJO0s/lvP7aNnUoaGtQ6CzzLkSpIOi86nrKSA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Oy1SHteZ30KjcxIwCIUPoefZiqR7E6OFkvocR9AiAxsisV34c35EjhgNdIZnulnseZxN7Xb+efBSjKX/QGKD3jLW9v6vPoT1fo5fl8rV1D+W00ogQO+apkDJhOgSpQVnKQ/cWDq7FzlnHDAyp8R8ARJUD3NkXsNcv6FJgA+F2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kajPJrca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kajPJrca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B4BC4CECD;
	Fri,  1 Nov 2024 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730482225;
	bh=FVZPuSGJO0s/lvP7aNnUoaGtQ6CzzLkSpIOi86nrKSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kajPJrcaTpBqilLfD9Y4Sc2g6hhhhEwsXVMhgvVB8DrU6fQp4oEHgYk4gNYKWDxbT
	 GZZCm2mc2FRMosc167Z68W/SRkTvPU2xIBOI2ZqqymRWZVwJ1SMyt65UIBX7K15KFD
	 IWnIUN260a3JFjPl/T0uW5YDx30lddj+0KAF0iLEDhqvMEFMlonOk1g5/Z1SUpz/ji
	 N1Pmbs49GHheFUewuxAzAKsXzEnqOtio0jH0KKcVbFyFKMk1RfscZVfD1ApgqfdP9g
	 0ZEDogF+qBRcxzMlnjDQFJGF2sRZesHrpxiSrCTtI5KYUqDSpfvaVYkrj/KNwlaCVE
	 h2KDRzFkNiWAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71AA53AB8975;
	Fri,  1 Nov 2024 17:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bluez PATCH v3] textfile: Fix possible bad memory access in find_key
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173048223325.2757827.11576100786494951096.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 17:30:33 +0000
References: <20241101151939.Bluez.v3.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
In-Reply-To: <20241101151939.Bluez.v3.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
To: Howard Chung <howardchung@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  1 Nov 2024 15:19:39 +0800 you wrote:
> From: Yun-Hao Chung <howardchung@google.com>
> 
> If the searched key is a prefix of the first key in the textfile,
> the code will assume it's not the first line which is wrong.
> 
> The issue can be reproduced by a fuzzer. More context can be found in
> https://issues.oss-fuzz.com/issues/42515619
> 
> [...]

Here is the summary with links:
  - [Bluez,v3] textfile: Fix possible bad memory access in find_key
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5573661fc2a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


