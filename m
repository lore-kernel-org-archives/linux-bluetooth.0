Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898E204C00
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Mar 2025 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974829; cv=none; b=QTplSRIV5GLBatPY+QWxaqsgFpzPa77H+367N5KD2cy5VQQDpIF0VZz179KMqXtkzFcTfT2bS0FZlBW0dMesyKcWWgZLqYew9jFobXfOX06QDK2AD4BCDSrdx6WmFINrO4Ckbwl7KKB+SXZZQBocYToSivdqUFycgcynHM/Qdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974829; c=relaxed/simple;
	bh=tM9Ecu/g3KO40hvd3k1ANYSsOhpQPTo9AVrI5HvdchU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEH2Hq8IO6yUejrgIlipyW5xYBolv0cQrmmYRNLcumyd0t6lEQqtLeat1UYBCk+OM2qKRd1lW2ErqZFTqKNlR7Inq9Ij/YzgSNJeMIdS6CBjv2GvLQoGkLN+4iSvXO0L0KLzELyv6D4BnvdqHyilxKi15wA2anmvDqAf8IOz5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTbQC06b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTbQC06b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9FCCC4CEEC
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Mar 2025 17:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741974828;
	bh=tM9Ecu/g3KO40hvd3k1ANYSsOhpQPTo9AVrI5HvdchU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jTbQC06bNS9O8hNSg0nYHezivTVAod1g7l2q0vEOYwfj403kxYCU15ZY4Zo0vjwkF
	 PPxXBXUIeKBoHdmMFgwzE+XWrdj8Ud5dQ0qNUuQeWlbT4jz755HlZ4b2Tp+4SXn5Kp
	 +mvpRok7tEEDQ830C3/HC1U8cll+QPf2g67Wgo/uf1tNH8s2qQoMjlqo/SJV8Pzvc7
	 8vCaQYECQgs6VaRqZIb+10DWB0LFo7Z+xGlqnvpHt+iC5x/IbhMsrmPqWAq85Z45X0
	 5cPv7NaO/+WT/WRZPsJQ4AAIdSldpfn68EqnUI1+ICT7ePqHTde+4nZMZnjz48+Lkb
	 bK590CC7GgywQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 94C09C3279F; Fri, 14 Mar 2025 17:53:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219866] Bluetooth stops working on BE201 after linux-firmware
 20250311
Date: Fri, 14 Mar 2025 17:53:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bhabeck34@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219866-62941-RYfcZFQvMI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219866-62941@https.bugzilla.kernel.org/>
References: <bug-219866-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219866

Bryan H. (bhabeck34@outlook.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #1 from Bryan H. (bhabeck34@outlook.com) ---
There appears to be a merge request in the linux-firmware git repo that
addresses this issue, so I'm marking this as resolved.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
