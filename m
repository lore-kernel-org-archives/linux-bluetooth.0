Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0844E1C9
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636829; cv=none; b=OZmO7egAlfosQoMy28vFytvjkfRTcz+9uC7z5tIbKFSnBLkYizdrlsKgG/ogNj7u8Pfe6caMxow1BuhNLHpvPwIM0SlDpvPZf4U7SDFbxRCmOmEgouICbZp+borb3+amoTNu1dtHCeHagM0wVNNTuo5epduo+bv9aofJ0IXgF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636829; c=relaxed/simple;
	bh=4C0mgQPdm8uMtNO/3AKT7nXpGCsTknTYCYA2Zn0tHKs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SOTt3vOfLVobWi+93BRxZVplcFkKMwBBxYx4ZzRpKojLZCwJxmk4LM+SYJxaj0sJhufyWOiltonwU5RfIBbGuY5k3aC6pVR3qHNMtl6/IMvuipKzKBpt+creoKh2t9ruh5ILKgU59cKc8XPI7n17KY7u+en18fm8I6nEfh3z4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QX21NFIe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QX21NFIe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7626BC43399;
	Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636829;
	bh=4C0mgQPdm8uMtNO/3AKT7nXpGCsTknTYCYA2Zn0tHKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QX21NFIeUiZ0dUbthNoPyk4q4i+ursC0V7iCJQgNNieEsJ+mHn+C3DO6FAntmX/Ay
	 Gbo/JqvYOPg9BLe/3FUNIOIB7PDVK/S6HBMekMffYgV/ak4uGX2gWhDVX/E5OWgLKC
	 B7jiP+kpaSqS5bkapvmCdcRfaJ0fMyaGsHmvN/iN3U95QMtsAhmMZS81DwtaM1wkX9
	 Z08n+smfnoe9ntf7/0AnmdPg4qT58ZSyszV9fWCYOngiEPREQrGqPsSA1ZguhYvhZE
	 vNP+wKY9YgOtA+7X6qhXPku1i/anK9Bqtb2zNCwzUYWyvLgr2n9CxQIhTkXPosv0Rl
	 AsSboV7B0prBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6999FD9505D;
	Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ,v1] obexd: Fix "Size" use g_dbus_emit_property_changed_full()
 to emit
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171163682942.3770.8017900428966501016.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 14:40:29 +0000
References: <20240327053712.578023-1-youwan@nfschina.com>
In-Reply-To: <20240327053712.578023-1-youwan@nfschina.com>
To: Youwan Wang <youwan@nfschina.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Mar 2024 13:37:12 +0800 you wrote:
> This is the comment for g_dbus_emit_property_changed()
> /*
>  * Note that when multiple properties for a given object path are changed
>  * in the same mainloop iteration, they will be grouped with the last
>  * property changed. If this behaviour is undesired, use
>  * g_dbus_emit_property_changed_full() with the
>  * G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH flag, causing the signal to ignore
>  * any grouping.
>  */
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] obexd: Fix "Size" use g_dbus_emit_property_changed_full() to emit
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=07d427227a1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


