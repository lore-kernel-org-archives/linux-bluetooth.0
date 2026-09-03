Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CA4F799E
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465686; cv=none; b=BF90S3qo8sv6qiyLkegUktVOLjva1nwNO1LAss1CD7M3ud9B6Sz9DB6WHNhbtrLB8fr7R3XQFOMLQIcNpetWR9P53g+buNyT87EHGsOy/FFfp2xVPbz24ZDf27pSJyR5bNOrzj7/bKPTNta5R60Y3aW0r7rb6pXTxfZZCuKIhs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465686; c=relaxed/simple;
	bh=J4Lf2GtiOXAx//98MvlOTh0NxO06e+nuwfy21dMcVOM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gxQJNHmSRGdYURgmUsyn/pZfOB8I01wu+RnLDb8paaJCynWzhKTA7C+gHKkRsswhDjBxw3WiJfIOodQbkLY1KnYiWHzxK8hzxsFA/BfdDvITPTHwxl2OmejI5lPpZI69CMZ6txA/yps2juM9vbo/wAl2UXJEPPzvy2Em0DWBQtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6QY9yKh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6QY9yKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C651F00AC4;
	Thu,  3 Sep 2026 20:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788465673;
	bh=E/sT73H4sT5loJoBm6fEo/4Mxk0f6fkNEJjambkKtIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C6QY9yKhLbAgCrBgwEtBs3Vw0QsnJcWiLo+p+AcU32YjGMqKtM1Ic+u3FaeuaEwPv
	 LfZfgg0A3CwXWe2gfKTJABUVY2dNqPbzQDK9eBYqQ1LTh0kKEtOBNU/Jb6phLhS/l3
	 RDU+dcHtasjhPP6cjwjUxGRgOMjZIGfxWkbs1oGZkLpFUxcGIF8pTNdWzR19Qa4tdI
	 MZn01yHv1YnpTB/iz9UyyBPKW8DH4Y8UybsC5KzZfMxuNOI69q3ULoLkKhngXgZqfQ
	 bKHjEjQcoAvARMtBTwf52uktlWr4foEz8T0nXerR/+jC94WOn+GOHJIwLZwVnCf+j+
	 43uxlq+eB7X5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939BD38119DE;
	Thu,  3 Sep 2026 20:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: Move H:4 reassembly into the Bluetooth
 core
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178846561414.3994681.12326882866187141906.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 20:00:14 +0000
References: <20260828201306.593974-1-luiz.dentz@gmail.com>
In-Reply-To: <20260828201306.593974-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Aug 2026 16:13:05 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> h4_recv_buf() is currently implemented in hci_h4.c which is only built as
> part of the hci_uart module, and only when CONFIG_BT_HCIUART_H4 is
> enabled. That makes the H:4 reassembly logic unusable by drivers which do
> not depend on hci_uart, e.g. btusb which needs it to implement Bulk
> Serialization Mode.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: Move H:4 reassembly into the Bluetooth core
    https://git.kernel.org/bluetooth/bluetooth-next/c/37521ec2f55f
  - [v2,2/2] Bluetooth: btusb: Add support for Bulk Serialization Mode
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


