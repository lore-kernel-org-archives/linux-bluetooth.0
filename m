Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712B03A1E98
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767051203; cv=none; b=kIPnrIM9ykREvNc8vF+Yzv7o+SHX7PCd8tQ0zTT3VF4hfaK8IVOwn9BERVAFDTErlvvjD4q4CZbtrobPpW8GUshLGPfgsHXLg6o1GrrO1Ga3FZRh6KdhqRwdyv3oemwvobwwXSpm7LUAyRdu1wXzL2mjRdOlicRkx7ngwrWq5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767051203; c=relaxed/simple;
	bh=7VyDsm+wxATzmHC/WByvfB8KljB5eN3N6a4V1I74pKo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aauLc54QWiVgE2n2zdfWT3oz3w5QGxaYrpkNF8VfkMP1PPQ3g+9p5w/WgesOkqNAylUOUFjsO1xayF9a8/wovsXRVigXOkys/PzBw7/RYAZunKNhjnRCp1V4DDIfSqNxZ6sMTH2g2kW+LyETC3JZ27gASPkhGa8LfAbIAie5hDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU8k+mMm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU8k+mMm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBAF7C4CEF7
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 23:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767051202;
	bh=7VyDsm+wxATzmHC/WByvfB8KljB5eN3N6a4V1I74pKo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YU8k+mMmErO9lEu+prX6/VJ9EQXF7T3roC0M4NiEhugZZSZBbd/Hz5NO5VMZXXeta
	 xaNNKzFBT0rHWqElrUWVi4FLRytaOSTsmBwmjf03UPHn7Buh7Upedy4FeDCvY0t+tI
	 FIbesiemgdGDcef9J6IryC5C/9t7GjfLC/OBQjgpN5vFR7nEkQphKf6m8xpFSh/kU5
	 PxdsjRI46gKRRDveDFuk1E226E8qcIoQZI4C8xLlckXrFwdYB3tYryqeT15oLxa6gE
	 o0JQqStRWVN1SNzeKjzj7zaUB8hDlJkDmVHOnfgqBiWRu3+ex3Oq/eSHgo/3IO3CXn
	 YMZ7heyrSjn0A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C761EC433E1; Mon, 29 Dec 2025 23:33:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220922] btusb: Add USB ID 0x13d3:0x3625 for MediaTek MT7922
Date: Mon, 29 Dec 2025 23:33:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lucenz@proton.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-220922-62941-609kmhJnoH@https.bugzilla.kernel.org/>
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

lucenz@proton.me changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.18.2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
