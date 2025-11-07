Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C42EB861
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542637; cv=none; b=P3CZ+QjUuUkAhK30ozI+WObARO3mj/mOy6AFm8+Qo7VfOXzXYBF+usmC8GrqZ5yTygSEVVkkByYVt/MW3XXzJKRfhWd5QxDzTY9lv8jILs6sai9OKnE42WKWRhfRWzOqA+nZdXaG0EHLrwlH8t9PbVdyncBuyn38+eBakCosCsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542637; c=relaxed/simple;
	bh=ZixnJg1YrPtSPtN2Uq5cIItCfi+bvi9MS+ESD5AmYHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PKi4RigWzRJ8k0ugGMv/2JtnpOetMAetLD35n1SjkRRURSOpf72h9/EQEP1VqhgjypD4X5Xf56AmmzS2zJok4wwDI4XilLN9d/sUO+ODeqVAbnRD5KPcJZdG4bUGUltt1rJzo1qsl64oQ0qV3FcEjRQD/SwwXpXwiWCcRB41EYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0k32lDT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0k32lDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736E7C113D0;
	Fri,  7 Nov 2025 19:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762542637;
	bh=ZixnJg1YrPtSPtN2Uq5cIItCfi+bvi9MS+ESD5AmYHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e0k32lDTFsf2dwUUIbSaV1vhk76KGJwWHHVtd7hbEP5crUVPf22NuVVh6s0tX/mQk
	 prUSMxgjV8td/g/nhN0IZSzKzDUT3e5XeIotXDsndMw2liP83rPWISFrLA7SZyXm4R
	 JWhZjaMW9P6eXlkHDKwaCHbbXT5XbhrTyOBbdO0kGCf01BekefeAaN+koU/+TKMdBS
	 MTNRh/aIWF+toF0qcwf3Yja/3JKTywrNz8j08+RQxr8uhT0ZtS09e2BzzPHTsvBC1w
	 USjsutumF6wyTDZn0MniZ75hlclZynexR4NGY1Hgj7E9TLGSr9j48KWNTimwmZ75Tf
	 O9w4dGx/gDZoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFDA39FEB7D;
	Fri,  7 Nov 2025 19:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_conn: Fix not cleaning up PA_LINK
 connections
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176254260974.1132280.2119288986960842637.git-patchwork-notify@kernel.org>
Date: Fri, 07 Nov 2025 19:10:09 +0000
References: <20251106230943.877242-1-luiz.dentz@gmail.com>
In-Reply-To: <20251106230943.877242-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  6 Nov 2025 18:09:42 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Contrary to what was stated on d36349ea73d8 ("Bluetooth: hci_conn:
> Fix running bis_cleanup for hci_conn->type PA_LINK") the PA_LINK does
> in fact needs to run bis_cleanup in order to terminate the PA Sync,
> since that is bond to the listening socket which is the entity that
> controls the lifetime of PA Sync, so if it is closed/released the PA
> Sync shall be terminated, terminating the PA Sync shall not result in
> the BIG Sync being terminated since once the later is established it
> doesn't depend on the former anymore.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: hci_conn: Fix not cleaning up PA_LINK connections
    https://git.kernel.org/bluetooth/bluetooth-next/c/84f59de96cf0
  - [v2,2/2] Bluetooth: hci_event: Fix not handling PA Sync Lost event
    https://git.kernel.org/bluetooth/bluetooth-next/c/59e5396a2579

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


