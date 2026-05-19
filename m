Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E09E3A9610
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195319; cv=none; b=povoEvVGCa7BcyU/0XwW/UQWJ44wiYYwC4m5WjJxrfLDdJhJbwmm/a6mowdh2wMPNrCOnfrmIMcRopP4e65FVqTQnDrPAx7PWOggwaEg6cU1JQtE569y+/qWW7jLkjfaPqf2rrsbebw4ut1rsdGdxanZKwruzCd/vhrkQ36ynGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195319; c=relaxed/simple;
	bh=Ot1Igmaete79vvG/kEf5xEoveqFWKuov5n2emAoipRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k9cmHQfjgSRRjzmRvP8DeWOvr/6O829XKkpiwZbkppAjtb9JIi6LBtGOPGXVYF1rz1OZN7eRnPeHQ25ELTzqApLSYU4GRwMmE/RMkoO9gPmRbAqpO6DDjsLS547xSKSABFIWGYcXCQOCmXxMVXL6oihYWLsp9fv+MOhyUSzBCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPzinbrs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPzinbrs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6316BC2BCC6
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 12:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779195319;
	bh=Ot1Igmaete79vvG/kEf5xEoveqFWKuov5n2emAoipRo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dPzinbrs6GJCvvZtIsSXQYPJvCTrs2yqvgfHAuNrTzYtUfWlpC7euOz3wxZQX4NiK
	 JP+XyJRTS3hCoOtWHTJQP0iBhcqe5vH9+Tuau6vbXok9rwpuegXG1eViCk03KTZJ5n
	 pMZ8RgpP2YnCkxj4q8pY9E03H3Q26CiIHJONJ5y0MX+Slke8TaQsZwH1PBkX+aalLk
	 yFfyuSxKlkHXlTHuv40R0uUaSu/ny0tcKyZ0m5fJwtZlUPpV2AQG/ZUKtjdBcQt9YU
	 Wv9zFYTmJaW9kSPFdXroFR4sZPWuN8+wbOge+rpoFdiku046ECsqdh99eQF8/gtQb2
	 EHkE6CR2onpSg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5174CC53BBF; Tue, 19 May 2026 12:55:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221547] MT7902 Bluetooth: Failed to send wmt func ctrl (-22)
 regression in 6.18.31 and 6.12.32
Date: Tue, 19 May 2026 12:55:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221547-62941-yhZD8wZpbi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221547-62941@https.bugzilla.kernel.org/>
References: <bug-221547-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221547

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Please check if this patch fixes it:

https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.177705=
8551.git.pav@iki.fi/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
