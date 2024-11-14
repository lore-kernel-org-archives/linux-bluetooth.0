Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11419D088
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615517; cv=none; b=WBPTase8/CwAFZwlC/dc5EuwpaMD85VUeQ5V+10QjqH8VIix6JhsmfXNPA6nNlFeLFcbz2uW4FzJyZ28InGniZPzI0HC4zGYOZcdTTRLAZii9mJyHz4o45AUxzLFAipE9aN5GzjZFp4wu4EbSARhAuNau2i1iNhF+1lFIxSO8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615517; c=relaxed/simple;
	bh=wwZ0xTndI6dEyLcJRklk1pomSAKCW1ub14uZo/Cch6E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uhYouSbrzwAuYiLWo+orUoMXS1TGaFCB4Hd6XoPRltLWGXpS4swoyC+MruBe8qgshfCZWzkvXzntHw4xjhQn9g9whGpC71z69IPHSQB7nFTbhl7655leYPGcnS52DdeoDwQFNZe9+TLtHsTKt+T/wWmKWxfj2tyGG2R62o/ywrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6cHacfm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6cHacfm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3500EC4CECD
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 20:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731615517;
	bh=wwZ0xTndI6dEyLcJRklk1pomSAKCW1ub14uZo/Cch6E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q6cHacfmg4DECRwJtRiteUuKzk+VZThxeILvLVd4JTB++8FrLDT/kqa+1CfSH2Jil
	 /IDN9ShhM4Slq4liYE4QAPDD32+B92Oswesc0SoA1/t2CUYkQZOBUVFO623TwVMqGs
	 0DBR6yYaR/5LWwNPlBCXqcAqC7E3gCtH5Z8OIToAlowlybCO5kx41xQw4Jp1xPbSzT
	 rUixKtN/B8BJyp/T27t4oMMeVe7z8FBy3I6HA05dKiXc2H+7Yhx4LTQu0A3x1GY2Cu
	 klFzxp3AYQa9nyppRdLsnecvUze11CZ3ODOMakcMR6aa6/svg77rz8nEI4h6qDlrdt
	 Iw2FLzixNBqJQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 25E2FC53BBF; Thu, 14 Nov 2024 20:18:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219494] Mediatek MT7921U WIFI + bluetooth USB Dongle - System
 Crash - Cold Boot
Date: Thu, 14 Nov 2024 20:18:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: mail@nelsongaspar.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219494-62941-BqSJmeLQfM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219494-62941@https.bugzilla.kernel.org/>
References: <bug-219494-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219494

--- Comment #2 from nelsongas (mail@nelsongaspar.com) ---
Applied the patch refered in
https://lore.kernel.org/all/20240822052310.25220-1-hao.qin@mediatek.com/ and
did no fixed the issue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
