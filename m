Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BD3C585C
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876427; cv=none; b=F2UK3NivJhgFFSpzBYvn2hl+NU7v+uEC+rmXHMocCPvZlMfi4JiAenEo8EotAVV0CdYPx9E/ACRnG9EMiY4Hg1vvkNySBuxZ8mjtXZQ9b7F67HZ8bCu+LUvGwhdVFzHSw5Mh5q6d0cIo+oq6U1b+4FtGXKl+giPrvW7e6XjPihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876427; c=relaxed/simple;
	bh=zu2fnDlhOnecfcBr25JNtAnC9COoL5lDn1uG5IjdL3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fsbZGs5LwxOGXE/AJjv3sa3Up94Oiq9YNQhtfNU9u9s70twTOqFL5dVcnq4fk8i21r6u4Giu2B1GJEHOF8gutOyzkUynXI48kMQvJYqqnXb3sb7JKWkBs1Ilyf59yPMUYCn1N0dlCr7V3XZjBFogDZknpwgZ/x1opQkQPygtjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKgD+Rzn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKgD+Rzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814301F000FF;
	Thu,  1 Oct 2026 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790876417;
	bh=rnLZRXJSh4nrxqIjgkYJTfyQCj56xUi5ZTMNP7LwH+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nKgD+Rzn4VUd4TUEnw8t7lbWr7nqi5OeYwN2j2yhSoQapqEyfgPCAmVbwWxnp4xBw
	 XqCM3HIR4AweYX+C00UR6kKmzxteFsWdsT2spvEJbqhrHU6J8jWg+x1LNSiLfjHl94
	 8nAI7F/k9UV62lsaSalfVcBZ2ejm25OGcfiOA+hyxbkWIeGSVW3+UNhYhpQ89wv2wJ
	 h6Sw/Aq8IMMCL6tYP5U4+T/ClKB9iee2Qkeno57tnPIdJ0yv7kYA7AmMw2RPM1dCDS
	 5K3Y7dzkAU1cixq07C43dnIlfTi5ovjkySWnuZuxIj9TvZuRfWQIuRoa7jmyivDtV0
	 4AiVeMY5FZeHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772C33811961;
	Thu,  1 Oct 2026 17:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 0/6] mgmt/device: report link security level to
 D-Bus
 clients
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179087641603.3027576.11599397534070933900.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 17:40:16 +0000
References: <20260929101953.254969-1-frederic.danis@collabora.com>
In-Reply-To: <20260929101953.254969-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Sep 2026 12:19:47 +0200 you wrote:
> This series adds connection security-level reporting.
> The new MGMT_EV_SECURITY_LEVEL_CHANGED event [1] is documented and
> org.bluez.Device1 is updates with new experimental read-only properties
> SecurityLevel and EncryptionType.
> Those properties can be displayed using "bluetoothctl info".
> 
> This is intended to let clients (including test tooling such as btpclient)
> observe effective link security changes.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/6] mgmt: Add Security Level Changed event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bb98c3e02282
  - [BlueZ,v4,2/6] mgmt-tester: Add Security Level Changed event tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=74334ac97049
  - [BlueZ,v4,3/6] monitor: Add support for Mgmt Security Level changed event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1391af1995a9
  - [BlueZ,v4,4/6] device: Add SecurityLevel properties to org.bluez.Device1
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=09e58eb8da1b
  - [BlueZ,v4,5/6] org.bluez.Device: Add Security Level related properties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d3f2b6f3e142
  - [BlueZ,v4,6/6] client: Display SecurityLevel in device info
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ae69dcddd549

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


