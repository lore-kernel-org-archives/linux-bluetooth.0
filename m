Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8C1DDC0F
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589789; cv=none; b=srW7A5oGgtmo7E37snw7Cfz/L0rscAUtwrGU0VkuSfqcRqi3WcvofmqvpmQKXHaIoXrqC+zVoyKeLj2m3BQ3ETPn9ktBir5pOJZX3fhLptowo/I5gP2MjBR6+NdxGNynDefokR2/FlgJA26bmGIwdIzKPHJVHnULGuLD1ureruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589789; c=relaxed/simple;
	bh=PUoPAlrplNjczEK11S37Risg1G5WoDt+ilXhD0oPlpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KhvVKM/+6Jm106iXdplHDkjFG/2tP3hfiGpprUc1em2SR7q8Xaoncw4ivFA8fGaUGAeINgyGYeHKBJw+ZPlnIM1dgGvcMSKb4IZ6vHSIjjojpMWIuDrgkvw3IbC+m2v+WfqtRbTqDFrJddmPD205s9arEoJuH6wKNwFBKTaM9W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKa+d2+9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKa+d2+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA6DC4CEE3;
	Tue, 15 Jul 2025 14:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589788;
	bh=PUoPAlrplNjczEK11S37Risg1G5WoDt+ilXhD0oPlpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MKa+d2+9BYmk/s8OvWwpPw4j3kRTKEmrKXeJThwecpsnHJZ0bfAfhUPdFFqZt5utW
	 DyrwETbuUSn8Hd3d7AYyByvIEOIvGW8uG/pUnfwV12nz7AUidwr0ujzbJhu+BPuk3F
	 RbtI6mYkEECLwaMbrEkDRr9lg7xl8CZ0lejoJIFdzXXupqcu4Gv5P/2vqtuBKKzvp6
	 l84W5C9eLoG7Dns5CKcZpDt1/pBeVNFk14BgDVJWlcF8m8dBZMHxS75Na1O5a+OTyv
	 2wsHVFJkrKDrGQV3EPCY2m5SKs/oS++mbvK+8K86vr++lEEXowGBGhlFkZqMJuHpZq
	 +UGheefBvh2fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 95FEB383BA03;
	Tue, 15 Jul 2025 14:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 01/15] mesh: crypto: remove dead function
 declaration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175258980956.461397.8072245298798373528.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 14:30:09 +0000
References: <20250708125947.11988-1-ceggers@arri.de>
In-Reply-To: <20250708125947.11988-1-ceggers@arri.de>
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 8 Jul 2025 14:59:33 +0200 you wrote:
> The implementation of mesh_aes_ecb_one() has been removed in commit
> dfed4839463f ("mesh: Convert crypto to use ELL wrappers").
> ---
>  mesh/crypto.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [BlueZ,01/15] mesh: crypto: remove dead function declaration
    (no matching commit)
  - [BlueZ,02/15] mesh: crypto: remove unused function parameter
    (no matching commit)
  - [BlueZ,03/15] mesh: friend: remove dead function declarations
    (no matching commit)
  - [BlueZ,04/15] mesh: mesh-config: remove dead function prototype
    (no matching commit)
  - [BlueZ,05/15] mesh: mesh-io-mgmt: Fix NULL pointer dereference
    (no matching commit)
  - [BlueZ,06/15] mesh: model: remove dead function prototype
    (no matching commit)
  - [BlueZ,07/15] mesh: net: remove unused stuff
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0e586df2d0ae
  - [BlueZ,08/15] mesh: net: update comment
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cb4b20c71fd3
  - [BlueZ,09/15] mesh: net: remove obsolete struct net_key
    (no matching commit)
  - [BlueZ,10/15] mesh: net-keys: introduce BEACON_LEN_SNB, BEACON_LEN_MPB, BEACON_LEN_MAX
    (no matching commit)
  - [BlueZ,11/15] mesh: net-keys: remove dead function prototype
    (no matching commit)
  - [BlueZ,12/15] mesh: node: remove dead function prototype
    (no matching commit)
  - [BlueZ,13/15] mesh: prov: cleanup header
    (no matching commit)
  - [BlueZ,14/15] mesh: remove unneeded casts to bool
    (no matching commit)
  - [BlueZ,15/15] mesh: use '0x1' rathen than 'true' for bit operations
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


