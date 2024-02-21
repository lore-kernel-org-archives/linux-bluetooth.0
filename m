Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119ACF9FD
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544432; cv=none; b=r31nR+XXOHdUDZqQZomwolxLAMzrs6l331h74aqvhDr0pZ6zSLs+VoE+B+UIHrEo5sB7I2xjKZ+Ys3gCgL4hMXRLIFeSurmenJ1OMVLIXemx/6XcmT6ZaAlq2nEPS8t0fpNj9QBPf0vibqUyLY6CNDaZpIkdLURPxYV0BLcG1z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544432; c=relaxed/simple;
	bh=noa0qMHDm9rBhzAdaCn2iq0ThQq88k7ooRFze9Pr/98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dwgUMeRvldbfIKdQ/4ue7YoYGPqCuGL2rjNaeUhJBMUku3G+aMourCOIFkbcb4Fp9E4jIbpatAfS+80RLx94AfYQ/cBgYX54mBdFX+3RfNkLGjxAPxISazLoADu+mzQoCngAcj0i/2PNB/Oq6kJ1Q3CvzZCj/O1JhYO2d27nRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqDbUhnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqDbUhnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5750C433F1;
	Wed, 21 Feb 2024 19:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708544431;
	bh=noa0qMHDm9rBhzAdaCn2iq0ThQq88k7ooRFze9Pr/98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AqDbUhnZgn57DynOkietKYtrq1rWmfZ9fSPTVBKitprrwF2PqW+EGEORe//lj3L7n
	 ZjKOAuUBkJmzrwtD1psSJuQg5ejka/fGesDY63egyNbFhx7B9epoTLH/X3Q/5zEqql
	 5wgZqB8a2/XJ9Tqb7mwwB8sUeJGgGgCW8w8OriOrgKkvRuhh3nHEu7CbSALeU+ufCW
	 j+0IpOzg2bwC8ibGBD0Evtco02fcDTU9KY4tf6ALhJXOpJpWJjlX6GM7tsiAb5gCJD
	 a17cUKW7cx8r4RJcEDEd+lDlCo6k7Znb6wbfRMy1qQD/hvm4y9GbnzNrD0DGgdgb4k
	 p8pAJDZRIxtAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAF52D84BB9;
	Wed, 21 Feb 2024 19:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/7] Add support for multiple BISes on the bcast
 source
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170854443182.27968.17013966618823039081.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 19:40:31 +0000
References: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
 iulia.tanasescu@nxp.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 Feb 2024 23:23:49 +0200 you wrote:
> This patch adds support for multiple BISes in broadcast sources.
> 
> Example commands:
> Create a local endpoint and an endpoint for BIS1:
> endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
> [/local/endpoint/ep0] Auto Accept (yes/no): y
> [/local/endpoint/ep0] Max Transports (auto/value): a
> [/local/endpoint/ep0] Locations: 0x03
> [/local/endpoint/ep0] Supported Context (value): 0
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/7] bap: Remove set lpac user data at bcast ep register
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c5f1c5ba0e8d
  - [BlueZ,v3,2/7] bap: Split bap_state and bap_connecting in two functions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5629f4784a4d
  - [BlueZ,v3,3/7] shared/bap: Generate one BIS BASE for
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a16c2ccf9c25
  - [BlueZ,v3,4/7] shared/bap: Add state in stream struct for bcast source
    (no matching commit)
  - [BlueZ,v3,5/7] shared/bap: Check state of all streams with same BIG ID
    (no matching commit)
  - [BlueZ,v3,6/7] shared/bap: Add support to create stream for bcast source
    (no matching commit)
  - [BlueZ,v3,7/7] bap: Set generated BASE on all setups from the same BIG
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


