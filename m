Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86552E3380
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784984; cv=none; b=QNCFIe00EmJnrVa1bZ2jz6dSsQzFsKVqLZZl2wyUkvrSXzs8yxK2fgfejIYrTzIJtTewSC+V27DE8W/hRddHPh98vv9rhbuDTxFx+1XF8V0lLv4/FiqrQLAJ+jDeIVXvQTAhFP9+KivZSi4Grraa4LsNFpDbzAKakmmiA9EpMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784984; c=relaxed/simple;
	bh=WhE0gc6qiRETwkrHiNU1/8zk+D6BVQ8wUstlx/oNR0I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fXwLImDXpW+qRyfGEoLmduyvpZBNefpcOsmYwB03yyYNSUjXmXWV8dh3ob1JocEcfoIztWTw10cNSc8GicAqIUM2fOGAGfy1vFzHIWjXTOIxlyDnG6GBmq3B9CUoDbC22o15vtHrAssGEHAP1siQ7/CNahWcUND+zDJYsXRYkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRxF/XxU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRxF/XxU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C3CBC4CEE3
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 17:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750784984;
	bh=WhE0gc6qiRETwkrHiNU1/8zk+D6BVQ8wUstlx/oNR0I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RRxF/XxUsuLjEGzruY5++t3oN7XMraE2Thzf+YrEcUeQ4vfv5xLlAaFssYOQ+Gu8Y
	 yzUnPjFJ4fdDMK1czfzTv225ZzZqMpZR+pw1RGDQGSXYbY0vtNUx9d8Rte87iuAzIs
	 yjFPVsa/3Evq5AliigTIyz4iwpZo4OadLlK8gB/xEMLgJX78aRNTL07nVUgFaPJJl7
	 ZyoEbpL5V8FP7lvYjPcMtXYm5kAjwCjswky4SK5h6eEF5P5BaW36NJcRWj0zbxu1wi
	 4B7byzUtRRIC4LX6Vsn0SMXjNqXXMCFr0aJfVET+N/oFJ/XB7jdKCq7DURYNJX5swa
	 CZkCZPFZMtZeg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3DE3AC41612; Tue, 24 Jun 2025 17:09:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 217256] 0bda:b00a Realtek Bluetooth 4.2 adapter disappears
 after suspend
Date: Tue, 24 Jun 2025 17:09:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yehudac45@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217256-62941-9msT37X5bT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217256-62941@https.bugzilla.kernel.org/>
References: <bug-217256-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217256

--- Comment #7 from Yehuda Cohen (yehudac45@gmail.com) ---
(In reply to Artem S. Tashkinov from comment #6)
> Is this still an issue in 6.14.2?

It's still here on 6.15.3

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
