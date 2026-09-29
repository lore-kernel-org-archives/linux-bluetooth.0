Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D54E9C10
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694644; cv=none; b=noYlPufbAz9FUpxQtNBf+bS/wd8mQEvo5Vzna6Wr2k26I3/+Xw9Mh0euV9lajFCxr9SKf4FpMNONkgF5aLNsKnPH2Vuk+oA2Xf4iG/L91BiqVLRPkOiMsZ4oZfvZOLK9IjVTbKxNFYyBAJWqqWZKimLfU7e2eaB7V36wXtznsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694644; c=relaxed/simple;
	bh=jWYapee8QsMZtcYQ6TT4KNecPrZeyGNTD3pkLM+m20Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jMgLr9tPemVSKNEPLoDR1SH4HKmC5UYtuZduNvc3hMcBvfhDzlnxF7P4lAP61QxTdT66W/nVUoK014SjhRxzE8eDLMd7hIgiAmSeFLJ12vI8zXK/L9vNK0leEjN+x5EOvIq8ek6lm4V/uG6JXrnXrQb/DkcoM4szklKouuEvrs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grquDkkj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grquDkkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814981F0089B;
	Tue, 29 Sep 2026 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694619;
	bh=qs0RTOgm0jpIG9TAykBf39jlkdSGGECjdmnJ+jl5HRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=grquDkkjFuM9iDC2kqJ8cDmM08ngRP0HfOEKZ3zwz55HCVVG1hnm/G+A6O/6//r2d
	 /SDaOgV4YqaaYc5zBQn4ZCGDUAfWcqcLD3Q33jqBBl0IBXSYCysU9tcWggq63mI6a4
	 l0i3s9S0peqsytWt4RrWN1YDfzOKi+Cb7OCc2nS3Y1r82tiGZ28sdu6TLGO6RDwcR2
	 DE+TEapgBM4C+HQOm5udqvWlIZLpp6l8urt/yQ5lb8gz+vVspqxb/csxbFNnR3wAM6
	 M2ypnKzstwaUhH5afHmJBhWm2L3A0uZd5WOLZbVURRQR5sNFnsV99lGM6cpxGN+NS6
	 ppqT8O7sX7qKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774083927049;
	Tue, 29 Sep 2026 15:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/4] Bluetooth: btintel_pcie: fix D-state transition
 and PM
 flows
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179069461801.983246.2880891224850041177.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 15:10:18 +0000
References: <20260928050344.2893790-1-ravindra@intel.com>
In-Reply-To: <20260928050344.2893790-1-ravindra@intel.com>
To: Ravindra <ravindra@intel.com>
Cc: linux-bluetooth@vger.kernel.org, lsa.uz@pm.me,
 vladimirkondratyev2@gmail.com, chethan.tumkur.narayan@intel.com,
 kiran.k@intel.com, pmenzel@molgen.mpg.de

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Sep 2026 10:33:40 +0530 you wrote:
> This series fixes the suspend/resume path of btintel_pcie.
> 
> Patch 1 re-reads the boot stage register before the fallback state check,
> so a missed alive interrupt no longer leaves btintel_pcie_set_dxstate()
> testing a stale cache and aborting suspend with -EBUSY.
> 
> Patch 2 distinguishes S0ix from S3/S4 so the controller is placed in the
> correct D-state, and routes .thaw through a normal D0 transition instead
> of an unnecessary FLR.
> 
> [...]

Here is the summary with links:
  - [v5,1/4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
    https://git.kernel.org/bluetooth/bluetooth-next/c/20dfccf8d854
  - [v5,2/4] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
    https://git.kernel.org/bluetooth/bluetooth-next/c/79463c0de429
  - [v5,3/4] Bluetooth: btintel_pcie: verify state after alive interrupt
    (no matching commit)
  - [v5,4/4] Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write
    https://git.kernel.org/bluetooth/bluetooth-next/c/6091d2771395

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


