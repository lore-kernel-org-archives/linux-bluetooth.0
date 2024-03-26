Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0B757314
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711423230; cv=none; b=cXK7cGhTL32vaV93BweKOi2Qkufwab+yqMYPbv6ErmUxuqByRLEf3LdULfZkRyCNmVlCoJwFN96DsLb5XaO+S0Ure8wDGZ7RVRaySCz0pkrNyBYV9uNF3ELsKrrBKFK27LLKN8GWb5B3Kjlz3iHcPuoEl1kheLzYuktwIROVT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711423230; c=relaxed/simple;
	bh=TECpCp6FcM3G0/v6XjyedQjhC7Y2WRs9dvivGwOAMMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dBCB02tdQhy08byV8sj+5MK33IBrFZyC2UIK3ABRhWL5UeqdLyddmvMiwOf9sZETt4Z2E+gW0K/LcYe5sBaSxka5ByIr04TlOUUu+YISPX/yNV8ADOkDyVvbgcGVmmWvCn2e9L4i/4YxwXga2aNrGuVTNZlTcDrcGVADnFPoltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/pO0qxF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/pO0qxF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEA43C433C7;
	Tue, 26 Mar 2024 03:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711423229;
	bh=TECpCp6FcM3G0/v6XjyedQjhC7Y2WRs9dvivGwOAMMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e/pO0qxF3TN5Va/sPj/43nZAVQoVJhl8M0u4OS6WEe9EszLuZyTAH6pltjboR793C
	 NiwdTew3MkFvMvceGPhCuI/6aHPRmcDAn7bAN65pVtHtKBZh8ZWIAaTTkKtDkl8taj
	 ovPyKwn32k9soyvl8xEiTN/IgrBk1roR/oxnJuXBVFqJVZyk5QZqI55pQ5R9aPjAEA
	 pIeN+A8glq/clOSmCfmPUWqcPajazwmMw5gYwGX1Pc1CGQRzwzCbUtnUTOWdyptcQi
	 fdtzXe+2695F9lQ17FGQ0siEOR60OUbFBxGDFp9gIG0r5I+NIGrQYeQ5EE4pD02WJT
	 no8JRPlE00r/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEC08D2D0EE;
	Tue, 26 Mar 2024 03:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/2] shared/bap: add bt_bap_cancel_select to cancel
 ongoing pac select
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171142322971.10863.1092962005071574864.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 03:20:29 +0000
References: <afc30fd4d201bdd92ffbc682ac66f472ce837814.1711389066.git.pav@iki.fi>
In-Reply-To: <afc30fd4d201bdd92ffbc682ac66f472ce837814.1711389066.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 25 Mar 2024 19:52:09 +0200 you wrote:
> Add function and PAC ops for canceling a previously initiated
> SelectProperties() call.
> ---
> 
> Notes:
>     v3: fix wrong usage of g_slist_next
>     v2: cancel the DBus request and callback, instead of ignoring stale cbs
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/2] shared/bap: add bt_bap_cancel_select to cancel ongoing pac select
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6849c64e1fdb
  - [BlueZ,v3,2/2] bap: cancel ongoing SelectProperties() before freeing the ep
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=41d6c4e1c92f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


