Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3222B1FA177;
	Tue, 14 Jan 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875217; cv=none; b=gEMo8FdRLlNnZKlOtYVzyR6t4OSdiFGQPZ6eH1l1CnQZ4ueSI08jO1BoZgJEzKAkzGCY7Bdo0p7dd5x6p26ch698F3QLa9TZG5nsKS9Tj6x4M9Of1zDYRFQmoYdRI98qnndActKukU8v34ZERrYzE5AlmfUFe9M9Awr/7reMBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875217; c=relaxed/simple;
	bh=EJuA9s8hbJspq10fpCDPXEJ5Z8qGqeFvvLkwHciNRqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PGLVpI1h8r5X03srZgOt9G8+3ZmdMsi+Xq7zqB3PH0qb4mpRvWkMOh1ZL6PoqC864FndKKNFn85myNiYWGEBjZWbOr5WBjkNa2qOxmcHHTeBFRLMfleOg1MTQDmcfxfrdk9V+f413DS8z2RquocG7T7d4vQFGwnZaWIb7a3DoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUowf/i/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUowf/i/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C83C4CEE6;
	Tue, 14 Jan 2025 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736875216;
	bh=EJuA9s8hbJspq10fpCDPXEJ5Z8qGqeFvvLkwHciNRqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IUowf/i/ZBTq0sB0nWDT8wnzPXkd9ePZq7f+NzSb6OqOA2mtLHZa42YtRVL4DTOKF
	 5qXMMUdZsE1UKTzCERM0ALNFcxC9IfgKAHO6Ffp74eWzAjXCHkkqFpODPWgitLhpg5
	 eV9BkylN+LAB9bJtJBVnEDWwpkzq2Vf7AIvkoDE71p5prIWcF7eJx70Ym6mLVqUHyj
	 Mp7UMTT9ZI6zDFwQZgzD0FZZlKICZs4URlrhfQCC1YcUhOx9vhgha+KaQui5F1v86c
	 DTcJFvzLVXkkJBv+VwK11b8z853aG6m0jD0NcgxM+Q0fi4k1iRgPC2vnGmkI1fLBVv
	 1RCiJj8/00gBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04B380AA5F;
	Tue, 14 Jan 2025 17:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Use str_enable_disable-like helpers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173687523924.62266.603650773422264073.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 17:20:39 +0000
References: <20250114105641.273451-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250114105641.273451-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 Jan 2025 11:56:41 +0100 you wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Use str_enable_disable-like helpers
    https://git.kernel.org/bluetooth/bluetooth-next/c/ca1c320b0453

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


