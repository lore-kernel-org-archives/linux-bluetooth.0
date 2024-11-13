Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C415414F9E9
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515420; cv=none; b=ckE4FpRmK1VHcMPfoqSRHmJtx8daejp18q+AvyTyy4pNT9h4p3HKasUouYhYz9x0NONQuzfzYE628HOkV+UhnQ+FMCaMLzid+NdoKngX/OjQLWE5mZTHVfthiNWrHgs+sbAu/0w8gBQdgJx45IG11x5d7bnQOzbvou3hISJeafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515420; c=relaxed/simple;
	bh=FSHAvVZ/CQpS8AfInoLWt88aiHYcV3QA3YjaBbjQGN8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NGKw0IwXe5dEwqwIDItuSqvrEfXMYbonWZb9LQ6634P6KGEt/2cLk2TKNtzy6F3KRab3LQVSOck3iESO7UQW/Wa3Rn/AvVcifANFHxruTe6ep91zURfh40G8SZhWp5/dkm0FprEAUfiOnHKmlW0FqKaxfIPFJ+PvaJJAm3eWKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Exwwdr9I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Exwwdr9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DBFC4CEC3;
	Wed, 13 Nov 2024 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731515420;
	bh=FSHAvVZ/CQpS8AfInoLWt88aiHYcV3QA3YjaBbjQGN8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Exwwdr9IelGWqTIOKuqwjEIiZRvIAuRPx4JVMkSzwSCEsoe+jKzlE5JM/cJx2gbFn
	 u5vx4K97vqD0TMzDJXwYfx0DOhdv7Haytq1gyDgcs49EXIdAweARZF816cx7WMNXq6
	 eRVXf6WaKuKrPKRkXFHgCsbXyOz3/8geWkZh62FQm+WiwVtTjl9ygGBph213yCv1VB
	 bIV8x6OlEyNgV+w5G7c/G6wPwGQ6Flws2O8iuionzTs2wms7fsDA5LCKVUX++Gn8Kk
	 +3AJb58i+exSYNkFcYI19ArQkd8OZCnN6OWYoL92eNtiCm08hYHMrUqp7zmjyejSoO
	 X8JZqxTqsGrqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4EC3809A80;
	Wed, 13 Nov 2024 16:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] rfkill: Do not log errors for missing device path
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173151543057.1280765.18365914663407722235.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 16:30:30 +0000
References: <20241113141256.602066-1-marcus.prebble@axis.com>
In-Reply-To: <20241113141256.602066-1-marcus.prebble@axis.com>
To: Marcus Prebble <marcus.prebble@axis.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 13 Nov 2024 15:12:56 +0100 you wrote:
> In the case of our products, we lack a physical RFKILL switch and do
> not have the rfkill module enabled in the kernel which resulted in an
> error message each time bluetoothd was started.
> 
> This commit looks at the errno code after failing to open the RFKILL
> device and only logs an error if it is something other than ENOENT
> (No such file or directory).
> 
> [...]

Here is the summary with links:
  - [BlueZ] rfkill: Do not log errors for missing device path
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=63f1ab560c42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


