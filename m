Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E23289367
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397040; cv=none; b=HEXusc7A3Fjd7GbTCutNGVMPjMWvROYsgPaBQAD0hQ4lwyt+Kge+Psf5S2IMc4W28WL6UkUDITjQytdqL9LBHsudwIrLP8DAXkZqFxhoi1QGxjXzJv77haaSwmU3SmVmoL51CAaAlFtmiDAL0X9Iwkc1PU7XV/AorVucN3POIUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397040; c=relaxed/simple;
	bh=eb1wOfWRUC4qTdYJML2T3AGfHcykHDALGCFnKv3s9b4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u62PExw8Ebx27MGL+KXsfzvuDej04QkiZ41wCRncLCGT4Ui3i2mNK7ufjTj0a7wkZd3houxXcuLN4CzMIPROzb8rcLkiQBJtIbil/XV+Xtbg6tIbKMABu7JWM2oAHsSyNYSHnSPM11+rmawnFrS/k4DgvKsDJOHJTSPls+fAGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTeBnzLI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTeBnzLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEA5C4CEF1;
	Mon, 17 Nov 2025 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763397039;
	bh=eb1wOfWRUC4qTdYJML2T3AGfHcykHDALGCFnKv3s9b4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZTeBnzLI3LMAJwJRzSGOEscn8BBDv76t1BWuJbve487ZhkmQef383XFmxyXVD7Lye
	 S6IEXYdhs9TbAgZHvwqfZKVsIefa+ymTi75QMK+BD28AdzT8ECUr/p1AnK1TmTZtDp
	 da20UTiRLH5jSnjC3sCvn1ANNsqc6jFrm2LT3JxEwHxcy6mDY+ts8XV8DoVJ6TX/G/
	 VAuZGQL9rdbG6Nxe9KvHrNev+EAqacBNZWiVLJ8S/DlELQcvrf1+cWq0LrgCMrJIx8
	 /hlD1O5+e51lUZSyzronYUDPjVudXT80d0wbzkYM1rZUTXHyOCeZtmZ9YrNx51B7iT
	 ZXoEA4EVEsc+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE6A3809A02;
	Mon, 17 Nov 2025 16:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v7 1/2] shared/battery: improve the display of the
 charge level
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176339700651.3386490.5816332864802462652.git-patchwork-notify@kernel.org>
Date: Mon, 17 Nov 2025 16:30:06 +0000
References: <20251114121140.102190-1-r.smirnov@omp.ru>
In-Reply-To: <20251114121140.102190-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Nov 2025 15:11:36 +0300 you wrote:
> The battery charge level may fluctuate due to uncalibrated
> sensors. Commit smooths out such fluctuations.
> 
> The algorithm for determining uncalibrated sensors consists of
> finding the number of changes in charge direction (i.e., "spikes").
> If the number of spikes is zero, the device is charging or discharging.
> If there is one spike, it may mean that the device has started charging
> or has been disconnected from charging. If there are two or more spikes,
> this is a clear indication of an uncalibrated sensor.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v7,1/2] shared/battery: improve the display of the charge level
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c5d4a041483c
  - [BlueZ,v7,2/2] unit: Add basic unit tests for battery charge handling
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


