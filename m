Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E317C203
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969769; cv=none; b=myrVEsiN8CVzlcGI7MZHf8hLuyvhkoW+/ifmSWzs2CdEtnOjk5xqNJp/jS9bFmFA1PMkCMXG7d8ITXg6hvS1T4QxFGD6WOHIE50A2j0t9Ee3QJ1tXvKdEJyWYH9ehQSiANJ9BljWU1mg6SQcU/ldZl/SMBeXAoJ7HNmNiP3cZTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969769; c=relaxed/simple;
	bh=H501Wu+JWvKrBDPBu+75Hjg1nBYSvPyHUuK7IQd3goQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gIG2OKca1LLDwHsLGb67KiU5nlA8KHGIKt7b0J0HdxO8pC4qlAUPK8yYDhIMWvddmJf52krVM+n65V2iDfgysrUlNL+z9z7hcmsIY3LovHlVkjjN2lPw7Sb156p1ikRoEHaLfdKncLfGiUjCzfbsCD/giKzlRA5EgxGxG7MXLkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1/6dQEL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1/6dQEL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81F62C4CEF9
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 14:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760969767;
	bh=H501Wu+JWvKrBDPBu+75Hjg1nBYSvPyHUuK7IQd3goQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y1/6dQELig/ZKChd5PFnoKBGpw2N7boLVfoOg8YsRZ6i3LP2UjaKqc/zAo3BkaISu
	 0C84DPvrLmHY77ohsEPPiI2JaFtK6Muy2E5PKVXNpkW3CWXbxOBBjkiGwQjAQI0ZKc
	 EJp3BWm71WWpEGkjble65n0WywWOLnipfE97A9FTifxiNnnOZiGlxn4Rg8VJ6Qq/HP
	 LMv/n0pOTOVhldX6fQi8BeOdlBxAA96Ru6Fa6kbIDNC7+utzYS6Eim/fGRPuYBfOQj
	 j/rB0mTVj02pJP/Ujfor/lU1TeiiUIBDffkp1cEmNBEeNRwrRRMQfmDVLM7u3vWZiG
	 DwXwoNZwwpGCw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 724F3C3279F; Mon, 20 Oct 2025 14:16:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 220682] Bluetooth adapter (MediaTek MT7925, USB ID 0489:e111)
 stops working after user logs in to the GNOME
Date: Mon, 20 Oct 2025 14:16:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jeremy53561@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220682-62941-ft0iKYjfyZ@https.bugzilla.kernel.org/>
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

jeremy (jeremy53561@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jeremy53561@gmail.com

--- Comment #3 from jeremy (jeremy53561@gmail.com) ---
Some additional information and possible solution at
https://github.com/LuanAdemi/mediatek7925e-bluetooth-fix/tree/main

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
