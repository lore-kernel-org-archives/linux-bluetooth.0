Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6424BA31
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281589; cv=none; b=m2Sdie7+61wMRYzBJ8f7LKN9u+iygh8T9agWsYn1AVECEco5ji8BNSSZHesejizYhD04WP9tJMdEPYAd6UyCswNYmrJ1hshVjNCa8TWVGQy/ZIe4hctTgKA2RiBBzlwgxYli2XmFpm6InSA2xS58PvVbyTU0OCeiF4bBDtIYZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281589; c=relaxed/simple;
	bh=Ka2xlVsgvnUZ4mvkYGq2R9078uP1u02li9UFPNsytvM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WU9Ubr5rX3FRzQFkjojhVoyNWAiQqhk0WAnb+4Ov4btHhOaOrUSfiJzDGuPaojHcFFFmmcrlTFJwQHXOmQFJ72uzOezjFn5TRM4nfFKsyHgqsBQe0yZY0NuSJrC8aYsdsjj2Xy7B3UsVsitD89QO2GFbkmDhM6SODiegQFOl8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6L4WT0J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6L4WT0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD79AC4CEE7;
	Wed, 23 Jul 2025 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753281588;
	bh=Ka2xlVsgvnUZ4mvkYGq2R9078uP1u02li9UFPNsytvM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b6L4WT0Jr23F6AIGjXWKYOlwE3eIuMPQLnTFtd0aKNqIFcePY/+xhLm4hcJIU8JzD
	 t4IZ/drBf7wUTRnmUiZnJ5qJ/RKbICHf5QmJfRlQo6IpBy5EmMlT6txZ2bpQG1VltQ
	 5eY7CEDV9Ei6XZrHKRsR8afqpEZ3DiBLQKba3X8HuJQJ+/hoBQBklwR3gV+PvxMyFu
	 A3iwh7mHjL30wLaDuloov2GP1DO6rptletrsDc2VaBi1aCdpxC7jfMRY/qzZ1CE9ez
	 oJL2Xj6oJpnzI8xzuYIwhhUMiBXwDRNhMa9ttdeVkdG+nnVxEu5BQug8NJKA/qe3Ix
	 DF4gd28NrHMOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B31383BF4E;
	Wed, 23 Jul 2025 14:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client: Fix gatt.{read,
 write} not working on scripts
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175328160674.1590822.2009256458126700314.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 14:40:06 +0000
References: <20250721200933.1102559-1-luiz.dentz@gmail.com>
In-Reply-To: <20250721200933.1102559-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 21 Jul 2025 16:09:33 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If gatt.{read, write} are called within a script they don't indicate
> completion so they block commands to be run after them.
> ---
>  client/gatt.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] client: Fix gatt.{read, write} not working on scripts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=06d73a43a854

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


