Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4D12E633
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021686; cv=none; b=H3YBdIV3cGDM64SIMNWpWZYfDXgqBayiWBF8uRGZ1mKJDM2A5w3dwUqnpXDdbaQJNGnYfAm/Nv5EyC1R5G1z3/1EbE5HJD/OaqYY5YzUYlXlhxPB2ePxm33a2UOrkGwvgfv00xB1CGpRQws25vL398VYoKqzbI5CxcuUbc1SkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021686; c=relaxed/simple;
	bh=aGNHNV+NkwQitWA5rAnsrLTHgBaRYHARHMrx2/mABsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A9/AdJdCh2UCSOJMRe3HuGFW13TpNWBLK5fLDrBcwzWzFKTyZvm1Ir1fdTZb8yAf/YJbrSiTgFyyaIVkiJskLQVow2j2XCGewVrJ1Vjqf/oq8cl3ho5xLPqWzLsu6+B6PSNDJXJg/wjy7HkNR0vsKelyAmgZdEsOuFo5UFg7Was=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb2/Pab4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb2/Pab4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D68F2C4AF09;
	Fri, 26 Jul 2024 19:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722021685;
	bh=aGNHNV+NkwQitWA5rAnsrLTHgBaRYHARHMrx2/mABsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fb2/Pab40PXpOJbcS0xYUAJCLp4LnyqWAGUx1vGnMwsH6dcFsnGqoPIok6TFUSphV
	 Bhq1wGcK4Xxmf0pGImIDh8Gdt+TdmdbRYf+OG04x5SHZjhyJmqNiFVJMMaAbJ0mAv/
	 EG2ZIBKCAfvB2FR9je7Qo1QFXK5Uu2Z3fB6aHcRGvVWvKS/6Bkg1/CH5XK/MJUvB1F
	 CXBC2jd3tJmR4q5E80MosujfcpNIyicP5yynEH83PneRDk8pZbbaY61E82HDZ0aaqn
	 3ZAlYz9Px9o/alkC5Qfw2aFCR+X5MIaagyDM+1JWjyL4W6CM/HrXIzye4X8qY+MOzn
	 wzWod5KhQNB3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6F76C4332F;
	Fri, 26 Jul 2024 19:21:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 1/3] client/player: Set number of channels based on
 locations
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172202168581.11725.7821729737879253760.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jul 2024 19:21:25 +0000
References: <20240725213626.3183962-1-luiz.dentz@gmail.com>
In-Reply-To: <20240725213626.3183962-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Jul 2024 17:36:24 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This sets the number of channels based on the locations set rather than
> always hardcoding it to 3 which in certain case is incorrect and can
> lead for the same location to be configured multiple times.
> ---
>  client/player.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [BlueZ,v4,1/3] client/player: Set number of channels based on locations
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4c9d4ed059b5
  - [BlueZ,v4,2/3] client/player: Add support to enter alternative preset
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c2312ebe3184
  - [BlueZ,v4,3/3] shared/bap: Fix bt_bap_select with multiple lpacs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fcf39175e35e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


