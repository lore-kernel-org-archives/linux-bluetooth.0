Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD269D2B
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208406; cv=none; b=F9VbqcJ6MeSWrretDgLvoULcmAjf4H5EGw5Dm/yG3/8LE3CwhbQMv8R/j60flLdtQH2b7qQAnqW/0m9rXrMUs6Ft9sYT9UFX8b1xmclhvAFzal9wyT8Iwb1P78blsipwjBAeK8IKuSTV9wKVMQ2w08ukuqKFMmJ3kYMiEyWbxEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208406; c=relaxed/simple;
	bh=I3KeeZ0brVuakk2AWlMU/XdWUY+YZheuMtBrFnoRy7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dgj+3Dydqa49ye1DN4hpvziPGbzRmQ2IxbwuqCfLobvu3ujKAkfDtyJ6qVFbQjrCUG/ttpwzzIleI/DShSYSAETuFqaRUnTPYHQx5PlBilutJ1Z71fET8/X/I3wvssar//1Nr0caq7VPTeVCivEva60gAgXgJrvehgZk1/lpMEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioDu8tHU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioDu8tHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AB4C4CEE3;
	Wed,  9 Apr 2025 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744208405;
	bh=I3KeeZ0brVuakk2AWlMU/XdWUY+YZheuMtBrFnoRy7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ioDu8tHU3FW9HUk+sgMEEb9PNfv2wpiV2OVjVxCY5i2+AcIplyRVkJ3QGTCqKgAgK
	 jxGoRolwXlDv7RLIT+N6oWrkPpCeBcb4n5tI90osbFKzuqlzIP9kN95udK/CTKikFm
	 fXMjLtC6UTiOKo29MNNmKfW493kNsEEE3qqM7wbzVg/KS9SZXhDPPE6PgetOt0ODE2
	 m5hkz6rbG65HebMLHqlEzR0GGc6c2uVkVWM6CnMmMMefKA55gBUbMnQV4ju42IxEJx
	 Li7tBIXBkwKH45Klmi425ENSXrMc1gL2nn8hHNvkxyqDydkVjEMOE/8bXdW/378o1A
	 mtlMI6owB0KpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 47A56380CEF0;
	Wed,  9 Apr 2025 14:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] shared/io: add watcher to be used with TX
 timestamping
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174420844315.2837833.13343345953883708543.git-patchwork-notify@kernel.org>
Date: Wed, 09 Apr 2025 14:20:43 +0000
References: <aa9cdb0ec03c5fcbf12a2df3d183c47de664bdc1.1744144760.git.pav@iki.fi>
In-Reply-To: <aa9cdb0ec03c5fcbf12a2df3d183c47de664bdc1.1744144760.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Apr 2025 23:42:38 +0300 you wrote:
> Add special implementation of fd watcher GSource for audio use.
> 
> For audio use cases, sound server may turn on TX timestamping on a
> socket that we are watching.  In this case, we shall not consider the TX
> timestamping POLLERR as a socket error condition, nor read the TX
> timestamps.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] shared/io: add watcher to be used with TX timestamping
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b19d445b0192
  - [BlueZ,2/3] avdtp: don't consider TX timestamps as errors
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0e831d8e6709
  - [BlueZ,3/3] bap: don't consider TX timestamps as errors
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9f167d495adb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


