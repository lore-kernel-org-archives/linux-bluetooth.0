Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2226ED46
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781356107; cv=none; b=XHJMNVbP5uLkXhfGc3xvqAkCbUyMRR9/XdcIN2iYNWMfd5FBTOgh0pb7eGNF6eh+KSUqJY/8p+2nK7JmFv8fJ/H+B7Gr3RWUWrj6akYNX0rfjNUpybFV2ZIOaNqCLEkOPHpEpdYVyZwDFQ3kpNBrnQ7KSEsrYGijFOoPY9rEOuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781356107; c=relaxed/simple;
	bh=a7LpUQRc2nWyXdUS59NyK9R9tdmLzCS+SwHe0rN3Mzk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hgTf4TEWP8MvgeqcIuWuTy2nmlCGfwrt+gKQHsV3zFilmaMD+fI9g4F033nw0QBts7zTvA3wyhh0BNMH50UEphsczeFaYc9kR1cZdLOXY8xiisBNlAsoHmD1lpyqlxY1Zmj3qvnsJc+lwB0o9aGWgQFNQjgCQFEpQKIAcOc2878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU6T3Vea; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU6T3Vea"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15B78C4AF0D
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 13:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781356107;
	bh=a7LpUQRc2nWyXdUS59NyK9R9tdmLzCS+SwHe0rN3Mzk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FU6T3VeaM0NsiKtypDZn65a04bRg0XiMZQTlkzCEMlhAkv0CjxxWlkSoDqrgIm3gQ
	 dPWj1uEYqcQ868AOuNtejMdre5bJXL4RW1vsOtrij7ixAKgHDGTJTl/Q4Fp0Viktjt
	 5Ra8asGjJcIqsTQ5X/m3lurhvC4CB6Txpvl8vuFR/aD8XCBgMbkzU6fGqFpp567Rv3
	 O/qeG4tWzLIo6sFwTM9k0NVjet/aETih8CdJeHxejqKWwVANg7J9Bs8ECB1/w7UbYm
	 l1bfPR1KNaUYskRSZ8dh3qNYTAO2WhuJvfQ48PWjm7xifx13uweG2jEU9OZpZr8wqk
	 Q4DG6xNV0xTjQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0693AC53BC7; Sat, 13 Jun 2026 13:08:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 73081] Fail to setup Bluetooth on Dell Venue 11 Pro
Date: Sat, 13 Jun 2026 13:08:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hytham@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-73081-62941-WLm4N0Z7Fl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-73081-62941@https.bugzilla.kernel.org/>
References: <bug-73081-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D73081

--- Comment #11 from Hytham (hytham@gmail.com) ---
Hi Dmitry,

I followed the instructions in https://github.com/bluez/bluez/issues/2222 to
copy the firmware to this directory and rebooted which solved the Wifi issue
but Bluetooth is yet not working. I provided additional logs in the bluez
ticket.

Thanks,
Hytham

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
