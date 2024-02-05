Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A33CF58
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Feb 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150283; cv=none; b=BSq/trfIj+6OBXVvUv1MkWcUsW+Q3eOgraHISQ40gjM7nhSny03nWGToW22cyF9ta6Wjr0lE+AQ0i4GaxlR4lFfiKNXEwK+9/HhNCvk/1Eqr4MDuYq9yJakrmuEtU09gA+Fer3mY2+8FnNedDFl7e609bcCoGXeLdRAvIapFgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150283; c=relaxed/simple;
	bh=k5x45+ds/vwlmtdqSNDCQq19NA+8HFxJRbbQ/Uy6HFU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DONUfdF/xtd0LGAyJhJKj9bH3TllXijHOV/ZI56Y5ZvHjYWX0nQjjblkl4yAo+R7fk4CVGy/W3ovbZc5UgCXVzEsVNgfAYq9jvAdSigyI7Wu9fNgqvOMFsCHNt03BX79WM5RXwbZii4RI0Jhq/0GW76vDO7gijkZlFpGAZ+2eg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj3v6N+h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj3v6N+h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9D0FC43399
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Feb 2024 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707150282;
	bh=k5x45+ds/vwlmtdqSNDCQq19NA+8HFxJRbbQ/Uy6HFU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kj3v6N+h/YkJ53Hw+PjyUMBSjdmfSWU4UPTk1aiWD7jX85QBxFyUzJ1v8Hd5WNcC0
	 55KX1PDW+roU/8Fghj1ZEegWNNqsdAC3a3cXtka31Khm47UWnoBuBteaC1dpcDGrEG
	 9ExA1MZrXdtsZRDHMJiq1HEBIzxqrz4e71TH5/SBp4fVtwdU0KExIE/2OSHLmsygfV
	 +c3Wpx0ORaXLGis9z4wclQmfklxlsqWYaTGIeKn1uEQEXOsmISzR1xOYD/OhJzxx4e
	 7vOz7Vjp85hheVPPHUDsyURsXUPxI+1lmiK53Q5BTAs23fVPYg7PSIVJlR77YAw9GY
	 3zF6Ylt/0GoOQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A9B18C4332E; Mon,  5 Feb 2024 16:24:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218440] KASAN: slab-use-after-free in hci_send_acl in Kernel
 6.7-rc2
Date: Mon, 05 Feb 2024 16:24:42 +0000
X-Bugzilla-Reason: CC AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: zhenghaoran@buaa.edu.cn
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218440-62941-7Z5opS1JaT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218440-62941@https.bugzilla.kernel.org/>
References: <bug-218440-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218440

zhenghaoran@buaa.edu.cn changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |REOPENED
         Resolution|ANSWERED                    |---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.=
