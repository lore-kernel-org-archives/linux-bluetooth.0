Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7710A0A;
	Thu, 23 May 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480639; cv=none; b=Eow1QyDceBRArmVw3zG8WC75yuPb6FFFiWn5kVUW1HGgrp7PQY8TFQo/MGEaDxD/lTHwVPk1egF26gkcGAezlg2PiHOY6i2PJPzT6uqt5dDwtD580BkUFsFhYf8BbgIoBJO5PnA4cX32GVFUEuv3lAJQat8UYzNi3WVezNvqqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480639; c=relaxed/simple;
	bh=LUsu4+PX8HsFrCk8/Sb8NQm534d/KZ3eS2N0XqMdpHg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bh42irsx7ievWiPNj2xR/uKrKb7I1BSqLQ8PK8Zk6eADL162zIL4NHM7tiTgZkvE5d5ucvDuFZmzpyi13WD4qrpngttoRxsRuNn/xIidlEL5L4ZzHQSODLse232y6pg4ThbrLn8lr8OURF1WyiYpHuI2wxhSCZQOJH/YLo1RAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXxfZkEG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXxfZkEG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A757C32786;
	Thu, 23 May 2024 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716480638;
	bh=LUsu4+PX8HsFrCk8/Sb8NQm534d/KZ3eS2N0XqMdpHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kXxfZkEGLdXSFxnQMlsPxG+vWCa8FAGpZwnuwSq5WdcX005UEN93ymOePHzbBkpwT
	 gFOVU2T0ZgBsLryd/ISd+JRTbX/WKFChGRE/ECpTkTKuLJ5VhtcO+aLe+msfTcaSwu
	 wFMbCZ4Ysf6nd7fRXLQ25MWaCNoLs3Bgg4tyMLAHne2ArKkCDZnUMh/HqKpahx8llV
	 qfIPqS+hCHyTaSulWh7aaGMFAx6qRqUID9zblBFMOWpCaFlR/uFXT5xfxfJZxMnl1o
	 SYHDP8jiAKGMzXZuAg19ThakW1Pbvx9cDa+M6/mpJw/07Sj6RAUqFTsPQyIjr+mOpV
	 dpQuOYqeaSk0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88EB1C54BB3;
	Thu, 23 May 2024 16:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth/nokia: Remove unused struct 'hci_nokia_radio_hdr'
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171648063855.15817.12738258117203307401.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 16:10:38 +0000
References: <20240509001138.204427-1-linux@treblig.org>
In-Reply-To: <20240509001138.204427-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, sre@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  9 May 2024 01:11:38 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'hci_nokia_radio_hdr' looks like it was unused since it's
> initial commit.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> [...]

Here is the summary with links:
  - Bluetooth/nokia: Remove unused struct 'hci_nokia_radio_hdr'
    https://git.kernel.org/bluetooth/bluetooth-next/c/04e83604f585

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


