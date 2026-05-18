Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB372853E9
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136051; cv=none; b=j74Hcg7IKosO8W+2bep2BPT7+1PV2MjCJvEl9UKNHp9Z+FZvb4oSsoxlS7akGmOmjbxlJ60+pBs5P3l/5azTiALWbwSXab2sJRAXuPr3D85J6a3x6UtJ+Vau3/NIwXjbzIwEn2pdFWwH5b5TjnaXnhjogsXgO/WDjZbLYVBRZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136051; c=relaxed/simple;
	bh=JZ51iYD8OcTF+pSKP9/RuAoIyCFOu+Wti+jy0q0Yt5M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DRWHYJVQ7SNwwFW0wD/CWCXbICOcrBUEsiTJpeMVmBuMo6GnEQFXpeEQJYVaDE4tnaXzOBk4S16ZyLqyTLdEaE3Fc0ydi0o7zD/BgdadcrcET1MTHemwCq8KZcJOv6lELLCuNtsrMyDEtlO1YymewDvYKNDWRfq572yII8EAGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEvAWW7e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEvAWW7e"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57403C2BCF5
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 20:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779136051;
	bh=JZ51iYD8OcTF+pSKP9/RuAoIyCFOu+Wti+jy0q0Yt5M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LEvAWW7e4PM4kLaAERCk2OD0Lo65KLS94LxloIyswixTz6GDJ5S9Cd29Nx48PFlYs
	 YxHZ5s/i8anQLVRVRL7L59z8xVRm4CTI9KrUjMEJU39eqtGFT+Hc2UOX8k5ih7q8LY
	 WswYFo/Yx8a7q4rOaG6575yeqldjzX+HGrbQapT99QRdmD6mRf2CcB/m5N8J5Ltvps
	 qjaBD+Fd2N04Y05Kno5Pb4f2NuUvNSIdsjA7Ng3Klf0SY4vHed/S3srulRkQUZTZuu
	 u1bY7R/Ho00N56dawGKZmGkslNbXd5JNbbUN8c+lMQZOvZfwxFDehu1MZ9pAiw7FqT
	 aK/Xx+de7ACEA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 49978C53BBF; Mon, 18 May 2026 20:27:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Mon, 18 May 2026 20:27:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221521-62941-pPxJwDsfwB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

--- Comment #10 from Artem S. Tashkinov (aros@gmx.com) ---
Kernel developers seemingly aren't interested in fixing this in stable. The=
 fix
has been submitted only for 7.1. At least that's what I've learned from som=
eone
involved.

Arch Linux has already incorporated the fix. If you use a different distro,
report to their bug tracker.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
