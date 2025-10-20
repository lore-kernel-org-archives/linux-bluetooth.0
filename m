Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0121348
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966426; cv=none; b=bw876nD3PaCb8wqYReGl0ntDdRzYg7UZOeSDrOnlIVSiTv90PBhzy2XtQ2URwQzrdhXE484QJc41/GNuMxk8bDz27oSu4I/Z+WoT2+d7nV9pcXqOh7MMgLsrMD6wCWGkanv2qBYuxPAVgzQb28qbF+iMKmW1bgiJyfFL56SO2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966426; c=relaxed/simple;
	bh=IaZBEIDb7qGDzk23zRgNWDkVEY1NMoVFM98z2P0sebo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eDCsV0Y+9EDQ+9aUHA1OkwW0U9yNIlByftmy854rjDRuV29cMmIkZdDKR9Bt8QIkeEsJqVodJI2TcvbBkPBpQ/akhLZqlvYw+G089caBFk8xG2QQOG3sb4lN0ge0aVzD0c7Cwd5ATUSFWD8WSAd+vFxuiYiCCQ8tAKkiyFPOKFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTxbySOT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTxbySOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF8AC4CEF9;
	Mon, 20 Oct 2025 13:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760966425;
	bh=IaZBEIDb7qGDzk23zRgNWDkVEY1NMoVFM98z2P0sebo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PTxbySOTsUF6RbBvOkZ7mAT7xM6U46ExOMebpB1c0m7P0KyTOD54j5TT7b6P5bAtP
	 ISCc2fHELBsB5FVRuhUXkWkBOOQ7xyzME3XbcOJ60Xk9FV5rRbqqga6oO6AvBuEorI
	 s1J8+3UlPh6Oc054hRRveegRl539NmkyXYJLqjX2g1H0iwt2hs2v17EhE0lr1gpwtg
	 IjKaTZMreo86ZhpqhyGqG2NecInpXAZPzYZxZoG2AUSQkcrIEQed+9VFPvDdvDF6jd
	 vMpaexGTyOy39EEw/yODzW9cXakT2DMNOe29/4dQ21fUiXzLbWCstaE6aoyXELu0Bw
	 yN+BqA08RcDWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D4D3A40FF4;
	Mon, 20 Oct 2025 13:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] bap: tolerate inverted STREAMING and
 iso_connect_cb()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176096640799.201781.1405336622138403931.git-patchwork-notify@kernel.org>
Date: Mon, 20 Oct 2025 13:20:07 +0000
References: 
 <d442c20f47eb10f51c19480988964e881f6b0049.1760542606.git.pav@iki.fi>
In-Reply-To: 
 <d442c20f47eb10f51c19480988964e881f6b0049.1760542606.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Oct 2025 18:40:11 +0300 you wrote:
> Ordering of STREAMING and iso_connect_cb() is unspecified, as
> kernel/Glib do not preserve the order of these events.
> 
> STREAMING before iso_connect_cb() causes transport to fail Acquire()
> since bt_bap_stream_io::connecting == true.
> 
> Fix by marking IO as connected even though the connection didn't yet
> complete. The socket fd is valid, although not yet writable/readable.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] bap: tolerate inverted STREAMING and iso_connect_cb()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c584335d4436
  - [BlueZ,2/2] transport: wait until BAP fd is writable/readable before resuming
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bac077c96b67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


