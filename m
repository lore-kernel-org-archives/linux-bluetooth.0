Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C3D4A13A1
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693460; cv=none; b=RPT+n6W8sh46pon0DereMbTrVL29S+olcMSYbizy2UIQKovA40p/Xre4ryU2eNktx+0o+c2cPMmoadskdr9xeZpJgHDPIcXgqJidZIrXEWHVzotedt4Uu1AJJK4T6MpcFIwl5d530uKjywGqdJvMP21g/xfjEQ2e2LzhoctFZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693460; c=relaxed/simple;
	bh=OuwdTUIR0xm4xHjVd8jGTcI4r9judw6RN7SzrK2wMMw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XQ9LcAEz2f6BgjfD/4DqGVGPO1dght1Jn6FiQwqdcQz/agpjhbFd/jOiDSEmGwhC67FhEzbrxgUYkHCbGPcQE2lxuCLzJmvcnAitTTtG7QW0Jo6/UDk0Pzf13ISv6xZTs1im6qjhvSQto466qOVoyJmtVYoq+2jRZsY/aW39dNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC3RA/TT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC3RA/TT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A285C19425;
	Wed, 13 May 2026 17:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778693460;
	bh=OuwdTUIR0xm4xHjVd8jGTcI4r9judw6RN7SzrK2wMMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NC3RA/TTGDr7BSCjzjoPLBcNyaxuQJIWQTx7egYbnnKGuOCZR5g67y2qt/Nxhhw8d
	 KRPWejKkvEezoqXTxEFfAjNG4bxVTBPWCI+j5n1rUwZUdvxdQ7SIMqydMqisahvPRM
	 C3hZ4ddn7P3+sSY1pPjbt+IvytvIERwbwvPO0w4ucPOGq3c8DlHc8MpRuOehRfSosZ
	 62vxaswbj+0urSQpDtqFe13p6oAM8Wxz7MXCMaOF9/8m6gNfDEbyHNWpoIS7Am00je
	 t2KivpNIAFU/tri6IhpLnVfzMQPiEPuucA8HsMA6rn7dsN6P258+8dtbR+LLr1Mdih
	 J/rbIHJCd8bwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DD3393023E;
	Wed, 13 May 2026 17:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btusb: Add support for Intel Lizard Peak 2
 (0x8087:0x0040)
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177869340530.3749256.5585432261077716049.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 17:30:05 +0000
References: <20260512083444.1214935-1-ravindra@intel.com>
In-Reply-To: <20260512083444.1214935-1-ravindra@intel.com>
To: Ravindra <ravindra@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 kiran.k@intel.com, chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 May 2026 14:04:44 +0530 you wrote:
> Device from /sys/kernel/debug/usb/devices:
> 
> T:  Bus=09 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=8087 ProdID=0040 Rev= 0.00
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btusb: Add support for Intel Lizard Peak 2 (0x8087:0x0040)
    https://git.kernel.org/bluetooth/bluetooth-next/c/a9a4dd96b77c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


