Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5432F765
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536217; cv=none; b=Ettw4QNKxj9vJCU7YHww4uWAIWDmPHTLsQ2omlcAgKMeVdp/EvnsFwZ8q6hB6S6jLmwMsvlmxtBAnpFMvAe6Ek/xtGXi1uOGjHhUl6JUrx/W588DTawnwP3CMqLP73L6fvcsYB/kzXhQdL3jdZty0UGfwEr13d75IL7sU/dJAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536217; c=relaxed/simple;
	bh=nnL3gVGkNjT0JrC0ZLI7rH46KGBgx8yLGqjhy60xIu4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iIBZA2ifM26UMGtzR5Z9sOAA99uKQEM9CT+wltlY5oOd3RdTIaF04EXxwF48xWvXbcqc2ilLxaaP7c64ttPD0un3LbOpP3St8xGPDmsg5HFkannmuHxS/Jog6Vnq2KGIEf+jQ8zYkwqh1x3zcDCpdRb6q3U0lB7rHk7fCXv+nuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAgNX3I1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAgNX3I1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED632C2BCB3
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 18:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783536217;
	bh=nnL3gVGkNjT0JrC0ZLI7rH46KGBgx8yLGqjhy60xIu4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rAgNX3I19ucNS2cNFkrX1RzI5Z/UYBhGqD+ZrBLvSm7XCcrK53k0KZlefrW+UFdGN
	 uyHU8+QD4NCsk/Q8WGkBO/RWGU5wdzHDkWPy4LOutocXrvgBjq/k4h+2a7GiP/h+Yw
	 h77njdMQ0vDRA247rBW1uUhoPQW3vnHZw5SxXeW7Ht5bh+bRoCAaTtNxFw3kv0M37g
	 0R9tLOzIFidqaJ19zEEGzuLz83AlYa/zVTOjuLQ+tv5nEaIXn71gWK7ceg2gFVLFnh
	 ShZ07j+5xGftR/N6k9gW6Sn27p3xRyWlfXtS6uHqkZ43FftUxbiisGNDMHG+2bSEpn
	 wjOTZjcbcyJXg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D154AC4160E; Wed,  8 Jul 2026 18:43:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218952] bluetooth and wireplumber stop working after some time
 - dmesg report BUG
Date: Wed, 08 Jul 2026 18:43:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: martin@hignett.net
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218952-62941-gUPSnkCWY9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218952-62941@https.bugzilla.kernel.org/>
References: <bug-218952-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218952

--- Comment #9 from Martin Hignett (martin@hignett.net) ---
This was fixed for me before 7.0 was released. My current 7.1.2 is also fin=
e.

Thanks,

Martin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
