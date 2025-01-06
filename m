Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494481DC9B8
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736168948; cv=none; b=TCT0TLOU3XMZjjwUvmEAJ9Duw7xobCbm96lzQXtCiIIzSSLf7KgPOK0k93X/zW1oyxZl5GKsWQ0m47NCwuSIyCFwY+GALZ4qPKeMD1QeyYZSVakp8mHBVad4dMgsP0ZWS945Jrv6lSbTgLWS6yVfizzQ8SiQvwJpqobgP6IgsoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736168948; c=relaxed/simple;
	bh=TIPysgrwb4IxzCAiJiQ6LKNbuJjE4M1zsdeG6TGQg1Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=twRyOp7gcQ7BZKez+iHTaJFyWukuaSwHSP33bASejmz/9My4o3ZtxjMy9OCtcxtrCELgOjX9JkN6RZqgPjLEgnd+R5xdnn7/7N+n+SKRbnZIKDHnYa26wwRdPrC9a9bKS4zukP0Y+YMRK0udyV4+tkhBTh9HnYHpw4dicVMYNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMggLvjE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMggLvjE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C219FC4CEE2
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 13:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736168946;
	bh=TIPysgrwb4IxzCAiJiQ6LKNbuJjE4M1zsdeG6TGQg1Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hMggLvjEQBIjGy8Q3C+LQGQzZuUAZmp8L+nTMmE/7ehNb5PjoPy+OsvgJOczG7FrG
	 WmczeXg/TDyerJ8Vm7CnuRodI4f/oQjmJ1TiolR3dF1sadpkhGAK/YfoPO/58GcEoq
	 yo6Xr0AxYpBTE5LJxZ1u+OwZkDNay1RHp71ZsDzX0dZWxuFvEnHXxhlok6mAL9uyu4
	 LZke3LwhPfpEZYUyV2W0ZVVqpY9A1NOSmRMJfTMjJrEYQs5H8R1/cWta+CJVA7yVBC
	 VmkvIRqQxAk2OalKgDCR37nlZ4W89Ht6cklYKLihLnNvh/ozL42NYTurunlL28ANrG
	 F1NEC9vdIFOog==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B39FAC41616; Mon,  6 Jan 2025 13:09:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219514] PC does not resume from suspend, bisect points to
 btusb/mediatek
Date: Mon, 06 Jan 2025 13:09:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bojan@kseneman.si
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219514-62941-jq1t2xBhV8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219514-62941@https.bugzilla.kernel.org/>
References: <bug-219514-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219514

--- Comment #10 from Bojan Kseneman (bojan@kseneman.si) ---
Yes in both use "all" instead of "bluetooth" however you don't need to call
`/usr/bin/systemctl suspend`as the service is hooked to sleep.target anyway.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
