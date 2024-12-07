Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3687711F
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Dec 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733564646; cv=none; b=KdtaDbtnEAKg5H17z2A+du5sn2tKZXLjMF57ekVbEWdcvgr9vn9eXZmTzB02Ea2LAN/YJlrkceSFu88GPD3c2X6gODaKB2pyIAOwgIj3lhk1y1svdUazHbTB6l3C4XS8HQaANaMuESwN2j+Ms6b5gfqS0Il6MM5ulH/z6ELvTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733564646; c=relaxed/simple;
	bh=NlAY4+Up4q3foIv0t+nSyHvpM/SvW+LcRd6UgvMHV2U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TePYpsj9DhlkJWRJ0FsCMZId+s4/cr7NdhXf9t68zOe6iAFen3JVVawykC03qhjUR8GuZ2XKLIvUwVgir53ASqRA6PoNSRMKX5y6dsoCP6pSVcNdpisFjd59S2Mo5FRiO84FFULw4xYjzszpgFyivGHAT3TuYEo0gXk8bXwvkio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSLx/MaV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSLx/MaV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C56D9C4CECD
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Dec 2024 09:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733564645;
	bh=NlAY4+Up4q3foIv0t+nSyHvpM/SvW+LcRd6UgvMHV2U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gSLx/MaVc5p/t6AOpuLMVy3K053d0qFVdudVGYDTXXx2USanUVTV7aEfwvSeGRXy+
	 59IlkjiPj9N6OeRQgqhxFPOkBVj8VCkw7GeKXTIFQTIdM6WGfJAsZv6G5hdb2X1tJm
	 RYSyjyEN7QkYrNzuMCcCQ7Gj3QgcAowSoYSfff05iQxwQUUmFQu1cemZzPI+xMQIZi
	 9thzWWZbR7NYzNqhQWb71VTMk7CigSPmiqLcQnEQqvbwpoH/PpgIO2HRXrphdN7gfM
	 IB0lKvwIfybAdas3HEJtPgjQYOzicuQ260Oz1S5xWm0KlJYiN3wYofistHCAGr6o2n
	 frItXGAd/f0rg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ACAE9C3279E; Sat,  7 Dec 2024 09:44:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 219571] Previous handle short-transfer fix for fake CSR
 controllers does not account for other fake devices
Date: Sat, 07 Dec 2024 09:44:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: sohailsameja@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219571-62941-CIeakQQPW2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219571-62941@https.bugzilla.kernel.org/>
References: <bug-219571-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219571

--- Comment #1 from Mohamed Sohail (sohailsameja@gmail.com) ---
[  +2.061002] Bluetooth: hci0: Opcode 0x1004 failed: -110
[  +0.000003] Bluetooth: hci0: command 0x1004 tx timeout


Forgot the above lines. Either reverting to the old code size handling code=
 i.e
        size =3D le16_to_cpu(data->intr_ep->wMaxPacketSize); or changing the
device identifier to match 0x10d7, 0xb012  fixes this.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
