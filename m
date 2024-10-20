Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CB187FE4
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729437934; cv=none; b=HB2qIXHZXewPZzh3BdjVepM7qZeDDkMPl8gS+q0MKSWP1rPC1i8R42ON0rFBVZmiWOeSMYsy1MOTY9KXiRJosaBOlQqLTXJ7kypmF5HFnHPYKEXQB/20TgbucXUKVQArKKdj1/c2HJNWL6ycuEkhOaChi33y1/ofQ8dPOBVJB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729437934; c=relaxed/simple;
	bh=4zeKy/cDhCTAm2BpOVwjHGhLrV/zIOBdINzDV+EDD2A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ADVQC+Pz2SxOAMWx2+m/HeoL71A3XTyN7VjxcrCCCBrqn0l19C+8fKWiTR1gaMc63vvKDxmDWidVLdklZMJU6yHQx5ZKkXt2n4lDqX9VaZYoqgX2n44w4nEqz6uiqCThIaPtO5Q83uk0jmmqD4wYzWIXjxQKgmwgZQyfcioYFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/+HTHkq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/+HTHkq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DF5FC4CEC6
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Oct 2024 15:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729437933;
	bh=4zeKy/cDhCTAm2BpOVwjHGhLrV/zIOBdINzDV+EDD2A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=D/+HTHkqBFCNQahMm3WK52F8lvbchg/FmymJfT1c8xXj2tzrx/3rmvG+/N3b5nVkm
	 mCGbjna/B0Bm5FVQf23iPHJDyFEFGqX7H7x2vmtuiIiDo59Xcs9HjBCfxlFgpYy5PV
	 uQrY6V2mziB584kVP++dWdU78iNwX6qbzSw12avQ1ffcPzSYkv4ZjlSUM/twfr0Ta4
	 yae5SOwnUog4s9zpjx154HGcw1PGuhldKVQ4SPwqpphvOgU0fgoR8jWbnsvqft63rM
	 ZfgMXiBNfuMa2GAliHwG68BUseo0+8XjHJko/Nm8K7w5dRF1FvAA32P6xIhGc+/J+N
	 AkehHRZtCZmVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7A6D3C53BC4; Sun, 20 Oct 2024 15:25:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219404] mt7922: bluetooth can't find any devices
Date: Sun, 20 Oct 2024 15:25:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: g.wenzel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219404-62941-44RXpb9hl3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219404-62941@https.bugzilla.kernel.org/>
References: <bug-219404-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219404

--- Comment #1 from Georg (g.wenzel@gmail.com) ---
Completely crazy. If I connect to a device like Bluetooth headphones and th=
en
search for other devices, it works fine.
But without any connection it finds nothing and I get the error message:
[bluetooth]# Failed to start discovery: org.bluez.Error.InProgress

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
