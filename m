Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B064EB5D
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967582; cv=none; b=Sg9sTaTYW4t6ucLfi+bCM2v9AbSwW9HL7+uDKGrCjDVdxjaRN5WmZCeQPzfXFOR8+wmevwsX102zX6dPsk2ur8jHDdPeoBcovVH+JT3ih3vEJbrJjDsA6syZuaexTsxl3D9HtYLFPge3vhGPoMVyg2M4I1fQPIxc3xBDIpuQv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967582; c=relaxed/simple;
	bh=FluFUA6fDTi7LAdn3i2K1kR4JJs9mOEHwZ7YCCKrYFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VDNvvzPtooXoveMoCYEK3qEb9arf2KwdWIsfw9/sbyV5rGupTNkADraSbYFRRYNVaEYJn9nIDvyja75HnZmc6WlHh9gfwWlTGOEBOBJCDUTyly5AUvmtmKE7WFjXj4jLtWvCJnuHZiebx/sVbG/gKzE3eYf9Kp4cik5Yf3Q8THk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz28oo20; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz28oo20"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68757C43601;
	Mon, 22 Jan 2024 23:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705967581;
	bh=FluFUA6fDTi7LAdn3i2K1kR4JJs9mOEHwZ7YCCKrYFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dz28oo20I4QMpmT2Q6PoOxhz7ti5S0hwDKe3lj93TB5G6sEynn2PxTBm4wTkCFBK6
	 Rk6a+HRRQNeu0updPN03hXTN7B4K2BugjC86f2szxb6xPwFMQ3emr3d04eYSwXvPYf
	 c0SDfUFN39xwYalknP7oA6zv+wRNyWU/FOycX1A0wc46x9GSZOrhPLLDGYrGMET2PK
	 7RBu/Q77fE9LZa9N32ZBB9QvmRpF3J7aTqW1DenGyoFTQ4Xbq3C4x8hxHT+StoL2hK
	 7pej0WP0UMSW30GW1MJo5QKo5+3jZNo1zQbFXYcTW5QUykOrsTYx/guYWRL5SYrL8M
	 n4sUTyhZ6gNEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FFE2E0B63B;
	Mon, 22 Jan 2024 23:53:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 00/20] Constify all the things
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170596758132.31397.2274426459312126473.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jan 2024 23:53:01 +0000
References: <20240116-const-v1-0-17c87978f40b@gmail.com>
In-Reply-To: <20240116-const-v1-0-17c87978f40b@gmail.com>
To: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, emil.velikov@collabora.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Jan 2024 14:00:25 +0000 you wrote:
> Hello list,
> 
> Here is series#2 of the paper cut fixes. Here we annotate a handful of
> the data as constant alongside updating all the respective APIs.
> 
> There's nothing particularly existing or controversial here, despite the
> size of the series. That said, I'm not 100% sure that all code-paths
> have been (runtime) tested.
> 
> [...]

Here is the summary with links:
  - [BlueZ,01/20] src: const annotate the bluetooth plugin API
    (no matching commit)
  - [BlueZ,02/20] monitor: const annotate util_ltv_debugger instances and API
    (no matching commit)
  - [BlueZ,03/20] monitor: const annotate cmd/handler tables
    (no matching commit)
  - [BlueZ,04/20] monitor: const annotate misc arrays
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4630f3fba0fc
  - [BlueZ,05/20] monitor: const annotate intel_version_tlv_desc::type_str and API
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5380e63a80f2
  - [BlueZ,06/20] monitor: const annotate type_table and related API
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f8e0270a7a73
  - [BlueZ,07/20] profiles: annotate immutable data as const
    (no matching commit)
  - [BlueZ,08/20] attrib: annotate immutable data as const
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a8543fd2b062
  - [BlueZ,09/20] client: annotate struct option instances as const
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=20864af937f3
  - [BlueZ,10/20] emulator: const annotate rfcomm_crc_table[]
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d88fd2fabd6
  - [BlueZ,11/20] gobex: const annotate RO arrays, use G_N_ELEMENTS
    (no matching commit)
  - [BlueZ,12/20] lib: const annotate hci_map instances and related API
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=af552cd906a0
  - [BlueZ,13/20] lib: const annotate tupla instances and API
    (no matching commit)
  - [BlueZ,14/20] mesh: const annotate misc data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a9393b2e9eec
  - [BlueZ,15/20] obexd: remove obex_mime_type_driver::set_io_watch
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e88f8cecaa8
  - [BlueZ,16/20] obexd: const obex_mime_type_driver instances and API
    (no matching commit)
  - [BlueZ,17/20] obexd: const obex_service_driver instances and API
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ae8f9c956069
  - [BlueZ,18/20] obexd: const obex_transport_driver instances and API
    (no matching commit)
  - [BlueZ,19/20] obexd: const annotate misc immutable data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ac1d2369b29a
  - [BlueZ,20/20] obexd: const annotate obex_plugin_desc entrypoint
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e0c64a2031e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


