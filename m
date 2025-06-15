Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4BD2E11A3
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jun 2025 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750022699; cv=none; b=C7kH893bnTThmVvK+n4HuL++MW+ttncNSNDgGAcXgVFY51LpnFFmf+wHcXasSxsRjRkulFHkScVROb4Lja8VvHqyDA48D//faaUlBIhuz/yUmdXJ+WiH8sKncdHbUFZd0VQXnT4yTpm8fqWsRHYFkYTGeH4caJ4EL82CRtVclLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750022699; c=relaxed/simple;
	bh=Sgdn7x68iUfpeOTKwbCTjZ0g93OC7/lzaV5n8pbsUlg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WxMs8pDVLZNXU3bS94iFg9xalmBa/aek4FbIAghWrFIPjTB8M4rcAGQjjqeETiO81nMFvNmrfLSqknkid+YhAfH6d6RGB1ksaSfcZWDzthCYVIocEWzi6gXRmeUOdkya48cXIUlAwtsTOZ9F/Fmg00Y6YXeHmnrC3Gs6tzf9KLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCGVMQaM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCGVMQaM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13A92C4CEE3
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jun 2025 21:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750022699;
	bh=Sgdn7x68iUfpeOTKwbCTjZ0g93OC7/lzaV5n8pbsUlg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OCGVMQaM/YFp9+oiA4xAyVjqhYovlVLl64AVe21yjoBien/QdnRNQVhW0K/8onMOQ
	 LqQAfLcOGz2MLg7IQDBOt0mO8D2/LwZzK+Ah9BB7mOwkxt6mGmpN2ud9t3Cc18tsfG
	 de8QAMDZyu+Os+i/kiIQLa+fH8YBJ9tcYjvkNpMUw7vk0qIcBDTNsZRAx2VKwVUKQG
	 6wS0Tv4UBOw/epy6kBpHPbFQrEQOOwrAyWpqRj3wr7hL22H3iDuMPE/SB3cBGjHALr
	 3pjbuUNb409nnE0+u6jqp3ptswuaEzdhfNGBDt76XTBnGZhVGsCKIWyQrL8wJ4es1F
	 nKVpVNsLUK3LQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0C4CCC4160E; Sun, 15 Jun 2025 21:24:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220237] Bluetooth: MediaTek MT7925 (0e8d:7925) fails to load
 firmware with timeout (-110)
Date: Sun, 15 Jun 2025 21:24:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: are.mehus@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220237-62941-2CxzBoYTg3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220237-62941@https.bugzilla.kernel.org/>
References: <bug-220237-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220237

--- Comment #3 from Are Mehus (are.mehus@protonmail.com) ---
Created attachment 308262
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308262&action=3Dedit
Kernel version

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
