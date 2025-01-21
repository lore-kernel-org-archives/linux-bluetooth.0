Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C641741D2
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477609; cv=none; b=fC8DcftL+Wy/DtIwuB53+7RREUbllml539TCmiO0lwzFzqP/M4MnKTj2fwpX5Ky0+31KbRkhV4XEWOWueHldWpjPww/TJyO9KmcnyMBQEzJGS9oXn3qdHiyCg7lL+ik4sFau2xnI5J++gFFrVTQ6zrO9n3rfcv9OWR7LQOSV3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477609; c=relaxed/simple;
	bh=aGfa1VrfhtXBiFKvoUBOJXTYWMXAJgB9qchIs70+dSY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BmPY8vTZ02pn8NMNLK4DkYBUVE6ifw9GCJoM96AJccrZrZs5qgLokIVcS7Jv1oU6zjkwPW3xxK5VKAq7c8txTfObfNBRLwjgwC05XYlyyZHEVgG01Lkef0BSU9LaXoGrWauHEY9UmKtJDhVUfRjjwqGCYjIvelbU7oBEILB2L6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWV8b+XJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWV8b+XJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E66BC4CEDF;
	Tue, 21 Jan 2025 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737477608;
	bh=aGfa1VrfhtXBiFKvoUBOJXTYWMXAJgB9qchIs70+dSY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cWV8b+XJd+4q0KU/RLUTfncYYCgdY3Qjniiao6svqwl1xSTQP8IcTbr8oZctFoS1f
	 rXxJrQyGOlUDODN91ckFhB0UbUWBz9XZAk8AOEjvLmsKZXBYuvx/IsKnx2OGJ62SGr
	 W8dRDoNNU6R1xSoU5DbiFX+Zz3zV/rFR/G+rBP9kvKr9iSATpRVMq9Q41V+d12IiNP
	 QNqfZ51a4HrWhRljBOAxtQy6NA5tAlGgAb2f0GRGuue2q/f7+mvhYECgAULkiwlnkc
	 g6czgR/fwbDjKPExbTnmgn5vXfjhB6wPHk5teboPy+GF/30v8Vec5kvcgtDwCxuvu4
	 6g01pmdscx67A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD83380AA75;
	Tue, 21 Jan 2025 16:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel: Add support for Intel Scorpius
 Peak
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173747763276.49514.4386226348504218267.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jan 2025 16:40:32 +0000
References: <20250116113709.566498-1-kiran.k@intel.com>
In-Reply-To: <20250116113709.566498-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Jan 2025 17:07:08 +0530 you wrote:
> Add support for Scorpious Peak core.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c      | 3 +++
>  drivers/bluetooth/btintel_pcie.c | 1 +
>  2 files changed, 4 insertions(+)

Here is the summary with links:
  - [v1,1/2] Bluetooth: btintel: Add support for Intel Scorpius Peak
    https://git.kernel.org/bluetooth/bluetooth-next/c/0e2d24b85e8a
  - [v1,2/2] Bluetooth: btintel_pcie: Add device id of Whale Peak
    https://git.kernel.org/bluetooth/bluetooth-next/c/40b9c2a0949f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


