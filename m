Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16C81726
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636829; cv=none; b=JE1tkl9UspEfU2VQSF/MTYUrNLkiC3v9lUdYQWCezlLyJadSYq0z2a/u+dWeNqiD70MC3yFZ6hi7MEbKuq2DAdeBbcg4XC56csjQzcUvMKwU+aPAUShAe7uu/w5z0DDQ8NftQpYPcYs7BjC42VGM/5ZPXrzNxstu2N+1ucqStcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636829; c=relaxed/simple;
	bh=TyG2f76uPB+rlM8+i5PgJ2D7ncTAmievDILcr3yxD+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e6EmfscMHX9W3MHhzUL9AtbLxBXePdsnIUXymeQPncJnhwipjp9P9eOV+fiYDqUhafS+wjK3pKNzdyZBBfXapGWbYHz2gvxRhNDD9UfaSWJTKpUrjs5yffFu1DI3lKZXtIlhiDfYC1wlm8QLtjG5xKnk7bhwHUR5PxdnqCCiCDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W05YCGxo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W05YCGxo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 809F1C43394;
	Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636829;
	bh=TyG2f76uPB+rlM8+i5PgJ2D7ncTAmievDILcr3yxD+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W05YCGxoBNAYwYfQrMXcAWjzTpuKDoYMQFzYJiojyaN/XbCGcqYfxeQRI5hv4nYRk
	 r88vMFL99wZyKPMixgsfhttf+djt6YJcq1PND2qOxPF0amabMI26D3C1In8HAG7+Ug
	 ztFiHzvfscE7PfBZcJxf29OFEIIKNMQc7JrQbFJogq4xmzjB4iHls/5wxBzWw18+px
	 AodZKNp8iagOxqkRFeTyAEwG1tWImJ+REDqXV9EHEVguL+nUptnmp2nn9sLg8rqhxL
	 owi0S9Rqrp3Ium0GQ7rEPNFfZmMsLN6BPAYZF/LzxO6rpFA631yQ/j4hT1dhFJ2uDw
	 VE7oM/fhTwKXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72B06D8BD1D;
	Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] Allow endpoint config without local endpoint
 argument
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171163682946.3770.7994830314688719570.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 14:40:29 +0000
References: <20240320144153.46408-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240320144153.46408-1-silviu.barbulescu@nxp.com>
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
 iulia.tanasescu@nxp.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Mar 2024 16:41:51 +0200 you wrote:
> Update endpoint config command to create a local endpoint for broadcast
> endpoint.
> This will be used to configure a broadcast source/sink if
> register endpoint is done from another application like PipeWire
> 
> Sample output from using the endpoint.config with endpoint and preset
> to configure a broadcast sink to connect to a BIS.
> The register endpoint for the broadcast sink has been done with PipeWire.
> [Waiting to connect to bluetoothd...
> [bluetooth]Agent registered
> [bluetooth]hci0 new_settings: powered bondable le secure-conn
> cis-central cis-peripheral iso-broadcaster sync-receiver
> [bluetooth][CHG[0m] Controller C0:07:E8:CE:94:CD Pairable: yes
> [bluetooth]AdvertisementMonitor path registered
> [bluetooth]scan on
> [?2004h[bluetooth]SetDiscoveryFilter success
> [bluetooth]Discovery started
> [bluetooth][CHG Controller C0:07:E8:CE:94:CD Discovering: yes
> [bluetooth][NEW [Device 18:41:1D:57:63:C6 18-41-1D-57-63-C6
> [bluetooth][NEW Endpoint /org/bluez/hci0/dev_18_41_1D_57_63_C6/pac_bcast0
> mendpoint.config /org/bluez/hci0/dev_18_41_1D_57_63_C6/pac_bcast0 48_4_1
> endpoint.config /org/bluez/hci0/dev_18_41_1D_57_63_C6/pac_bcast0 48_4_1
> Configuration.#0: len 0x02 type 0x01
> Configuration.Sampling Frequency: 48 Khz (0x08)
> Configuration.#1: len 0x02 type 0x02
> Configuration.Frame Duration: 10 ms (0x01)
> Configuration.#2: len 0x03 type 0x04
> Configuration.Frame Length: 120 (0x0078)
> BCode:
> 01 02 68 05 53 f1 41 5a a2 65 bb af c6 ea 03 b8 ..h.S.AZ.e......
> Framing 0x00
> PresentationDelay 40000
> Interval 10000
> PHY 0x02
> SDU 120
> Retransmissions 4
> Latency 20
> [NEW Transport /org/bluez/hci0/dev_18_41_1D_57_63_C6/pac_bcast0/fd0
> [bluetooth]Endpoint /local/endpoint/baa/lc3 configured
> Sample output from using the endpoint.config with endpoint and preset
> to configure a broadcast source BIS.
> The register endpoint has been done with PipeWire.
> [Waiting to connect to bluetoothd...
> [[bluetooth][0m# Agent registered
> [[bluetooth][0m# hci0 new_settings: powered bondable le secure-conn
> cis-central cis-peripheral iso-broadcaster sync-receiver
> [[bluetooth][0m# [[CHG[0m] Controller C0:07:E8:CE:94:CD Pairable: yes
> [[bluetooth][0m# AdvertisementMonitor path registered
> [[bluetooth][0m# [[NEW[0m] Endpoint /org/bluez/hci0/pac_bcast0
> [[bluetooth][0m# [7mendpoint.config /org/bluez/hci0/pac_bcast0 48_4_1
> endpoint.config /org/bluez/hci0/pac_bcast0 48_4_1
> [[1;39m[/local/endpoint/bcaa/lc3] BIG (auto/value): [0m0
> [[1;39m[/local/endpoint/bcaa/lc3] Enter channel location (value/no): [0m1
> [[1;39m[/local/endpoint/bcaa/lc3] Enter Metadata (value/no): [0mn
> Configuration.#0: len 0x02 type 0x01
> Configuration.Sampling Frequency: 48 Khz (0x08)
> Configuration.#1: len 0x02 type 0x02
> Configuration.Frame Duration: 10 ms (0x01)
> Configuration.#2: len 0x03 type 0x04
> Configuration.Frame Length: 120 (0x0078)
> Configuration.#3: len 0x05 type 0x03
> Configuration.Location: 0x00000001
> Configuration.Location: Front Left (0x00000001)
> BIG 0x00
> BCode:
> 01 02 68 05 53 f1 41 5a a2 65 bb af c6 ea 03 b8 ..h.S.AZ.e......
> Framing 0x00
> PresentationDelay 40000
> Interval 10000
> PHY 0x02
> SDU 120
> Retransmissions 4
> Latency 20
> [[[bluetooth][0m# [[NEW[0m] Transport /org/bluez/hci0/pac_bcast0/fd0
> [[bluetooth][0m# Endpoint /local/endpoint/bcaa/lc3 configured
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] bap: Add bcast source support for MediaEndpoint Codec
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0ff7392af164
  - [BlueZ,2/2] player: Allow endpoint config without local endpoint argument
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


