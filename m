Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8BCEEDE
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043582; cv=none; b=TrtoxlXpQeSt4J5q/fBT79x+1JM+DGi11/B0pgD2IHZaKm64LinL4YjhWllorHHtgHIdiYLvxJ5kgTpCR9pM00nLlUgGdpi7mTesqi81acfl1orYifHGu289f5MhkwJLDmh3tgd2F9phX+eMjFlsTs9YNA9ogo0bsDx13rnbOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043582; c=relaxed/simple;
	bh=f6ZYn4WSjnlTUnorEw1pOaiVo6andwnVBgkXq/72YVM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o+EWIrJt2iT5s4ENLOOc1rcF6of4NKaEuC6qN3jvuLOMclpW9fAqPugcEQfWt99im7PAiA5TtFTNsIK4DP9p5M4ycaJNfY6NYUTFM4GNMXtq7G4eF0d8SBHBjEGYzVwPf98I6alCEqMKf458bYB3yQ3+ZBkFo9UbU+H6/EwcEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrS5k+rG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrS5k+rG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701E1C4CEE3;
	Fri, 27 Jun 2025 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751043581;
	bh=f6ZYn4WSjnlTUnorEw1pOaiVo6andwnVBgkXq/72YVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nrS5k+rGfc+oHKM1BT+iYSJLYql96hPyqzp/Yj9tLzHgC0h99TPFaaIL84/13bodJ
	 dHGHF6XbkPa+YHMf3wpoI1dLnCuH4YiyjnvamVCKGm9dQgdnZ7ghS6oTgvcvAaua7t
	 jZ0MHHFRKtv+fH6kSyUKDpfyELICXozWuzvK177joPn8yOpbChnBtGhJjC7jse/Mtp
	 A8WkWhKt4CEpYANvb3HQT+CzBdyNzz/kcAjzMawFyjV/qxZlQvvyOVPAzoCK4UzObE
	 KGSmnUOSt1PPEsKjzxl4+iF8enKcpcghwClXaOvLZACuOtsCC+36Rzf+FYfzrMrYQO
	 dlayQINqyrBjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC6C380DBEE;
	Fri, 27 Jun 2025 17:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/9] doc: mesh-api: minor copy&paste fix
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175104360724.1996502.15314023353118607724.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 17:00:07 +0000
References: <20250627075928.19788-1-ceggers@arri.de>
In-Reply-To: <20250627075928.19788-1-ceggers@arri.de>
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 27 Jun 2025 09:59:20 +0200 you wrote:
> ---
>  doc/mesh-api.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/9] doc: mesh-api: minor copy&paste fix
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6983c985e08a
  - [BlueZ,2/9] mesh: keyring: constify
    (no matching commit)
  - [BlueZ,3/9] mesh: mesh-config: constify
    (no matching commit)
  - [BlueZ,4/9] mesh: util: constify
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b913bd1b92a4
  - [BlueZ,5/9] mesh: mesh_net_transport_send: simplify
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=725a72ea654c
  - [BlueZ,6/9] mesh: node_add_pending_local: use concrete type
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2874aeb4d056
  - [BlueZ,7/9] mesh: remove unused function typedef
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2a40b2f8e07a
  - [BlueZ,8/9] net: packet_received: avoid unnecessary copying
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2251e6d79620
  - [BlueZ,9/9] tools: parser: fix printf format errors
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


