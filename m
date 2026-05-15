Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408373FB05B
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838169; cv=none; b=MEdTRl+P2CVbfobFNWdK94gpLcadmJCutYJudxVAqq2AU3qJ67NcpYpLPQbaanKQ/bfxrfbht82g9xBBMTDaLwEXPB4mZUYzTEsFe0/79hxlrWu1b7caALwef0pLTWfw7koxCzc9lOcd5ETGf9zLBHx9hKvFiNeDS6g8OC61Jh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838169; c=relaxed/simple;
	bh=/DOmDbTgXjhjh6SmhOG5oJGrpus6T8FdxbD4ZL1557k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QMo6SNy1hgvdixHyBrdd1sFPJO6CU+yRRJAjtYWp78anzU8/6XMONR4/hMERgOKStg0NZ0YUqQxNdKZ38j84EM2t0OZtnpRBuGXmF8TRcXU9IwowO3DybGpBNHABxAwWbOYmYWbRQnuob44EBd90MgaK/oWJ9goo5gZxNKaWEZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgYkeM8v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgYkeM8v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE3CFC2BCB0
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 09:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778838168;
	bh=/DOmDbTgXjhjh6SmhOG5oJGrpus6T8FdxbD4ZL1557k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JgYkeM8vkAHJX1EXzcMBQc8EG4v3/8JjHZHs3PkOioJVC9bIYSTPMHha6F5zi3E2P
	 J77SDOyn+6nA6a0PUrxcg/QzeTD6sSF/QPQRv17g7tvZRz4IrqJayfHcuXurBRJMMZ
	 /e5HW4SE1/c4p/bH2kVJD1QxqQpl81rfPvR2+oJ+qYGpk/8bdkBiKzMkXVkvRPfPXr
	 fshQRZ+WWtAxcVojsj8tI7FiZ9MeEmlnTD5+PucILOMazWMNBQDB2QaYruhJnZVDq9
	 sN0rQFJIMSLRGadK3NryTLMIvc+cXLSxRZGC/T/RIUQzgqu4FOU2DZASIu24ZnTrjt
	 8VBxlzTckXUUQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D49F7C4160E; Fri, 15 May 2026 09:42:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220922] btusb: Add USB ID 0x13d3:0x3625 for MediaTek MT7922
Date: Fri, 15 May 2026 09:42:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sunil@thakares.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220922-62941-beUv5lfhk7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220922-62941@https.bugzilla.kernel.org/>
References: <bug-220922-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220922

--- Comment #4 from sunil@thakares.com (sunil@thakares.com) ---
Regression: Bluetooth broken on MediaTek MT7922 (USB ID 0489:e0d8)
Last working: linux-7.0.6.arch1-1
First broken: linux-7.0.7.arch1-1
Hardware: Lenovo IdeaPad Slim 5 16AHP9 (AMD Ryzen 7 8845HS)
Adapter: Foxconn/Hon Hai BT 5.2 [MediaTek MT7922], USB 0489:e0d8
Symptom: hci0: Failed to send wmt func ctrl (-22), btmgmt shows 0 controlle=
rs

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
