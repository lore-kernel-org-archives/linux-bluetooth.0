Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B3D41754;
	Fri, 20 Feb 2026 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771598400; cv=none; b=CDcZ/z4tunmedHDAGwdvA2tXSCIWHo+fmar5QqVX/2uPAfQnCmE6Z8QAJuBT6rBupsStnX3YohLlOyaxsZ+nEgZvmh9JGvA2lzDoaBYqGDrD7zBcEmONJEkXX2qldc/fdVWqM9JUGxaE/43gcSslA/OK1Tb0UpZuxI2Ygq33RNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771598400; c=relaxed/simple;
	bh=LyGi7WUbWhTHoolhD36fLiBiIaIOs25Zl5kFFcKGUGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ebCjeOvaulQERynvWrx3hfspVtRMRQ8AxcKgtpbRGdZgvU/HenK9+qoZ81dImyb0ORrA8TiURMiwHz6hvmTrURZxIBnCGoP9zlcBAG18ZfjAb9EwCOICtDeU+ngUqy45KizKui5VhAGylJb0OqV6OSd47lCCOjSlzYcdPMLEoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D824gdji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D824gdji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE52C116C6;
	Fri, 20 Feb 2026 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771598400;
	bh=LyGi7WUbWhTHoolhD36fLiBiIaIOs25Zl5kFFcKGUGg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D824gdji96H9YLjbFCmQ8fVAjmNLvwra3pwmKYw5uCISZY31jtd2+To6uoGcjkrDs
	 acjMI6czymR6HxyJsuiGraTMwkIvPNo8pF1t27iPf+pmoWhuC7/iXV19IohLjtSRQK
	 eTlraURi1ylx6nJSse+6KBZPPAo7MaSZHHb96iacJtU1zdphMbyfXmjkDR2EGM5ljv
	 kIW9ZEdyhgvF8Q/0qaL5PIcSM0oGAdJypUPmLjgzITvYPKmdjWTAMdPDGSQDCNJzj/
	 8Po0LGqr0Z1oM7eTWQR1haw5wzSlf2vPs4RE3LCcQRmGjEoTH4GrSIoOs4IbZImUqb
	 mLoWmyeT2znCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0893808200;
	Fri, 20 Feb 2026 14:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: hci_qca: Fix confusing shutdown() and
 power_off() naming
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177159840830.557111.11680373477755318049.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 14:40:08 +0000
References: <20260212141721.69961-1-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20260212141721.69961-1-johannes.goede@oss.qualcomm.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Feb 2026 15:17:20 +0100 you wrote:
> The function called qca_power_off() is actually the hci_dev shutdown
> handler, rename it to qca_hci_shutdown() to make this clear.
> 
> While the qca_power_shutdown() function is actually the counter-part
> of qca_power_on() rename it to qca_power_off() to make this clear.
> 
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_qca: Fix confusing shutdown() and power_off() naming
    (no matching commit)
  - [2/2] Bluetooth: hci_qca: Fix BT not getting powered-off on rmmod
    https://git.kernel.org/bluetooth/bluetooth-next/c/e08fdde76adb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


