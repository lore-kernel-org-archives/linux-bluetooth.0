Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCE8208A7
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Sep 2024 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725211416; cv=none; b=ghhwrkosCYx9GVJPoOxdopcnAPHLZJPkBOGEY1PS43AHqY4pidTmDq+e/ZwSDXan73QwCjrowbZIm4XJhNw5qij/fWlHlfoIzS8M6Sr4r13S2i9L5TOfBe/HNPJQqAHWgsZLlDw5joe/8rmy4AnaMeJcXL9WyugdiByCvpToiGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725211416; c=relaxed/simple;
	bh=F9tKLhaItzYoWmeEG40BP/nWEgx+5xIowumZ+OqiPfo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z1CXDNw0IgX6XZpy6pzgT4bXUXeZTzVzUnzxq1AOMloJHGE8O/0OrcSSOpqH4tehwTHyyr2XdKEwVFFI/e6JhDi1s2HMS06HwyNAqNl+Co5fMu7HJr0GbHuTuIWZMWqrA32usKz3nAiaFME3eMstRezrd95bD/J/yKYEAWcOP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjJN7Wq5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjJN7Wq5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ED9FC4CEC3
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Sep 2024 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725211415;
	bh=F9tKLhaItzYoWmeEG40BP/nWEgx+5xIowumZ+OqiPfo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bjJN7Wq50hB4NZ5Yxm3IteqlOyeSabQrq6T8zXbPB6bQ1qtJA1LM+V2fSnBJOdK7W
	 RLVutK6bXMFCRAXr3s9AjgsmEGj4PAz5InAppRE6Rz34x0slbk3LZGaHYEiJmjIC09
	 6uRoNjUOt8q1lB2hOmd6sdBT136S973sBp2sHC2EKbKEcFrkIXOiuuvuJKibMsVV5u
	 K7Nlp6qRkHhU0vNlpxalFbcEi2QfXdtNKvVf/ausnUDbIk55g9Kk4rlWFkoLI/GQp4
	 7FKazLhp9CIkjJTYpjeyqXjvjjOPWFxjKYqF9PGFePN+W8HIgoTRe4Vo3VK46AkaOw
	 KEkP7vOj4baNA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8BAEFC53BA7; Sun,  1 Sep 2024 17:23:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219211] Bluetooth not working. Bluetooth: hci0: Opcode 0x0c03
 failed: -110
Date: Sun, 01 Sep 2024 17:23:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aprilgrimoire@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219211-62941-oqijTnxH9M@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219211-62941@https.bugzilla.kernel.org/>
References: <bug-219211-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219211

--- Comment #7 from aprilgrimoire@gmail.com ---
(In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from
comment #6)
> Did BT work in earlier kernels?

I tried as early as 6.6, and it didn't work. Should I try older ones?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
