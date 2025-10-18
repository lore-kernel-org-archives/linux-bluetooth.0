Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53B23BCFD
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Oct 2025 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809933; cv=none; b=IoaKPOPNV7Ltg0Jj4/UvjNK99jAk3s4RPe2y0iWTip0ihjz+WYGfPFzcbI0/oMtFlad8fNJZO3JdqPokTVeDhQ5IA585xc8kpcm9B7/tE7MHPhblgHWEs/Uh4aFVspTUKYWE5sdhStJtesZcheKjGq/rdpRCzuDQ7PC1DiBoW6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809933; c=relaxed/simple;
	bh=lfkGVpQZaG9M7Vv3KwQ8HOuVNOprp5tJcIS0CTjkn7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RwAXNLbpC1AJFKxRRzDyiPMPDni/hXNymHR9/XfSNBK6l94cwC+rdA7DC4fGPMY9hcZ4KpmIzNibe8FvnhGbg06/jkMEv/3XZhs5W8mR6xVyhlW+moA8JAjZP+Kg7ru7NWdoBmHnj2VQTgJ/V932e7IQU2iO8Drrg4NbpDSJTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+kTaOna; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+kTaOna"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 933DEC4CEF8
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Oct 2025 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760809930;
	bh=lfkGVpQZaG9M7Vv3KwQ8HOuVNOprp5tJcIS0CTjkn7o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=r+kTaOnauuGdO70jJP77+A8TH/6gDWWcI6NwHJN+4cJ39HBxOpex83LFEKQVFB+Az
	 x8qB5RUpfINx4XqZifZBlkCXe8n0lZJKJt2XxET8+Y0hX/Zl4lt4G3B4ar+dImQqe1
	 D6OCdoQMDF0lu1WGkH5WhqOkmbsWppbsCQ2+3iqimApGjmcURSD5pSv/61LU6TyZiK
	 WZ3DDtCgcLu/P6/schmhrWrH0SjcjDJsC8NWZ/ksR674zietwUFGp0hrVUTqP8QO11
	 srfg6R4pzVatOy8UnYjKmJgmyvJ06euUlQUqmUtE5J3dSiyA7HfMFWiwdYXzfUwHs8
	 x+0nczLiw867w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 88E08C3279F; Sat, 18 Oct 2025 17:52:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220682] Bluetooth adapter (MediaTek MT7925, USB ID 0489:e111)
 stops working after user logs in to the GNOME
Date: Sat, 18 Oct 2025 17:52:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alex.jakimov@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220682-62941-Z8qAbYiFeo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220682-62941@https.bugzilla.kernel.org/>
References: <bug-220682-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220682

--- Comment #1 from Alex Yakimov (alex.jakimov@gmail.com) ---
To be more specific, the laptop in question is Lenovo Yoga Pro 7 14ASP10.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
