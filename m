Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793360717;
	b=PMCnXbtdIXXr9i2hTQhseWpMjTilsBYGR5bAjAujyzmqUGEVk3nivz8zYbggMh2qs6aL
	 OwBv9Py+1XTkTtMumR7LT0zx0hYvQP0r79mHlt9q060OETkufaWLzZOluc9DJXXSkn+Bt
	 xaO+itunv4H9mYpa9F+padOjUme1kg5GsvvMheaoQO7oH7ydhHM0IS540BIVcFmDwRLUJ
	 D3k3HydIu60NOwxuqNNKvgijIGNEphlYQDlUXMParKHbqwcpQtR4dRJPFjJZDboR2P792
	 HJL1+usbIP+0GPOvc7EMqq53X47Qwxx4tpdKkCaL3pkpOTsvQmoPxgZdPuFvAedWLUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360717;
	h=Received:Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=mCAbw1w455hcLOIqW2s/IZXRGq+I1YfxZoxlqMF/BQw=;
	b=kQGGUXUAZdjjTUdUsNZiyRem6MCnLBklwd6NTFIiunlHXjS2jVRiileriuw5OP19jGxL
	 G2/nLvX3Iv/j5g1NYN8lWP0xMSzAfbfMmMceDAjsvYI3A1OpUWS+QLcUdB0JjWpzOD1zG
	 GmpZ9YlNUIm/m7VdBWQLxK1Rlm76U4SX18yDhwt8SZo+YCPhinsGIbKLZTlXZ3y/SKO+U
	 +A2cZJE7g4nb6iQdPndGm4YzG4k6mq1oaX+UxKXILu+4zCgitPmGeFJt6vaIooEXwEiCB
	 CjZ5f3jyAuaPGrE+FGgKzZCnPvaaz+uJMxUNZNOm4XXGGNg0YYTFkpvvmcale/V95Kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h1jtsiou;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BE3606A31A
	for <linux-bluetooth.vger.kernel.org@localhost.mlmmj>; Fri, 30 Oct 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h1jtsiou
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7386513C0
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1793360716; cv=none; b=BdS9DWPRG8qury5vy+GEEGoiDNRKN4U/0QPdGah18cItRA/RD+dLvbTqNSbpeZtEofluFH2rsJjeJArncIXwxYV27htjMwGaV6DCqyWlPsg1wLpLa2csd3rIIMqmMsmmR+Bx2O+ngkDvA0boJ3oqYaPkSGw28Z1nXDlgnNXf9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1793360716; c=relaxed/simple;
	bh=rUz3OymZulrF6bSgh0AEFO058GJ16XkKPz97+EtJozs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FBNRDznjm6aVC7P2rSx5AaYdz0sjrny61kR9gJHvfYrLAzYAPgn0hkqNTLABWteNwCunBtSFWlfdwCFfZ1X9SkSEKNNtbIJtD1U9hVAEqRhoHtA7YZgXzv9sNYEL0WOzYxZRaB5l9x2LswSSUkxLBPwqblzUzDQNDlzxXHCMJoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1jtsiou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE6A7C2BD04
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1793360716;
	bh=rUz3OymZulrF6bSgh0AEFO058GJ16XkKPz97+EtJozs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h1jtsiouR0IbeweHAvLXSvP1CvBQBWW4WaexBdQN3pyscaEn3kjT+KvmDvJOAqpwW
	 h06WQ0Mdur8ccDszAf64c5nSZDnZZ7sp/10GpL3lCFPVNOkD4tRT4TIH+UveDUk/09
	 wwjkB3qSWEA0W4RKj2MCfU89bZy5waROcwnZ9SDt030ySSEpSMmGX3Lqj9jGE3VBxB
	 1IpVyxLvFhXrQc0zEwO5RxM/T+G0yJbvaUTtMtYXH1s/7OQSYAT9y6iXXeYrsgFdnl
	 R1HstV2rsuwioTiteIjdRJWIzv7jUqXRfAq/pq4uxFtwn4YTCwWpmEhfmNVbnjdGP2
	 gRMshAtzpjUMA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C8BCDC4160E; Fri, 30 Oct 2026 11:45:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 222177] Bluetooth AX201 device does not work on Debian 13 on
 Kernel 6.12.114, works on 6.12.113
Date: Fri, 30 Oct 2026 11:45:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: haasje@welmers.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-222177-62941-Zauf3xBZ6N@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222177-62941@https.bugzilla.kernel.org/>
References: <bug-222177-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222177

Bastiaan Welmers (haasje@welmers.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |haasje@welmers.net

--- Comment #2 from Bastiaan Welmers (haasje@welmers.net) ---
I've encountered the same problem, bluetooth no longer working in 6.12.114.=
=20
Yesterday I've rebuild with patch 5bd0dec150f5 on it and I can confirm
Bluetooth is working fine now, on a Thinkpad E15 Gen2 Ryzen 7 5600U
See https://github.com/bast1aan/linux/commits/v6.12.114-2-ubuntu2404/
I can send a Tested-by later when I've time (and would know how to)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
